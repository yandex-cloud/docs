---
title: Estimating the cost of requests to {{ ydb-short-name }} via the Document API
description: This article explains how to estimate the cost of requests to {{ ydb-name }} via the Document API.
editable: false
---

# Estimating the cost of requests to {{ ydb-short-name }} via the Document API



The cost per document requested via the Document API is equal to the RU (request units) cost per unit multiplied by the document size in blocks. The size in blocks equals the size in bytes divided by the block size and rounded up. Requesting a non-existent document is the same as reading a document with a size of one block. If a request processes multiple documents, e.g., `BatchGetItem`, the total cost is equal to the sum of costs per document. If you use the `Query` and `Scan` methods, the pricing is based on the amount of read data regardless of the number of documents. 

Request type | Unit cost | Block size
--- | --- | ---
Reading (`GetItem`, `BatchGetItem`, `Query`, `Scan`) | 1 RU | 4 KB
Reading within a transaction (`TransactGetItems`) | 2 RUs | 4 KB
Writing (`PutItem`, `BatchWriteItem`, `UpdateItem`) | 2 RUs | 1 KB
Writing within a transaction (`TransactWriteItems`) | 4 RUs | 1 KB
Deleting (`DeleteItem`) | 2 RUs | N/A
Working with a DB schema (`CreateTable`, `DeleteTable`, `DescribeTable`, `ListTables`) | 0 RUs | N/A
