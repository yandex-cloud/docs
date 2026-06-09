# Взаимодействие с файлами на Яндекс Диске

{% list tabs %}

- Консоль управления {#console}

  1. В процессе [создания](../workflow/create-constructor.md) нового рабочего процесса или [изменения](../workflow/update.md) существующего в консоли управления в блоке **{{ ui-key.yacloud.serverless-workflows.label_create-workflow-title }}** / **{{ ui-key.yacloud.serverless-workflows.label_edit-workflow-title }}** выберите `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`. 
  1. Из секции **Интеграционные шаги** в левой части экрана перетащите элемент ![yadisk-icon](../../../../_assets/yadisk-icon.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_integration_title }}** в нужное место рабочего процесса в окне конструктора.

      Перетаскивать шаги можно в обозначенные пунктирной линией блоки на графической схеме рабочего процесса, такие как **Добавить шаг** и т.п.
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_integration_title }}**, чтобы выбрать его.
  1. В правой части окна на вкладке **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-settings-label }}**:

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_step-name-label }}** задайте имя шага рабочего процесса.
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.ydb_document_properties_action_view_spec_layout_title }}** выберите:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_action_description_upload }}`, чтобы записать файл на Яндекс Диск.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_action_description_download }}`, чтобы получить файл с Яндекс Диска.

      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_action_properties_download_properties_view_spec_layout_title }}** выберите тип содержимого файла:

          {% cut "Если загружаете файлы на диск" %}

          * `BINARY` — содержимое файла будет раскодировано из формата [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64).
          * `TEXT` — содержимое файла будет сохранено в простом текстовом формате.
          * `JSON` — текст файла, содержащий [JSON](https://ru.wikipedia.org/wiki/JSON), будет сохранен в виде JSON-структуры.

          {% endcut %}
              
          {% cut "Если загружаете файлы с диска" %}

          * `BINARY` — содержимое файла будет закодировано в формат [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64).
          * `JSON` — содержимое файла будет получено в виде [JSON](https://ru.wikipedia.org/wiki/JSON)-структуры.
          * `TEXT` — содержимое файла будет получено в простом текстовом формате.
          * `EXCEL` — содержимое файла будет преобразовано в массив страниц, где каждая страница — массив массивов строк. Поддерживаемые форматы: `XLAM`, `XLSM`, `XLSX`, `XLTM` и `XLTX`.
          * `CSV` — содержимое файла будет преобразовано в массив массивов строк путем деления строк по следующим символам-разделителям: запятая (`,`) и перенос строки.

          {% endcut %}

      1. Если вы загружаете файлы на диск, в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_action_properties_upload_properties_content_view_spec_layout_title }}** задайте содержимое, которое будет сохранено в файл.
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.shared_disk_properties_disk_type_view_spec_layout_title }}** выберите тип Яндекс Диска:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.shared_disk_properties_disk_type_description_private }}` — диск принадлежит одному пользователю.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.shared_disk_properties_disk_type_description_shared }}` — диск принадлежит организации в {{ yandex-360 }}.

          При использовании диска, принадлежащего организации, в поле **Идентификатор общего диска** укажите идентификатор диска. Идентификатор отображается в интерфейсе Яндекс Диска в адресной строке после `vd/`.

      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_path_view_spec_layout_title }}** укажите путь к целевому файлу на Яндекс Диске.
      1. В секции **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_oauth_token_view_spec_layout_title }}** укажите [OAuth-токен приложения]({{ link-yadisk-doc }}concepts/quickstart#oauth) или [секрет](../../../../lockbox/concepts/secret.md) {{ lockbox-full-name }}, в котором сохранен этот токен. Выберите:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_oauth_token_description_lockbox }}`, чтобы хранить OAuth-токен в секрете, и в блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_oauth_token_properties_lockbox_properties_name_view_spec_layout_title }}** выберите секрет, его [версию](../../../../lockbox/concepts/secret.md#version) и ключ, в которых сохранен OAuth-токен.

              Если у вас еще нет секрета {{ lockbox-name }}, нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать его.
            
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_oauth_token_description_plain }}`, чтобы хранить OAuth-токен в спецификации в виде текста, и в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_oauth_token_properties_plain_properties_token_view_spec_layout_title }}** введите OAuth-токен.

              {% note warning %}

              Хранить OAuth-токен в открытом виде в тексте спецификации небезопасно.

              {% endnote %}

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

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/disk.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)