---
title: '{{ datalens-full-name }} error ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.MORE_THAN_ONE_TABLE'
description: This page describes the Cannot join a concatenation of tables with another table {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Cannot join a concatenation of tables with another table

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.MORE_THAN_ONE_TABLE`

When connecting to CHYT, you cannot use two table ranges (both left and right) in a JOIN.

To fix this error, rewrite one of the ranges as a subquery.
