# Views

```javascript
db.createView(
    "<viewName>",
    "<source>",
    [pipeline],
    {
        "collation": {collation}
    }
)
```

Create view:

```javascript
db.createView("AccountsLimitView", "accounts", [{$project: {account_id: 1, limit: 1}}])
```

Query view:

```javascript
db.AccountsLimitView.find({})
```
