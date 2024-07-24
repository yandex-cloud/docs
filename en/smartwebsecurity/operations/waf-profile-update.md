---
title: "Updating basic WAF profile settings"
description: "Follow this guide to update basic WAF profile settings."
---

# Updating basic WAF profile settings

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to update basic [WAF profile](../concepts/waf.md) settings in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Go to ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Click ![options](../../_assets/console-icons/ellipsis.svg) next to the profile and select **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. On the profile page, update these settings:
      * **{{ ui-key.yacloud.common.name }}**​.
      * **{{ ui-key.yacloud.common.description }}**​.
      * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md). To add a label, click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### See also {#see-also}

* [{#T}](waf-profile-delete.md)
* [{#T}](rule-add.md)
* [{#T}](rule-update.md)
