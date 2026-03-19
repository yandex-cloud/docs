---
title: '{{ datalens-full-name }} error ERR.DS_API.ACTION_NOT_ALLOWED'
description: This page describes the Internal Server Error {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Internal Server Error

`ERR.DS_API.ACTION_NOT_ALLOWED`

You may get this error when trying to retrieve data via the API.

The error means the specified dataset action is not allowed in this scenario. For example, when querying dataset data, you are only allowed to add or edit fields, but you cannot change the connection or add a new table to the query.

To avoid this error, when querying dataset data, use only actions related to fields: `add_field`, `update_field`, or `delete_field`.
