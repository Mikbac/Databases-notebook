# TTL Indexes

https://www.mongodb.com/docs/manual/core/index-ttl/

TTL indexes are special single-field indexes that MongoDB can use to automatically remove documents from a collection
after a certain amount of time or at a specific clock time.

```javascript
db.eventlog.createIndex(
    {"lastModifiedDate": 1},
    {expireAfterSeconds: 3600}
)
```
