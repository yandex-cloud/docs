---
title: Отправка письма в {{ postbox-full-name }}
description: Следуя данной инструкции, вы сможете отправить письмо в {{ postbox-name }}.
---

# Отправка письма

В {{ postbox-name }} отправить письмо можно с помощью [AWS CLI](#aws-cli-send) или из почтового клиента по [протоколу SMTP](#smtp-send).

{% include [tls](../../_includes/postbox/tls.md) %}

## Перед началом работы {#before-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт в том же каталоге, в котором находится адрес. Если вы создадите сервисный аккаунт и адрес в разных каталогах, при попытке отправить письмо возникнет ошибка.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../security/index.md#postbox-sender) `postbox.sender`.
1. Создайте ключ для сервисного аккаунта:
   * Для отправки письма с помощью AWS CLI или по протоколу SMTP с аутентификацией по паролю [создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа. Надежно сохраните идентификатор и секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.
   * Для отправки письма по протоколу SMTP с аутентификацией по API-ключу [создайте](../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ. При создании API-ключа задайте область действия `yc.postbox.send`. Надежно сохраните полученный секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.

## Отправьте письмо {#send-email}

### AWS CLI {#aws-cli-send}

{% include [send-email-aws](../../_includes/postbox/send-email-aws.md) %}

### SMTP {#smtp-send}

Отправка по протоколу SMTP возможна с аутентификацией по API-ключу сервисного аккаунта или по паролю, сгенерированному на основе статического ключа доступа сервисного аккаунта.

{% list tabs %}

- Аутентификация по API-ключу

  {% include [smtp-send-api](../../_includes/postbox/smtp-send-api.md) %}

- Аутентификация по паролю

  {% include [smtp-send-python](../../_includes/postbox/smtp-send-python.md) %}

{% endlist %}
