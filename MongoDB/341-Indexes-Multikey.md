# Multikey indexes

Any index where one of the indexed fields contains an array.

```javascript
db.customers.createIndex({
    accounts: 1
})
```

```javascript
db.accounts.createIndex({
    transfers_complete: 1
})
// verification
db.accounts.explain().find({
    transfers_complete: {$in: ['TR617907396']}
})
```
