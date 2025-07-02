---
title: Adding parallel logic to a {{ sw-name }} workflow
description: Follow this guide to add parallel logic, which will run multiple concurrent step sequences (branches), to a {{ sw-full-name }} workflow using the workflow step constructor.
---

# Adding parallel logic

The Parallel control step executes multiple branches (sequences of steps) concurrently. The result of the step is an object in which keys and values are the names of the execution branches and their outputs, respectively. Read more about the [workflow state during the Parallel step](../../../concepts/workflows/workflow.md#state-for-Parallel).

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** section on the left side of the screen, drag the ![parallel-step-icon](../../../../_assets/serverless-integrations/parallel-step-icon.svg) **Parallel** element to the relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **Parallel** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. Set the number of concurrent branches in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_parallel-step-concurrency-field }}** field. For example, if you set it to `2` while a total of 5 branches were added, no more than 2 randomly selected branches will be executed simultaneously.
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. To add a new execution branch:

      1. In the bottom-right corner of the **Parallel** section, click ![circle-plus-fill](../../../../_assets/console-icons/circle-plus-fill.svg).
      1. In the dialog box that opens, enter the name of the branch to add. Click **{{ ui-key.yacloud.common.create }}**.
  1. To add a new step to an execution branch, drag the step to the area marked by the dotted line under **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** or **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}**.

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/management/parallel.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
