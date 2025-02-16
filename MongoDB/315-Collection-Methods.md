# Collection methods

## countDocuments

```javascript
db.collection.countDocuments(query, options)
```

Count all documents:

```javascript
db.companies.countDocuments()
```

Count specific documents:

```javascript
db.companies.countDocuments({category_code: 'music'})
```

```javascript
db.sales.countDocuments({couponUsed: true, storeLocation: 'Denver'})
```

```javascript
db.sales.countDocuments({items: {$elemMatch: {name: "laptop", price: {$lt: 600}}}})
```
