---
title: Создание виртуальной машины Linux
description: Cоздайте виртуальную машину Linux в облаке с помощью сервиса {{ compute-name }}. Вы можете подключиться к виртуальной машине Linux по протоколу SSH через консоль или программу PuTTY. Для подключения необходимо указать публичный адрес виртуальной машины Linux.
keywords:
  - linux
  - linux vm
  - linux вм
  - linux виртуальная машина
  - виртуальная машина
  - вм

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Создание виртуальной машины Linux

Cоздайте [виртуальную машину](../concepts/vm.md) Linux с помощью сервиса {{ compute-name }} в консоли управления {{ yandex-cloud }} и подключитесь к ней.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin-linux](../../_includes/compute/before-you-begin-linux.md) %}

## Создайте виртуальную машину {#create-vm}

{% include [create-instance-via-console-linux](../_includes_service/create-instance-via-console-linux.md) %}

## Подключитесь к виртуальной машине {#connect-to-vm}

{% include notitle [vm-connect-ssh](../operations/vm-connect/ssh.md#vm-connect) %}

## Настройте серийную консоль {#serial-console}

Через [серийную консоль](../operations/serial-console/index.md) можно подключиться к ВМ вне зависимости от состояния сети или операционной системы (например, при проблемах с загрузкой или доступом по SSH).

Доступ к ВМ через серийную консоль необходимо настроить заранее.

## Удалите виртуальную машину {#delete-vm}

Если вы больше не планируете работать с созданной ВМ, [удалите ее](../operations/vm-control/vm-delete.md).

## Что дальше {#what-is-next}

* Посмотрите [сценарии создания веб-сервисов в {{ yandex-cloud }}](../../solutions/web/index.md).
* Узнайте, [как работать с ВМ](../operations/index.md).
* Узнайте, [как создать ВМ с GPU](../operations/vm-create/create-vm-with-gpu.md).
* Прочитайте [ответы на часто задаваемые вопросы](../qa/general.md).