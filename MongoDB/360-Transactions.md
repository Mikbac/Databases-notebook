# Transactions

* Atomicity - all operations will either succeed or fail together
* Consistency - all changes made by operations are consistent with database constraints
* Isolation - multiple transactions can happen at the same time without affecting the outcome of the other transaction
* Durability - all changes made by operations in the transaction will be permanent, no matter what fails

A transaction has a maximum runtime of less than one minute after the first write.

```javascript
const session = db.getMongo().startSession()

session.startTransaction()

const account = session.getDatabase('bank').getCollection('accounts')

//Add database operations like .updateOne() here
// START
accounts.updateOne({accounts_id: "333-444-555"}, {$inc: {balance: -30}})
accounts.updateOne({accounts_id: "777-888-999"}, {$inc: {balance: +30}})
// END

// Aborting a transaction
// session.abortTransaction()

// Commit a transaction
session.commitTransaction()
```

## commited transaction example

```javascript
const session = db.getMongo().startSession()
session.startTransaction()
const account = session.getDatabase('bank').getCollection('accounts')

// operations - start
account.insertOne({
    account_id: "MDB454252264",
    account_holder: "Florence Taylor",
    account_type: "savings",
    balance: 100.0,
    transfers_complete: [],
    last_updated: new Date()
})
account.updateOne( { account_id: "MDB963134500" }, {$inc: { balance: -100.00 }})
// operations - end

session.commitTransaction()
```

## aborted transaction example


```javascript
session = db.getMongo().startSession();
session.startTransaction();
const account = session.getDatabase('bank').getCollection('accounts')
// operations - start
account.updateOne( { account_id: "MDB740836066" }, {$inc: { balance: 100 }})
account.updateOne( { account_id: "MDB963134500" }, {$inc: { balance: -5 }})
// operations - end
session.abortTransaction()
```
