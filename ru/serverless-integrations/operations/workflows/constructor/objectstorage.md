---
title: Добавить взаимодействие с объектами {{ objstorage-name }} в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить взаимодействие с объектами {{ objstorage-full-name }} в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Взаимодействие с объектами {{ objstorage-full-name }}

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** в левой части экрана перетащите элемент ![object-storage-icon](../../../../_assets/object-storage-icon.svg) **{{ objstorage-name }}** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ objstorage-name }}**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_bucket_view_spec_layout_title }}** выберите [бакет](../../../../storage/concepts/bucket.md), с объектами которого вы будете взаимодействовать из рабочего процесса.
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_object_view_spec_layout_title }}** укажите имя [объекта](../../../../storage/concepts/object.md), с которым вы будете взаимодействовать.
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_view_spec_layout_title }}** выберите:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_description_put }}`, чтобы добавить новый объект в бакет.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_description_get }}`, чтобы получить содержимое объекта из бакета.

      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_properties_get_properties_content_type_view_spec_layout_title }}** выберите тип содержимого целевого объекта:

          {% cut "Если вы добавляете объект в бакет" %}

          * `BINARY` — содержимое объекта будет раскодировано из формата [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64).
          * `TEXT` — содержимое объекта будет сохранено в простом текстовом формате.
          * `JSON` — текст объекта, содержащий JSON, будет сохранен в виде [JSON](https://ru.wikipedia.org/wiki/JSON)-структуры.

          {% endcut %}

          {% cut "Если вы получаете объект из бакета" %}

          * `BINARY` — содержимое объекта будет закодировано в формат [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64).
          * `JSON` — содержимое объекта будет получено в виде [JSON](https://ru.wikipedia.org/wiki/JSON)-структуры.
          * `TEXT` — содержимое объекта будет получено в простом текстовом формате.
          * `EXCEL` — содержимое объекта будет преобразовано в массив страниц, где каждая страница — массив массивов строк. Поддерживаемые форматы: `XLAM`, `XLSM`, `XLSX`, `XLTM` и `XLTX`.
          * `CSV` — содержимое объекта будет преобразовано в массив массивов строк путем деления строк по следующим символам-разделителям: запятая (`,`) и перенос строки.

          {% endcut %}

      1. Если вы добавляете объект в бакет, в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_properties_put_properties_content_view_spec_layout_title }}** укажите содержимое создаваемого объекта.
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/objectstorage.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
