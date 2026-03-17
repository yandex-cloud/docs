---
title: Adding interaction with {{ ai-studio-name }} agents to a workflow in {{ sw-name }}
description: Follow this guide to add interaction with {{ ai-studio-name }} agents to your workflow in {{ sw-full-name }} using the workflow step constructor.
---

# Interacting with {{ ai-studio-name }} agents

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ai-studio-name }}** section on the left side of the screen, drag the ![face-robot](../../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.ai_studio_agent_title }}** element to relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **{{ ui-key.yc-serverless-workflows.dynamic-forms.ai_studio_agent_title }}** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.ai_studio_agent_properties_prompt_template_id_view_spec_layout_title }}** field, specify the [{{ ai-studio-name }} agent]({{ link-docs-ai }}ai-studio/concepts/agents/index) ID.
      1. Under **{{ ui-key.yc-serverless-workflows.dynamic-forms.ai_studio_agent_properties_variables_view_spec_layout_title }}**, click **{{ ui-key.yc-serverless-workflows.dynamic-forms.ai_studio_agent_properties_variables_view_spec_item_label }}** to add the names and values of the variables you will use in your prompt. [Templating](../../../concepts/workflows/templating.md) is supported for variable values.

          To add multiple variables, click **{{ ui-key.yc-serverless-workflows.dynamic-forms.ai_studio_agent_properties_variables_view_spec_item_label }}** as many times as needed.

      1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.ai_studio_agent_properties_message_view_spec_layout_title }}** field, enter the incoming message to provide to the agent together with the prompt.
      1. Optionally, enable **Automatically allow tools**. If this option is off and the tool requires confirmation of use, the step will end with an error.
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/aistudioagent.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
