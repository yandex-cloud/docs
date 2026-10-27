---
title: '{{ datalens-full-name }} error: ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN'
description: This page describes the `Invalid sorted JOIN` {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Invalid sorted JOIN

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN`

Sorting error when joining tables in CHYT.

For a sorted JOIN, both tables must be sorted, and the `ON`/`USING` condition must use simple equalities to match identical prefixes of key columns.

To fix this error, try the following:

* Fix table sorting order or the join condition.
* For a SQL query, choose a different join strategy, e.g., `GLOBAL JOIN` or a subquery.
* For a dataset, create a junction table or SQL source.
