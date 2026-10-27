---
title: '{{ datalens-full-name }} error: ERR.DS_API.DB.INDEX_NOT_USED'
description: This page describes the `Filtration by any of indexed columns required` error in {{ datalens-full-name }}.
---

# [{{ datalens-full-name }}] Filtration by any of indexed columns required

`ERR.DS_API.DB.INDEX_NOT_USED`

This error occurs when a user profile requires using an index or table key, but the query filter does not do it.

To fix this error, add the filter by primary key columns or sort key columns.

If such a filter cannot be applied to your report, contact the source administrator to check the restrictions and database user's settings.
