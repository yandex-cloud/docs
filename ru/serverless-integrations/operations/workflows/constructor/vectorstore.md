---
title: Добавить взаимодействие с векторным хранилищем в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить взаимодействие с векторным хранилищем в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Взаимодействие с векторным хранилищем

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ai-studio-name }}** в левой части экрана перетащите элемент ![database](../../../../_assets/console-icons/database.svg) **Vector Store** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Vector Store**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **Идентификатор векторного хранилища** укажите идентификатор векторного хранилища, в который хотите загрузить файл.
      1. В блоке **Источник** выберите:

          * `Текст`, чтобы указать содержимое файла в виде текста. Укажите имя файла, под которым он будет сохранен.
          * `URL`, чтобы указать публичный URL, по которому доступен файл. Укажите имя файла, под которым он будет сохранен.
          * `{{ objstorage-name }}`, чтобы указать [бакет](../../../../storage/concepts/bucket.md) {{ objstorage-name }}, в котором находится файл, и имя объекта с файлом, например `prefix/subprefix/data.json`.

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/vectorstore.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
