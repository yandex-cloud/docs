---
title: Configuring connection access permissions
description: Follow this guide to configure connection access permissions.
---

# Configuring connection access permissions


{% list tabs group=instructions %}

- Management console {#console}
    
  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) in which to configure access to a connection.
  1. [Go](../../console/operations/select-service#select-service) to **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Click the connection name.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. In the {{ ui-key.yacloud_components.acl.label.subject }} field of the window that opens, select a group, user, or [service account](../../iam/concepts/users/service-accounts.md) to provide with access to the secret.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [roles](../security/index.md#roles-list).
  1. Click **{{ ui-key.yacloud.common.save }}**.   

{% endlist %}

## See also {#see-also}

* [{#T}](../concepts/connection-manager.md)
* [{#T}](../../iam/concepts/access-control/index.md)
* [{#T}](../security/index.md)
