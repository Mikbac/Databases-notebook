# Single field indexes

Special data structures, that store small partition of the data.

Get indexes from collection:

```javascript
db.customers.getIndexes()
```

## Single field index

```javascript
db.customers.createIndex({birthdate: 1})
```

force uniqueness in the index field values:

```javascript
db.customers.createIndex({email: 1}, {unique: true})
// or
db.accounts.createIndex({account_id: 1}, {unique: true})
```

## Explain

This plan provides the details of the execution stages:

* The `IXSCAN` stage indicates the query is using an index and what index is being selected.
* The `COLLSCAN` stage indicates a collection scan is perform, not using any indexes.
* The `FETCH` stage indicates documents are being read from the collection.
* The `SORT` stage indicates documents are being sorted in memory.

```javascript
// with index db.customers.createIndex({birthdate: 1})
db.customers.explain().find({
    birthdate: {
        $gt: ISODate("1995-08-01")
    }
})
```

```json
{
  "queryPlanner": {
    "namespace": "sample_analytics.customers",
    "parsedQuery": {
      "birthdate": {
        "$gt": {
          "$date": "1995-08-01T00:00:00.000Z"
        }
      }
    },
    "indexFilterSet": false,
    "planCacheShapeHash": "BBB426A3",
    "planCacheKey": "DCC3BEC8",
    "optimizationTimeMillis": 0,
    "maxIndexedOrSolutionsReached": false,
    "maxIndexedAndSolutionsReached": false,
    "maxScansToExplodeReached": false,
    "prunedSimilarIndexes": false,
    "winningPlan": {
      "isCached": false,
      "stage": "FETCH",
      "inputStage": {
        "stage": "IXSCAN",
        "keyPattern": {
          "birthdate": 1
        },
        "indexName": "birthdate_1",
        "isMultiKey": false,
        "multiKeyPaths": {
          "birthdate": []
        },
        "isUnique": false,
        "isSparse": false,
        "isPartial": false,
        "indexVersion": 2,
        "direction": "forward",
        "indexBounds": {
          "birthdate": [
            "(new Date(807235200000), new Date(9223372036854775807)]"
          ]
        }
      }
    },
    "rejectedPlans": []
  }
}
```

```javascript
// without index
db.customers.explain().find({accounts: 871666})
```

```json
{
  "queryPlanner": {
    "namespace": "sample_analytics.customers",
    "parsedQuery": {
      "accounts": {
        "$eq": 871666
      }
    },
    "indexFilterSet": false,
    "planCacheShapeHash": "A55C686F",
    "planCacheKey": "CBBC7703",
    "optimizationTimeMillis": 0,
    "maxIndexedOrSolutionsReached": false,
    "maxIndexedAndSolutionsReached": false,
    "maxScansToExplodeReached": false,
    "prunedSimilarIndexes": false,
    "winningPlan": {
      "isCached": false,
      "stage": "COLLSCAN",
      "filter": {
        "accounts": {
          "$eq": 871666
        }
      },
      "direction": "forward"
    },
    "rejectedPlans": []
  }
}
```
