# Cursor methods

https://www.mongodb.com/docs/manual/reference/method/js-cursor/

## Sort

1 or -1 to specify an ascending or descending sort

```javascript
db.companies.find({category_code: 'music'}).sort({name: 1})
// with projection to get only required fields
db.companies.find({category_code: 'music'}, {name: 1, created_at: 1}).sort({name: 1})
```

```javascript
db.companies.find({category_code: 'music'}).sort({name: 1, created_at: 1})
```

```javascript
// from oldest to newest
db.sales.find().sort({saleDate: 1})
```

```javascript
// from newest to oldest
db.sales.find({purchaseMethod: 'Online', couponUsed: true}).sort({saleDate: -1})
```

-----------------------------------------------------------------------

## limit

```javascript
db.companies.find({category_code: 'music'}).sort({number_of_employees: -1}).limit(5)
// or
db.companies.find(
    {category_code: 'music'},
    {_id: 0, name: 1, number_of_employees: 1}
)
    .sort({number_of_employees: -1})
    .limit(5)
```

```javascript
db.sales.find({
    storeLocation: 'London',
    "items.name": {$in: ['laptop', 'backpack', 'printer']}
}).sort({saleDate: -1}).limit(3)
```

-----------------------------------------------------------------------

## count
