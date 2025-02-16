# Find

```javascript
db.collection.find(query, projection)
```

```javascript
db.users.find()
```

-----------------------------------------------------------------------

## Comparators

https://www.mongodb.com/docs/manual/reference/operator/query-comparison/

| Name | Description                                                         |
|------|---------------------------------------------------------------------|
| $eq  | Matches values that are equal to a specified value.                 |
| $gt  | Matches values that are greater than a specified value.             |
| $gte | Matches values that are greater than or equal to a specified value. |
| $in  | Matches any of the values specified in an array.                    |
| $lt  | Matches values that are less than a specified value.                |
| $lte | Matches values that are less than or equal to a specified value.    |
| $ne  | Matches all values that are not equal to a specified value.         |
| $nin | Matches none of the values specified in an array.                   |

```javascript
db.users.find({username: {$eq: "Bob"}})
db.users.find({username: "Bob"})
db.users.find({_id: ObjectId("67ae9a38d76e8304d9b2de19")})
```

```javascript
db.accounts.find({limit: {$gt: 10000}})
db.sales.find({"items.price": {$gt: 200}})
db.sales.find({"items.quantity": {$gte: 10}})
db.sales.find({"items.price": {$lt: 25}})
db.sales.find({"customer.age": {$lte: 65}})
db.sales.find({"customer.age": {$lte: 45}})
```

```javascript
db.users.find({username: {$in: ["Alice", "Bob"]}})
db.sales.find({storeLocation: {$in: ["London", "New York"]}})
db.users.find({_id: {$in: [ObjectId("67ae9a38d76e8304d9b2de19")]}})
```

```javascript
// works like and
db.accounts.find({
    limit: {$gt: 10000},
    products: {$in: ["Brokerage"]}
})
```

-----------------------------------------------------------------------

## Array query

```javascript
// matches all the documents with a products array that contains the value of CurrencyService
db.accounts.find({products: "CurrencyService"})
```

https://www.mongodb.com/docs/manual/reference/operator/query/elemMatch/

The $elemMatch operator matches documents that contain an array field with at least one element that matches all the
specified query criteria. The returned documents will include the entire array, not just the elements that satisfy the
query.

```javascript
db.users.find({
    phones: {
        $elemMatch: {number: {$in: ["222-333-444"]}, type: {$in: ["cellphone"]}}
    }
})
```

```javascript
db.transactions.find({
    transactions: {
        $elemMatch: {amount: {$lte: 4500}, transaction_code: 'sell'}
    }
})
```

-----------------------------------------------------------------------

## Logical operators

```javascript
db.accounts.find({
    $and: [
        {limit: {$gt: 10000}},
        {products: {$in: ["Brokerage"]}}
    ]
})
// or
db.accounts.find({
    limit: {$gt: 10000},
    products: {$in: ["Brokerage"]}
})
```

```javascript
db.sales.find({
    $and: [
        {purchaseMethod: "Online"},
        {couponUsed: true},
        {"customer.age": {$lte: 25}}
    ]
})
// or
db.sales.find({
    purchaseMethod: "Online",
    couponUsed: true,
    "customer.age": {$lte: 25}
})
```

```javascript
db.accounts.find({
    $or: [
        {limit: {$gt: 10000}},
        {products: {$in: ["Brokerage"]}}
    ]
})
```

```javascript
db.sales.find({
    $or: [
        {"items.name": "pens"},
        {"items.tag": "writing"}
    ]
})
```

```javascript
db.accounts.find({
    $and: [
        {
            $or: [
                {limit: {$gt: 11000}},
                {limit: {$lt: 9000}}
            ]
        },
        {products: {$in: ["Brokerage"]}}
    ]
})
```

-----------------------------------------------------------------------

## projection

include -> 1
exclude -> 0

inclusion and exclusion can't be combined in projections, except _id field

```javascript
db.companies.find({category_code: 'music'}, {name: 1, _id: 0})
```

```javascript
db.sales.find({storeLocation: 'Denver'}, {saleDate: 1, storeLocation: 1, purchaseMethod: 1})
```

```javascript
db.sales.find({"customer.age": {$lt: 30}, "customer.satisfaction": {$gt: 3}}, {
    "customer.age": 1,
    "customer.satisfaction": 1,
    _id: 0
})
```

```javascript
db.sales.find(
    {storeLocation: {$in: ['Seattle', 'New York']}},
    {purchaseMethod: 0, customer: 0, couponUsed: 0}
)
```
