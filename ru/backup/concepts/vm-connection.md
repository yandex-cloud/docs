---
title: Подключение виртуальных машин {{ compute-name }} и серверов {{ baremetal-full-name }} к {{ backup-name }}
description: Из этой статьи вы узнаете, какие виртуальные машины и сервера {{ baremetal-name }} можно подключить к {{ backup-name }}.
---

# Подключение виртуальных машин {{ compute-name }} и серверов {{ baremetal-full-name }} к {{ backup-name }}


Если вы хотите создавать резервные копии [виртуальных машин](../../compute/concepts/vm.md) [{{ compute-full-name }}](../../compute/) или [серверов {{ baremetal-name }}](../../baremetal/concepts/servers.md) в сервисе {{ backup-name }}, эти ВМ и сервера нужно подключить к сервису и корректно настроить.

К {{ backup-name }} можно подключить:
* Виртуальные машины, созданные из [поддерживаемых образов {{ marketplace-full-name }}](#os). Агент {{ backup-name }} на таких ВМ устанавливается автоматически.
* Виртуальные машины, созданные из других образов, если эти образы поддерживаются [провайдером](./index.md#providers) резервного копирования Киберпротект. Агента {{ backup-name }} на такие ВМ необходимо [устанавливать вручную](#self-install).
* Серверы {{ baremetal-name }} с [поддерживаемой](#self-install) операционной системой. Агента {{ backup-name }} на серверы {{ baremetal-name }} можно установить [вручную](#self-install) или автоматически при [заказе](../../baremetal/operations/servers/server-lease.md) сервера.

Подробнее о подключении к {{ backup-name }} см. в [инструкциях](../operations/index.md).

Чтобы подключение к {{ backup-name }} работало корректно, привяжите к защищаемому ресурсу [сервисный аккаунт](#sa) (с ролью `backup.editor` для ВМ или ролями `baremetal.editor` и `backup.editor` для сервера {{ baremetal-name }}) и настройте [сетевой доступ](#vm-network-access).

После подключения к {{ backup-name }} [добавьте](../operations/policy-vm/attach-and-detach-vm.md#attach-vm) ВМ или сервер {{ baremetal-name }} в [политику резервного копирования](policy.md).

{% include [vm-running](../../_includes/backup/vm-running.md) %}

Привязать политику к виртуальной машине или серверу {{ baremetal-name }} также можно во время создания ВМ / заказа сервера. Привязка политики выполняется асинхронно после создания и инициализации ВМ / сервера, а также установки и настройки агента {{ backup-name }}. Это может занимать до 10–15 минут. Подробнее об автоматической привязке политик к виртуальным машинам см. в разделе [{#T}](../tutorials/vm-with-backup-policy/index.md).

## Требования к характеристикам ВМ и серверов {{ baremetal-name }} {#requirements}

{% include [vm-requirements](../../_includes/backup/vm-requirements.md) %}

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

- Сервер {{ baremetal-name }} {#baremetal-server}

  * CentOS 7
  * Debian 10
  * Debian 11
  * Ubuntu 18.04 LTS
  * Ubuntu 20.04 LTS
  * Ubuntu 22.04 LTS
  * Ubuntu 24.04 LTS

{% endlist %}

### Образы на базе Windows {#windows}

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

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

  {% include [baremetal-os-list](../../_includes/backup/baremetal-os-list.md) %}

  Чтобы установить агента на сервер, воспользуйтесь [инструкцией по подключению сервера {{ baremetal-name }} к {{ backup-name }}](../operations/backup-baremetal/backup-baremetal.md).

{% endlist %}

При возникновении проблем с установкой агента {{ backup-name }} [обратитесь]({{ link-console-support }}) в техническую поддержку.

### Обновление ядра операционной системы {#os-kernel-update}

{% include [update-kernel-headers-description](../../_includes/backup/operations/update-kernel-headers-description.md) %}

Чтобы обновить версии заголовков ядра Linux, воспользуйтесь инструкциями [Восстановить работоспособность агента {{ backup-name }} на ВМ](../operations/update-backup-agent.md#restore-agent) и [Восстановить работоспособность агента {{ backup-name }} на сервере {{ baremetal-name }}](../operations/backup-baremetal/restore-agent.md).

## Сервисный аккаунт {#sa}

[Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — специальный аккаунт, от имени которого агент {{ backup-name }} регистрируется у провайдера Киберпротект.

Когда вы создаете ВМ, для которой хотите настроить резервное копирование в {{ backup-name }}, к ВМ нужно привязать сервисный аккаунт с ролью [`backup.editor`](../security/index.md#backup-editor).

Когда вы заказываете сервер {{ baremetal-name }}, для которого хотите настроить резервное копирование в {{ backup-name }}, к серверу нужно привязать сервисный аккаунт с ролями [`baremetal.editor`](../../baremetal/security/index.md#baremetal-editor) и [`backup.editor`](../security/index.md#backup-editor).

Вы можете [назначить роль](../../iam/operations/sa/assign-role-for-sa.md) существующему сервисному аккаунту или [создать](../../iam/operations/sa/create.md) новый сервисный аккаунт с нужными ролями.

## Разрешения сетевого доступа {#vm-network-access}

Чтобы агент {{ backup-name }} мог обмениваться данными с серверами [провайдера резервного копирования](index.md#providers), для ВМ или сервера {{ baremetal-name }} должен быть обеспечен сетевой доступ к IP-адресам ресурсов сервиса {{ backup-name }} согласно таблице:

{% list tabs group=traffic %}

- Исходящий трафик {#outgoing}

  {% include [outgoing traffic](../../_includes/backup/outgoing-rules.md) %}

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

  {% include [connection-statuses](../../_includes/backup/connection-statuses.md) %}

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
