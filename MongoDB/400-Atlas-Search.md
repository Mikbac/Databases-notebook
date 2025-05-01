# Atlas search

Atlas Search is an embedded full-text search in MongoDB Atlas. Built on Apache Lucene, Atlas Search eliminates the need
to run a separate search system alongside your database.

https://www.mongodb.com/docs/atlas/atlas-search/

```json
{
  "analyzer": "lucene.standard",
  "searchAnalyzer": "lucene.standard",
  "mappings": {
    "dynamic": true
  }
}
```

## autocomplete (via Atlas Search Index)

Full-text indexes are not available natively in MongoDB server deployed locally.

```javascript
db.customers.find()
```

```javascript
db.customers.createSearchIndex(
    "searchIndex01",
    {
        mappings: {
            dynamic: false,
            fields: {
                email: [
                    {
                        "type": "stringFacet"
                    },
                    {
                        "type": "string"
                    },
                    {
                        foldDiacritics: false,
                        maxGrams: 7,
                        minGrams: 3,
                        tokenization: "edgeGram",
                        type: "autocomplete"
                    }
                ]
            }
        }
    })
```

search emails:

```javascript
db.customers.aggregate([
    {
        $search: {
            "index": "searchIndex01",
            "autocomplete": {
                "path": "email",
                "query": "jona"
            }
        }
    },
    {
        $limit: 10
    },
    {
        $project: {
            "_id": 0,
            "title": 1
        }
    }
])
```

## Example — 1 - Dynamic indexing

```json
{
  "mappings": {
    "dynamic": true
  }
}
```

query:

```javascript
[
    {
        $search: {
            index: "restaurants_cuisine",
            text: {
                query: "Delicatessen",
                path: {
                    wildcard: "*"
                }
            }
        }
    }
]
```

## Example — 2 Static indexing

You can use the Atlas Search autocomplete type to index text values in string fields for autocompletion.

```json
{
  "mappings": {
    "dynamic": false,
    "fields": {
      "cuisine": {
        "type": "autocomplete",
        "maxGrams": 7,
        "minGrams": 3
      }
    }
  }
}
```

Visual Search Tester only supports basic wildcard queries, so it works only via Compas or Mongo Shell.

```javascript
db.restaurants.aggregate([
    {
        $search: {
            index: "restaurants_cuisine_2",
            autocomplete: {
                query: "Del",
                path: "cuisine"
            }
        }
    }
])
```

## Example — 3

```javascript
db.sales.aggregate([
    {
        $search: {
            index: "sample_supplies-sales-dynamic",
            text: {
                query: "notepad",
                path: {"wildcard": "*"}
            }
        }
    },
    {
        $set: {
            score: {
                $meta: "searchScore"
            }
        }
    }
])
```

* $search is an aggregation stage used to perform a full-text search on the specified field(s) by using an Atlas Search
  Index.
* index is the name of the index we've created in the previous challenge.
* text is the search operator that the $search stage will use. It performs a full-text search using the analyzer we have
  specified in the index > configuration. For your convenience, you can review the index configuration in the
  /app/search_index.json file available under the Index > Configuration tab.
* query specifies the string to search for.
* path specifies the fields to search. In our example, we are using a wildcard path so all the fields will be searched.
* The $set stage is used to add the score field to the result set.
* $meta is an aggregation operator to return the metadata associated to a document. In this case, we are interested in
  the searchScore of a search query. The score is based on how much that record matches the search term and on the rules
  described in the index. In this case, with a dynamic index, all of the fields were treated equally.

## Example — 4 Static indexing

```json
{
  "mappings": {
    "dynamic": false,
    "fields": {
      "borough": {
        "type": "string"
      },
      "cuisine": {
        "type": "string"
      }
    }
  }
}
```

```javascript
db.restaurants.aggregate([
    {
        $search: {
            index: "restaurants_cuisine_string",
            text: {
                query: "Delicatessen",
                path: "cuisine"
            }
        }
    }
])
```

## Example — 5 Static indexing

```json
{
  "name": "sample_supplies-sales-static",
  "searchAnalyzer": "lucene.standard",
  "analyzer": "lucene.standard",
  "collectionName": "sales",
  "database": "sample_supplies",
  "mappings": {
    "dynamic": false,
    "fields": {
      "storeLocation": {
        "type": "string"
      }
    }
  }
}
```

```javascript
db.sales.aggregate([
    {
        $search: {
            index: 'sample_supplies-sales-static',
            text: {
                query: 'London', path: {'wildcard': '*'}
            }
        }
    },
    {
        $set: {
            score: {$meta: "searchScore"}
        }
    }
])
```

## Example — 6

$search aggregation stage allows us to give weight to different field and also filter our results without having to
create additional aggregation stages.

* "must" will exclude records that do not meet the criteria
* "mustNot" will exclude results that do meet the criteria
* "should" will allow you to give weight to results that do meet the criteria so that they appear first
* "filter" will remove results that do not meet the criteria.

