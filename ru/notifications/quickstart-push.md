---
title: Как начать работать с push-уведомлениями в {{ cns-full-name }}
description: 'С помощью {{ cns-name }} вы можете отправлять push-уведомления в приложения, зарегистрированные в следующих сервисах: Apple Push Notification service (APNs), Firebase Cloud Messaging (FCM), Huawei Mobile Services (HMS).'
---


# Как начать работать с push-уведомлениями в {{ cns-full-name }}

{% include [preview-stage](../_includes/notifications/preview-stage.md) %}

{% include [ask-for-turning-on](../_includes/notifications/ask-for-turning-on.md) %}

{% include [about-service](../_includes/notifications/about-service.md) %}

С помощью {{ cns-name }} вы можете отправлять push-уведомления в приложения, зарегистрированные в следующих сервисах:
* [Apple Push Notification service](https://developer.apple.com/notifications/) (APNs).
* [Firebase Cloud Messaging](https://firebase.google.com/) (FCM).
* [Huawei Mobile Services](https://developer.huawei.com/consumer/) (HMS).
* [RuStore](https://www.rustore.ru/help/sdk/push-notifications/).

Чтобы начать работу с push-уведомлениями:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте канал push-уведомлений](#create-channel).
1. [Создайте эндпоинт](#create-endpoint).
1. [Отправьте уведомление](#publish).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте канал push-уведомлений {#create-channel}

В {{ cns-name }} сообщения конечным пользователям отправляются через [каналы уведомлений](./concepts/index.md#channels).

Чтобы создать канал:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [push-channel-create](../_includes/notifications/push-channel-create.md) %}

{% endlist %}

Создание канала уведомлений может занять некоторое время.

## Создайте эндпоинт {#create-endpoint}

Каждый канал имеет свою базу [эндпоинтов](./concepts/index.md#mobile-endpoints) для отправки уведомлений напрямую в приложение на устройства пользователей.

Чтобы создать эндпоинт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите канал уведомлений, созданный ранее.
  1. Перейдите на вкладку ![image](../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cns.action_create-endpoint }}**.
  1. Введите **{{ ui-key.yacloud.cns.field_token }}** — уникальный токен на устройстве пользователя, созданный сервисом уведомлений для приложения.
  1. (опционально) Введите **{{ ui-key.yacloud.cns.field_endpoint-user-data }}** — текст длиной до 2048 символов в кодировке [UTF-8](https://ru.wikipedia.org/wiki/UTF-8).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  Создание эндпоинта может занять некоторое время.

{% endlist %}

## Отправьте уведомление {#publish}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите эндпоинт, созданный ранее.
  1. В блоке **{{ ui-key.yacloud.cns.section_message-sending }}** выберите формат уведомления: `{{ ui-key.yacloud.cns.label_editor-text }}` или `{{ ui-key.yacloud.cns.label_editor-json }}`.
  1. Введите текст уведомления или JSON-объект, содержащий данные уведомления.
  1. Нажмите кнопку **{{ ui-key.yacloud.cns.action_send-msg }}**.
  
  Каждому отправленному уведомлению присваивается уникальный идентификатор. Чтобы сохранить его, нажмите кнопку **{{ ui-key.yacloud.cns.action_copy-msg-id }}**.

  Вы можете сразу же отправить новое уведомление или повторить предыдущее.

{% endlist %}

## См. также {#see-also}

* [Как начать работать с SMS](quickstart-sms.md)
* [Как начать работать с сервисом с помощью AWS CLI](./tools/aws-cli.md)
* [Обзор сервиса](./concepts/index.md)
* [Канал мобильных Push-уведомлений](./concepts/push.md)
