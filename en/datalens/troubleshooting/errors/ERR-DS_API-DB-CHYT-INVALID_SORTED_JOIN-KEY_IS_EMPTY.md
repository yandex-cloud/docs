---
title: '{{ datalens-full-name }} error: ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.KEY_IS_EMPTY'
description: 'This page describes the `Cannot join: key is empty` {{ datalens-full-name }} error.'
---

# [{{ datalens-full-name }}] Cannot join: key is empty

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.KEY_IS_EMPTY`

This error occurs when CHYT cannot extract a join key from the `ON`/`USING` condition.

To fix it, add at least one direct equality between the key columns and make sure the joined columns are included in the sort key prefixes of both tables.
