# Insert

If the collection doesn't exist, Mongo will create it.

## insertOne

```javascript
db.users.insertOne({
    user_id: 111,
    username: 'Bob',
    phones: [
        {
            number: '111-222-333',
            type: 'cellphone'
        }
    ]
})
```

```javascript
db.accounts.insertOne({
    "account_id": 111333,
    "limit": 12000,
    "products": [
        "Commodity",
        "Brokerage"
    ],
    "last_updated": new Date()
})
```

## insertMany

```javascript
db.users.insertMany([{
    user_id: 222,
    username: 'Alice',
    phones: [
        {
            number: '222-333-444',
            type: 'cellphone'
        }
    ]
},
    {
        user_id: 333,
        username: 'Pankracy',
        phones: [
            {
                number: '333-444-555',
                type: 'cellphone'
            }
        ]
    }])
```

```javascript
db.accounts.insertMany([{
    "account_id": 111333,
    "limit": 12000,
    "products": [
        "Commodity",
        "Brokerage"
    ],
    "last_updated": new Date()
},
    {
        "account_id": 678943,
        "limit": 8000,
        "products": [
            "CurrencyService",
            "Brokerage",
            "InvestmentStock"
        ],
        "last_updated": new Date()
    },
    {
        "account_id": 321654,
        "limit": 10000,
        "products": [
            "Commodity",
            "CurrencyService"
        ],
        "last_updated": new Date()
    }])
```
