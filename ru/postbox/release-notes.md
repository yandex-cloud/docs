---
title: История изменений в {{ postbox-full-name }}
description: В разделе представлена история изменений сервиса {{ postbox-name }}.
---

# История изменений в {{ postbox-full-name }}

## Июль 2025 {#july-2025}

### Обновления {#updates}

* Добавлена поддержка [аутентификации с помощью {{ iam-short-name }}-токена](api-ref/authentication.md#iam-ses-example).
* Добавлена поддержка получения уведомлений о том, что:
    * [письмо открыто](concepts/notification.md#open);
    * [доставка письма задерживается](concepts/notification.md#delayed-delivery);
    * [получатель отписался от рассылки](concepts/notification.md#subscription).
* Добавлена поддержка [доставки письма по защищенному соединению](aws-compatible-api/api-ref/put-configuration-set-delivery-options.md).

## Май 2025 {#may-2025}

### Обновления {#updates}

* Добавлена поддержка {{ TF }} — теперь можно создавать адреса и проверять владение пользовательским доменом с помощью {{ TF }}. Подробнее см. [{#T}](tutorials/domain-identity-creating.md)

## Март 2025 {#march-2025}

### Обновления {#updates}

* Добавлена поддержка SMTPS — теперь пользователи, чей почтовый клиент не поддерживает STARTTLS, могут отправлять письма с помощью {{ postbox-full-name }}.
* Добавлена поддержка [шаблонизации писем](operations/send-templated-email.md).

## Январь 2025 {#january-2025}

### Обновления {#updates}

* Добавлена поддержка отправки [уведомлений о доставке писем](concepts/notification.md) в поток данных {{ yds-full-name }}.
* Добавлена поддержка [аутентификации по API-ключу](operations/send-email.md#smtp-send) при отправке писем из почтового клиента по протоколу SMTP.

## Август 2024 {#august-2024}

### Обновления {#updates}

* Добавлена поддержка [записи логов](operations/logs-write.md) в журнал выполнения.
