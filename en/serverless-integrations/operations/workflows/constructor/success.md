---
title: Adding the Success step to a workflow in {{ sw-name }}
description: Follow this guide to use the workflow step constructor to add the Success step, which successfully completes the workflow execution, to a workflow in {{ sw-full-name }}.
---

# Adding the Success step

The Success control step successfully completes the workflow execution. If the step is inside the [Foreach](./foreach.md) or [Parallel](./parallel.md) steps, it terminates the entire workflow execution, not just the current execution branch.

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** section on the left side of the screen, drag the ![seal-check](../../../../_assets/console-icons/seal-check.svg) **Success** element to desired workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the added **Success** block to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/management/success.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)