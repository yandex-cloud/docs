---
title: '{{ datalens-full-name }} error: ERR.DS_API.CONNECTION.MIGRATION.NO_MATCHING_CONNECTION'
description: This page describes the `No matching connection found in {{ connection-manager-name }}` {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] found no matching connection in {{ connection-manager-name }}

`ERR.DS_API.CONNECTION.MIGRATION.NO_MATCHING_CONNECTION`

No matching connection was found in {{ connection-manager-name }}. You do not have access to any connections for this cluster that use the specified database user.

To fix this error, create a connection for that user or specify a database user who already has a connection, then retry the migration.
