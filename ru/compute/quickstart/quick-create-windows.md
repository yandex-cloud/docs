---
title: Создание виртуальной машины Windows
description: Создайте виртуальную машину Windows в облаке с помощью сервиса {{ compute-short-name }}. Вы можете подключиться к виртуальной машине Windows используя Remote Dektop Protocol (RDP), встроенный в образ ОС. Перед подключением к виртуальной машине Windows убедитесь, что NLA включен в настройках вашего компьютера.
keywords:
  - windows
  - windows vm
  - windows вм
  - windows виртуальная машина
  - виртуальная машина
  - вм
---

# Создание виртуальной машины Windows


Создайте [виртуальную машину](../concepts/vm.md) Windows с помощью сервиса {{ compute-short-name }} в консоли управления {{ yandex-cloud }} и подключитесь к ней.

{% include [ms-licensing-personal-data](../../_includes/ms-licensing-personal-data.md) %}

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).

## Создайте виртуальную машину {#create-vm}

{% include [create-instance-via-console-windows](../_includes_service/create-instance-via-console-windows.md) %}

## Сбросьте пароль администратора {#reset-admin-password}

Пароль администратора, указываемый при создании ВМ, сохраняется в метаданных в незашифрованном виде, поэтому рекомендуется сгенерировать вместо него новый пароль.

Чтобы сбросить пароль:

{% include [vm-reset-password-windows-console](../../_includes/compute/vm-reset-password-windows-console.md) %}

## Подключитесь к виртуальной машине {#connect-rdp}

{% include [vm-connect-rdp](../../_includes/vm-connect-rdp.md) %}

## Настройте серийную консоль {#serial-console}

Через [серийную консоль](../operations/serial-console/index.md) можно подключиться к ВМ вне зависимости от состояния сети или операционной системы (например, при проблемах с загрузкой или доступом по RDP).

Доступ к ВМ через серийную консоль необходимо настроить заранее.

## Удалите виртуальную машину {#delete-vm}

Если вы больше не планируете работать с созданной ВМ, [удалите ее](../operations/vm-control/vm-delete.md).

## Что дальше {#what-is-next}

* Посмотрите [Сценарии создания веб-сервисов в {{ yandex-cloud }}](../../tutorials/web/index.md).
* Узнайте, [как создать ВМ с GPU](../operations/vm-create/create-vm-with-gpu.md).
* Узнайте, [как работать с ВМ](../operations/index.md).
* Прочитайте [ответы на часто задаваемые вопросы](../qa/all.md).
