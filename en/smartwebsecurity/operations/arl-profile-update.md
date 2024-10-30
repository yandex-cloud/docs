---
title: Updating basic ARL profile settings
description: Follow this guide to update basic ARL profile settings.
---

# Updating basic ARL profile settings

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the [ARL profile](../concepts/arl.md) resides in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. In the profile row, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. In the window that opens, edit the parameters:
      * **{{ ui-key.yacloud.common.name }}**​.
      * **{{ ui-key.yacloud.common.description }}**​.
      * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md). To add a label, click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### See also {#see-also}

* [{#T}](arl-profile-delete.md)
* [{#T}](arl-rule-add.md)
* [{#T}](arl-rule-update.md)

