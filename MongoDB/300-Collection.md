# Collection

```shell
show collections;
```

## Capped Collections

Capped collections are fixed-size collections that insert and retrieve documents based on insertion order.

```javascript
db.createCollection("log", {capped: true, size: 10000})
```
