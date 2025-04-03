---
title: Как начать работать с push-уведомлениями в браузере в {{ cns-full-name }}
description: С помощью {{ cns-name }} вы можете отправлять push-уведомления в браузеры пользователей
---


# Как начать работать с push-уведомлениями в браузере {{ cns-full-name }}

{% include [preview-stage](../_includes/notifications/preview-stage.md) %}

{% include [ask-for-turning-on](../_includes/notifications/ask-for-turning-on.md) %}

{% include [about-service](../_includes/notifications/about-service.md) %}

С помощью {{ cns-name }} вы можете отправлять push-уведомления в браузеры пользователей.

Чтобы начать работу с push-уведомлениями:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте канал push-уведомлений в браузере](#create-channel).
1. [Получите данные для отправки уведомлений пользователю](#subscribe-notifications).
1. [Создайте эндпоинт](#create-endpoint).
1. [Отправьте уведомление](#publish).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте канал push-уведомлений в браузере {#create-channel}

В {{ cns-name }} сообщения конечным пользователям отправляются через [каналы уведомлений](./concepts/index.md#channels).

Чтобы создать канал:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать канал уведомлений.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Нажмите **{{ ui-key.yacloud.cns.action_create-channel }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.cns.type_web }}**.
  1. Введите имя канала уведомления. Имя канала должно быть уникальным в {{ cns-name }}.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

     Создание канала уведомлений может занять некоторое время.

{% endlist %}

## Получите данные для отправки уведомлений пользователю {#subscribe-notifications}

Для каждого канала надо создать набор [эндпоинтов](concepts/browser.md), через которые будут отправляться уведомления в браузеры конкретных пользователей.

Чтобы создать эндпоинт, получите данные пользователя:

1. Из браузера пользователя с помощью [Service Worker](https://developer.mozilla.org/ru/docs/Web/API/Service_Worker_API/Using_Service_Workers) вызовите метод JavaScript [subscribe](https://developer.mozilla.org/en-US/docs/Web/API/PushManager/subscribe#applications).

    В ответ вернется объект [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription).

1. Преобразуйте полученный объект в JSON, вызвав метод [toJSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON).

{% cut "Пример параметров подписки в JSON" %}

   ```json
   {
    "endpoint": "https://fcm.googleapis.com/fcm/send/abcdef123456",
    "expirationTime": 1704093740000,
    "keys": {
      "p256dh": "BOrLkr7sEt8tERyAv6c8ZG5UC********",
      "auth": "aBcDeFg12345"
    }
   }
   ```
{% endcut %}

## Создайте эндпоинт {#create-endpoint}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите созданный канал уведомлений.
  1. Выберите вкладку ![image](../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}**.
  1. Нажмите **{{ ui-key.yacloud.cns.action_create-endpoint }}**.
  1. Введите **{{ ui-key.yacloud.cns.field_web-push-endpoint_params }}**, которые были получены в браузере пользователя.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Отправьте уведомление {#publish}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите созданный эндпоинт.
  1. Введите текст уведомления.
  1. Нажмите кнопку **{{ ui-key.yacloud.cns.action_send-msg }}**.
  
  Каждому отправленному уведомлению присваивается уникальный идентификатор. Чтобы сохранить его, нажмите кнопку **{{ ui-key.yacloud.cns.action_copy-msg-id }}**.

{% endlist %}

## См. также {#see-also}

* [Как начать работать с мобильными push-уведомлениями](quickstart-push.md)
* [Как начать работать с SMS](quickstart-sms.md)
* [Инструменты для работы с уведомлениями](./tools/index.md)
* [Пошаговые инструкции](./operations/index.md)
* [Обзор сервиса](./concepts/index.md)
* [Канал push-уведомлений в браузере](./concepts/browser.md)
