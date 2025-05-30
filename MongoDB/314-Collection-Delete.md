# Delete

## deleteOne

If we don't specify a filter, MongoDB matches the first document in the collection.

```javascript
db.users.deleteOne({_id: ObjectId('67b101e4ff05fa8dfacab63a')})
```

```javascript
db.birds.deleteOne({_id: ObjectId("62cddf53c1d62bc45439bebf")})
```

```javascript
db.birds.findOneAndDelete({_id: ObjectId("62cddf53c1d62bc45439bebf")})
```

## deleteMany

If we provide an empty filter, MongoDB matches all documents in the collection and deletes them.

```javascript
db.users.deleteMany({sallary: {$eq: null}})
```

```javascript
db.birds.deleteMany({sightings_count: {$lte: 10}})
```
