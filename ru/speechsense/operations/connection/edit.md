---
title: Изменить подключение в {{ speechsense-full-name }}
description: Следуя данной инструкции, вы сможете добавить дополнительные метаданные в подключение.
---

# Изменить подключение

После создания подключения вы можете отредактировать описание существующих ключей и добавить дополнительные метаданные. Для изменения подключения нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в пространстве.

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство.
1. На вкладке **{{ ui-key.yc-ui-talkanalytics.connections.connections }}** найдите нужное подключение и перейдите в него.
1. Нажмите кнопку ![create](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-talkanalytics.connections.edit-connection-key-value }}**.
1. В открывшемся окне измените нужные параметры:

   * Описание подключения.
   * В зависимости от типа данных в блоках **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.bot }}**, **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}**:
   
      * Измените значения полей **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}**, **{{ ui-key.yc-ui-talkanalytics.connections.column.description }}** для существующих ключей.
      * Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**, чтобы добавить дополнительные метаданные. Для нового ключа обязательно введите его название и выберите [тип метаданных](../../concepts/resources-hierarchy.md#connection).

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.save }}**.