---
title: Searching with {{ OS }} in {{ mos-full-name }}
description: '{{ OS }} is a tool for searching and analyzing data using structured queries, full-text queries, and complex queries.'
---

# Searching with {{ OS }}

{{ OS }} is used as a tool for searching and analyzing data in documents through:

* Structured queries similar to SQL queries: to find documents with a set of fields that meet the specified conditions.
* Full-text queries: to find a certain string in the documents and sort the results by relevance. These queries also allow you to use additional search functions, including autocomplete and search for phrases and similar strings. To learn more about full-text search, see the [{{ OS }} documentation]({{ os.docs }}/search-plugins/sql/full-text/).
* Complex queries that combine the above types of queries.

In {{ mos-name }}, you can run queries of all these types using pre-installed search plugins, such as [Querqy]({{ os.docs }}/search-plugins/querqy/index/), [SQL and PPL]({{ os.docs }}/search-plugins/sql/index/), and more.

Search features in {{ OS }} include the following:

* You can run search within a specific [index](indexing.md) in a cluster or across multiple indexes.
* [Asynchronous search]({{ os.docs }}/search-plugins/async/index/) is supported for large queries that may take a long time to run.

To learn more about search options, see the [{{ OS }} documentation]({{ os.docs }}/opensearch/search/index/).
