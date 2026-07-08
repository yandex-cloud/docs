---
title: Подключение виртуальных машин {{ compute-full-name }} к {{ backup-full-name }}
description: Из этой статьи вы узнаете, как подключить к {{ backup-full-name }} виртуальные машины {{ compute-full-name }}.
---

# Подключение виртуальных машин {{ compute-full-name }} к {{ backup-name }}


Чтобы создавать резервные копии [виртуальных машин](../../../compute/concepts/vm.md) [{{ compute-full-name }}](../../../compute/index.yaml) в сервисе {{ backup-name }}, эти виртуальные машины нужно подключить к сервису и корректно настроить.

Подробнее о подключении виртуальной машины {{ compute-name }} к {{ backup-name }} читайте в разделе [{#T}](../../operations/index.md#connect-vm).

Чтобы подключение к {{ backup-name }} работало корректно, привяжите к виртуальной машине [сервисный аккаунт](#sa) с [ролью](../../security/index.md#backup-user) `backup.user` или выше и настройте [сетевой доступ](#vm-network-access).

{% note tip %}

{% include [user-console-vm-creation-notice](../../../_includes/backup/user-console-vm-creation-notice.md) %}

{% endnote %}

После подключения к {{ backup-name }} [привяжите](../../operations/policy-vm/attach-and-detach-vm.md#attach-vm) виртуальную машину к [политике резервного копирования](../policy.md).

{% note info %}

В момент создания резервной копии виртуальная машина должна быть запущена.

{% endnote %}

Привязать политику к виртуальной машине также можно во время создания ВМ. Привязка политики выполняется асинхронно после создания и инициализации ВМ, а также установки и настройки агента {{ backup-name }}. Это может занимать до 10–15 минут. Подробнее об автоматической привязке политик к виртуальным машинам см. в разделе [{#T}](../../tutorials/vm-with-backup-policy/index.md).

## Поддерживаемые образы {{ marketplace-name }} с автоматической установкой агента {{ backup-name }} {#os}


На виртуальных машинах {{ compute-name }} агент {{ backup-name }} доступен для автоматической установки при создании ВМ с использованием следующих образов {{ marketplace-name }}:

### Образы на базе Linux {#linux}

* [CentOS 7](/marketplace/products/yc/centos-7)
* [CentOS 7 OS Login](/marketplace/products/yc/centos-7-oslogin)
* [CentOS Stream](/marketplace/products/yc/centos-stream-8)
* [Debian 12](/marketplace/products/yc/debian-12)
* [Ubuntu 16.04 LTS](/marketplace/products/yc/ubuntu-16-04-lts)
* [Ubuntu 18.04 LTS](/marketplace/products/yc/ubuntu-18-04-lts)
* [Ubuntu 18.04 LTS OS Login](/marketplace/products/yc/ubuntu-1804-lts-oslogin)
* [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts)
* [Ubuntu 20.04 LTS OS Login](/marketplace/products/yc/ubuntu-2004-lts-oslogin)
* [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts)
* [Ubuntu 22.04 LTS OS Login](/marketplace/products/yc/ubuntu-2204-lts-oslogin)
* [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-2404-lts-oslogin)

### Образы на базе Windows {#windows}

* [Kosmos VM 2022 на базе Windows Server Datacenter 2022](/marketplace/products/fotonsrv/kosmosvm2022)
* [Kosmos VM 2019 на базе Windows Server Datacenter 2019](/marketplace/products/fotonsrv/kosmosvm2019)
* [Kosmos VM 2016 на базе Windows Server Datacenter 2016](/marketplace/products/fotonsrv/kosmosvm2016)
* [Kosmos VM RDS (5 лицензий)](/marketplace/products/fotonsrv/kos-5-rds)
* [Kosmos VM RDS (10 лицензий)](/marketplace/products/fotonsrv/kos-10-rds)
* [Kosmos VM RDS (50 лицензий)](/marketplace/products/fotonsrv/kos-50-rds)
* [Kosmos BD WEB 2019](/marketplace/products/fotonsrv/kosmosbdweb2019)
* [Kosmos BD Standard 2019](/marketplace/products/fotonsrv/kosmosbdstd2019)
* [Kosmos VM Visio Pro 2021](/marketplace/products/fotonsrv/kosmosvisio)

{% note info %}

Операционная система должна быть установлена из публичного образа (продукта {{ marketplace-full-name }}). При создании ВМ можно выбрать ОС напрямую либо использовать [образ](../../../compute/concepts/image.md) или [снимок диска](../../../compute/concepts/snapshot.md) с другой ВМ, если ОС на нее также устанавливалась из публичного образа.

{% endnote %}

### Самостоятельная установка в поддерживаемой операционной системе {#self-install}

Вы можете самостоятельно установить агент {{ backup-name }} на виртуальную машину. Подробнее читайте в следующих разделах:

* [Инструкция для Linux](../../operations/connect-vm-linux.md)
* [Инструкция для Windows](../../operations/connect-vm-windows.md)

С полным списком поддерживаемых ОС можно ознакомиться в [документации провайдера резервного копирования](https://docs.cyberprotect.ru/ru-RU/CyberBackupCloud/21.06/user/#supported-operating-systems-and-environments.html).

При возникновении проблем с установкой агента {{ backup-name }} [обратитесь]({{ link-console-support }}) в службу технической поддержки.

### Обновление ядра операционной системы {#os-kernel-update}

{% include [update-kernel-headers-description](../../../_includes/backup/operations/update-kernel-headers-description.md) %}

Чтобы обновить версии заголовков ядра Linux, воспользуйтесь инструкцией [{#T}](../../operations/backup-baremetal/restore-agent.md).

## Сервисный аккаунт {#sa}

{% note info %}

{% include [user-console-vm-creation-notice](../../../_includes/backup/user-console-vm-creation-notice.md) %}

{% endnote %}

[Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — специальный аккаунт, от имени которого агент {{ backup-name }} регистрируется у [провайдера](../index.md#providers) Киберпротект.

Когда вы создаете ВМ {{ compute-name }}, для которой хотите настроить резервное копирование в {{ backup-name }}, к ВМ нужно привязать сервисный аккаунт с [ролью](../../security/index.md#backup-user) `backup.user` или выше.

Вы можете [назначить роль](../../../iam/operations/sa/assign-role-for-sa.md) существующему сервисному аккаунту или [создать](../../../iam/operations/sa/create.md) новый сервисный аккаунт с нужной ролью.

## Разрешения сетевого доступа {#vm-network-access}

Чтобы агент {{ backup-name }} мог обмениваться данными с серверами провайдера резервного копирования, для виртуальной машины должен быть обеспечен сетевой доступ к IP-адресам ресурсов сервиса {{ backup-name }} согласно таблице:

{% list tabs group=traffic %}

- Исходящий трафик {#outgoing}

  {% include [outgoing traffic](../../../_includes/backup/outgoing-rules.md) %}

  {% note tip %}

  При установке [агента {{ backup-name }}](../agent.md) на ВМ может понадобиться доустановить отсутствующие компоненты ПО из интернета. Для этого добавьте в [группу безопасности](../../../vpc/concepts/security-groups.md) следующее правило для исходящего трафика:
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
  После установки агента {{ backup-name }} вы можете удалить это правило.

  Для доступа к ВМ по протоколу [SSH](../../../compute/operations/vm-connect/ssh.md) добавьте следующее правило для входящего трафика:
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

  {% endnote %}

{% endlist %}

Чтобы обеспечить сетевой доступ:
{#provide-access}

[Назначьте](../../../compute/operations/vm-control/vm-attach-public-ip.md) виртуальной машине публичный IP-адрес или примените [таблицу маршрутизации](../../../vpc/concepts/routing.md#rt-vm), разрешающую доступ в интернет через [NAT-шлюз](../../../vpc/concepts/gateways.md) или пользовательский маршрутизатор.

Правила [группы безопасности](../../../vpc/concepts/security-groups.md) ВМ должны разрешать доступ к указанным ресурсам. Вы можете [добавить правила](../../../vpc/operations/security-group-add-rule.md) в существующую группу безопасности или [создать](../../../vpc/operations/security-group-create.md) новую группу с нужными правилами.

## Статусы подключения {#statuses}

{% include [connection-statuses](../../../_includes/backup/connection-statuses.md) %}

#### См. также {#see-also}

* [{#T}](../../tutorials/vm-with-backup-policy/index.md)
* [{#T}](./baremetal.md)
* [{#T}](./external-resources.md)