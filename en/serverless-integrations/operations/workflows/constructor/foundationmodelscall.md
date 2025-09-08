---
title: Adding integration with {{ foundation-models-name }} to a {{ sw-name }} workflow
description: Follow this guide to add an integration with {{ foundation-models-full-name }} to a {{ sw-full-name }} workflow using the workflow step constructor.
---

# Integration with {{ foundation-models-full-name }}

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![foundation-models-icon](../../../../_assets/foundation-models-icon.svg) **{{ foundation-models-name }}** element to the relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **{{ foundation-models-name }}** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. Select:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_description_yagpt_latest }}` to use the `{{ gpt-pro }}` model and, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_yagpt_latest_view_spec_layout_title }}** field, select the [folder](../../../../resource-manager/concepts/resources-hierarchy.md#folder) the model will be invoked in.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_description_custom }}` to use a fine-tuned model, and specify the fine-tuned model's ID ([URI](../../../../foundation-models/concepts/tuning/index.md#requests)) in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_custom_view_spec_layout_title }}** field.

      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_temperature_view_spec_layout_title }}** field, set the model's response variability: the higher the temperature value, the less predictable the result. The range of possible values ​​is from `0` to `1`.
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_max_tokens_view_spec_layout_title }}** field, limit the maximum allowed number of [tokens](../../../../foundation-models/concepts/generation/tokens.md) in the model's response.
      1. Under **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_view_spec_layout_title }}**, select:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_description_json }}` to specify the [context](../../../../foundation-models/concepts/index.md#prompt) of your query to the model in [JSON](https://en.wikipedia.org/wiki/JSON) string format.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_description_messages }}` to set the context of your query to the model as a sequence of individual messages in `<Message_sender_ID>`:`<Message_text>` format using the ![plus](../../../../_assets/console-icons/plus.svg) button.

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/foundationmodelscall.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
