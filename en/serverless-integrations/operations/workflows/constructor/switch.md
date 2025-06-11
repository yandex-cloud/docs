---
title: Adding the Switch step for selecting the further execution path to a {{ sw-name }} workflow
description: Follow this guide to add the Switch step for selecting the further execution path to a {{ sw-full-name }} workflow using the workflow step constructor.
---

# Adding the Switch step for selecting a further execution path

With the Switch control step, you can define conditions for selecting the further execution path in your workflow. This way, only one path can be selected: the one where the defined condition first returns `true`.

If all conditions return `false`, the workflow will be executed for the path specified in the default condition; if there is no default condition, the workflow execution will fail.

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** section on the left side of the screen, drag the ![switch-icon](../../../../_assets/serverless-integrations/switch-icon.svg) **Switch** element to desired workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the added **Switch** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. To add a new execution branch:

      1. In the bottom-right corner of the **Switch** section, click ![circle-plus-fill](../../../../_assets/console-icons/circle-plus-fill.svg).

      1. In the window that opens, add a condition for selecting the execution branch. To specify the condition, use the jq format. To add the default condition, enable **{{ ui-key.yacloud.serverless-workflows.edit-switch-choice_default-field }}**. The default condition is created automatically if Switch is not the first step in the workflow. Once the condition is added, click **{{ ui-key.yacloud.common.create }}**. 

      To delete an execution branch, add any integration step to it and delete that step using ![circle-xmark-fill](../../../../_assets/console-icons/circle-xmark-fill.svg).

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/management/switch.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
