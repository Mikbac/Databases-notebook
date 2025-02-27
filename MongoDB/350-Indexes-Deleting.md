# Deleting  indexes

## Get all indexes

```javascript
db.customers.getIndexes()
```

## Hide index

Hides an existing index from the query planner, but will be still updated.

A good practice is to hide the index from deletion.

```javascript
db.customers.hideIndex(
    'active_1_birthdate_-1_name_1'
)
```

## Delete an index

```javascript
db.customers.dropIndex(
    'active_1_birthdate_-1_name_1'
)
```

```javascript
db.accounts.getIndexes()
db.accounts.dropIndex({account_holder: 1})
```

## Delete indexes

```javascript
db.collection.dropIndexes([
    'index1name', 'index2name', 'index3name'
])
```

delete all the indexes from a collection

```javascript
db.customers.dropIndexes()
```
