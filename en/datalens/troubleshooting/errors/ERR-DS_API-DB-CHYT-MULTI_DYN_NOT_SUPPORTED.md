---
title: '{{ datalens-full-name }} error: ERR.DS_API.DB.CHYT.MULTI_DYN_NOT_SUPPORTED'
description: This page describes the `Reading multiple dynamic tables or dynamic table together with static table is not supported in CHYT` {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Reading multiple dynamic tables or dynamic table together with static table is not supported in CHYT

`ERR.DS_API.DB.CHYT.MULTI_DYN_NOT_SUPPORTED`

This error occurs when one CHYT query reads several dynamic tables or reads both a dynamic and static table at the same time.

To fix it, leave only one dynamic table in the query, split the query, or first materialize relevant data into a single static table.
