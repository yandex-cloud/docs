---
title: '{{ datalens-full-name }} error ERR.DS_API.CONNECTION_CONFIG.SUBSELECT_NOT_ALLOWED'
description: This page describes the Subquery source is disallowed in the connection settings {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Subquery source is disallowed in the connection settings

`ERR.DS_API.CONNECTION_CONFIG.SUBSELECT_NOT_ALLOWED`

This error occurs when subqueries to the source are disabled in the connection settings.

To fix it, turn on **SQL query access level** in the connection settings.

{% note info %}

This option is available for some database [connections](../../concepts/connection/index.md). For more details, see the description of the specific connection type.

{% endnote %}