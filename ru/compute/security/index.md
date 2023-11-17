---
title: "Управление доступом в {{ compute-full-name }}"
description: "Управление доступом в сервисе предоставляющим масштабируемые вычислительные мощности для создания виртуальных машин и управления ими — {{ compute-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе."
---

# Управление доступом в {{ compute-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Кроме того, роль можно назначить и на отдельную ВМ. 

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/compute/security/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

Роль | Разрешения
----- | -----
`compute.admin` | Дает права на управление виртуальными машинами и [группами виртуальных машин](../../compute/concepts/instance-groups/index.md), а также позволяет назначать роли другим пользователям.
`compute.editor` | Дает права на управление виртуальными машинами и группами виртуальных машин.
`compute.viewer` | Дает права на просмотр информации о [ресурсах {{ compute-name }}](../concepts/index.md).
`compute.disks.user` | Позволяет использовать диски для создания новых ресурсов, например виртуальных машин.
`compute.images.user` | Позволяет использовать образы для создания новых ресурсов, например виртуальных машин.
`compute.operator` | Позволяет [останавливать, запускать и перезапускать виртуальные машины](../../compute/operations/vm-control/vm-stop-and-start.md), но не позволяет создавать и удалять ВМ.
`compute.snapshotSchedules.editor` | Дает права на [создание](../operations/snapshot-control/create-schedule.md) и [изменение](../operations/snapshot-control/update-schedule.md) снимков дисков по расписаниям.
`compute.snapshotSchedules.viewer` | Дает права на просмотр информации о [снимках дисков по расписаниям](../concepts/snapshot-schedule.md).
`compute.osLogin` | Разрешает доступ к виртуальным машинам по протоколу SSH через OS Login.
`compute.osAdminLogin` | Разрешает доступ к виртуальным машинам по протоколу SSH через OS Login с возможностью выполнять команды от имени суперпользователя (`sudo`).
`iam.serviceAccounts.user` | Подтверждает права на использование сервисного аккаунта.<br/>Эта роль необходима для выполнения операций с группами ВМ. Если вы указали сервисный аккаунт в запросе, {{ iam-short-name }} проверит, есть ли у вас права на использование этого аккаунта.
`resource-manager.clouds.member` | Роль, необходимая для доступа к ресурсам в облаке всем, кроме [владельцев облака](../../resource-manager/concepts/resources-hierarchy.md#owner) и [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md).
`resource-manager.clouds.owner` | Дает полный доступ к облаку и ресурсам в нем. Можно назначить только на облако.

Более подробную информацию о сервисных ролях читайте на странице [{#T}](../../iam/concepts/access-control/roles.md) в документации сервиса {{ iam-full-name }}.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

#### Что дальше {#what-is-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
