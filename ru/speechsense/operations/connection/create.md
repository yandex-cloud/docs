---
title: Создать подключение в {{ speechsense-full-name }}
description: В подключения {{ speechsense-name }} можно загружать двухканальное аудио или чат с текстовыми сообщениями.
---

# Создать подключение

В подключение {{ speechsense-name }} можно загружать [двухканальное аудио](#create-audio-connection), [одноканальное аудио](#create-one-channel-audio-connection) или [чат](#create-chat-connection) с текстовыми сообщениями. Для создания подключения нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в пространстве.

## Создать подключение для двухканального аудио {#create-audio-connection}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство.
1. В правом верхнем углу нажмите **{{ ui-key.yc-ui-talkanalytics.common.more }}** → ![create](../../../_assets/console-icons/thunderbolt.svg) **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
1. Укажите название и при необходимости добавьте описание подключения.
1. Выберите тип данных **{{ ui-key.yc-ui-talkanalytics.connections.type.two-channel-key-value }}**.
1. В блоках **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**:

    1. Укажите каналы, в которых записаны голос оператора и голос клиента. Левый канал соответствует звуковой дорожке под номером 0, правый — звуковой дорожке под номером 1.
    1. Укажите для оператора и клиента ключи из файла метаданных. Этот файл содержит информацию о звонке, полученную из CRM-систем, АТС или других источников.

       {% include [metadata](../../../_includes/speechsense/data/metadata.md) %}

1. В блоке **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}** укажите не связанные с оператором и клиентом ключи из файла метаданных.

   {% include [shared-metadata](../../../_includes/speechsense/data/shared-metadata.md) %}

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.

## Создать подключение для одноканального аудио {#create-one-channel-audio-connection}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство.
1. В правом верхнем углу нажмите **{{ ui-key.yc-ui-talkanalytics.common.more }}** → ![create](../../../_assets/console-icons/thunderbolt.svg) **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
1. Укажите название и при необходимости добавьте описание подключения.
1. Выберите тип данных **{{ ui-key.yc-ui-talkanalytics.connections.type.one-channel-key-value }}**.
1. В блоках **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**:

   Укажите для оператора и клиента ключи из файла метаданных. Этот файл содержит информацию о звонке, полученную из CRM-систем, АТС или других источников.

   {% include [metadata](../../../_includes/speechsense/data/metadata.md) %}

1. В блоке **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}** укажите не связанные с оператором и клиентом ключи из файла метаданных.

   {% include [shared-metadata](../../../_includes/speechsense/data/shared-metadata.md) %}

1. (Опционально) В блоке **{{ ui-key.yc-ui-talkanalytics.connections.additional.title }}** включите опции:

   * **Разделять текст диалогов по спикерам** — текст диалога разделяется по спикерам.
   
      {% note info %}
      
      Если отключить опцию, текст диалога будет отображаться только от имени оператора. Все теги и параметры отчета будут применяться исключительно к каналу оператора.
      
      {% endnote %}
      
   * **{{ ui-key.yc-ui-talkanalytics.connections.additional.split.title }}** и выберите вариант разбивки диалога:

      * **По длительности** — диалог разбивается на отрезки указанной длительности.

         * **{{ ui-key.yc-ui-talkanalytics.connections.additional.slice-length }}** — укажите длину отрезка в минутах и секундах.

      * **По фразам** — диалог разбивается на отрезки по ключевым фразам.

         * **{{ ui-key.yc-ui-talkanalytics.connections.additional.separators.start }}**, **{{ ui-key.yc-ui-talkanalytics.connections.additional.separators.finish }}** — перечислите ключевые фразы, по которым будут определяться начало и конец диалога.

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.

## Создать подключение для чата {#create-chat-connection}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство.
1. В правом верхнем углу нажмите **{{ ui-key.yc-ui-talkanalytics.common.more }}** → ![create](../../../_assets/console-icons/thunderbolt.svg) **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
1. Укажите название и при необходимости добавьте описание подключения.
1. Выберите тип данных **{{ ui-key.yc-ui-talkanalytics.connections.type.chat-key-value }}**.
1. В блоках **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.bot }}** укажите ключи из файла метаданных. Этот файл содержит информацию о диалоге, полученную из чатов, CRM-систем или других источников.

    По умолчанию в подключение добавлены ключи с именем и идентификатором оператора, клиента и бота. В поле **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** введите название, под которым ключ будет отображаться в {{ speechsense-name }}. При необходимости добавьте описание.

    Чтобы указать дополнительные метаданные для оператора, клиента и бота, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**. Для нового ключа обязательно введите его название и выберите [тип метаданных](../../concepts/resources-hierarchy.md#connection).

1. В блоке **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}** укажите не связанные с оператором, клиентом и ботом ключи из файла метаданных.

    По умолчанию в подключение добавлены ключи с датой, направлением и языком диалога. В поле **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** введите название, под которым ключ будет отображаться в {{ speechsense-name }}. При необходимости добавьте описание.

    Чтобы указать дополнительные метаданные, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**. Для нового ключа обязательно введите его название и выберите [тип метаданных](../../concepts/resources-hierarchy.md#connection).

    {{ speechsense-name }} может анализировать диалоги на русском и казахском языке. Сервис переводит расшифровку на русский язык для дальнейшего анализа. Метаданные каждого диалога должны содержать строку с указанием языков, которые могут быть в разговоре. Если вы загружаете диалоги на казахском языке, указывайте в метаданных строку `language: ru-RU, kk-KZ`. Для русского языка указывайте `language: ru-RU`. Коды языков не чувствительны к регистру.

    Чтобы загружать в подключение [связанные диалоги](../../concepts/dialogs.md#related-dialogs), добавьте строковый ключ `ticket_id`. По этому ключу диалоги будут связаны. Введите название, под которым ключ будет отображаться в {{ speechsense-name }}, например `Номер задачи`. При необходимости добавьте описание.

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
