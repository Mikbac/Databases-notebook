# Java Driver

```java
final ServerApi serverApi = ServerApi.builder()
        .version(ServerApiVersion.V1)
        .build();
final MongoClientSettings settings = MongoClientSettings.builder()
        .applyConnectionString(new ConnectionString("mongodb+srv://test:pass@cluster0/?retryWrites=true&w=majority&appName=Cluster0"))
        .serverApi(serverApi)
        .build();

final MongoClient mongoClient = MongoClients.create(settings);

// ------ get available databases ------
final List<Document> databases = mongoClient.listDatabases().into(new ArrayList<>());

// ------ get available collections ------
final MongoDatabase database = mongoClient.getDatabase("test_db");
final ListCollectionNamesIterable collections = database.listCollectionNames();

// ------ create collection ------
final MongoDatabase database = mongoClient.getDatabase("test_db");
database.createCollection("test_collection");

// ------ find all documents ------
final MongoDatabase database = mongoClient.getDatabase("test_db");
database.getCollection("test_collection").find().forEach(System.out::println);

// ------ find documents ------
final MongoDatabase database = mongoClient.getDatabase("test_db");
final Bson filters = Filters.and(Filters.eq("name", "Bob"), Filters.eq("age", 25));
database.getCollection("test_collection").find(filters).forEach(System.out::println);

// ------ find documents ------
final MongoDatabase database = mongoClient.getDatabase("test_db");
final Bson filters = Filters.and(Filters.eq("name", "Bob"), Filters.eq("age", 25));
for (final Document document : database.getCollection("test_collection").find(filters)) {
    System.out.println(document.toJson());
}

// ------ find documents ------
final MongoDatabase database = mongoClient.getDatabase("test_db");
final Bson filters = Filters.and(Filters.eq("name", "Bob"), Filters.eq("age", 25));
final Document document = database.getCollection("test_collection").find(filters).first();
System.out.println(Optional.ofNullable(document).map(Document::toJson));

// ------ insert document ------
final MongoDatabase database = mongoClient.getDatabase("test_db");
database.getCollection("test_collection")
        .insertOne(new Document("ping", new Document("ok", true)));
        
// ------ insert document ------
final MongoDatabase database = mongoClient.getDatabase("test_db");
final Document document = new Document("_id", new ObjectId())
        .append("name", "Bob")
        .append("age", 25)
        .append("birthday", LocalDate.of(1999, 2, 3))
        .append("phone", new Document().append("number", "123-456-789")
                .append("type", "home"));
final InsertOneResult result = database.getCollection("test_collection")
        .insertOne(document);

// ------ insert multiple documents ------
final MongoDatabase database = mongoClient.getDatabase("test_db");
final InsertManyResult result = database.getCollection("test_collection")
        .insertMany(List.of(new Document("ping", 1), new Document("ping", 2)));
result.getInsertedIds().forEach((k, v) -> System.out.println(k + ": " + v));

// ------ update document ------
final MongoDatabase database = mongoClient.getDatabase("test_db");
final Bson filters = Filters.eq("name", "Alice");
final Bson updates = Updates.combine(Updates.inc("age", 2), Updates.set("name", "Bob"));
final UpdateResult result = database.getCollection("test_collection").updateOne(filters, updates);

// ------ update multiple documents ------
final MongoDatabase database = mongoClient.getDatabase("test_db");
final Bson filters = Filters.eq("name", "Alice");
final Bson updates = Updates.combine(Updates.inc("age", 2), Updates.set("name", "Bob"));
final UpdateResult result = database.getCollection("test_collection").updateMany(filters, updates);

// ------ delete document ------
final MongoDatabase database = mongoClient.getDatabase("test_db");
final Bson filters = Filters.eq("name", "Alice");
// If we don't specify a filter, MongoDB matches the first document in the collection.
final DeleteResult result = database.getCollection("test_collection").deleteOne(filters);
        
// ------ delete multiple documents ------
final MongoDatabase database = mongoClient.getDatabase("test_db");
final Bson filters = Filters.eq("name", "Alice");
final DeleteResult result = database.getCollection("test_collection").deleteMany(filters);

// ------ transaction ------
final ClientSession clientSession = mongoClient.startSession();
...
try {
    clientSession.withTransaction(txnBody);
} catch (RuntimeException e) {
    System.out.println(e);
} finally {
    clientSession.close();
}

// ------ transaction body ------
final TransactionBody<String> txnBody = () -> {
    final MongoDatabase database = mongoClient.getDatabase("test_db");

    final Document document = new Document("_id", new ObjectId())
            .append("name", "Bob")
            .append("age", 25)
            .append("birthday", LocalDate.of(1999, 2, 3))
            .append("phone", new Document().append("number", "123-456-789")
                    .append("type", "home"));
    database.getCollection("test_collection").insertOne(document);

    final Bson filters = Filters.eq("name", "Bob");
    final Bson updates = Updates.combine(Updates.inc("age", 2), Updates.set("name", "Boby"));
    database.getCollection("test_collection").updateOne(filters, updates);

    return "Done";
};
```
