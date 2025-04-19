# Update

## replaceOne - replacement of the entire document

Replaces a single document within the collection based on the filter.

https://www.mongodb.com/docs/manual/reference/method/db.collection.replaceOne/

```javascript
db.collection.replaceOne(filter, replacement, options)
```

```javascript
db.users.replaceOne(
    {_id: ObjectId("67ae9a38d76e8304d9b2de19")},
    {
        phones: [
            {
                number: "1-2-3",
                type: "cellphone"
            }
        ],
        user_id: 111,
        username: "Boby"
    }
)
```

```javascript
db.birds.replaceOne(
    {common_name: 'Northern Cardinal'},
    {
        "common_name": "Morning Dove",
        "scientific_name": "Zenaida macroura",
        "wingspan_cm": 37.23,
        "habitat": ["urban areas", "farms", "grassland"],
        "diet": ["seeds"],
    }
)
```

-----------------------------------------------------------------------

## updateOne

Updates a single document within the collection based on the filter.

https://www.mongodb.com/docs/manual/reference/method/db.collection.updateOne/

```javascript
db.collection.updateOne(filter, update, options)
```

* $set - adds new fields to documents. $set outputs documents that contain all existing fields from the input documents
  and newly added fields.
* $push - appends a specified value to an array.

```javascript
db.users.updateOne(
    {_id: ObjectId("67ae9a38d76e8304d9b2de19")},
    {$set: {username: "Beaver"}}
)
```

```javascript
db.birds.updateOne(
    {common_name: "Canada Goose"},
    {$set: {tags: ['geese', 'herbivore', 'migration ']}}
)
```

```javascript
db.users.updateOne(
    {user_id: 111},
    {$push: {group: "IT"}}
)
```

```javascript
db.birds.updateOne(
    {_id: ObjectId("6268471e613e55b82d7065d7")},
    {$push: {diet: ["newts", "opossum", "skunks", "squirrels"]}}
)
```

upsert - insert a document with provided information if matching documents doesn't exist

```javascript
db.users.updateOne(
    {user_id: 444},
    {$set: {username: "Alexy"}},
    {upsert: true}
)
```

The $inc operator increments a field by a specified value.

```javascript
db.birds.updateOne(
    {common_name: "Robin Redbreast"},
    {
        $inc: {sightings: 1},
        $set: {last_updated: new Date()}
    },
    {upsert: true}
)
```

The $mul operator multiplies the value of a field by a number.

```javascript
db.birds.updateOne(
    {common_name: "Robin Redbreast"},
    {
        $mul: {sightings: 2},
    },
    {upsert: true}
)
```

The $addToSet operator in MongoDB is used to add a value to an array and if the value already exists in the array then
this operator will do nothing.

```javascript
db.movies.find({_id: ObjectId("573a1391f29313caabcd6d40")},
    {
        languages: 1
    }
)
// 573a1391f29313caabcd6d40,"[""English""]"

db.movies.updateOne(
    {_id: ObjectId("573a1391f29313caabcd6d40")},
    {$addToSet: {languages: "Polish"}}
)

db.movies.find({_id: ObjectId("573a1391f29313caabcd6d40")},
    {
        languages: 1
    }
)
// 573a1391f29313caabcd6d40,"[""English"", ""Polish""]"
```

-----------------------------------------------------------------------

## findAndModify

Updates and returns a single document (findOne() + updateOne()).

* Returns the document (original or updated).
* Modifies only one document.
* Can be used for atomic operations (e.g., counters).
* Can also remove the document instead of updating (remove: true).

https://www.mongodb.com/docs/manual/reference/method/db.collection.findAndModify/

```javascript
db.users.findAndModify({
        query: {user_id: 333},
        update: {$inc: {salary: 100}}
    }
)
```

new - returns the updated document rather than the original

```javascript
db.users.findAndModify({
        query: {user_id: 333},
        update: {$inc: {salary: 100}},
        new: true
    }
)
```

```javascript
db.birds.findAndModify({
    query: {common_name: 'Blue Jay'},
    update: {$inc: {sightings_count: 1}},
    new: true
})
```

```javascript
db.users.findAndModify({
        query: {user_id: 777},
        update: {$set: {username: "Eve", salary: 101}},
        upsert: true,
        new: true
    }
)
```

-----------------------------------------------------------------------

## updateMany

Updates all documents that match the specified filter for a collection.

https://www.mongodb.com/docs/manual/reference/method/db.collection.updateMany/

```javascript
db.collection.updateMany(filter, update, options)
```

```javascript
db.users.updateMany(
    {salary: {$lte: 300}},
    {$set: {salary: 700}}
)
```

```javascript
db.users.updateMany(
    {birthday: {$lt: new Date("2025-01-01")}},
    {$set: {salary: 700}}
)
```

```javascript
db.birds.updateMany(
    {common_name: {$in: ['Blue Jay', 'Grackle']}},
    {$set: {last_seen: new Date("2022-01-01")}}
)
```
