---
title: Adding the Fail step to a workflow in {{ sw-name }}
description: Follow this guide to use the workflow step constructor to add the Fail step, which terminates the workflow execution with an error, to a workflow in {{ sw-full-name }}.
---

# Adding the Fail step

The Fail control step terminates a workflow execution with an error. If the step is inside the [Foreach](./foreach.md) or [Parallel](./parallel.md) steps, it terminates the entire workflow execution, not just the current execution branch.

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** section on the left side of the screen, drag the ![octagon-xmark](../../../../_assets/console-icons/octagon-xmark.svg) **Fail** element to desired workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the added **Fail** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}

      1. In the **Error text** field, enter the error message that will terminate a workflow execution.

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/management/fail.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)