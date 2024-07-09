# Rules for estimating the cost of requests to {{ ydb-short-name }} via the Document API



The cost per document requested via the Document API is equal to the RU (Request Units) cost per unit multiplied by the document size in blocks. The size in blocks equals the size in bytes divided by the block size and rounded up. Requesting a non-existent document is the same as reading a document with a size of 1 block. If a request processes multiple documents (for example, `BatchGetItem`), the total cost is equal to the sum of costs per document. If you use the `Query` and `Scan` methods, pricing is based on the amount of data read regardless of the number of documents.

| Request type | Unit cost | Block size |
--- | --- | ---
| Reading (`GetItem`, `BatchGetItem`, `Query`, `Scan`) | 1 RU | 4 KB |
| Reading during a transaction (`TransactGetItems`) | 2 RUs | 4 KB |
| Writing (`PutItem`, `BatchWriteItem`, `UpdateItem`) | 2 RUs | 1 KB |
| Writing during a transaction (`TransactWriteItems`) | 4 RUs | 1 KB |
| Deleting (`DeleteItem`) | 2 RUs | N/A |
| Working with the database schema (`CreateTable`, `DeleteTable`, `DescribeTable`, `ListTables`) | 0 RU | N/A |
