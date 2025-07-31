---
title: Механизм отписки от рассылок
description: Механизм one-click unsubscribe в {{ postbox-full-name }} позволяет получателям легко отписаться от рассылок одним кликом.
---

# Механизм отписки от рассылок

{{ postbox-name }} поддерживает механизм отписки «отказ от подписки в один клик» (`one-click unsubscribe`), реализованный в соответствии со стандартом [RFC 8058](https://tools.ietf.org/html/rfc8058). Чтобы механизм работал корректно, почтовый клиент получателя должен поддерживать его.

## Что такое механизм отписки {#overview}

Механизм отписки — это стандартизированный способ позволить получателям писем легко отписаться от рассылок. Без такого механизма пользователи часто отмечают нежелательные письма как спам, что негативно влияет на репутацию отправителя и доставляемость писем.

«Отказ от подписки в один клик» решает эту проблему, предоставляя получателям простой способ отписаться от рассылки в интерфейсе почтового клиента без дополнительных подтверждений и необходимости переходить на веб-страницы или заполнять формы.

## Как добавить механизм отписки в письмо {#implementation}

{% note warning %}

Механизм отписки можно добавить в письмо, у которого только один получатель.

{% endnote %}

Чтобы активировать механизм отписки, передайте параметр `ListManagementOptions` при отправке письма. Параметр `ListManagementOptions` содержит следующие атрибуты:

* `ContactListName` — имя списка контактов, с которым связано письмо. Обязательный атрибут.
* `TopicName` — имя темы внутри списка контактов, от которой можно отписаться. Необязательный атрибут.

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

    Добавьте параметр `--list-management-options`, например:

    ```bash
    aws sesv2 send-email \
      --from-email-address mail@example.com \
      --destination file://destination.json \
      --content file://message.json \
      --list-management-options ContactListName=my-list, TopicName=newsletter \
      --endpoint-url https://postbox.cloud.yandex.net
    ```

- SMTP {#smtp}

    Добавьте заголовок `X-SES-LIST-MANAGEMENT-OPTIONS`, например:

    ```
    X-SES-LIST-MANAGEMENT-OPTIONS: contactListName=my-list
    ```

    При необходимости можно указать имя темы `topicName`, например:

    ```
    X-SES-LIST-MANAGEMENT-OPTIONS: contactListName=my-list; topicName=newsletter
    ```

{% endlist %}

## Как работает механизм отписки {#how-it-works}

### Добавление заголовков {#headers}

Когда вы указываете параметр `ListManagementOptions`, {{ postbox-name }} автоматически добавляет в письмо два заголовка:

* `List-Unsubscribe` — содержит HTTPS-ссылку для отписки.
* `List-Unsubscribe-Post: List-Unsubscribe=One-Click` — указывает, что отписка выполняется в один клик.

Пример добавленных заголовков:

```
List-Unsubscribe: <https://postbox.yandexcloud.net/tracking/v1/unsubscribe?token=...>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
```

### Сохранение существующих заголовков {#existing-headers}

{{ postbox-name }} не перезаписывает заголовок `List-Unsubscribe`, если он уже есть в письме, и не добавляет заголовок `List-Unsubscribe-Post`.

## Обработка отписок {#processing}

Когда пользователь нажимает кнопку «Отписаться» в почтовом клиенте, {{ postbox-name }}:

1. Обрабатывает запрос на отписку.
1. Отправляет [уведомление](notification.md#subscription), если подписка на уведомления настроена.
1. Записывает событие в журнал выполнения.
