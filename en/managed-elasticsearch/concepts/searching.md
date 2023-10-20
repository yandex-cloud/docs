---
title: "Searching with {{ ES }}"
description: "{{ ES }} acts both as a document storage and a tool for searching and analyzing data in documents."
---

# Searching with {{ ES }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

{{ ES }} acts both as a document storage and a tool for searching and analyzing data in the documents using:
1. Structured queries similar to SQL queries: to find documents with a set of fields that meet the specified conditions.
1. Full text queries: to find a certain string in the documents and sort the results by relevance. These queries also allow you to use additional search functions, including autocomplete and search for phrases and similar strings. To learn more about full-text search, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-overview.html).
1. Complex queries that combine the above types of queries.

In {{ mes-name }}, you can perform all these types of queries using the following tools:
- [Request JSON](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-search.html) written in [{{ ES }} QueryDSL](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html).
- [Requests URI](https://www.elastic.co/guide/en/elasticsearch/reference/6.8/search-uri-request.html) in which a Lucene query string is provided in the GET parameter: `?q=<query_string>`.
- [SQL queries](https://www.elastic.co/guide/en/elasticsearch/reference/current/sql-overview.html). {{ ES }} fully supports SQL queries without any intermediary between itself and SQL.

Search features in {{ ES }} include the following:
- You can run search within a specific [index](indexing.md) in a cluster or across multiple indexes.
- [Asynchronous search](https://www.elastic.co/guide/en/elasticsearch/reference/current/async-search-intro.html) is supported for large queries that can be performed over a long period of time.

To learn more about search options, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-your-data.html).
