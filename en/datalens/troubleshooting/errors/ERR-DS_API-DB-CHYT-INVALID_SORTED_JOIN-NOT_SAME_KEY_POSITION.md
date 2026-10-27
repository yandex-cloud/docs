---
title: '{{ datalens-full-name }} error: ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.NOT_SAME_KEY_POSITION'
description: This page describes the `Joined columns do not occupy same positions in key columns of joined tables` {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Joined columns do not occupy same positions in key columns of joined tables

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.NOT_SAME_KEY_POSITION`

This error occurs when the joined columns are at different positions in the tables’ sort keys.

To fix it, align the order of the key columns in the table schemas and match columns that occupy the same positions. If the sorting is not an option, prepare a junction table or use a different JOIN strategy in the SQL query.
