---
title: Добавить интеграцию с {{ foundation-models-name }} в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить интеграцию с {{ foundation-models-full-name }} в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Интеграция с {{ foundation-models-full-name }}

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** в левой части экрана перетащите элемент ![foundation-models-icon](../../../../_assets/foundation-models-icon.svg) **{{ foundation-models-name }}** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ foundation-models-name }}**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. Выберите:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_description_yagpt_latest }}`, чтобы использовать модель `{{ gpt-pro }}`, и в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_yagpt_latest_view_spec_layout_title }}** выберите [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет вызываться модель.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_description_custom }}`, чтобы использовать дообученную модель, и в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_custom_view_spec_layout_title }}** укажите идентификатор ([URI](../../../../foundation-models/concepts/tuning/index.md#requests)) дообученной модели.

      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_temperature_view_spec_layout_title }}** задайте вариативность ответа модели: чем выше значение температуры, тем более непредсказуемым будет результат выполнения запроса. Диапазон возможных значений – от `0` до `1`.
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_max_tokens_view_spec_layout_title }}** задайте ограничение на максимально допустимое количество [токенов](../../../../foundation-models/concepts/yandexgpt/tokens.md) в ответе модели.
      1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_view_spec_layout_title }}** выберите:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_description_json }}`, чтобы задать [контекст](../../../../foundation-models/concepts/index.md#prompt) запроса к модели в формате [JSON](https://ru.wikipedia.org/wiki/JSON)-строки.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_description_messages }}`, чтобы задать контекст запроса к модели в виде последовательности отдельных сообщений в формате `<Идентификатор_отправителя_сообщения>`:`<Текст_сообщения>`, используя кнопку ![plus](../../../../_assets/console-icons/plus.svg).

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/foundationmodelscall.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
