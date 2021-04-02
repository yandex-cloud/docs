# Начало работы с AWS CLI и {{ ydb-short-name }}

В разделе описано, как с использованием AWS CLI выполнить следующие операции в {{ ydb-short-name }}:

* [Создание](create-table.md) таблицы.
* [Добавление](put-item.md), [чтение](get-item.md) и [обновление](update-item.md) данных в таблице.
* [Выполнение](query.md) простых запросов.

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../../resource-manager/operations/folder/create.md).
1. [Установите AWS CLI](../../quickstart/aws-instrument/setup.md).
1. [Создайте базу данных](../../operations/create_manage_database.md#create-db) в бессерверной (**Serverless**) конфигурации.
