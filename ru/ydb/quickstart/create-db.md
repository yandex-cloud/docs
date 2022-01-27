---
sourcePath: overlay/quickstart/create-db.md
---
# Создание базы данных

Создайте [базу данных](../concepts/databases.md#database) с помощью сервиса Yandex Database в консоли управления Yandex.Cloud.

## Перед началом работы {#before-you-begin}

Чтобы начать работать в Yandex.Cloud:

1. Войдите в [консоль управления](https://console.cloud.yandex.ru/). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга](https://console.cloud.yandex.ru/billing) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).

## Создайте базу данных {#control-plane}

Вы можете создать базу данных в бессерверной (Serverless) конфигурации или с выделенными серверами (Dedicated). Подробнее о различиях в конфигурациях читайте в разделе [Serverless и Dedicated режимы работы](../concepts/serverless_and_dedicated.md).

{% note info %}

Для работы в режиме совместимости с Amazon DynamoDB используйте бессерверную (Serverless) конфигурацию БД.

{% endnote %}

{% include [create-db-via-console](../_includes/create-db-via-console.md) %}