```javascript
db.birds.aggregate([
    {
        $search: {
            index: 'sample_birds_index',
            "compound": {
                "must": [{
                    "text": {
                        "query": "field",
                        "path": "habitat"
                    }
                }],
                "should": [{
                    "range": {
                        "gte": 45,
                        "path": "wingspan_cm",
                        "score": {"constant": {"value": 5}}
                    }
                }]
            }
        }
    }
])
```

## Example — 7

```javascript
db.sales.aggregate([
    {
        $search: {
            index: 'sample_supplies-sales-dynamic',
            "compound": {
                "filter": [
                    {
                        "text": {
                            "query": "Online",
                            "path": "purchaseMethod"
                        }
                    }
                ],
                "should": [
                    {
                        "text": {
                            "query": "notepad",
                            "path": "items.name",
                            "score": {"constant": {"value": 5}}
                        }
                    }
                ]
            }
        }
    },
    {
        $project: {
            "items.name": 1,
            "purchaseMethod": 1,
            "score": {$meta: "searchScore"}
        }
    }
])
```

## Example — 8 Facets

index:

```json
{
  "mappings": {
    "dynamic": false,
    "fields": {
      "borough": {
        "type": "stringFacet"
      },
      "cuisine": {
        "type": "string"
      }
    }
  }
}
```

query:

```javascript
db.restaurants.aggregate([
    {
        $searchMeta: {
            index: 'bucket_test',
            facet: {
                operator: {
                    text: {
                        query: "Delicatessen",
                        path: "cuisine"
                    }
                },
                facets: {
                    boroughFacet: {
                        type: "string",
                        path: "borough"
                    }
                }
            }
        }
    }
])
```

response:

```json
[
  {
    "count": {
      "lowerBound": 321
    },
    "facet": {
      "boroughFacet": {
        "buckets": [
          {
            "_id": "Manhattan",
            "count": 133
          },
          {
            "_id": "Queens",
            "count": 99
          },
          {
            "_id": "Brooklyn",
            "count": 46
          },
          {
            "_id": "Bronx",
            "count": 26
          },
          {
            "_id": "Staten Island",
            "count": 16
          },
          {
            "_id": "Missing",
            "count": 1
          }
        ]
      }
    }
  }
]
```

## Example — 9 - Facets

```javascript
db.birds.aggregate([
    {
        $searchMeta: {
            index: 'sample_birds_facet',
            "facet": {
                "operator": {
                    "text": {
                        "query": ["Northern Cardinal"],
                        "path": "common_name"
                    }
                },
                "facets": {
                    "sightingWeekFacet": {
                        "type": "date",
                        "path": "sighting",
                        "boundaries": [ISODate("2022-01-01"),
                            ISODate("2022-01-08"),
                            ISODate("2022-01-15"),
                            ISODate("2022-01-22")],
                        "default": "other"
                    }
                }
            }
        }
    }
])
```

## Example — 9 

```json
{
    "name": "sample_supplies-sales-facets",
    "searchAnalyzer": "lucene.standard",
    "analyzer": "lucene.standard",
    "collectionName": "sales",
    "database": "sample_supplies",
    "mappings": {
        "dynamic": true,
        "fields": {
        "purchaseMethod": [
            {
            "dynamic": true,
            "type": "document"
            },
            {
            "type": "string"
            }
        ],
        "storeLocation": [
            {
            "dynamic": true,
            "type": "document"
            },
            {
            "type": "stringFacet"
            }
        ]
        }
    }
}
```

```javascript
db.sales.aggregate([
  {
    $searchMeta: {
      index: 'sample_supplies-sales-facets',
        "facet": {
            "operator": {
                "text": {
                    "query": "In store",
                    "path": "purchaseMethod"
                }
            },
            "facets": {
                "locationFacet": {
                    "type": "string",
                    "path": "storeLocation",
                }
            }
        }
    }
  }
])
```

```json
[
  {
    "count": {
      "lowerBound": "2819"
    },
    "facet": {
      "locationFacet": {
        "buckets": [
          {
            "_id": "Denver",
            "count": 864
          },
          {
            "_id": "Seattle",
            "count": 648
          },
          {
            "_id": "London",
            "count": 455
          },
          {
            "_id": "Austin",
            "count": 378
          },
          {
            "_id": "New York",
            "count": 289
          },
          {
            "_id": "San Diego",
            "count": 185
          }
        ]
      }
    }
  }
]
```

## Example — 10

```javascript
db.products.find(
    { $text: { $search: 'orange' } }, 
    { score: { $meta: 'textScore' } },
).sort( { score: { $meta: 'textScore' } } )
```

## Example — 11

```json
{
  "mappings": {
    "dynamic": false,
    "fields": {
      "name": [
        {
          "type": "autocomplete",
          "tokenization": "edgeGram"
        }
      ]
    }
  }
}
```


```javascript
db.products.aggregate(
    [
        {"$search": 
                  {"text": 
                            {
                                "path": "name", 
                              "query": "apples"
                            }
                  }
        }
    ]
)
```
