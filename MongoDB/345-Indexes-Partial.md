# Partial Indexes

Partial indexes only index the documents in a collection that meet a specified filter expression. By indexing a subset
of the documents in a collection, partial indexes have lower storage requirements and reduced performance costs for
index creation and maintenance.

https://www.mongodb.com/docs/manual/core/index-partial/

e.g.

```javascript
db.restaurants.createIndex(
    {cuisine: 1, name: 1},
    {partialFilterExpression: {rating: {$gt: 5}}}mo
)
```
