---
title: '{{ datalens-full-name }} error: ERR.DS_API.CONNECTION.MIGRATION.CONNMAN.INSUFFICIENT_USE_PERMISSION'
description: This page describes the `No access to {{ connection-manager-name }} connection` error in {{ datalens-full-name }}.
alternate:
  - href: en/datalens/troubleshooting/errors/ERR-DS_API-CONNECTION-MIGRATION-CONNMAN-INSUFFICIENT_USE_PERMISSION.md
    type: text/markdown
    title: Markdown version
---

# [{{ datalens-full-name }}] No access to {{ connection-manager-name }} connection

`ERR.DS_API.CONNECTION.MIGRATION.CONNMAN.INSUFFICIENT_USE_PERMISSION`

No access to {{ connection-manager-name }} connection. There is a connection for a database user, but you do not have the permissions to use it. You need the `connection-manager.user` role in this catalog or directly for the connection.

Request the `connection-manager.user` [role]({{ link-docs }}/metadata-hub/security/connection-manager-roles#connection-manager-user) in this catalog or directly for the connection from the administrator and repeat the migration.
