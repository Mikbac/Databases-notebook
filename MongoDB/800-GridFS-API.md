# GridFS API

https://www.mongodb.com/docs/manual/core/gridfs/

GridFS is a specification for storing and retrieving files that exceed the BSON-document size limit of 16 MB.

When storing files with GridFS, the driver splits the files into smaller chunks, each represented by a separate document
in the chunks collection. It also creates a document in the files collection that contains a file id, file name, and
other file metadata.

By default, GridFS uses two collections with a bucket named fs:

* fs.files
* fs.chunks

Each document in the fs.chunks collection represents a distinct chunk of a file as represented in GridFS.

Each document in the fs.files collection represents a file in GridFS.
