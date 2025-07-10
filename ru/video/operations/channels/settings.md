---
title: Как настроить канал в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете настроить канал {{ video-full-name }} и управлять рекламой.
---

# Настроить канал и рекламу

## Настроить канал {#channel-settings}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На панели справа выберите **Настройки канала**.
  1. В разделе **Реклама** укажите настройки для показа рекламы всех видео на канале.
  1. В разделе **Разрешенные домены** добавьте адреса сайтов, на которых можно показывать видео с этого канала. На других сайтах видео не будут показываться.
     1. Включите **Статус проверки**.
     1. Нажмите кнопку ![plus-sign](../../../_assets/console-icons/plus.svg) **Добавить домен**.
     1. Введите адрес сайта или группы сайтов.
     1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_create }}**.
     1. При необходимости добавьте другие домены.
  1. Чтобы показывать видео на всех сайтах, отключите **Статус проверки**. Добавленные домены сохранятся.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Воспользуйтесь методами REST API [create](../../api-ref/Channel/create.md) или [update](../../api-ref/Channel/update.md) для ресурса [Channel](../../api-ref/Channel/index.md), вызовом gRPC API [ChannelService/Create](../../api-ref/grpc/Channel/create.md) или [ChannelService/Update](../../api-ref/grpc/Channel/update.md). Настройки задаются с помощью параметра `settings`.

{% endlist %}

## Настроить показ рекламы {#ad-settings}

Вы можете монетизировать свой видеоконтент с помощью рекламной сети Яндекса.

Чтобы настроить показ рекламы:

1. Ознакомьтесь с [требованиями к размещению видеоблоков](https://yandex.ru/support2/partner/ru/yan-rules/video).
1. [Зарегистрируйтесь](http://partner.yandex.ru/form/) в рекламной сети Яндекса (РСЯ).
1. Отправьте запрос на добавление видеоресурса через [службу поддержки](https://yandex.ru/support2/partner/ru/support).

    Подробнее см. документацию Яндекса: [Новым партнерам](https://yandex.ru/support2/partner/ru/joining/) и [Создание видеоресурса](https://yandex.ru/support2/partner/ru/video/resource).

    После создания видеоресурса в интерфейсе рекламной сети Яндекса появится раздел **Реклама в видео**, а сам видеоресурс появится на вкладке **Реклама в видео → Видеоресурсы**. Ему будет присвоен уникальный идентификатор (`Page ID`) и статус **Новый**.

1. [Добавьте](#add-page-id) `Page ID` в настройки канала {{ video-name }}.
1. Дождитесь прохождения модерации, когда статус видеоресурса в РСЯ изменится на **Работает. Нет статистики**.
1. [Настройте](https://yandex.ru/support2/partner/ru/video/create-instream) показ рекламных блоков для ваших видео.
1. [Посмотрите статистику](https://yandex.ru/support2/partner/ru/statistics/working-with-reports) по рекламе и ознакомьтесь с [технологиями повышения эффективности](https://yandex.ru/support2/partner/ru/efficiency/site-quality) рекламы.

### Добавление Page ID {#add-page-id}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте **Настройки канала**.
  1. В разделе **Реклама** укажите:
     * **Провайдер** — `Yandex Direct`.
     * **Page ID**, полученный после создания видеоресурса.
     * **Категория** (тематика) видео на вашем канале.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Воспользуйтесь методами REST API [create](../../api-ref/Channel/create.md) или [update](../../api-ref/Channel/update.md) для ресурса [Channel](../../api-ref/Channel/index.md), вызовом gRPC API [ChannelService/Create](../../api-ref/grpc/Channel/create.md) или [ChannelService/Update](../../api-ref/grpc/Channel/update.md).
  
  Настройки рекламы задаются с помощью параметра `settings` > `advertisement`.

{% endlist %}

#### См. также {#see-also}

[{#T}](../../concepts/index.md#channels)
