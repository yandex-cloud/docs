# Service roles for managing connections using {{ connection-manager-full-name }}


With {{ connection-manager-full-name }} service roles, you can view non-secret connection data and manage connections. You can view secret connection data, such as DB passwords, in [{{ lockbox-full-name }}](../../lockbox/index.yaml). To do this, you will also need the `lockbox.payloadViewer` [role](../../lockbox/security/index.md#lockbox-payloadViewer).

### connection-manager.auditor {#connection-manager-auditor}

{% include [connection-manager.auditor](../../_roles/connection-manager/auditor.md) %}

### connection-manager.viewer {#connection-manager-viewer}

{% include [connection-manager.viewer](../../_roles/connection-manager/viewer.md) %}


### connection-manager.editor {#connection-manager-editor}

{% include [connection-manager.editor](../../_roles/connection-manager/editor.md) %}

### connection-manager.admin {#connection-manager-admin}

{% include [connection-manager.admin](../../_roles/connection-manager/admin.md) %}

### connection-manager.user {#connection-manager-user}

{% include [connection-manager.user](../../_roles/connection-manager/user.md) %}


## Roles required {#choosing-roles}

The table below lists the roles required for specific actions. You can always assign a role with more permissions. For example, you can assign the `editor` role instead of `viewer`.

| Action                                                      | Required roles                     |
|---------------------------------------------------------------|--------------------------------------|
| Getting information about connections                            | `connection-manager.viewer`          |
| Getting a list of connections                                   | `connection-manager.viewer`          | 
| Creating a connection                                           | `connection-manager.editor`          | 
| Editing a connection                                          | `connection-manager.editor`          |
| Deleting a connection                                           | `connection-manager.editor`          |
| Setting connection access permissions                        | `connection-manager.admin`           |
| Changing connection access permissions                          | `connection-manager.admin`           |