---
title: Adding integration with an AI agent to a {{ sw-name }} workflow
description: Follow this guide to add integration with an AI agent to a {{ sw-full-name }} workflow using the workflow step constructor.
---

# Integration with an AI agent

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![foundation-models-icon](../../../../_assets/foundation-models-icon.svg) **AI agent** element to the appropriate workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the added **AI agent** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. Under **AI agent settings**:

          1. In the **Model** field, select a large language model for the AI agent to use.
          1. In the **Role** field, describe the role that defines the AI agent's functions and experience, e.g., `car parts consultant`.
          1. In the **Goal** section, describe an individual goal that guides the AI agent's decision-making, e.g., `help with the choice of parts for the specified vehicle`.
          1. In the **Backstory** field, specify a backstory defining the AI agent's personality and enriching the context, e.g., `you find the best value for money car parts and briefly explain your choice`.
      1. In the **Tasks** section, use the ![plus](../../../../_assets/console-icons/plus.svg) button to set the tasks the AI agent has to complete:

          * In the **Task description** field, describe the essence of the task you want the AI agent to perform, e.g., `find an oil filter for a BMW 320i`.
          * In the **Expected result** field, describe the format you expect to get the result in, e.g., `a list of addresses of stores selling the car parts you need`.

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/aiagent.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
