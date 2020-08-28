# Создание виртуальной машины Linux

Cоздайте [виртуальную машину](../concepts/vm.md) Linux с помощью сервиса {{ compute-name }} в консоли управления {{ yandex-cloud }} и подключитесь к ней.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin-linux](../../_includes/compute/before-you-begin-linux.md) %}

## Создайте виртуальную машину {#create-vm}

{% include [create-instance-via-console-linux](../_includes_service/create-instance-via-console-linux.md) %}

## Подключитесь к виртуальной машине {#connect-to-vm}

{% include notitle [vm-connect-ssh](../operations/vm-connect/ssh.md#vm-connect) %}

## Настройте серийную консоль {#serial-console}

Через [серийную консоль](../operations/serial-console/index.md) можно подключиться к виртуальной машине вне зависимости от состояния сети или операционной системы (например, при проблемах с загрузкой или доступом по SSH).

Доступ к виртуальной машине через серийную консоль необходимо настроить заранее.

## Удалите виртуальную машину {#delete-vm}

Если вы больше не планируете работать с созданной виртуальной машиной, [удалите ее](../operations/vm-control/vm-delete.md).

## Что дальше {#what-is-next}

- Посмотрите [сценарии создания веб-сервисов в {{ yandex-cloud }}](../../solutions/web/).
- Узнайте, [как работать с виртуальными машинами](../operations/).
- Узнайте, [как создать виртуальную машину с GPU](../operations/vm-create/create-vm-with-gpu.md).
- Прочитайте [ответы на часто задаваемые вопросы](../qa/general.md).