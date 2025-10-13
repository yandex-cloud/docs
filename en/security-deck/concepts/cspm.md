---
title: Cloud Security Posture Management ({{ cspm-name }}) in {{ sd-full-name }}
description: Cloud Security Posture Management ({{ cspm-name }}) ensures that the cloud infrastructure and applications deployed in {{ yandex-cloud }} comply with complex security requirements and best practices.
---

# Cloud Security Posture Management ({{ cspm-name }})

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

{% include [cspm-basic-intro](../../_includes/security-deck/cspm-basic-intro.md) %}

## Standards {#standards}

Currently, Cloud Security Posture Management ({{ cspm-name }}) supports infrastructure compliance checks for the following security standards:

{% include [cspm-sec-standard-list](../../_includes/security-deck/cspm-sec-standard-list.md) %}

## Rules {#rules}

You can [view](../operations/cspm/view-rules.md) the information about {{ cspm-name }} rules currently enforced in your [workspace](./workspace.md) and compliance violations detected in the workspace infrastructure on the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page in the **{{ ui-key.yacloud_org.security.controls.ControlsPageLayout.configuration_w7Kw7 }}** tab. This section lists rules that are part of [security standards](#standards) applied to the current workspace.

### General information about rules {#general-info}

{% include [cspm-view-general-info](../../_includes/security-deck/cspm-view-general-info.md) %}

### Detailed information about a rule {#detailed-info}

{% include [cspm-view-detailed-info](../../_includes/security-deck/cspm-view-detailed-info.md) %}

## Exceptions to rules {#exceptions}

Exceptions allow you to flexibly configure when and for which objects {{ cspm-name }} should ignore the results of a rule check. You can [view the list of exceptions](../operations/cspm/manage-exceptions.md#view-exceptions-list) set for your workspace in the [{{ sd-name }} interface]({{ link-sd-main }}) under **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.

You can specify the following settings for an exception when [creating it](../operations/cspm/manage-exceptions.md#create-exception):

* **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.info_type_1dxbZ }}**: Action which the exception will trigger:

    {% include [cspm-exception-types](../../_includes/security-deck/cspm-exception-types.md) %}

* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}**: Resources you want to exclude when checking security rules:

    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.allResources_2ax5E }}`: To exclude all controlled resources in the [workspace](./workspace.md).
    * `Selected resources`: To exclude only the explicitly selected resources.
* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}**: {{ cspm-name }} rules for which the selected resources should not be checked:

    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}`: To exclude all security rules from compliance checks for the selected resources.
    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}`: To exclude explicitly indicated rules from compliance checks for the selected resources.
* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}**: Reason for the exception. Specify it as plain text in any form.

To cancel the limitations on rule compliance checks imposed by an exception, [delete](../operations/cspm/manage-exceptions.md#delete-exception) that exception.

#### See also {#see-also}

* [{#T}](./workspace.md)
* [{#T}](../operations/cspm/view-rules.md)
* [{#T}](../operations/cspm/manage-exceptions.md)