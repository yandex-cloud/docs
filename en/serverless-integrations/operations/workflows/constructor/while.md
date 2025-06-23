---
title: Adding the While loop to a {{ sw-name }} workflow
description: Follow this guide to use the workflow step constructor to add to a {{ sw-full-name }} workflow a sequence of steps which will apply to each input data item a specified number of times or while a given condition is true.
---

# Adding the While loop

You can use the While control step to set a sequence of steps to apply within a loop. The step will apply while the condition from **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-condition-field }}** is true, but only as many times as set in **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-max-iterations-field }}**. If no condition is set, the step is performed the specified number of times. If the number of iterations is not specified, the loop will continue until the condition is no longer met or the workflow [timeout](../../../concepts/limits.md) is reached.

Each execution branch within the While step (including all [Switch](./switch.md) steps) must contain an [integration](./index.md#integration-steps) step or a [Success](./success.md), [Fail](./fail.md), or [Wait](./wait.md) step.

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** section on the left side of the screen, drag the ![arrows-rotate-right](../../../../_assets/console-icons/arrows-rotate-right.svg) **While** element to the appropriate workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the added **While** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. In the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-condition-field }}** field, specify a condition in jq format that returns either the `true` or `false` string. This is a required field if the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-max-iterations-field }}** field is not set.
      1. In the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-max-iterations-field }}** field, specify the maximum number of iterations the loop can complete. This is a required field if the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-condition-field }}** value is not set.
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. To add a new step to an execution branch, drag the step you need from **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** or **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** to the area marked by the dotted line within the branch.

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/management/while.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
