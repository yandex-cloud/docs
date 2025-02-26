---
title: Интеграционный шаг Postbox
description: В статье описаны поля для интеграционного шага Postbox.
---

# Postbox

Рассылка писем с помощью {{ postbox-full-name }}. Поля `simple` и `raw` — взаимоисключающие.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`fromAddress` | `string` | Да | Нет | Нет | [Адрес](../../../../../postbox/concepts/glossary.md#adress) {{ postbox-name }}, с которого будет осуществляться отправка писем.<br/><br/>[Сервисный аккаунт](../../../../../iam/concepts/users/service-accounts.md), указанный в настройках [рабочего процесса](../../workflow.md), и адрес, заданный в этом поле, должны находиться в одном [каталоге](../../../../../resource-manager/concepts/resources-hierarchy.md#folder).
`destination` | [Destination](#postbox-destination) | Да | Нет | Нет | Объект описывающий адреса получателей.
`simple` | [SimpleMessage](#postbox-simplemessage) | Нет | Нет | Нет | Письмо, которое будет отправлено.
`raw` | [RawMessage](#postbox-rawmessage) | Нет | Нет | Нет | Письмо, которое будет отправлено.

## Destination {#postbox-destination}

Значения полей после шаблонизации должны иметь формат `a@example.com, b@example.com` или `[a@example.com, b@example.com]`.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`toAddresses` | `string` | Да | Нет | Да | Адреса получателей письма.
`ccAdresses` | `string` | Нет | Нет | Да | Адреса получателей копии письма.

## RawMessage {#postbox-rawmessage}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`data` | `string` | Да | Нет | Да | Необработанный тип письма. Подробнее см. в [документации сервиса {{ postbox-name }}](../../../../../postbox/aws-compatible-api/api-ref/send-email.md).

## SimpleMessage {#postbox-simplemessage}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`subject` | [MessageData](#postbox-messagedata) | Да | Нет | Нет | Заголовок письма.
`body` | [Body](#postbox-body) | Да | Нет | Нет | Текст письма.

## Body {#postbox-body}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`text` | [MessageData](#postbox-messagedata) | Да | Нет | Нет | Объект, отвечающий за отображение письма в почтовых клиентах, которые не поддерживают HTML.
`html` | [MessageData](#postbox-messagedata) | Да | Нет | Нет | Объект, отвечающий за отображение письма в почтовых клиентах, которые поддерживают HTML.

## MessageData {#postbox-messagedata}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`data` | `string` | Да | Нет | Да | Текст.
`charset` | `UTF_8`\|<br/>`ISO_8859_1`\|<br/>`Shift_JIS` | Да | Нет | Нет | Кодировка.