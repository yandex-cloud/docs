---
title: Добавить взаимодействие с моделями {{ ai-studio-name }} в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить взаимодействие с моделями {{ ai-studio-name }} в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Взаимодействие с моделями {{ ai-studio-name }}

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ai-studio-name }}** в левой части экрана перетащите элемент ![foundation-models-icon](../../../../_assets/foundation-models-icon.svg) **Модели {{ ai-studio-name }}** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Модели {{ ai-studio-name }}**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}
      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}      
      1. Выберите [AI-модель](../../../../ai-studio/concepts/generation/index.md):

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_description_generate }}`" %}
        
          1. Выберите:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_model_description_base_model }}`, чтобы использовать модель из выпадающего списка, и в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_yagpt_latest_view_spec_layout_title }}** выберите [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет вызываться модель.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_model_description_custom }}`, чтобы использовать дообученную модель, и в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_custom_view_spec_layout_title }}** укажите идентификатор ([URI](../../../../ai-studio/concepts/tuning/index.md#requests)) дообученной модели.

          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_temperature_view_spec_layout_title }}** задайте вариативность ответа модели: чем выше значение температуры, тем более непредсказуемым будет результат выполнения запроса. Диапазон возможных значений — от `0` до `1`.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_max_tokens_view_spec_layout_title }}** задайте ограничение на максимально допустимое количество [токенов](../../../../ai-studio/concepts/generation/tokens.md) в ответе модели.
          1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_view_spec_layout_title }}** выберите:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_description_messages }}`, чтобы задать контекст запроса к модели в виде последовательности отдельных сообщений в формате `<Роль_отправителя_сообщения>`:`<Текст_сообщения>`, используя кнопку ![plus](../../../../_assets/console-icons/plus.svg).
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_description_json }}`, чтобы задать [контекст](../../../../ai-studio/concepts/index.md#prompt) запроса к модели в формате [JSON](https://ru.wikipedia.org/wiki/JSON)-строки.

          1. (Опционально) В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_reasoning_mode_view_spec_layout_title }}** выберите статус [режима рассуждений](../../../../ai-studio/concepts/generation/chain-of-thought.md):
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_reasoning_mode_description_reasoning_mode_unspecified }}` — не указано.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_reasoning_mode_description_disabled }}` — режим рассуждений выключен. 
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_reasoning_mode_description_enabled_hidden }}` — режим рассуждений включен.
          1. (Опционально) В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_view_spec_layout_title }}** выберите [формат ответа](../../../../ai-studio/concepts/generation/structured-output.md):

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_description_none }}` — модель возвращает ответ, отформатированный с помощью разметки Markdown.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_description_json_object }}` — модель возвращает ответ в виде JSON-объекта.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_description_json_schema }}` — модель возвращает ответ в виде JSON-схемы, заданной в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_properties_json_schema_view_spec_layout_title }}**.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_description_vision }}`" %}

          1. Выберите модель из выпадающего списка и в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_yagpt_latest_view_spec_layout_title }}** выберите [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет вызываться модель.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_temperature_view_spec_layout_title }}** задайте вариативность ответа модели: чем выше значение температуры, тем более непредсказуемым будет результат выполнения запроса. Диапазон возможных значений — от `0` до `1`.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_max_tokens_view_spec_layout_title }}** задайте ограничение на максимально допустимое количество [токенов](../../../../ai-studio/concepts/generation/tokens.md) в ответе модели.
          1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_context_view_spec_layout_title }}** выберите:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_context_properties_messages_view_spec_layout_title }}`, чтобы задать контекст запроса к модели в виде последовательности отдельных сообщений в формате `<Роль_отправителя_сообщения>`:`<Текст_сообщения>`, используя кнопку ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_context_properties_messages_view_spec_item_label }}**.

                  Вы можете добавить изображение в сообщение. Для этого нажмите ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_context_properties_messages_items_properties_images_view_spec_item_label }}** и выберите:
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_context_properties_messages_items_properties_images_items_properties_base64_view_spec_layout_title }}`, чтобы добавить изображение в формате [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_context_properties_messages_items_properties_images_items_properties_file_view_spec_layout_title }}`, чтобы указать публичный URL, по которому будет доступно изображение, или имя объекта с изображением в [бакете](../../../../storage/concepts/bucket.md) {{ objstorage-name }} (например, `prefix/subprefix/image.png`).

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_context_properties_json_view_spec_layout_title }}`, чтобы задать [контекст](../../../../ai-studio/concepts/index.md#prompt) запроса к модели в формате [JSON](https://{{ lang }}.wikipedia.org/wiki/JSON)-строки.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_description_classify }}`" %}

          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_custom_view_spec_layout_title }}** введите идентификатор дообученной модели. Подробнее см. в разделе [{#T}](../../../../ai-studio/concepts/classifier/models.md).
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_text_view_spec_layout_title }}** введите текстовое содержимое сообщения.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_description_few_shot_classify }}`" %}

          1. Выберите модель и [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором она будет вызываться.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_task_description_view_spec_layout_title }}** введите текстовое описание задания для классификатора.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_text_view_spec_layout_title }}** введите текстовое содержимое сообщения.
          1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_labels_view_spec_layout_title }}** выберите:
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_labels_description_labels_array }}`, чтобы ввести классы, используя кнопку ![plus](../../../../_assets/console-icons/plus.svg).
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_labels_description_labels_json }}` и в блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_labels_properties_labels_json_view_spec_title }}** введите классы в формате [JSON](https://ru.wikipedia.org/wiki/JSON).

          1. (Опционально) В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_samples_view_spec_layout_title }}** выберите: 
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_samples_description_samples_array }}`, чтобы ввести примеры запросов, используя кнопку ![plus](../../../../_assets/console-icons/plus.svg).
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_samples_description_samples_json }}` и в блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_few_shot_classify_properties_samples_properties_samples_json_view_spec_title }}** введите примеры запросов в формате JSON.
        
          {% endcut %}
      
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/foundationmodelscall.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
