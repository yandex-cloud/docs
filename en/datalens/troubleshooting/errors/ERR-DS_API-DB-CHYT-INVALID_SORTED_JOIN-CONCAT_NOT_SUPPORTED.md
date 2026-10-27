---
title: '{{ datalens-full-name }} error: ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.CONCAT_NOT_SUPPORTED'
description: This page describes the `Joining concatenation of multiple tables is not supported` {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Joining concatenation of multiple tables is not supported

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.CONCAT_NOT_SUPPORTED`

This error occurs when attempting to perform a sorted JOIN with a source representing the concatenation of multiple tables, e.g., list or range of tables.

Use a single table in the join, pre-aggregate the data into a junction table, or move the concatenation to an SQL subquery, and select a supported JOIN strategy.
