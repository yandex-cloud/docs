---
title: '{{ datalens-full-name }} error: ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.COMPOUND_EXPR_NOT_SUPPORTED'
description: This page describes the `CHYT does not support compound expressions in ON/USING clause` {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] CHYT does not support compound expressions in ON/USING clause

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.COMPOUND_EXPR_NOT_SUPPORTED`

This error occurs when the sorting condition in a table join (JOIN) in CHYT contains a composite expression instead of a direct equality between key columns.

To fix this error, try the following:

* Move calculations into a subquery or precomputed columns, and keep simple equalities of the appropriate keys in `ON`/`USING`.
* Pick a different join strategy for your SQL query, e.g., `GLOBAL JOIN`.
