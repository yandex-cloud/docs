# Search using {{ ES }}

{{ ES }} acts not only as document storage, but also as a tool for searching and {% if lang == "ru" and audience != "internal" %}[analyzing data](../../glossary/data-analytics.md){% else %}analyzing data{% endif %} in the documents using:

1. Structured queries similar to SQL queries: to find documents with a set of fields that meet the specified conditions.
1. Full text queries: to find a given string in documents and sort the results by relevance. These queries also allow you to use additional search functions, including autocomplete and search for phrases and similar strings. To learn more about full-text search, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-overview.html).
1. Complex queries that combine the previous types of queries.

In {{ mes-name }}, you can perform all these types of queries using the following tools:

- [JSON queries](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-search.html) written using [{{ ES }} QueryDSL](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html).
- [URI queries](https://www.elastic.co/guide/en/elasticsearch/reference/6.8/search-uri-request.html), in which a Lucene query string is passed in the GET parameter: `?q=<query string>`.
- [SQL queries](https://www.elastic.co/guide/en/elasticsearch/reference/current/sql-overview.html). {{ ES }} fully supports SQL queries without requiring any intermediary between itself and SQL.

Some search features in {{ ES }}:

- Searches can be performed within a specific [index](indexing.md) in a cluster or across multiple indexes.
- [Asynchronous search](https://www.elastic.co/guide/en/elasticsearch/reference/current/async-search-intro.html) is supported for large queries that can be performed over a long period of time.

To learn more about search options, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-your-data.html).

