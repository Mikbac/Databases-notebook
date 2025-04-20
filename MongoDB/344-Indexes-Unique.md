# Unique Indexes

A unique index ensures that the indexed fields do not store duplicate values; i.e. enforces uniqueness for the indexed fields. By default, MongoDB creates a unique index on the _id field during the creation of a collection.

https://www.mongodb.com/docs/v7.0/core/index-unique/

e.g.

```javascript
db.members.createIndex({"user_id": 1}, {unique: true})
```
