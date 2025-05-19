---
title: Добавить взаимодействие с базой данных {{ ydb-name }} в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить взаимодействие с документными таблицами в базе данных {{ ydb-full-name }} в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Взаимодействие с документными таблицами в базе данных {{ ydb-full-name }}

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** в левой части экрана перетащите элемент ![ydb-icon](../../../../_assets/ydb-icon.svg) **{{ ydb-name }}** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ ydb-name }}**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **База данных** выберите базу данных. Поддерживаются только базы данных, созданные в режиме [Serverless](../../../../ydb/concepts/serverless-and-dedicated.md#serverless).
      1. В поле **Путь к таблице** укажите путь к таблице, с которой рабочий процесс будет взаимодействовать. Поддерживаются только [документные таблицы](../../../../ydb/concepts/dynamodb-tables.md).
      1. В блоке **Действие** выберите:

          * `Get`, чтобы получить содержимое элемента в базе данных, и в поле **Ключ** задайте значение первичного ключа БД, относящегося к нужному элементу.
          * `Put`, чтобы записать данные в таблицу, и в поле **Атрибуты** задайте ассоциативный массив атрибутов в формате `ключ`/`значение`.
          * `Update`, чтобы изменить данные в таблице, и настройте параметры обновления:

              1. В поле **Ключ** задайте значение первичного ключа элемента в базе данных, который нужно обновить.
              1. В поле **Выражение для обновления** задайте выражение, описывающее обновления атрибутов элемента в базе данных. Подробнее см. информацию о параметре `UpdateExpression` в [документации {{ ydb-full-name }}](../../../../ydb/docapi/api-ref/actions/updateItem.md#parametry).
              1. В поле **Значения атрибутов** задайте значения атрибутов, используемых в выражении выше. Подробнее см. информацию о параметре `ExpressionAttributeValues` в [документации {{ ydb-full-name }}](../../../../ydb/docapi/api-ref/actions/updateItem.md#parametry).

          * `Scan`, чтобы выполнить поиск в базе данных, и настройте параметры поиска:

              1. В поле **Ключ** задайте значение первичного ключа элемента в базе данных, с которого начнется поиск.
              1. В поле **Лимит** задайте ограничение на максимальное количество элементов в списке с результатами.

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/ydbdocument.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
