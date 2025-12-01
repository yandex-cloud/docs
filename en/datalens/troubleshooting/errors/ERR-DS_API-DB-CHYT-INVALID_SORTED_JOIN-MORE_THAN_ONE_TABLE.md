---
title: '{{ datalens-full-name }} error ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.MORE_THAN_ONE_TABLE'
description: This page describes the Cannot join a concatenation of tables with another table {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Cannot join a concatenation of tables with another table

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.MORE_THAN_ONE_TABLE`

When connecting to CHYT, you cannot use two table ranges in JOINs, i.e., both left and right. One of the ranges needs to be rewritten as a subquery.
