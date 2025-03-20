---
title: Создать подключение в {{ speechsense-full-name }}
description: В подключения {{ speechsense-name }} можно загружать двухканальное аудио или чат с текстовыми сообщениями.
---

# Создать подключение

В подключения {{ speechsense-name }} можно загружать [двухканальное аудио](#create-connection-audio) или [чат](#create-connection-chat) с текстовыми сообщениями. Для создания подключения нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в пространстве.

## Создать подключение для аудио {#create-audio-connection}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство.
1. В правом верхнем углу нажмите **{{ ui-key.yc-ui-talkanalytics.common.more }}** → ![create](../../../_assets/console-icons/thunderbolt.svg) **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
1. Укажите название и при необходимости описание подключения.
1. Выберите тип данных **{{ ui-key.yc-ui-talkanalytics.connections.type.two-channel-key-value }}**.
1. В блоках **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**:

    1. Укажите каналы, в которых записаны голос оператора и голос клиента. Левый канал соответствует звуковой дорожке под номером 0, правый — звуковой дорожке под номером 1.
    1. Укажите для оператора и клиента ключи из файла метаданных. Этот файл содержит информацию о звонке, полученную из CRM-систем, АТС или других источников.

       По умолчанию в подключение добавлены ключи с именем и идентификатором оператора и клиента. В поле **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** введите название, под которым ключ будет отображаться в {{ speechsense-name }}. При необходимости добавьте описание.

       Чтобы указать дополнительные метаданные для оператора и клиента, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

1. В блоке **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}** укажите не связанные с оператором и клиентом ключи из файла метаданных.

    По умолчанию в подключение добавлены ключи с датой, направлением звонка и языком диалога. В поле **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** введите название, под которым ключ будет отображаться в {{ speechsense-name }}. При необходимости добавьте описание.

    Чтобы указать дополнительные метаданные, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.

## Создать подключение для чата {#create-chat-connection}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство.
1. В правом верхнем углу нажмите **{{ ui-key.yc-ui-talkanalytics.common.more }}** → ![create](../../../_assets/console-icons/thunderbolt.svg) **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
1. Укажите название и при необходимости описание подключения.
1. Выберите тип данных **{{ ui-key.yc-ui-talkanalytics.connections.type.chat-key-value }}**.
1. В блоках **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.bot }}** укажите ключи из файла метаданных. Этот файл содержит информацию о диалоге, полученную из чатов, CRM-систем или других источников.

    По умолчанию в подключение добавлены ключи с именем и идентификатором оператора, клиента и бота. В поле **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** введите название, под которым ключ будет отображаться в {{ speechsense-name }}. При необходимости добавьте описание.

    Чтобы указать дополнительные метаданные для оператора, клиента и бота, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

1. В блоке **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}** укажите не связанные с оператором, клиентом и ботом ключи из файла метаданных.

    По умолчанию в подключение добавлены ключи с датой, направлением и языком диалога. В поле **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** введите название, под которым ключ будет отображаться в {{ speechsense-name }}. При необходимости добавьте описание.

    Чтобы указать дополнительные метаданные, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
