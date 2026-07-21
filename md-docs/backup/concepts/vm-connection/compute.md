[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Backup](../../index.md) > [Концепции](../index.md) > [Подключение ресурсов к Cloud Backup](index.md) > ВМ Compute Cloud

# Подключение виртуальных машин Yandex Compute Cloud к Cloud Backup


Чтобы создавать резервные копии [виртуальных машин](../../../compute/concepts/vm.md) [Yandex Compute Cloud](../../../compute/index.md) в сервисе Cloud Backup, эти виртуальные машины нужно подключить к сервису и корректно настроить.

Подробнее о подключении виртуальной машины Compute Cloud к Cloud Backup читайте в разделе [Управление виртуальными машинами Yandex Compute Cloud в Cloud Backup](../../operations/index.md#connect-vm).

Чтобы подключение к Cloud Backup работало корректно, привяжите к виртуальной машине [сервисный аккаунт](#sa) с [ролью](../../security/index.md#backup-user) `backup.user` или выше и настройте [сетевой доступ](#vm-network-access).

{% note tip %}

При создании ВМ с помощью [консоли управления](https://console.yandex.cloud) использовать сервисный аккаунт не обязательно. При этом пользователю, создающему ВМ, должна быть назначена [роль](../../security/index.md#backup-user) `backup.user` или выше на каталог, в котором создается ВМ.

{% endnote %}

После подключения к Cloud Backup [привяжите](../../operations/policy-vm/attach-and-detach-vm.md#attach-vm) виртуальную машину к [политике резервного копирования](../policy.md).

{% note info %}

В момент создания резервной копии виртуальная машина должна быть запущена.

{% endnote %}

Привязать политику к виртуальной машине также можно во время создания ВМ. Привязка политики выполняется асинхронно после создания и инициализации ВМ, а также установки и настройки агента Cloud Backup. Это может занимать до 10–15 минут. Подробнее об автоматической привязке политик к виртуальным машинам см. в разделе [Автоматическая привязка политики резервного копирования Yandex Cloud Backup к ВМ](../../tutorials/vm-with-backup-policy/index.md).

## Поддерживаемые образы Cloud Marketplace с автоматической установкой агента Cloud Backup {#os}


На виртуальных машинах Compute Cloud агент Cloud Backup доступен для автоматической установки при создании ВМ с использованием следующих образов Cloud Marketplace:

### Образы на базе Linux {#linux}

* [CentOS 7](https://yandex.cloud/ru/marketplace/products/yc/centos-7)
* [CentOS 7 OS Login](https://yandex.cloud/ru/marketplace/products/yc/centos-7-oslogin)
* [CentOS Stream](https://yandex.cloud/ru/marketplace/products/yc/centos-stream-8)
* [Debian 12](https://yandex.cloud/ru/marketplace/products/yc/debian-12)
* [Ubuntu 16.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-16-04-lts)
* [Ubuntu 18.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-18-04-lts)
* [Ubuntu 18.04 LTS OS Login](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-1804-lts-oslogin)
* [Ubuntu 20.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts)
* [Ubuntu 20.04 LTS OS Login](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2004-lts-oslogin)
* [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts)
* [Ubuntu 22.04 LTS OS Login](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2204-lts-oslogin)
* [Ubuntu 24.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2404-lts-oslogin)

### Образы на базе Windows {#windows}

* [Kosmos VM 2022 на базе Windows Server Datacenter 2022](https://yandex.cloud/ru/marketplace/products/fotonsrv/kosmosvm2022)
* [Kosmos VM 2019 на базе Windows Server Datacenter 2019](https://yandex.cloud/ru/marketplace/products/fotonsrv/kosmosvm2019)
* [Kosmos VM 2016 на базе Windows Server Datacenter 2016](https://yandex.cloud/ru/marketplace/products/fotonsrv/kosmosvm2016)
* [Kosmos VM RDS (5 лицензий)](https://yandex.cloud/ru/marketplace/products/fotonsrv/kos-5-rds)
* [Kosmos VM RDS (10 лицензий)](https://yandex.cloud/ru/marketplace/products/fotonsrv/kos-10-rds)
* [Kosmos VM RDS (50 лицензий)](https://yandex.cloud/ru/marketplace/products/fotonsrv/kos-50-rds)
* [Kosmos BD WEB 2019](https://yandex.cloud/ru/marketplace/products/fotonsrv/kosmosbdweb2019)
* [Kosmos BD Standard 2019](https://yandex.cloud/ru/marketplace/products/fotonsrv/kosmosbdstd2019)
* [Kosmos VM Visio Pro 2021](https://yandex.cloud/ru/marketplace/products/fotonsrv/kosmosvisio)

{% note info %}

Операционная система должна быть установлена из публичного образа (продукта Yandex Cloud Marketplace). При создании ВМ можно выбрать ОС напрямую либо использовать [образ](../../../compute/concepts/image.md) или [снимок диска](../../../compute/concepts/snapshot.md) с другой ВМ, если ОС на нее также устанавливалась из публичного образа.

{% endnote %}

### Самостоятельная установка в поддерживаемой операционной системе {#self-install}

Вы можете самостоятельно установить агент Cloud Backup на виртуальную машину. Подробнее читайте в следующих разделах:

* [Инструкция для Linux](../../operations/connect-vm-linux.md)
* [Инструкция для Windows](../../operations/connect-vm-windows.md)

С полным списком поддерживаемых ОС можно ознакомиться в [документации провайдера резервного копирования](https://docs.cyberprotect.ru/ru-RU/CyberBackupCloud/21.06/user/#supported-operating-systems-and-environments.html).

При возникновении проблем с установкой агента Cloud Backup [обратитесь](https://center.yandex.cloud/support) в службу технической поддержки.

### Обновление ядра операционной системы {#os-kernel-update}

При обновлении [ядра](https://ru.wikipedia.org/wiki/Ядро_Linux) операционной системы Linux [защищаемого ресурса](../index.md#protected-resources), подключенного к Cloud Backup, работоспособность агента Cloud Backup может оказаться нарушена: будет невозможно создать резервную копию защищаемого ресурса или восстановить его из резервной копии.

Функционирование агента может нарушиться, потому что модуль SnapAPI, разработанный [провайдером резервного копирования](../index.md#providers) для работы агента с дисками и собираемый [фреймворком DKMS](https://ru.wikipedia.org/wiki/Dynamic_Kernel_Module_Support) под конкретное ядро Linux, после обновления ядра может не обновиться и перестать соответствовать версии ядра.

Чтобы восстановить работоспособность агента Cloud Backup, нарушенную после обновления ядра ОС, необходимо обновить версию заголовков ядра Linux, на которую ориентируется DKMS при сборке модуля SnapAPI. Как только версия заголовков ядра станет соответствовать версии ядра, DKMS пересоберет модуль SnapAPI под нужную версию ядра Linux при следующем запуске защищаемого ресурса.

Чтобы обновить версии заголовков ядра Linux, воспользуйтесь инструкцией [Восстановить работоспособность агента Cloud Backup после обновления ядра Linux](../../operations/backup-baremetal/restore-agent.md).

## Сервисный аккаунт {#sa}

{% note info %}

При создании ВМ с помощью [консоли управления](https://console.yandex.cloud) использовать сервисный аккаунт не обязательно. При этом пользователю, создающему ВМ, должна быть назначена [роль](../../security/index.md#backup-user) `backup.user` или выше на каталог, в котором создается ВМ.

{% endnote %}

[Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — специальный аккаунт, от имени которого агент Cloud Backup регистрируется у [провайдера](../index.md#providers) Киберпротект.

Когда вы создаете ВМ Compute Cloud, для которой хотите настроить резервное копирование в Cloud Backup, к ВМ нужно привязать сервисный аккаунт с [ролью](../../security/index.md#backup-user) `backup.user` или выше.

Вы можете [назначить роль](../../../iam/operations/sa/assign-role-for-sa.md) существующему сервисному аккаунту или [создать](../../../iam/operations/sa/create.md) новый сервисный аккаунт с нужной ролью.

## Разрешения сетевого доступа {#vm-network-access}

Чтобы агент Cloud Backup мог обмениваться данными с серверами провайдера резервного копирования, для виртуальной машины должен быть обеспечен сетевой доступ к IP-адресам ресурсов сервиса Cloud Backup согласно таблице:

{% list tabs group=traffic %}

- Исходящий трафик {#outgoing}

  Диапазон портов | Протокол | Назначение | IPv4 CIDR
  --- | --- | --- | ---
  `80` | `TCP` | `Диапазон адресов` | `213.180.193.0/24`
  `80` | `TCP` | `Диапазон адресов` | `213.180.204.0/24`
  `443` | `TCP` | `Диапазон адресов` | `84.47.172.0/24`
  `443` | `TCP` | `Диапазон адресов` | `84.201.181.0/24`
  `443` | `TCP` | `Диапазон адресов` | `178.176.128.0/24`
  `443` | `TCP` | `Диапазон адресов` | `213.180.193.0/24`
  `443` | `TCP` | `Диапазон адресов` | `213.180.204.0/24`
  `7770-7800` | `TCP` | `Диапазон адресов` | `84.47.172.0/24`
  `8443` | `TCP` | `Диапазон адресов` | `84.47.172.0/24`
  `44445` | `TCP` | `Диапазон адресов` | `51.250.1.0/24`

  {% note tip %}

  При установке [агента Cloud Backup](../agent.md) на ВМ может понадобиться доустановить отсутствующие компоненты ПО из интернета. Для этого добавьте в [группу безопасности](../../../vpc/concepts/security-groups.md) следующее правило для исходящего трафика:
  * **Диапазон портов** — `0-65535`.
  * **Протокол** — `Любой` (`Any`).
  * **Назначение** — `Диапазон адресов`.
  * **IPv4 CIDR** — `0.0.0.0/0`.
  После установки агента Cloud Backup вы можете удалить это правило.

  Для доступа к ВМ по протоколу [SSH](../../../compute/operations/vm-connect/ssh.md) добавьте следующее правило для входящего трафика:
  * **Диапазон портов** — `22`.
  * **Протокол** — `Любой` (`Any`).
  * **Назначение** — `Диапазон адресов`.
  * **IPv4 CIDR** — `0.0.0.0/0`.

  {% endnote %}

{% endlist %}

Чтобы обеспечить сетевой доступ:
{#provide-access}

[Назначьте](../../../compute/operations/vm-control/vm-attach-public-ip.md) виртуальной машине публичный IP-адрес или примените [таблицу маршрутизации](../../../vpc/concepts/routing.md#rt-vm), разрешающую доступ в интернет через [NAT-шлюз](../../../vpc/concepts/gateways.md) или пользовательский маршрутизатор.

Правила [группы безопасности](../../../vpc/concepts/security-groups.md) ВМ должны разрешать доступ к указанным ресурсам. Вы можете [добавить правила](../../../vpc/operations/security-group-add-rule.md) в существующую группу безопасности или [создать](../../../vpc/operations/security-group-create.md) новую группу с нужными правилами.

## Статусы подключения {#statuses}

Информация о статусе подключения ВМ к Cloud Backup отображается в [консоли управления](https://console.yandex.cloud) в сервисе **Compute Cloud** на странице со списком ВМ. Доступны следующие статусы:

* `Подключён` — сервис Cloud Backup подключен к ВМ, резервные копии создаются в рамках указанных политик, агент Cloud Backup онлайн.
* `Нет политики` — сервис подключен, но не привязана ни одна политика, резервные копии не создаются.
* `Ошибка` — агент не онлайн или произошла ошибка регистрации агента.
* `Не подключён` — сервис не подключен к ВМ.

Вы можете [посмотреть](../../operations/get-connection-status.md) статус подключения ВМ и [узнать](../../operations/get-journal.md) подробности о резервном копировании ВМ в журнале резервного копирования.

#### См. также {#see-also}

* [Автоматическая привязка политики резервного копирования Yandex Cloud Backup к ВМ](../../tutorials/vm-with-backup-policy/index.md)
* [Подключение серверов Yandex BareMetal к Cloud Backup](baremetal.md)
* [Подключение к Cloud Backup виртуальных машин и серверов, расположенных за пределами Yandex Cloud](external-resources.md)