# Создание виртуальной машины Linux

Cоздайте [виртуальную машину](../concepts/vm.md) Linux с помощью сервиса {{ compute-name }} в консоли управления Яндекс.Облаком и подключитесь к ней.

## Перед началом работы {#before-begin}

1. Войдите в [консоль управления](https://console.cloud.yandex.ru) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга](https://console.cloud.yandex.ru/billing) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).
1. Если у вас еще нет пары SSH-ключей, [создайте их](../operations/vm-connect/ssh#creating-ssh-keys).

## Создайте виртуальную машину {#create-vm}

{% include [create-instance-via-concole-linux](../_includes_service/create-instance-via-concole-linux.md) %}

## Подключитесь к виртуальной машине {#connect-to-vm}

{% include notitle [vm-connect-ssh](../operations/vm-connect/ssh.md#vm-connect) %}

## Удалите виртуальную машину {#delete-vm}

Если вы больше не планируете работать с созданной виртуальной машиной, [удалите ее](../operations/vm-control/vm-delete.md).

## Что дальше
              
- Посмотрите [Сценарии создания веб-сервисов в Яндекс.Облаке](../../solutions/web/).
- Узнайте [как работать с виртуальными машинами](../operations/).
- Прочитайте [ответы на часто задаваемые вопросы](../qa/general.md).