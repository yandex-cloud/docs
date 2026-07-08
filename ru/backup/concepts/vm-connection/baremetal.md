---
title: Подключение серверов {{ baremetal-full-name }} к {{ backup-full-name }}
description: Из этой статьи вы узнаете, как подключить к {{ backup-full-name }} виртуальные машины {{ baremetal-full-name }}.
---

# Подключение серверов {{ baremetal-full-name }} к {{ backup-name }}


Чтобы создавать резервные копии [серверов {{ baremetal-name }}](../../../baremetal/concepts/servers.md) в сервисе {{ backup-name }}, эти серверы нужно подключить к сервису и корректно настроить.

Подробнее о подключении серверов {{ baremetal-name }} к {{ backup-name }} читайте в разделе [{#T}](../../operations/index.md#connect-baremetal).

Чтобы подключение к {{ backup-name }} работало корректно, привяжите к серверу [сервисный аккаунт](#sa) с ролями [`baremetal.editor`](../../../baremetal/security/index.md#baremetal-editor) и [`backup.user`](../../security/index.md#backup-user) или выше и настройте [сетевой доступ](#vm-network-access).

После подключения к {{ backup-name }} [привяжите](../../operations/policy-vm/attach-and-detach-vm.md#attach-vm) сервер {{ baremetal-name }} к [политике резервного копирования](../policy.md).

{% note info %}

В момент создания резервной копии сервер {{ baremetal-name }} должен быть запущен.

{% endnote %}

Привязать политику к серверу {{ baremetal-name }} также можно во время заказа сервера. Привязка политики выполняется асинхронно после создания и инициализации сервера, а также установки и настройки агента {{ backup-name }}. Это может занимать до 10–15 минут.

## Поддерживаемые образы {{ marketplace-name }} с автоматической установкой агента {{ backup-name }} {#os}


На серверах {{ baremetal-name }} агент {{ backup-name }} доступен для автоматической установки при заказе сервера с использованием следующих образов {{ marketplace-name }}:

* CentOS 7
* Debian 11
* Ubuntu 18.04 LTS
* Ubuntu 20.04 LTS
* Ubuntu 22.04 LTS
* Ubuntu 24.04 LTS

{% note info %}

Операционная система должна быть установлена из публичного образа (продукта {{ marketplace-full-name }}).

{% endnote %}

### Самостоятельная установка в поддерживаемой операционной системе {#self-install}

Вы можете самостоятельно установить агент {{ backup-name }} на сервер {{ baremetal-name }} с одной из операционных систем:

{% include [baremetal-os-list](../../../_includes/backup/baremetal-os-list.md) %}

Чтобы установить агент на сервер, воспользуйтесь [инструкцией по подключению сервера {{ baremetal-name }} к {{ backup-name }}](../../operations/backup-baremetal/backup-baremetal.md).

При возникновении проблем с установкой агента {{ backup-name }} [обратитесь]({{ link-console-support }}) в службу технической поддержки.

### Обновление ядра операционной системы {#os-kernel-update}

{% include [update-kernel-headers-description](../../../_includes/backup/operations/update-kernel-headers-description.md) %}

Чтобы обновить версии заголовков ядра Linux, воспользуйтесь инструкцией [Восстановить работоспособность агента {{ backup-name }} на сервере {{ baremetal-name }}](../../operations/backup-baremetal/restore-agent.md).

## Сервисный аккаунт {#sa}

[Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — специальный аккаунт, от имени которого агент {{ backup-name }} регистрируется у [провайдера](../index.md#providers) Киберпротект.

Когда вы арендуете сервер {{ baremetal-name }}, для которого хотите настроить резервное копирование в {{ backup-name }}, к серверу нужно привязать сервисный аккаунт с ролями [`baremetal.editor`](../../../baremetal/security/index.md#baremetal-editor) и [`backup.user`](../../security/index.md#backup-user) или выше.

Вы можете [назначить роль](../../../iam/operations/sa/assign-role-for-sa.md) существующему сервисному аккаунту или [создать](../../../iam/operations/sa/create.md) новый сервисный аккаунт с нужными ролями.

## Разрешения сетевого доступа {#vm-network-access}

Чтобы агент {{ backup-name }} мог обмениваться данными с серверами провайдера резервного копирования, для сервера {{ baremetal-name }} должен быть обеспечен сетевой доступ к IP-адресам ресурсов сервиса {{ backup-name }} согласно таблице:

{% list tabs group=traffic %}

- Исходящий трафик {#outgoing}

  {% include [outgoing-rules](../../../_includes/backup/outgoing-rules.md) %}

  {% note tip %}

  При установке агента {{ backup-name }} на сервер {{ baremetal-name }} может понадобиться доустановить отсутствующие компоненты ПО из интернета. Для этого на время установки разрешите для сетевого интерфейса, подключенного к [публичной сети](../../../baremetal/concepts/public-network.md), любой исходящий сетевой трафик. После установки агента {{ backup-name }} вы можете вновь ограничить сетевой трафик с учетом указанных выше сетевых разрешений.

  {% endnote %}

{% endlist %}

Чтобы обеспечить сетевой доступ:
{#provide-access}

* При [аренде сервера](../../../baremetal/operations/servers/server-lease.md) в поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите `{{ ui-key.yacloud.baremetal.label_public-ip-ephemeral }}` или `{{ ui-key.yacloud.baremetal.label_public-ip-from-dedicated-subnet }}`, чтобы назначить серверу публичный IP-адрес.
* Убедитесь, что сетевые настройки сервера не блокируют исходящий трафик на указанные выше ресурсы.

## Статусы подключения {#statuses}

Информация о статусе подключения сервера к {{ backup-name }} отображается в [консоли управления]({{ link-console-main }}) в сервисе **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}** на странице со списком серверов. Доступны следующие статусы:

* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-ok }}` — сервис {{ backup-name }} подключен к серверу, резервные копии создаются в рамках указанных политик, агент {{ backup-name }} онлайн.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-no-applications }}` — сервис подключен, но не привязана ни одна политика, резервные копии не создаются.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-failed }}` — агент не онлайн или произошла ошибка регистрации агента.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-not-connected }}` — сервис не подключен к серверу.

#### См. также {#see-also}

* [{#T}](../../operations/index.md#connect-baremetal)
* [{#T}](./compute.md)
* [{#T}](./external-resources.md)