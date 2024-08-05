# Подключение виртуальных машин {{ compute-name }} к {{ backup-name }}

Если вы хотите создавать резервные копии [ВМ](../../compute/concepts/vm.md) [{{ compute-full-name }}](../../compute/) в сервисе {{ backup-name }}, ее нужно подключить к сервису и корректно настроить.

Чтобы ВМ можно было подключить к {{ backup-name }}, на ней должна быть установлена одна из [поддерживаемых операционных систем](#os). Подробнее о подключении см. в [инструкциях](../operations/index.md#connect-vm).

Чтобы подключение работало корректно, привяжите к ВМ [сервисный аккаунт](#sa) с ролью `backup.editor` и настройте для ВМ [сетевой доступ](#vm-network-access).

После подключения к {{ backup-name }} [добавьте](../operations/policy-vm/attach-and-detach-vm.md#attach-vm) ВМ в [политику резервного копирования](policy.md).

{% include [vm-running](../../_includes/backup/vm-running.md) %}

Также можно привязать политику к виртуальной машине во время создания ВМ. Привязка политики выполняется асинхронно после создания и инициализации ВМ, а также установки и настройки агента резервного копирования. Это может занимать до 10–15 минут. Подробнее в разделе [{#T}](../tutorials/vm-with-backup-policy.md).

## Требования к характеристикам ВМ {#requirements}

{% include [vm-requirements](../../_includes/backup/vm-requirements.md) %}

## Поддерживаемые операционные системы {#os}

Агент {{ backup-name }} доступен для автоматической установки при создании ВМ из образов {{ marketplace-full-name }}:

### Образы на базе Linux {#linux}

* [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts)
* [Ubuntu 22.04 LTS OS Login](/marketplace/products/yc/ubuntu-2204-lts-oslogin)
* [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts)
* [Ubuntu 20.04 LTS OS Login](/marketplace/products/yc/ubuntu-2004-lts-oslogin)
* [Ubuntu 18.04 LTS](/marketplace/products/yc/ubuntu-18-04-lts)
* [Ubuntu 18.04 LTS OS Login](/marketplace/products/yc/ubuntu-1804-lts-oslogin)
* [Ubuntu 16.04 LTS](/marketplace/products/yc/ubuntu-16-04-lts)
* [CentOS 7](/marketplace/products/yc/centos-7)
* [CentOS 7 OS Login](/marketplace/products/yc/centos-7-oslogin)
* [CentOS Stream](/marketplace/products/yc/centos-stream-8)
* [Astra Linux SE 1.7 «Воронеж»](/marketplace/products/astralinux/alse)
* [Astra Linux SE 1.7 «Орел»](/marketplace/products/astralinux/alse-orel)

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

Операционная система должна быть установлена из публичного образа (продукта {{ marketplace-full-name }}). При создании ВМ можно выбрать ОС напрямую либо использовать [образ](../../compute/concepts/image.md) или [снимок диска](../../compute/concepts/snapshot.md) с другой ВМ, если ОС на нее тоже устанавливалась из публичного образа.

{% endnote %}

### Самостоятельная установка {#self-install}

Вы можете установить агента {{ backup-name }} самостоятельно:

* [Инструкция для Linux](../operations/connect-vm-linux.md)
* [Инструкция для Windows](../operations/connect-vm-windows.md)

С полным списком поддерживаемых ОС можно ознакомиться в [документации провайдера резервного копирования](https://docs.cyberprotect.ru/ru-RU/CyberBackupCloud/21.06/user/#supported-operating-systems-and-environments.html).

При возникновении проблем с установкой агента, [обратитесь]({{ link-console-support }}) в техническую поддержку.

## Сервисный аккаунт {#sa}

[Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — специальный аккаунт, от имени которого копии ВМ создаются и загружаются в хранилище {{ backup-name }}.

Когда вы создаете ВМ, для которой хотите настроить резервное копирование в {{ backup-name }}, к ВМ нужно привязать сервисный аккаунт с [ролью `backup.editor`](../security/index.md).

Вы можете [назначить роль](../../iam/operations/sa/assign-role-for-sa.md) существующему сервисному аккаунту или [создать](../../iam/operations/sa/create.md) сервисный аккаунт с нужными ролями.

## Разрешения сетевого доступа для ВМ {#vm-network-access}

Чтобы агент {{ backup-name }} мог обмениваться данными с серверами [провайдера резервного копирования](index.md#providers), для ВМ должен быть обеспечен сетевой доступ к IP-адресам ресурсов сервиса {{ backup-name }} согласно таблице:

{% list tabs group=traffic %}

- Исходящий трафик {#outgoing}

  {% include [outgoing traffic](../../_includes/backup/outgoing-rules.md) %}

{% endlist %}

Чтобы обеспечить сетевой доступ, [назначьте](../../compute/operations/vm-control/vm-attach-public-ip.md) ВМ публичный IP-адрес или примените [таблицу маршрутизации](../../vpc/concepts/static-routes.md#rt-vm), разрешающую доступ в интернет через [NAT-шлюз](../../vpc/concepts/gateways.md) или пользовательский маршрутизатор.

Правила [группы безопасности](../../vpc/concepts/security-groups.md) ВМ должны разрешать доступ к указанным ресурсам. Вы можете [добавить правила](../../vpc/operations/security-group-add-rule.md) в существующую группу безопасности или [создать](../../vpc/operations/security-group-create.md) новую группу с нужными правилами.
