---
title: Configuring an error transition rule for a workflow step in {{ sw-name }}
description: Follow this guide to configure an error transition rule for an integration workflow step in {{ sw-full-name }} using the workflow step constructor.
---

# Configuring an error transition rule

For each [integration step](../../../concepts/workflows/yawl/index.md#integration-steps) in your workflow, you can configure [error transition rules](../../../concepts/workflows/yawl/index.md#catchrule) to handle errors encountered during that step. The rules will apply one by one after the retry policy.

To configure an error transition rule for a workflow integration step, do the following:

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %}
  1. In the bottom-right corner of the [integration step](../../../concepts/workflows/yawl/index.md#integration-steps) section, click ![pencil](../../../../_assets/serverless-integrations/circle-plus-fill-red.svg).
  1. Under **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-label }}**:

      1. In the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-error-list-label }}** field, select the errors that will, or will not, trigger the transition to the next workflow step.

          {% include [error-details](../../../../_includes/serverless-integrations/workflows-constructor/error-details.md) %}
      1. In the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-error-list-mode-label }}** field, select:

          * `INCLUDE`: To transition to the next workflow step on errors listed in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-error-list-label }}** field.
          * `EXCLUDE`: To transition to the next workflow step on any errors except those listed in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-error-list-label }}** field.
      1. In the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-output-field }}** field, specify a [jq template](../../../concepts/workflows/templating.md) to filter the step outputs added into the workflow state. Note that the jq template defined for this step on the **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-output-label }}** tab will not apply.

  1. To add the next step for error transition, drag the step from the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** or **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** section to the area marked with the dotted line, which was automatically added to the workflow when you created this error transition rule.

{% endlist %}

## See also {#see-also}

* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)