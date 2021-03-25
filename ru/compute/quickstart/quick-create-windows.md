# Создание виртуальной машины Windows

Создайте [виртуальную машину](../concepts/vm.md) Windows с помощью сервиса {{ compute-short-name }} в консоли управления {{ yandex-cloud }} и подключитесь к ней.

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).

## Создайте виртуальную машину {#create-vm}

{% include [create-instance-via-console-windows](../_includes_service/create-instance-via-console-windows.md) %}

## Подключитесь к виртуальной машине {#connect-rdp}

{% include [vm-connect-rdp](../../_includes/vm-connect-rdp.md) %}

## Настройте серийную консоль {#serial-console}

Через [серийную консоль](../operations/serial-console/index.md) можно подключиться к виртуальной машине вне зависимости от состояния сети или операционной системы (например, при проблемах с загрузкой или доступом по RDP).

Доступ к виртуальной машине через серийную консоль необходимо настроить заранее.

## Удалите виртуальную машину {#delete-vm}

Если вы больше не планируете работать с созданной виртуальной машиной, [удалите ее](../operations/vm-control/vm-delete.md).

## Что дальше {#what-is-next}

* Посмотрите [Сценарии создания веб-сервисов в {{ yandex-cloud }}](../../solutions/web/index.md).
* Узнайте, [как создать виртуальную машину с GPU](../operations/vm-create/create-vm-with-gpu.md).
* Узнайте, [как работать с виртуальными машинами](../operations/index.md).
* Прочитайте [ответы на часто задаваемые вопросы](../qa/all.md).