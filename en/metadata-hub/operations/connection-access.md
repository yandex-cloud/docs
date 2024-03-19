---
title: "Set up access right to a connection"
description: "By following this instruction, you can configure access rights to the connection."
---

# Set up access rights for a connection

{% include notitle [preview](../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}) select [the folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create a connection.
  1. Select the **{{ metadata-hub-name }}** service.
  1. On the left panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ connection-manager-name }}**/ **Connections**.
  1. Click the connection name.
  1. On the left panel, select ![image](../../_assets/console-icons/persons.svg) **Access bindings** and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the opened window, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.select-subject }}**.
  1. Select the group, user, or [service account](../../iam/concepts/users/service-accounts.md) to configure connection access.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required [roles](../security/index.md#roles-list).
  1. Click **{{ ui-key.yacloud.common.save }}**.   

{% endlist %}

## See also {#see-also}

* [{#T}](../concepts/connection-manager.md)
* [{#T}](../../iam/concepts/access-control/index.md)
* [{#T}](../security/index.md)
