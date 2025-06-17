---
title: Добавить взаимодействие с файлами на Яндекс Диске в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить взаимодействие с файлами на Яндекс Диске в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Взаимодействие с файлами на Яндекс Диске

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** в левой части экрана перетащите элемент ![yadisk-icon](../../../../_assets/yadisk-icon.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_integration_title }}** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_integration_title }}**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
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

          {% include [oauth](../../../../_includes/serverless-integrations/workflows-constructor/oauth.md) %}

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/disk.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
