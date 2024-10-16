# DynamoDB tables

In {{ ydb-name }} [serverless operation mode](serverless-and-dedicated.md#serverless), you can use _document tables_.

{{ ydb-name }} document tables are compatible with [Amazon DynamoDB tables](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.CoreComponents.html#HowItWorks.CoreComponents.TablesItemsAttributes).

A document table contains data represented as a set of items. When creating a document table, you must specify a primary key that serves as a unique identifier for table items.

An item is a group of attributes. Each item has a unique ID or primary key that distinguishes them from any other table item. A primary key is a set of attributes. All table items must contain attributes that are part of the table's primary key. Except for the primary key, items may contain arbitrary attributes of arbitrary types. Document table items are pretty much similar to rows, records, or tuples in other DBMS's.

An attribute is a data unit represented in a document table as a key-value pair. Attributes are much like fields or columns in other DBMS's.

To work with document tables, [use the Document API](../docapi/tools/aws-setup.md). You can only use the [{{ ydb-short-name }} API](https://ydb.tech/docs/en/reference/ydb-sdk/) in the read mode.
