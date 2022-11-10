# Начало работы с {{ cloud-logging-name }}

В этой инструкции вы добавите записи в [лог-группу](./concepts/log-group.md), а после посмотрите их.

## Перед началом работы {#before-you-begin}

Чтобы начать работать в {{ yandex-cloud }}:
1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
{% if product == "yandex-cloud" %}
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
{% endif %}
1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md).

## Добавьте записи в лог-группу

{% include [write-logs](../_includes/logging/write-logs.md) %}

## Посмотрите записи

{% include [read-logs](../_includes/logging/read-logs.md) %}
