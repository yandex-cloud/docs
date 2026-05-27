* **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.info_type_1dxbZ }}**: Action which the exception will trigger:

    {% include [cspm-exception-types](./cspm-exception-types.md) %}

* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}**: Resources you want to exclude when checking the security rules:

    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.allResources_2ax5E }}`: To exclude all resources controlled in the [workspace](../../security-deck/concepts/workspace.md).
    * `Selected resources`: To exclude only explicitly specified resources.
* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}**: Security control rules to disregard when checking the selected resources:

    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}`: To disregard all security rules for the selected resources.
    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}`: To explicitly specify the rules you want to disregard when checking the selected resources for compliance.
* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}**: Reason for the exception. Specify it as plain text in any form.