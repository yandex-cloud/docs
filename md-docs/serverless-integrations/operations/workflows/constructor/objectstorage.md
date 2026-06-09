# Взаимодействие с объектами {{ objstorage-full-name }}

{% list tabs %}

- Консоль управления {#console}

  1. В процессе [создания](../workflow/create-constructor.md) нового рабочего процесса или [изменения](../workflow/update.md) существующего в консоли управления в блоке **{{ ui-key.yacloud.serverless-workflows.label_create-workflow-title }}** / **{{ ui-key.yacloud.serverless-workflows.label_edit-workflow-title }}** выберите `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`. 
  1. Из секции **Интеграционные шаги** в левой части экрана перетащите элемент ![object-storage-icon](../../../../_assets/object-storage-icon.svg) **{{ objstorage-name }}** в нужное место рабочего процесса в окне конструктора.

      Перетаскивать шаги можно в обозначенные пунктирной линией блоки на графической схеме рабочего процесса, такие как **Добавить шаг** и т.п.
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ objstorage-name }}**, чтобы выбрать его.
  1. В правой части окна на вкладке **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-settings-label }}**:

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_step-name-label }}** задайте имя шага рабочего процесса.
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_bucket_view_spec_layout_title }}** выберите [бакет](../../../../storage/concepts/bucket.md), с объектами которого вы будете взаимодействовать из рабочего процесса.
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_object_view_spec_layout_title }}** укажите имя [объекта](../../../../storage/concepts/object.md), с которым вы будете взаимодействовать.
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_view_spec_layout_title }}** выберите:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_description_put }}`, чтобы добавить новый объект в бакет.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_description_get }}`, чтобы получить содержимое объекта из бакета.

      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_properties_get_properties_content_type_view_spec_layout_title }}** выберите тип содержимого целевого объекта:

          {% cut "Если вы добавляете объект в бакет" %}

          * `BINARY` — содержимое объекта будет раскодировано из формата [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64).
          * `TEXT` — содержимое объекта будет сохранено в простом текстовом формате в кодировке UTF-8. Если файл имеет другую кодировку, {{ sw-name }} вернет ошибку или рабочий процесс будет работать некорректно.
          * `JSON` — текст объекта, содержащий JSON, будет сохранен в виде [JSON](https://ru.wikipedia.org/wiki/JSON)-структуры.

          {% endcut %}

          {% cut "Если вы получаете объект из бакета" %}

          * `BINARY` — содержимое объекта будет закодировано в формат [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64).
          * `JSON` — содержимое объекта будет получено в виде [JSON](https://ru.wikipedia.org/wiki/JSON)-структуры.
          * `TEXT` — содержимое объекта будет получено в простом текстовом формате в кодировке UTF-8. Если файл имеет другую кодировку, {{ sw-name }} вернет ошибку или рабочий процесс будет работать некорректно.
          * `EXCEL` — содержимое объекта будет преобразовано в массив страниц, где каждая страница — массив массивов строк. Поддерживаемые форматы: `XLAM`, `XLSM`, `XLSX`, `XLTM` и `XLTX`.
          * `CSV` — содержимое объекта будет преобразовано в массив массивов строк путем деления строк по следующим символам-разделителям: запятая (`,`) и перенос строки.

          {% endcut %}

      1. Если вы добавляете объект в бакет, в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_properties_put_properties_content_view_spec_layout_title }}** укажите содержимое создаваемого объекта.
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

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/objectstorage.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)