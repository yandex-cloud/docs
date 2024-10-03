---
title: Elasticsearch indexes
description: When saving a document to {{ ES }}, it is indexed and placed in a specific {{ ES }} index of the user's choice. This makes it available for search and analysis. One may think of an index as a data table in a traditional DBMS.
---

# Indexes

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

When saving a document to {{ ES }}, it is indexed and placed in a user-specified _index_, making it available for search and analysis. One may think of an index as a data table in a traditional DBMS.

In {{ ES }}, a document is a set of fields where each field is a `key: value` pair. The index stores optimized documents to enable quickly searching documents by field. Such optimization is achieved with each document field having a specific type. This is how the field data is effectively stored in the index.

Unlike a traditional DBMS, to save the document in the index, {{ ES }} does not require the explicit specification of the schema, i.e., links between document fields and their types. Even though it is the recommended approach, you can save documents to the index without explicitly specifying the field types; {{ ES }} will try to determine the type automatically for each field in the document. As a result, you can quickly add documents to {{ ES }} storage and start working with them.

To learn more about how indexes work, see the [documentation {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/documents-indices.html).

In multihost clusters, index [sharding and replication](scalability-and-resilience.md) are supported. This makes it easier to scale a cluster and improves its fault tolerance.