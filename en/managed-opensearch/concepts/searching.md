# Search using {{ OS }}

{{ OS }} is used as a tool for searching and analyzing data} in documents using:

* Structured queries similar to SQL queries: to find documents with a set of fields that meet the specified conditions.
* Full text queries: to find a given string in documents and sort the results by relevance. These queries also allow you to use additional search functions, including autocomplete and search for phrases and similar strings. To learn more about full-text search, see the [{{ OS }} documentation]({{ os.docs }}/search-plugins/sql/full-text/).
* Complex queries that combine the previous types of queries.

In {{ mos-name }}, you can run queries of any of these types using pre-installed plugins: [Querqy]({{ os.docs }}/search-plugins/querqy/index/), [SQL and PPL]({{ os.docs }}/search-plugins/sql/index/), and more.

Some search features in {{ OS }}:

* Searches can be performed within a specific [index](indexing.md) in a cluster or across multiple indexes.
* [Asynchronous search]({{ os.docs }}/search-plugins/async/index/) is supported for large queries that may take a long time to run.

To learn more about search options, see the [{{ OS }} documentation]({{ os.docs }}/opensearch/search/index/).
