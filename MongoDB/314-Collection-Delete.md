# Delete

## deleteOne

```javascript
db.users.deleteOne({_id: ObjectId('67b101e4ff05fa8dfacab63a')})
```

```javascript
db.birds.deleteOne({_id: ObjectId("62cddf53c1d62bc45439bebf")})
```

## deleteMany

```javascript
db.users.deleteMany({sallary: {$eq: null}})
```

```javascript
db.birds.deleteMany({sightings_count: {$lte: 10}})
```
