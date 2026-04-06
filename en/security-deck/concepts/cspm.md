---
title: '{{ cspm-full-name }} ({{ cspm-name }}) in {{ sd-full-name }}'
description: '{{ cspm-full-name }} ({{ cspm-name }}) ensures that the cloud infrastructure and applications deployed in {{ yandex-cloud }} comply with complex security requirements and best practices.'
---

# {{ cspm-full-name }} ({{ cspm-name }})

{% include [note-preview](../../_includes/note-preview.md) %}

{% include [cspm-basic-intro](../../_includes/security-deck/cspm-basic-intro.md) %}

The check resumes every 8 hours. Upon completion, the system updates the violation count, applies created exceptions, and sends alerts.

## Standards {#standards}

Currently, {{ cspm-full-name }} ({{ cspm-name }}) supports infrastructure compliance checks for the following security standards:

{% include [cspm-sec-standard-list](../../_includes/security-deck/cspm-sec-standard-list.md) %}

## Rules {#rules}

You can [view](../operations/cspm/view-rules.md) the information about {{ cspm-name }} rules currently enforced in your [workspace](./workspace.md) and compliance violations detected in the workspace infrastructure on the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page in the **{{ ui-key.yacloud_org.security.controls.ControlsPageLayout.configuration_w7Kw7 }}** tab. This section lists the control rules that form a part of the [security standards](#standards) specified for the current workspace.

### General information about rules {#general-info}

{% include [cspm-view-general-info](../../_includes/security-deck/cspm-view-general-info.md) %}

### Detailed information about a rule {#detailed-info}

{% include [cspm-view-detailed-info](../../_includes/security-deck/cspm-view-detailed-info.md) %}

## Exceptions to rules {#exceptions}

Exceptions allow you to flexibly configure when and for which objects {{ cspm-name }} should ignore the results of a rule check. You can [view the list of exceptions](../operations/cspm/manage-exceptions.md#view-exceptions-list) set for your workspace in the [{{ sd-name }} interface]({{ link-sd-main }}) under **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.

You can specify the following settings for an exception when [creating it](../operations/cspm/manage-exceptions.md#create-exception):

* **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.info_type_1dxbZ }}**: Action which the exception will trigger:

    {% include [cspm-exception-types](../../_includes/security-deck/cspm-exception-types.md) %}

* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}**: Resources you want to exclude when checking the security rules:

    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.allResources_2ax5E }}`: To exclude all resources controlled in the [workspace](./workspace.md).
    * `Selected resources`: To exclude only explicitly specified resources.
* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}**: {{ cspm-name }} rules to disregard when checking the selected resources:

    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}`: To disregard all security rules for the selected resources.
    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}`: To disregard an explicitly specified set of rules when checking the selected resources for compliance.
* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}**: Reason for the exception. Specify it as plain text in any form.

To cancel the limitations on rule compliance checks imposed by an exception, [delete](../operations/cspm/manage-exceptions.md#delete-exception) that exception.

#### See also {#see-also}

* [{#T}](./workspace.md)
* [{#T}](../operations/cspm/view-rules.md)
* [{#T}](../operations/cspm/manage-exceptions.md)