---
title: Adding interaction with {{ ai-studio-name }} models to a {{ sw-name }} workflow
description: Follow this guide to add interaction with {{ ai-studio-name }} models to your {{ sw-full-name }} workflow using the workflow step constructor.
---

# Interacting with {{ ai-studio-name }} models

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ai-studio-name }}** section on the left side of the screen, drag the ![foundation-models-icon](../../../../_assets/foundation-models-icon.svg) **{{ ai-studio-name }} models** element to relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **{{ ai-studio-name }} models** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}
      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}      
      1. Select an [AI model](../../../../ai-studio/concepts/generation/index.md):

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_description_generate }}`" %}
        
          1. Select:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_model_description_base_model }}` to use `{{ gpt-pro }}` or `{{ gpt-lite }}` and, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_yagpt_latest_view_spec_layout_title }}** field, select the [folder](../../../../resource-manager/concepts/resources-hierarchy.md#folder) the model will be invoked in.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_model_description_custom }}` to use a fine-tuned model, and specify the model's ID ([URI](../../../../ai-studio/concepts/tuning/index.md#requests)) in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_custom_view_spec_layout_title }}** field.

          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_temperature_view_spec_layout_title }}** field, set the model's response variability: the higher the temperature, the less predictable will be the result. The possible values range from `0` to `1`.
          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_max_tokens_view_spec_layout_title }}** field, limit the maximum allowed number of [tokens](../../../../ai-studio/concepts/generation/tokens.md) in the model's response.
          1. Under **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_view_spec_layout_title }}**, select:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_description_messages }}` to set the context of your request to the model as a sequence of individual messages in `<Message_sender_role>`:`<Message_text>` format using the ![plus](../../../../_assets/console-icons/plus.svg) button.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_description_json }}` to set the [context](../../../../ai-studio/concepts/index.md#prompt) of your request to the model in [JSON](https://en.wikipedia.org/wiki/JSON) string format.

          1. Optionally, under **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_reasoning_mode_view_spec_layout_title }}**, select the [reasoning mode](../../../../ai-studio/concepts/generation/chain-of-thought.md) status:
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_reasoning_mode_description_reasoning_mode_unspecified }}`: Not specified.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_reasoning_mode_description_disabled }}`: Reasoning mode is disabled. 
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_reasoning_mode_description_enabled_hidden }}`: Reasoning mode is enabled.
          1. Optionally, under **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_view_spec_layout_title }}**, select [response format](../../../../ai-studio/concepts/generation/structured-output.md):

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_description_none }}`: The model returns a response formatted with [Markdown](https://en.wikipedia.org/wiki/Markdown).
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_description_json_object }}`: The model returns a response as a JSON object.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_description_json_schema }}`: The model returns a response as a JSON schema set in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_properties_json_schema_view_spec_layout_title }}** field.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_description_classify }}`" %}

          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_custom_view_spec_layout_title }}** field, enter a fine-tuned model's ID. For more information, see [{#T}](../../../../ai-studio/concepts/classifier/models.md).
          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_text_view_spec_layout_title }}** field, enter the message text.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_description_few_shot_classify }}`" %}

          1. Select the model and the [folder](../../../../resource-manager/concepts/resources-hierarchy.md#folder) it will be invoked in.
          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_task_description_view_spec_layout_title }}** field, enter the text description of the task for the classifier.
          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_text_view_spec_layout_title }}** field, enter the message text.
          1. Under **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_labels_view_spec_layout_title }}**, select:
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_labels_description_labels_array }}` to enter classes, click ![plus](../../../../_assets/console-icons/plus.svg).
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_labels_description_labels_json }}` and enter classes in [JSON](https://en.wikipedia.org/wiki/JSON) format under **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_labels_properties_labels_json_view_spec_title }}**.

          1. Optionally, under **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_samples_view_spec_layout_title }}**, select: 
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_samples_description_samples_array }}` to enter request examples using ![plus](../../../../_assets/console-icons/plus.svg).
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_labels_description_labels_json }}` and enter request examples in JSON format under **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_labels_properties_labels_json_view_spec_title }}**.
        
          {% endcut %}
      
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/foundationmodelscall.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
