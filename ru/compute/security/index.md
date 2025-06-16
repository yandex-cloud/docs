---
title: Управление доступом в {{ compute-full-name }}
description: Управление доступом в сервисе предоставляющим масштабируемые вычислительные мощности для создания виртуальных машин и управления ими — {{ compute-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе.
---

# Управление доступом в {{ compute-name }}


В этом разделе вы узнаете:

* [об управлении доступом в {{ yandex-cloud }}](#about-access-control);
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли нужны для выполнения определенных действий](#choosing-roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

{% include [role-note](../../_includes/compute/role-note.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `compute.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначать роли {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Вы также можете назначать роли на отдельные ресурсы сервиса:

{% list tabs group=instructions %}

- Консоль управления {#console}

  Через [консоль управления]({{ link-console-main }}) вы можете назначить роли на следующие ресурсы:

  {% include notitle [compute-resources](../../_includes/iam/resources-with-access-control/compute.md) %}

- CLI {#cli}

  Через [{{ yandex-cloud }} CLI](../../cli/cli-ref/compute/cli-ref/index.md) вы можете назначить роли на следующие ресурсы:

  {% include notitle [compute-resources](../../_includes/iam/resources-with-access-control/compute.md) %}

- {{ TF }} {#tf}

  Через [{{ TF }}]({{ tf-provider-link }}) вы можете назначить роли на следующие ресурсы:

  {% include notitle [compute-resources-tf](../../_includes/iam/resources-with-access-control/compute-tf.md) %}

- API {#api}

  Через [API {{ yandex-cloud }}](../api-ref/authentication.md) вы можете назначить роли на следующие ресурсы:

  {% include notitle [compute-resources](../../_includes/iam/resources-with-access-control/compute.md) %}

{% endlist %}

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/compute/security/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

#### compute.auditor {#compute-auditor}

{% include [compute.auditor](../../_roles/compute/auditor.md) %}

#### compute.viewer {#compute-viewer}

{% include [compute.viewer](../../_roles/compute/viewer.md) %}

#### compute.editor {#compute-editor}

{% include [compute.editor](../../_roles/compute/editor.md) %}

#### compute.admin {#compute-admin}

{% include [compute.admin](../../_roles/compute/admin.md) %}

#### compute.osLogin {#compute-oslogin}

{% include [compute.oslogin](../../_roles/compute/osLogin.md) %}

#### compute.osAdminLogin {#compute-osadminlogin}

{% include [compute.osadminlogin](../../_roles/compute/osAdminLogin.md) %}

{% note alert %}

{% include [sudo-and-oslogin](../../_includes/compute/sudo-and-oslogin.md) %}

{% endnote %}

#### compute.disks.user {#compute-disks-user}

{% include [compute.disks.user](../../_roles/compute/disks/user.md) %}

#### compute.images.user {#compute-images-user}

{% include [compute.images.user](../../_roles/compute/images/user.md) %}

#### compute.operator {#compute-operator}

{% include [compute.operator](../../_roles/compute/operator.md) %}

#### compute.snapshotSchedules.viewer {#compute-snapshotSchedules-viewer}

{% include [compute.snapshotSchedules.viewer](../../_roles/compute/snapshotSchedules/viewer.md) %}

#### compute.snapshotSchedules.editor {#compute-snapshotSchedules-editor}

{% include [compute.snapshotSchedules.editor](../../_roles/compute/snapshotSchedules/editor.md) %}

#### iam.serviceAccounts.user {#iam-serviceAccounts-user}

{% include [iam.serviceAccounts.user](../../_roles/iam/serviceAccounts/user.md) %}

Более подробную информацию о сервисных ролях читайте на странице [{#T}](../../iam/concepts/access-control/roles.md) в документации сервиса {{ iam-full-name }}.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие права, чем указанная. Например, можно назначить `editor` вместо `compute.editor` или назначить роль `compute.viewer` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) вместо отдельной виртуальной машины или диска.

Действие | Минимально необходимые роли
----- | -----
**Просмотр информации** |
Просмотр информации о любом ресурсе и о [правах доступа](../../iam/concepts/access-control/index.md), назначенных к любому ресурсу | `compute.viewer` на этот ресурс
Просмотр списка [виртуальных машин](../concepts/vm.md), входящих в [группу виртуальных машин](../concepts/instance-groups/index.md), просмотр журнала логов группы виртуальных машин | `compute.viewer` на группу ВМ
Просмотр списка [дисков](../concepts/disk.md), входящих в [группу размещения дисков](../concepts/disk-placement-group.md) | `compute.viewer` на группу размещения дисков
Просмотр списка виртуальных машин, входящих в [кластер GPU](../concepts/gpus.md#gpu-clusters) | `compute.viewer` на кластер GPU
Просмотр списка виртуальных машин на [выделенном хосте](../concepts/dedicated-host.md), просмотр списка выделенных хостов в группе выделенных хостов | `compute.viewer` на группу выделенных хостов
Просмотр списка виртуальных машин в [группе размещения](../concepts/placement-groups.md) | `compute.viewer` на группу размещения
[Получение вывода последовательного порта](../operations/vm-info/get-serial-port-output.md) виртуальной машины | `compute.viewer` на ВМ
Получение информации о наиболее актуальном [образе](../concepts/image.md) в [семействе образов](../concepts/image.md#family) | `compute.viewer` или `compute.images.user` на образ
Просмотр информации о [расписаниях](../concepts/snapshot-schedule.md), по которым создаются [снимки](../concepts/snapshot.md) дисков, просмотр списка дисков, подключенных к определенному расписанию создания снимков дисков, и списка снимков дисков, созданных по этому расписанию | `compute.snapshotSchedules.viewer` или `compute.viewer` на расписание
**Использование ресурсов** |
Использование любого ресурса | `compute.editor` на этот ресурс
Использование [дисков](../concepts/disk.md) | `compute.disks.user`, `compute.snapshotSchedules.editor` или `compute.editor` на диск
Использование [образов](../concepts/image.md) | `compute.images.user` или `compute.editor` на образ
**Управление ресурсами** |
[Создание](../operations/vm-create/create-linux-vm.md) виртуальной машины | `compute.editor` на каталог
[Запуск](../operations/vm-control/vm-stop-and-start.md#start), [остановка](../operations/vm-control/vm-stop-and-start.md#stop) и [перезапуск](../operations/vm-control/vm-stop-and-start.md#restart) виртуальных машин | `compute.operator` на ВМ
[Изменение](../operations/vm-control/vm-update.md) и [удаление](../operations/vm-control/vm-delete.md) виртуальной машины | `compute.editor` на ВМ
[Привязка](../operations/vm-control/vm-connect-sa.md) сервисного аккаунта к ВМ | `compute.editor` на ВМ
[Изменение метаданных](../operations/vm-metadata/update-vm-metadata.md) виртуальной машины | `compute.editor` на ВМ
[Подключение](../operations/vm-control/vm-attach-disk.md) к ВМ и [отключение](../operations/vm-control/vm-detach-disk.md) от ВМ диска | `compute.editor` на ВМ
[Подключение](../operations/filesystem/attach-to-vm.md) к ВМ и [отключение](../operations/filesystem/detach-from-vm.md) от ВМ [файлового хранилища](../concepts/filesystem.md) | `compute.editor` на ВМ
[Добавление](../operations/vm-control/attach-network-interface.md) на ВМ и [удаление](../operations/vm-control/detach-network-interface.md) из ВМ [сетевого интерфейса](../concepts/network.md), [изменение](../operations/vm-control/internal-ip-update.md) сетевого интерфейса ВМ | `compute.editor` на ВМ
[Привязка](../operations/vm-control/vm-attach-public-ip.md) к ВМ и [отвязка](../operations/vm-control/vm-detach-public-ip.md) от ВМ [публичного IP-адреса](../../vpc/concepts/address#public-addresses.md) | `compute.editor` на ВМ
[Назначение](../operations/vm-control/vm-change-security-groups-set.md) виртуальной машине [групп безопасности](../../vpc/concepts/security-groups.md) | `compute.editor` на ВМ
Перенос виртуальной машины [в другой каталог](../operations/vm-control/vm-change-folder.md) облака | `compute.editor` на ВМ
[Имитирование](../operations/vm-control/vm-update-policies.md#simulate) события обслуживания виртуальной машины | `compute.editor` на ВМ
[Создание](../operations/instance-groups/create-fixed-group.md) группы виртуальных машин | `compute.editor` на каталог
[Запуск](../operations/instance-groups/start.md) и [остановка](../operations/instance-groups/stop.md) групп виртуальных машин | `compute.operator` на группу ВМ
[Изменение](../operations/instance-groups/update.md) и [удаление](../operations/instance-groups/delete.md) группы виртуальных машин | `compute.editor` на группу ВМ
Поочередный [перезапуск](../operations/instance-groups/rolling-restart.md) и поочередное [пересоздание](../operations/instance-groups/rolling-recreate.md) ВМ в группе ВМ | `compute.operator` на группу ВМ
[Приостановка](../operations/instance-groups/pause-processes.md) и [возобновление](../operations/instance-groups/resume-processes.md) процессов в группе виртуальных машин | `compute.editor` на группу ВМ
[Создание](../operations/gpu-cluster/gpu-cluster-create.md) кластера GPU | `compute.editor` на каталог
[Изменение](../operations/gpu-cluster/gpu-cluster-update.md) и [удаление](../operations/gpu-cluster/gpu-cluster-delete.md) кластера GPU | `compute.editor` на кластер GPU
[Создание](../operations/dedicated-host/create-host-group.md) группы выделенных хостов | `compute.editor` на каталог
Изменение и удаление группы выделенных хостов, изменение хоста в группе выделенных хостов | `compute.editor` на группу выделенных хостов
[Создание](../operations/reserved-pools/create-reserved-pool.md) пула зарезервированных ВМ | `compute.editor` на каталог
[Изменение](../operations/reserved-pools/update-reserved-pool.md) и [удаление](../operations/reserved-pools/delete-reserved-pool.md) пула зарезервированных ВМ | `compute.editor` на каталог
[Создание](../operations/placement-groups/create.md) группы размещения | `compute.editor` на каталог
Изменение и [удаление](../operations/placement-groups/delete.md) группы размещения | `compute.editor` на группу размещения
[Создание](../operations/disk-placement-groups/create.md) группы размещения дисков | `compute.editor` на каталог
Изменение и удаление группы размещения дисков | `compute.editor` на группу размещения дисков
[Создание](../operations/disk-create/empty.md) диска | `compute.editor` на каталог
[Изменение](../operations/disk-control/update.md) и [удаление](../operations/disk-control/delete.md) диска | `compute.editor` на диск
Перенос диска [в другой каталог](../operations/disk-control/disk-change-folder.md) облака | `compute.editor` на диск
[Создание](../operations/filesystem/create.md) файлового хранилища | `compute.editor` на каталог
[Изменение](../operations/filesystem/update.md) и [удаление](../operations/filesystem/delete.md) файлового хранилища | `compute.editor` на файловое хранилище
[Создание](../operations/image-create/create-from-disk.md) образа | `compute.editor` на каталог
Изменение и [удаление](../operations/image-control/delete.md) образа | `compute.editor` на образ
[Создание](../operations/disk-control/create-snapshot.md) снимка диска | `compute.snapshotSchedules.editor` или `compute.editor` на каталог
[Удаление](../operations/snapshot-control/delete.md) снимка диска | `compute.snapshotSchedules.editor` или `compute.editor` на снимок диска
[Создание](../operations/snapshot-control/create-schedule.md) расписания, по которому будут создаваться снимки дисков | `compute.snapshotSchedules.editor` или `compute.editor` на каталог
[Запуск](../operations/snapshot-control/stop-and-start-schedule.md#start-schedule), [остановка](../operations/snapshot-control/stop-and-start-schedule.md#stop-schedule), [изменение](../operations/snapshot-control/update-schedule.md) и [удаление](../operations/snapshot-control/delete-schedule.md) расписания, по которому создаются снимки дисков | `compute.snapshotSchedules.editor` или `compute.editor` на расписание
**Управление доступом к ресурсам** |
[Назначение](../../iam/operations/roles/grant.md) и [отзыв](../../iam/operations/roles/revoke.md) прав доступа к любому ресурсу | `compute.admin` на этот ресурс

#### Что дальше {#what-is-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
