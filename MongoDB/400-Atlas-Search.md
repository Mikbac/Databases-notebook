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
