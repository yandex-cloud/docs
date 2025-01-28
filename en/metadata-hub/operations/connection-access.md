---
title: Configuring connection access permissions
description: Follow this guide to configure connection access permissions.
---

# Configuring connection access permissions

{% include notitle [preview](../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Management console {#console}
    
  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) in which to configure access to a connection.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Click the connection name.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the window that opens, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.select-subject }}**.
  1. Select the group, user, or [service account](../../iam/concepts/users/service-accounts.md) to be granted access to the connection.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [roles](../security/index.md#roles-list).
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## See also {#see-also}

* [{#T}](../concepts/connection-manager.md)
* [{#T}](../../iam/concepts/access-control/index.md)
* [{#T}](../security/index.md)
