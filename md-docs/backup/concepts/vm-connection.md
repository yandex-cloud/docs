# Подключение виртуальных машин {{ compute-name }} и серверов {{ baremetal-full-name }} к {{ backup-name }}


Если вы хотите создавать резервные копии [виртуальных машин](../../compute/concepts/vm.md) [{{ compute-full-name }}](../../compute/index.md) или [серверов {{ baremetal-name }}](../../baremetal/concepts/servers.md) в сервисе {{ backup-name }}, эти ВМ и сервера нужно подключить к сервису и корректно настроить.

К {{ backup-name }} можно подключить:
* Виртуальные машины, созданные из [поддерживаемых образов {{ marketplace-full-name }}](#os). Агент {{ backup-name }} на таких ВМ устанавливается автоматически.
* Виртуальные машины, созданные из других образов, если эти образы поддерживаются [провайдером](index.md#providers) резервного копирования Киберпротект. Агента {{ backup-name }} на такие ВМ необходимо [устанавливать вручную](#self-install).
* Серверы {{ baremetal-name }} с [поддерживаемой](#self-install) операционной системой. Агента {{ backup-name }} на серверы {{ baremetal-name }} можно установить [вручную](#self-install) или автоматически при [заказе](../../baremetal/operations/servers/server-lease.md) сервера.

Подробнее о подключении к {{ backup-name }} см. в [инструкциях](../operations/index.md).

Чтобы подключение к {{ backup-name }} работало корректно, привяжите к защищаемому ресурсу [сервисный аккаунт](#sa) (с ролью `backup.user` или выше для ВМ или ролями `baremetal.editor` и `backup.user` или выше для сервера {{ baremetal-name }}) и настройте [сетевой доступ](#vm-network-access).

{% note tip %}

При создании ВМ с помощью [консоли управления]({{ link-console-main }}) использовать сервисный аккаунт не обязательно. При этом пользователю, создающему ВМ, должна быть назначена [роль](../security/index.md#backup-user) `backup.user` или выше на каталог, в котором создается ВМ.

{% endnote %}

После подключения к {{ backup-name }} [добавьте](../operations/policy-vm/attach-and-detach-vm.md#attach-vm) ВМ или сервер {{ baremetal-name }} в [политику резервного копирования](policy.md).

{% note info %}

В момент создания резервной копии виртуальная машина или сервер {{ baremetal-name }} должны быть запущены.

{% endnote %}

Привязать политику к виртуальной машине или серверу {{ baremetal-name }} также можно во время создания ВМ / заказа сервера. Привязка политики выполняется асинхронно после создания и инициализации ВМ / сервера, а также установки и настройки агента {{ backup-name }}. Это может занимать до 10–15 минут. Подробнее об автоматической привязке политик к виртуальным машинам см. в разделе [{#T}](../tutorials/vm-with-backup-policy/index.md).

## Требования к характеристикам ВМ и серверов {{ baremetal-name }} {#requirements}

Минимальные характеристики ВМ и серверов {{ baremetal-name }} для установки и корректной работы агента {{ backup-name }}:

* Объем свободного места на диске:

  * Для ВМ с ОС Linux — 2 ГБ.
  * Для ВМ с ОС Windows — 1,2 ГБ.

* Объем памяти (RAM) — при резервном копировании требуется 1 ГБ RAM на каждый ТБ резервной копии. Объем используемой памяти зависит от объема и типа данных, обрабатываемых [агентом {{ backup-name }}](agent.md).

{% note tip %}

Установка агента {{ backup-name }} является ресурсоемкой операцией. Если вы хотите использовать ВМ в минимально возможной конфигурации или, например, ВМ с [уровнем производительности vCPU](../../compute/concepts/performance-levels.md) ниже 100%, рекомендуем на время установки агента {{ backup-name }} увеличить ресурсы ВМ.

{% endnote %}

Для ускорения [резервного копирования](../operations/backup-vm/create.md) данных и их [восстановления](../operations/backup-vm/recover.md) из резервных копий [агент {{ backup-name }}](agent.md) может потреблять значительные объемы оперативной памяти (RAM) защищаемого ресурса — [виртуальной машины](../../compute/concepts/vm.md) или [сервера {{ baremetal-name }}](../../baremetal/concepts/servers.md). При этом агент может использовать всю доступную память, что в некоторых случаях приводит к сбоям в работе других служб защищаемого ресурса и невозможности завершить процесс резервного копирования или восстановления данных.

Чтобы предотвратить возникновение таких сбоев, [ограничьте](../operations/limit-agent-memory-usage.md) объем данных, кешируемых агентом в оперативной памяти.

{% note info %}

Ограничение использования оперативной памяти агентом {{ backup-name }} может привести к снижению скорости выполнения операций резервного копирования и восстановления данных.

{% endnote %}

## Поддерживаемые файловые системы {#file-systems}

#|
|| **Файловая система** | **ОС** | **Ограничения** ||
||
**FAT16/32**,
**ext2/ext3/ext4**,
**NTFS**
| Linux, Windows | Без ограничений ||
||
**JFS**,
**ReiserFS3**
| Linux 
|
* Файлы невозможно исключить из резервной копии диска
* Невозможно включить быстрое инкрементное/дифференциальное резервное копирование
|| 
|| 
**ReiserFS4** | Linux 
|
* Файлы невозможно исключить из резервной копии диска
* Невозможно включить быстрое инкрементное/дифференциальное резервное копирование
* Невозможно изменить размер томов при выполнении восстановления 
|| 
||
**ReFS**,
**XFS**
| Linux, Windows 
|
* Файлы невозможно исключить из резервной копии диска
* Невозможно включить быстрое инкрементное/дифференциальное резервное копирование
* Невозможно изменить размер томов при выполнении восстановления 
||
|| **Linux SWAP**     | Linux | Без ограничений ||
|| **exFAT**          | Linux, Windows 
|
* Поддерживается только резервное копирование дисков/томов
* Файлы невозможно исключить из резервной копии
* Отдельные файлы невозможно восстановить из резервной копии
||
|# {wide-content}

## Поддерживаемые образы {{ marketplace-name }} с автоматической установкой агента {{ backup-name }} {#os}


На виртуальных машинах и серверах {{ baremetal-name }} агент {{ backup-name }} доступен для автоматической установки при создании ВМ / заказе сервера с использованием следующих образов {{ marketplace-name }}:

### Образы на базе Linux {#linux}

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

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

- Сервер {{ baremetal-name }} {#baremetal-server}

  * CentOS 7
  * Debian 11
  * Ubuntu 18.04 LTS
  * Ubuntu 20.04 LTS
  * Ubuntu 22.04 LTS
  * Ubuntu 24.04 LTS

{% endlist %}

### Образы на базе Windows {#windows}

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

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

  Операционная система должна быть установлена из публичного образа (продукта {{ marketplace-full-name }}). При создании ВМ можно выбрать ОС напрямую либо использовать [образ](../../compute/concepts/image.md) или [снимок диска](../../compute/concepts/snapshot.md) с другой ВМ, если ОС на нее тоже устанавливалась из публичного образа.

  {% endnote %}

{% endlist %}

### Самостоятельная установка в поддерживаемой операционной системе {#self-install}

Вы можете самостоятельно установить агента {{ backup-name }} на виртуальную машину или сервер {{ baremetal-name }}:

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

  * [Инструкция для Linux](../operations/connect-vm-linux.md)
  * [Инструкция для Windows](../operations/connect-vm-windows.md)

  С полным списком поддерживаемых ОС можно ознакомиться в [документации провайдера резервного копирования](https://docs.cyberprotect.ru/ru-RU/CyberBackupCloud/21.06/user/#supported-operating-systems-and-environments.html).

- Сервер {{ baremetal-name }} {#baremetal-server}

  Установить агента {{ backup-name }} можно на сервер с одной из операционных систем:

  * CentOS 7;
  * Debian 11;
  * Ubuntu 16.04 LTS;
  * Ubuntu 18.04 LTS;
  * Ubuntu 20.04 LTS;
  * Ubuntu 22.04 LTS;
  * Ubuntu 24.04 LTS.

  Чтобы установить агента на сервер, воспользуйтесь [инструкцией по подключению сервера {{ baremetal-name }} к {{ backup-name }}](../operations/backup-baremetal/backup-baremetal.md).

{% endlist %}

При возникновении проблем с установкой агента {{ backup-name }} [обратитесь]({{ link-console-support }}) в техническую поддержку.

### Обновление ядра операционной системы {#os-kernel-update}

При обновлении [ядра](https://ru.wikipedia.org/wiki/Ядро_Linux) операционной системы Linux виртуальной машины или сервера {{ baremetal-name }}, подключенных к {{ backup-name }}, работоспособность агента {{ backup-name }} может оказаться нарушена: будет невозможно создать резервную копию ВМ/сервера или восстановить ВМ/сервер из резервной копии.

Функционирование агента может нарушиться, потому что модуль SnapAPI, разработанный [провайдером резервного копирования](index.md#providers) для работы агента с дисками и собираемый [фреймворком DKMS](https://ru.wikipedia.org/wiki/Dynamic_Kernel_Module_Support) под конкретное ядро Linux, после обновления ядра может не обновиться и перестать соответствовать версии ядра. 

Чтобы восстановить работоспособность агента {{ backup-name }}, нарушенную после обновления ядра ОС, необходимо обновить версию заголовков ядра Linux, на которую ориентируется DKMS при сборке модуля SnapAPI. Как только версия заголовков ядра станет соответствовать версии ядра, DKMS пересоберет модуль SnapAPI под нужную версию ядра Linux при следующем запуске ВМ или сервера {{ baremetal-name }}.

Чтобы обновить версии заголовков ядра Linux, воспользуйтесь инструкциями [Восстановить работоспособность агента {{ backup-name }} на ВМ](../operations/update-backup-agent.md#restore-agent) и [Восстановить работоспособность агента {{ backup-name }} на сервере {{ baremetal-name }}](../operations/backup-baremetal/restore-agent.md).

## Сервисный аккаунт {#sa}

{% note info %}

При создании ВМ с помощью [консоли управления]({{ link-console-main }}) использовать сервисный аккаунт не обязательно. При этом пользователю, создающему ВМ, должна быть назначена [роль](../security/index.md#backup-user) `backup.user` или выше на каталог, в котором создается ВМ.

{% endnote %}

[Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — специальный аккаунт, от имени которого агент {{ backup-name }} регистрируется у провайдера Киберпротект.

Когда вы создаете ВМ, для которой хотите настроить резервное копирование в {{ backup-name }}, к ВМ нужно привязать сервисный аккаунт с ролью [`backup.user`](../security/index.md#backup-user) или выше.

Когда вы заказываете сервер {{ baremetal-name }}, для которого хотите настроить резервное копирование в {{ backup-name }}, к серверу нужно привязать сервисный аккаунт с ролями [`baremetal.editor`](../../baremetal/security/index.md#baremetal-editor) и [`backup.user`](../security/index.md#backup-user) или выше.

Вы можете [назначить роль](../../iam/operations/sa/assign-role-for-sa.md) существующему сервисному аккаунту или [создать](../../iam/operations/sa/create.md) новый сервисный аккаунт с нужными ролями.

## Разрешения сетевого доступа {#vm-network-access}

Чтобы агент {{ backup-name }} мог обмениваться данными с серверами [провайдера резервного копирования](index.md#providers), для ВМ или сервера {{ baremetal-name }} должен быть обеспечен сетевой доступ к IP-адресам ресурсов сервиса {{ backup-name }} согласно таблице:

{% list tabs group=traffic %}

- Исходящий трафик {#outgoing}

  {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
  --- | --- | --- | ---
  `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.193.0/24`
  `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.204.0/24`
  `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
  `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.201.181.0/24`
  `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `178.176.128.0/24`
  `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.193.0/24`
  `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.204.0/24`
  `7770-7800` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
  `8443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
  `44445` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `51.250.1.0/24`
  
  
  
  {% note tip %}
  
  При установке [агента {{ backup-name }}](agent.md) на ВМ или сервер {{ baremetal-name }} может понадобиться доустановить отсутствующие компоненты ПО из интернета. Для этого добавьте в [группу безопасности](../../vpc/concepts/security-groups.md) следующее правило для исходящего трафика:
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
  После установки агента {{ backup-name }} вы можете удалить это правило.
  
  Для доступа к ВМ по протоколу [SSH](../../compute/operations/vm-connect/ssh.md) добавьте следующее правило для входящего трафика:
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
  
  {% endnote %}

{% endlist %}

Чтобы обеспечить сетевой доступ:
{#provide-access}

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

  [Назначьте](../../compute/operations/vm-control/vm-attach-public-ip.md) виртуальной машине публичный IP-адрес или примените [таблицу маршрутизации](../../vpc/concepts/routing.md#rt-vm), разрешающую доступ в интернет через [NAT-шлюз](../../vpc/concepts/gateways.md) или пользовательский маршрутизатор.

  Правила [группы безопасности](../../vpc/concepts/security-groups.md) ВМ должны разрешать доступ к указанным ресурсам. Вы можете [добавить правила](../../vpc/operations/security-group-add-rule.md) в существующую группу безопасности или [создать](../../vpc/operations/security-group-create.md) новую группу с нужными правилами.

- Сервер {{ baremetal-name }} {#baremetal-server}

  При [заказе сервера](../../baremetal/operations/servers/server-lease.md) в поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите `{{ ui-key.yacloud.baremetal.label_public-ip-ephemeral }}` или `{{ ui-key.yacloud.baremetal.label_public-ip-from-dedicated-subnet }}`, чтобы назначить серверу публичный IP-адрес.

  Убедитесь, что сетевые настройки сервера не блокируют исходящий трафик на указанные ресурсы.

{% endlist %}

## Статусы подключения {#statuses}

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

  Информация о статусе подключения ВМ к {{ backup-name }} отображается в [консоли управления]({{ link-console-main }}) в сервисе **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** на странице со списком ВМ. Доступны следующие статусы:
  
  * `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-ok }}` — сервис {{ backup-name }} подключен к ВМ, резервные копии создаются в рамках указанных политик, агент {{ backup-name }} онлайн.
  * `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-no-applications }}` — сервис подключен, но не привязана ни одна политика, резервные копии не создаются.
  * `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-failed }}` — агент не онлайн или произошла ошибка регистрации агента.
  * `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-not-connected }}` — сервис не подключен к ВМ.
  
  Вы можете [посмотреть](../operations/get-connection-status.md) статус подключения ВМ и [узнать](../operations/get-journal.md) подробности о резервном копировании ВМ в журнале резервирования.

- Сервер {{ baremetal-name }} {#baremetal-server}

  Информация о статусе подключения сервера к {{ backup-name }} отображается в [консоли управления]({{ link-console-main }}) в сервисе **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}** на странице со списком серверов. Доступны следующие статусы:

  * `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-ok }}` — сервис {{ backup-name }} подключен к серверу, резервные копии создаются в рамках указанных политик, агент {{ backup-name }} онлайн.
  * `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-no-applications }}` — сервис подключен, но не привязана ни одна политика, резервные копии не создаются.
  * `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-failed }}` — агент не онлайн или произошла ошибка регистрации агента.
  * `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-not-connected }}` — сервис не подключен к серверу.

{% endlist %}

## Примеры использования {#examples}

* [{#T}](../tutorials/backup-baremetal.md)
* [{#T}](../tutorials/vm-with-backup-policy/index.md)