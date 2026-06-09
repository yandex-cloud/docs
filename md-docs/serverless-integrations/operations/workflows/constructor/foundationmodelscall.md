# Взаимодействие с моделями {{ ai-studio-name }}

{% list tabs %}

- Консоль управления {#console}

  1. В процессе [создания](../workflow/create-constructor.md) нового рабочего процесса или [изменения](../workflow/update.md) существующего в консоли управления в блоке **{{ ui-key.yacloud.serverless-workflows.label_create-workflow-title }}** / **{{ ui-key.yacloud.serverless-workflows.label_edit-workflow-title }}** выберите `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`. 
  1. Из секции **{{ ai-studio-name }}** в левой части экрана перетащите элемент ![foundation-models-icon](../../../../_assets/foundation-models-icon.svg) **Модели {{ ai-studio-name }}** в нужное место рабочего процесса в окне конструктора.

      Перетаскивать шаги можно в обозначенные пунктирной линией блоки на графической схеме рабочего процесса, такие как **Добавить шаг** и т.п.
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Модели {{ ai-studio-name }}**, чтобы выбрать его.
  1. В правой части окна на вкладке **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-settings-label }}**:
      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_step-name-label }}** задайте имя шага рабочего процесса.      
      1. Выберите [AI-модель]({{ link-docs-ai }}ai-studio/concepts/generation/index):

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_description_generate }}`" %}
        
          1. Выберите:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_model_description_base_model }}`, чтобы использовать модель из выпадающего списка, и в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_yagpt_latest_view_spec_layout_title }}** выберите [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет вызываться модель.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_model_description_custom }}`, чтобы использовать дообученную модель, и в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_custom_view_spec_layout_title }}** укажите идентификатор ([URI]({{ link-docs-ai }}ai-studio/concepts/tuning/index#requests)) дообученной модели.

          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_temperature_view_spec_layout_title }}** задайте вариативность ответа модели: чем выше значение температуры, тем более непредсказуемым будет результат выполнения запроса. Диапазон возможных значений — от `0` до `1`.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_max_tokens_view_spec_layout_title }}** задайте ограничение на максимально допустимое количество [токенов]({{ link-docs-ai }}ai-studio/concepts/generation/tokens) в ответе модели.
          1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_view_spec_layout_title }}** выберите:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_description_messages }}`, чтобы задать контекст запроса к модели в виде последовательности отдельных сообщений в формате `<Роль_отправителя_сообщения>`:`<Текст_сообщения>`, используя кнопку ![plus](../../../../_assets/console-icons/plus.svg).
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_context_description_json }}`, чтобы задать [контекст]({{ link-docs-ai }}ai-studio/concepts/index#prompt) запроса к модели в формате [JSON](https://ru.wikipedia.org/wiki/JSON)-строки.

          1. (Опционально) В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_reasoning_mode_view_spec_layout_title }}** выберите статус [режима рассуждений]({{ link-docs-ai }}ai-studio/concepts/generation/chain-of-thought):
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_reasoning_mode_description_reasoning_mode_unspecified }}` — не указано.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_reasoning_mode_description_disabled }}` — режим рассуждений выключен. 
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_reasoning_mode_description_enabled_hidden }}` — режим рассуждений включен.
          1. (Опционально) В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_view_spec_layout_title }}** выберите [формат ответа]({{ link-docs-ai }}ai-studio/concepts/generation/structured-output):

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_description_none }}` — модель возвращает ответ, отформатированный с помощью разметки Markdown.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_description_json_object }}` — модель возвращает ответ в виде JSON-объекта.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_description_json_schema }}` — модель возвращает ответ в виде JSON-схемы, заданной в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_generate_properties_structured_output_properties_json_schema_view_spec_layout_title }}**.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_description_vision }}`" %}

          1. Выберите модель из выпадающего списка и в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_yagpt_latest_view_spec_layout_title }}** выберите [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет вызываться модель.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_temperature_view_spec_layout_title }}** задайте вариативность ответа модели: чем выше значение температуры, тем более непредсказуемым будет результат выполнения запроса. Диапазон возможных значений — от `0` до `1`.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_max_tokens_view_spec_layout_title }}** задайте ограничение на максимально допустимое количество [токенов]({{ link-docs-ai }}ai-studio/concepts/generation/tokens) в ответе модели.
          1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_context_view_spec_layout_title }}** выберите:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_context_properties_messages_view_spec_layout_title }}`, чтобы задать контекст запроса к модели в виде последовательности отдельных сообщений в формате `<Роль_отправителя_сообщения>`:`<Текст_сообщения>`, используя кнопку ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_context_properties_messages_view_spec_item_label }}**.

                  Вы можете добавить изображение в сообщение. Для этого нажмите ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_context_properties_messages_items_properties_images_view_spec_item_label }}** и выберите:
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_context_properties_messages_items_properties_images_items_properties_base64_view_spec_layout_title }}`, чтобы добавить изображение в формате [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_context_properties_messages_items_properties_images_items_properties_file_view_spec_layout_title }}`, чтобы указать публичный URL, по которому будет доступно изображение, или имя объекта с изображением в [бакете](../../../../storage/concepts/bucket.md) {{ objstorage-name }} (например, `prefix/subprefix/image.png`).

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_properties_vision_properties_context_properties_json_view_spec_layout_title }}`, чтобы задать [контекст]({{ link-docs-ai }}ai-studio/concepts/index#prompt) запроса к модели в формате [JSON](https://{{ lang }}.wikipedia.org/wiki/JSON)-строки.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_action_description_classify }}`" %}

          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.foundation_models_properties_model_properties_custom_view_spec_layout_title }}** введите идентификатор дообученной модели. Подробнее см. в разделе [Модели классификаторов на базе {{ yagpt-name }}]({{ link-docs-ai }}ai-studio/concepts/classifier/models).
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

      1. (Опционально) Отключите логирование запросов. Подробнее в [документации {{ ai-studio-name }}]({{ link-docs-ai }}ai-studio/operations/disable-logging).
      1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.common_timeout_view_spec_layout_title }}** задайте максимальное время выполнения текущего шага.
      1. (Опционально) Чтобы задать для шага собственную политику повторных попыток, разверните блок **{{ ui-key.yc-serverless-workflows.dynamic-forms.common_retry_policy_view_spec_layout_title }}** и нажмите кнопку ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.common_retry_policy_view_spec_layout_title }}**. В появившейся форме:
         
         1. (Опционально) В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_initial-delay-field }}** задайте начальное значение задержки между повторными попытками выполнения шага.
         1. (Опционально) В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_backoff-rate-field }}** задайте коэффициент, на который будет умножаться время задержки перед каждой повторной попыткой выполнения шага.
         1. (Опционально) В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_max-delay-field }}** задайте значение максимальной задержки между повторными попытками выполнения шага.
         1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}** выберите ошибки, для которых будут (или, наоборот, не будут) сделаны повторные попытки выполнения шага.
         
             Подробную информацию о возможных ошибках см. в разделе [{#T}](../../../concepts/workflows/execution.md#errors).
         1. (Опционально) В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_retry-count-field }}** задайте максимальное количество повторных попыток выполнения шага.
         1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-mode-field }}** выберите:
         
             * `INCLUDE` — чтобы делать для шага повторные попытки выполнения при возникновении ошибок, указанных в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}**.
             * `EXCLUDE` — чтобы делать для шага повторные попытки выполнения при возникновении любых ошибок, за исключением ошибок, указанных в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}**.
         
         Если вы хотите удалить политику повторных попыток, ранее созданную для шага, в строке **{{ ui-key.yc-serverless-workflows.dynamic-forms.common_retry_policy_view_spec_layout_title }}** нажмите ![ellipsis](../../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
         
         Если для шага не настроена собственная политика повторных попыток, к нему будет применяться политика повторных попыток, [заданная для всего рабочего процесса](setup-restart-policy.md).
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-input-label }}** и задайте [jq-шаблон](../../../concepts/workflows/templating.md) для фильтрации [состояния рабочего процесса](../../../concepts/workflows/workflow.md#state), которое передается в шаг.
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-output-label }}** и задайте [jq-шаблон](../../../concepts/workflows/templating.md) для фильтрации выходных данных шага, которые добавляются в [состояние рабочего процесса](../../../concepts/workflows/workflow.md#state).
  1. (Опционально) [Добавьте](setup-catch-rule.md) для создаваемого шага [правило перехода по ошибкам](../../../concepts/workflows/yawl/index.md#catchrule), которые могут возникать во время выполнения этого шага.

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/foundationmodelscall.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)