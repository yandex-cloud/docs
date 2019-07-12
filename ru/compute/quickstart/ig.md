# Создание группы виртуальных машин

Cоздайте [группу виртуальных машин](../concepts/instance-groups/index.md) фиксированного размера с помощью сервиса Compute Cloud в консоли управления Яндекс.Облаком.

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления](https://console.cloud.yandex.ru) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга](https://console.cloud.yandex.ru/billing) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).

## Создайте группу виртуальных машин {#create-ig}

Вы можете создать группу с заданным количеством виртуальных машин. Управление размером группы осуществляется вручную. Подробнее читайте в разделе [#T](../concepts/instance-groups/scale.md#fixed-scale).

{% include [warning.md](../../_includes/instance-groups/warning.md) %}

{% include [create-instance-group-via-concole.md](../../_includes/instance-groups/create-instance-group-via-concole.md) %}

## Что дальше {#next}
              
- Посмотрите [Сценарии создания веб-сервисов в Яндекс.Облаке](../../solutions/web/).
- Узнайте [как работать с группами виртуальных машин](../operations/).
- Прочитайте [ответы на часто задаваемые вопросы](../qa/general.md).