---
title: Tutorial on changing access permissions for a desktop group in {{ cloud-desktop-full-name }}
description: In this tutorial, you will learn how to change access permissions for a desktop group in {{ cloud-desktop-full-name }}.
---

# Changing desktop group permissions

{% include [access-options](../../../_includes/cloud-desktop/access-options.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the desktop group is in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) to the right of the desktop group you want to change access permissions for and select **{{ ui-key.yacloud.vdi.button_acl }}**.
  1. In the **{{ ui-key.yacloud.component.acl-dialog.label_title }}** window that opens, grant or revoke the appropriate permissions.

{% endlist %}
