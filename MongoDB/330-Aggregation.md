# Aggregation

https://www.mongodb.com/docs/manual/aggregation/
https://www.mongodb.com/docs/manual/reference/operator/aggregation-pipeline/

* Aggregation - collection and summary of data
* Stage - an aggregation operation performed on the data (a single operation on the data)
* Aggregation pipeline - a series of stages completed on the data in order

```javascript
db.collection.aggregate([
    {
        $stage1: {
            expression1,
            expression2
        },
        $stage2: {
            expression1
        }
    }])
```

* $match - filters for data criteria
* $group - group documents based on criteria
* $sort - sort documents in a specific order

-----------------------------------------------------------------------

## $match

```javascript
db.users.aggregate([
    {
        $match: {
            "field_name": "value"
        }
    }
])
```

```javascript
db.users.aggregate([
    {
        $match: {username: "Alice"}
    }
])
```

-----------------------------------------------------------------------

## $search

aggregation pipeline stage performs a full-text search of the field or fields

```javascript
db.users.aggregate([
    {
        $search: {
            "index": "<index name>", // optional, defaults to "default"
            "autocomplete": {
                "query": "<search-string>",
                "path": "<field-to-search>",
                "tokenOrder": "any|sequential",
                "fuzzy": "<options>",
                "score": " <options>"
            }
        }
    }
])
```

```javascript
db.users.aggregate([
    {
        $search: {
            "index": "<index name>", // optional, defaults to "default"
            "text": {
                "query": "<search-string>",
                "path": "<field-to-search>",
                "fuzzy": "<options>",
                "matchCriteria": "\"any\" |\ \"all\"",
                "score": "<options>",
                "synonyms": "<synonyms-mapping-name>"
            }
        }
    }
])
```

-----------------------------------------------------------------------

## $group

```javascript
db.users.aggregate([
    {
        $group:
            {
                _id: expression, // Group key
                field: {accumulator: expression}
            }
    }
])
```

```javascript
db.users.aggregate([
    {
        $match: {username: "Alice"}
    },
    {
        $group: {
            _id: "$user_id", // group key
            total_phones: {$count: {}}
        }
    }
])
```

```javascript
db.sightings.aggregate([
    {
        $match: {species_common: "Eastern Bluebird"}
    }, {
        $group: {
            _id: "$location.coordinates",
            number_of_sightings: {$count: {}}
        }
    }
])
```

-----------------------------------------------------------------------

## $sort

```javascript
db.zips.aggregate([
    {
        $sort: {pop: -1} // from highest population to lowest
    }
])
```

```javascript
db.zips.aggregate([
    {
        $group: {"_id": "$pop"}
    },
    {
        $sort: {_id: -1}
    }
])
```

```javascript
db.reviews.aggregate([
    {$group: {_id: "$product_id", avgRating: {$avg: "$rating"}}},
    {$sort: {avgRating: -1}}
])
```

-----------------------------------------------------------------------

## $limit

```javascript
db.zips.aggregate([
    {
        $sort: {pop: -1} // from the largest population to the smallest
    }, {
        $limit: 5
    }
])
```

```javascript
db.sightings.aggregate([
    {
        $sort: {"location.coordinates.1": -1} // { location: { coordinates: [x, y] } }
    }, {
        $limit: 4
    }
])
```

```javascript
db.zips.aggregate([
    {
        $group: {"_id": "$pop"}
    },
    {
        $sort: {_id: -1}
    },
    {
        $limit: 10
    }
])
```

-----------------------------------------------------------------------

## $project - determine output shape

* 1 - include
* 0 - exclude

```javascript
db.zips.aggregate([
    {
        $project: {
            _id: 0,
            city: 1,
            zip: 1,
            population: "$pop"
        }
    }
])
```

```javascript
db.sightings.aggregate([
    {
        $project: {
            date: 1,
            species_common: 1
        }
    }
])
```

-----------------------------------------------------------------------

## $set - set or add new field

```javascript
db.zips.aggregate([
    {
        $set: {
            twice_pop: {$multiply: [2, "$pop"]}
        }
    }
])
```

```javascript
db.birds.aggregate([
    {
        $set: {
            class: 'bird'
        }
    }
])
```

-----------------------------------------------------------------------

## $count - counts documents in the pipeline

```javascript
db.zips.aggregate([
    {
        $count: "total_zips" // name of the output field which has the count as its value
    }
])
```

```javascript
db.sightings.aggregate([
    {
        $match: {
            date: {
                $gt: ISODate('2022-01-01T00:00:00.000Z'),
                $lt: ISODate('2023-01-01T00:00:00.000Z')
            },
            species_common: 'Eastern Bluebird'
        }
    }, {
        $count: 'bluebird_sightings_2022'
    }
])
```

-----------------------------------------------------------------------

## $unwind - deconstructs the items array, creating a separate document for each element in the array

```javascript
db.customers.aggregate([
    {
        $unwind: "$accounts"
    }
])
```

-----------------------------------------------------------------------

## $out - writes the documents that are returned by an aggregation pipeline into a collection

must be the last stage

```javascript
db.sightings.aggregate([
    {
        $match: {
            date: { // matching records of sightings that took place in 2022
                $gte: ISODate('2022-01-01T00:00:00.000Z'),
                $lt: ISODate('2023-01-01T00:00:00.000Z')
            }
        }
    }, { // outputs the filtered data to a new collection
        $out: 'sightings_2022'
    }
])
```

```javascript
db.getSiblingDB("sample_analytics").customers.aggregate([
    {
        $match: {
            email: 'laura34@yahoo.com'
        }
    },
    {
        $out: {db: 'test', coll: 'results'}
    }
])
```
