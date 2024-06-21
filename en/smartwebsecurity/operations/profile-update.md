---
title: "Editing basic settings in a security profile"
description: "Follow this guide to edit basic settings in a security profile."
---

# Editing basic settings in a security profile

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to edit basic parameters for a [security profile](../concepts/profiles.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. Next to the profile to edit the basic parameters for, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
   1. In the window that opens, edit the parameters:
      * **{{ ui-key.yacloud.common.name }}**.
      * **{{ ui-key.yacloud.common.description }}**.
      * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md). To add a label, click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
      * **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}**: `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` or `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
      * [{{ captcha-name }}](../../smartcaptcha/).
   1. Click **{{ ui-key.yacloud.common.save }}**.

- API {#api}

   {% include [api-profile-update](../../_includes/smartwebsecurity/api-profile-update.md) %}

{% endlist %}

### See also {#see-also}

* [{#T}](rule-add.md)
* [{#T}](rule-update.md)
* [{#T}](host-connect.md)
* [{#T}](profile-delete.md)
