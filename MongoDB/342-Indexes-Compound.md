# Compound Indexes

* Index on multiple fields.
* Can be a multikey index if it include an array field.
* Maximum of one array field per index.
* Support queries that match on the prefix of the index fields.

The order of the fields in a compound index matters.

Order:

* equality
* sort
* range

## Example 1

```javascript
db.customers.createIndex({
    active: 1,
    birthdate: -1,
    name: 1
})
```

index will be used in this case:

```javascript
db.customers.explain().find({
    birthdate: {$gte: ISODate("1999-01-01")},
    active: true,
}).sort({birthdate: -1, name: 1})
```

```json
[
  {
    "winningPlan": {
      "isCached": false,
      "stage": "FETCH",
      "inputStage": {
        "stage": "IXSCAN",
        "keyPattern": {
          "active": 1,
          "birthdate": -1,
          "name": 1
        },
        "indexName": "active_1_birthdate_-1_name_1",
        "isMultiKey": false,
        "multiKeyPaths": {
          "active": [],
          "birthdate": [],
          "name": []
        },
        "isUnique": false,
        "isSparse": false,
        "isPartial": false,
        "indexVersion": 2,
        "direction": "forward",
        "indexBounds": {
          "active": [
            "[true, true]"
          ],
          "birthdate": [
            "[new Date(9223372036854775807), new Date(915148800000)]"
          ],
          "name": [
            "[MinKey, MaxKey]"
          ]
        }
      }
    }
  }
]
```

## Example 2

```javascript
db.accounts.createIndex({
    account_holder: 1,
    balance: 1,
    account_type: 1
})
```

```javascript
db.accounts.explain().find(
    {account_holder: "Andrea", balance: {$gt: 5}},
    {account_holder: 1, balance: 1, account_type: 1, _id: 0}
).sort({balance: 1});
```

```json
{
  "winningPlan": {
    "stage": "PROJECTION_COVERED",
    "transformBy": {
      "account_holder": 1,
      "balance": 1,
      "account_type": 1,
      "_id": 0
    },
    "inputStage": {
      "stage": "IXSCAN",
      "keyPattern": {
        "account_holder": 1,
        "balance": 1,
        "account_type": 1
      },
      "indexName": "account_holder_1_balance_1_account_type_1",
      "isMultiKey": false,
      "multiKeyPaths": {
        "account_holder": [],
        "balance": [],
        "account_type": []
      },
      "isUnique": false,
      "isSparse": false,
      "isPartial": false,
      "indexVersion": 2,
      "direction": "forward",
      "indexBounds": {
        "account_holder": [
          "[\"Andrea\", \"Andrea\"]"
        ],
        "balance": [
          "(5, inf.0]"
        ],
        "account_type": [
          "[MinKey, MaxKey]"
        ]
      }
    }
  }
}
```
