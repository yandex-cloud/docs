---
title: Adding the Wait step to a workflow in {{ sw-name }}
description: Follow this guide to use the workflow step constructor to add the Wait step, which waits for a particular point in time, to a workflow in {{ sw-full-name }}.
---

# Adding the Wait step

The Wait control step suspends the execution of the workflow for a specified time interval or until a specified timestamp is reached. If the specified time interval is negative or zero, or the specified timestamp is already reached, this step will end immediately.

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** section on the left side of the screen, drag the ![clock](../../../../_assets/console-icons/clock.svg) **Wait** element to the relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **Wait** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. Under **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-type-field }}**, select:

          * `{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-type-field-duration-label }}` to specify wait duration in seconds. Specify the required value in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-duration-field }}** field.
          * `{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-type-field-until-label }}` to wait for a particular point in time. In the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-until-field }}** field, enter the required time point in [ISO 8601](https://{{ lang }}.wikipedia.org/wiki/ISO_8601) format or locate the required date using the interactive calendar ![calendar](../../../../_assets/console-icons/calendar.svg).
          
          To get wait duration or timestamp from the workflow state, enable the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-use-jq-expression-field }}** option and specify a template in jq format in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-jq-expression-field }}** field. For more information, see [{#T}](../../../concepts/workflows/templating.md).

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/management/wait.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
