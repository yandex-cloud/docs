---
title: Updating basic WAF profile settings
description: Follow this guide to update basic WAF profile settings.
---

# Updating basic WAF profile settings

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the [WAF profile](../concepts/waf.md) is in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
   1. In the profile row, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
   1. On the profile editing page, update these parameters:
      * **{{ ui-key.yacloud.common.name }}**​.
      * **{{ ui-key.yacloud.common.description }}**​.
      * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md). To add a label, click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.

   1. {% include [waf-inspect-request](../../_includes/smartwebsecurity/waf-inspect-request.md) %}

   1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### See also {#see-also}

* [{#T}](waf-profile-delete.md)
* [{#T}](rule-add.md)
* [{#T}](rule-update.md)
