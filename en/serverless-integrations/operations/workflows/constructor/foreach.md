---
title: Adding the Foreach loop to a {{ sw-name }} workflow
description: Follow this guide to use the workflow step constructor to add a sequence of steps to apply to each input data item to a {{ sw-full-name }} workflow.
---

# Adding the Foreach loop

You can use the Foreach control step to set a sequence of steps to apply to each input data item. The output is an array of execution results for all steps in the sequence. Read more about the [workflow state during the Foreach step](../../../concepts/workflows/workflow.md#state-for-Foreach).

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** section on the left side of the screen, drag the ![code-fork](../../../../_assets/console-icons/code-fork.svg) **Foreach** element to desired workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the added **Foreach** block to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. To add a new step to the sequence, drag it to the area marked by the dotted line under **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** or **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}**.

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/management/foreach.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
