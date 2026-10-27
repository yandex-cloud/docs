---
title: '{{ datalens-full-name }} error: ERR.DS_API.DB.CH.READONLY_USER'
description: This page describes the `{{ CH }} user must be correctly configured to use readonly 1 option (see docs)` {{ datalens-full-name }} error. For other readonly options user should have parameter readonly set to 0 or 2.
---

# [{{ datalens-full-name }}] {{ CH }} user must be correctly configured to use readonly 1 option (see docs). For other readonly options user should have parameter readonly set to 0 or 2

`ERR.DS_API.DB.CH.READONLY_USER`

This error occurs because of restrictions in the {{ CH }} user profile or because the server-side `readonly` setting does not match the {{ datalens-name }} connection setting.

To fix this error:

* For data reads, set `Readonly` to `2` in [advanced connection settings](../../operations/connection/create-clickhouse.md#clickhouse-additional-settings).
* If `Readonly` is set to `1`, the {{ CH }} administrator should configure the user as described in [this guide](../../operations/connection/create-clickhouse.md).
* For data writes, use a user with proper permissions and set `Readonly` to `0` in advanced connection settings.
* In other cases, remove write operations.
