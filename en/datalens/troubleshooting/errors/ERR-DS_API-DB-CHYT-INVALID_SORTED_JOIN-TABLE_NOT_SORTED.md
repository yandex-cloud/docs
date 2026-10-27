---
title: '{{ datalens-full-name }} error: ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.TABLE_NOT_SORTED'
description: This page describes the `Tables should be sorted` {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Tables should be sorted

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.TABLE_NOT_SORTED`

This error occurs when one of the tables in a sorted JOIN is not sorted. The detailed error message specifies the problematic table.

To fix this error, sort and save the table using an appropriate key, or use a pre-sorted table. If this is not possible, use a different JOIN strategy in your SQL query or prepare an intermediate source.
