# Взаимодействие с документными таблицами в базе данных {{ ydb-full-name }}

{% list tabs %}

- Консоль управления {#console}

  1. В процессе [создания](../workflow/create-constructor.md) нового рабочего процесса или [изменения](../workflow/update.md) существующего в консоли управления в блоке **{{ ui-key.yacloud.serverless-workflows.label_create-workflow-title }}** / **{{ ui-key.yacloud.serverless-workflows.label_edit-workflow-title }}** выберите `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`. 
  1. Из секции **Интеграционные шаги** в левой части экрана перетащите элемент ![ydb-icon](../../../../_assets/ydb-icon.svg) **{{ ydb-name }}** в нужное место рабочего процесса в окне конструктора.

      Перетаскивать шаги можно в обозначенные пунктирной линией блоки на графической схеме рабочего процесса, такие как **Добавить шаг** и т.п.
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ ydb-name }}**, чтобы выбрать его.
  1. В правой части окна на вкладке **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-settings-label }}**:

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_step-name-label }}** задайте имя шага рабочего процесса.
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.ydb_document_properties_ydb_database_view_spec_layout_title }}** выберите базу данных. Поддерживаются только базы данных, созданные в режиме [Serverless](../../../../ydb/concepts/serverless-and-dedicated.md#serverless).
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.ydb_document_properties_ydb_table_view_spec_layout_title }}** укажите путь к таблице, с которой рабочий процесс будет взаимодействовать. Поддерживаются только [документные таблицы](../../../../ydb/concepts/dynamodb-tables.md).
      1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.ydb_document_properties_action_view_spec_layout_title }}** выберите:

          * `Get`, чтобы получить содержимое элемента в базе данных, и в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.ydb_document_properties_action_properties_get_properties_key_view_spec_layout_title }}** задайте значение первичного ключа БД, относящегося к нужному элементу.
          * `Put`, чтобы записать данные в таблицу, и в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.ydb_document_properties_action_properties_put_properties_item_view_spec_layout_title }}** задайте ассоциативный массив атрибутов в формате `ключ`/`значение`.
          * `Update`, чтобы изменить данные в таблице, и настройте параметры обновления:

              1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.ydb_document_properties_action_properties_update_properties_key_view_spec_layout_title }}** задайте значение первичного ключа элемента в базе данных, который нужно обновить.
              1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.ydb_document_properties_action_properties_update_properties_expression_view_spec_layout_title }}** задайте выражение, описывающее обновления атрибутов элемента в базе данных. Подробнее см. информацию о параметре `UpdateExpression` в [документации {{ ydb-full-name }}](../../../../ydb/docapi/api-ref/actions/updateItem.md#parametry).
              1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.ydb_document_properties_action_properties_update_properties_expression_attribute_values_view_spec_layout_title }}** задайте значения атрибутов, используемых в выражении выше. Подробнее см. информацию о параметре `ExpressionAttributeValues` в [документации {{ ydb-full-name }}](../../../../ydb/docapi/api-ref/actions/updateItem.md#parametry).

          * `Scan`, чтобы выполнить поиск в базе данных, и настройте параметры поиска:

              1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.ydb_document_properties_action_properties_scan_properties_exclusive_start_key_view_spec_layout_title }}** задайте значение первичного ключа элемента в базе данных, с которого начнется поиск.
              1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.ydb_document_properties_action_properties_scan_properties_limit_view_spec_layout_title }}** задайте ограничение на максимальное количество элементов в списке с результатами.

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

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/ydbdocument.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)