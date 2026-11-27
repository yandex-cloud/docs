---
title: '{{ datalens-full-name }} error: ERR.DS_API.CONNECTION.MIGRATION.CONNMAN.CREATOR_ROLE_REQUIRED'
description: This error describes the Not enough permissions to create connection {{ datalens-full-name }} error.
alternate:
  - href: en/datalens/troubleshooting/errors/ERR-DS_API-CONNECTION-MIGRATION-CONNMAN-CREATOR_ROLE_REQUIRED.md
    type: text/markdown
    title: Markdown version
---

# [{{ datalens-full-name }}], "Not enough permissions to create connection"

`ERR.DS_API.CONNECTION.MIGRATION.CONNMAN.CREATOR_ROLE_REQUIRED`

Not enough permissions to create connection. To migrate a connection, {{ datalens-name }} creates a {{ connection-manager-name }} connection on your behalf in the cluster folder. To do this, it needs the `connection_manager.editor` role for this folder. 

To fix the error, request the `connection_manager.editor` [role]({{ link-docs }}/metadata-hub/security/connection-manager-roles#connection-manager-user) in the cluster folder from the administrator and repeat the migration.
