---
title: Как подключить виртуальную машину на Linux к {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете подключить виртуальную машину на Linux к {{ backup-name }}.
---

# Подключить существующую виртуальную машину на Linux к {{ backup-name }}

Вы можете создавать резервные копии [виртуальных машин](../../compute/concepts/vm.md) {{ compute-name }} c [поддерживаемыми операционными системами на базе Linux](../concepts/vm-connection.md#linux).

{% include [requirements](../../_includes/backup/requirements.md) %}

{% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

Если вы [удалили](delete-vm.md) ВМ из {{ backup-name }} и хотите подключить ее к сервису заново, воспользуйтесь инструкцией ниже.

Чтобы подключить ВМ на Linux к {{ backup-name }}:

1. [{#T}](#create-sa).
1. [{#T}](#connect-sa-to-vm).
1. [{#T}](#configure-network-access).
1. [{#T}](#connect-vm).


## Создайте сервисный аккаунт {#create-sa}

{% include [create-sa-backup-editor](../../_includes/backup/operations/create-sa-backup-editor.md) %}


## Подключите сервисный аккаунт к ВМ {#connect-sa-to-vm}

{% include [connect-sa-to-vm](../../_includes/backup/operations/connect-sa-to-vm.md) %}


## Настройте сетевой доступ для ВМ {#configure-network-access}

### Создайте группу безопасности {#create-sg}

{% include [create-sg](../../_includes/backup/operations/create-sg.md) %}


### Настройте сетевой интерфейс ВМ {#configure-vm}

{% include [configure-vm](../../_includes/backup/operations/configure-vm.md) %}


## Установите агент {{ backup-name }} {#connect-vm}

{% include [install-agent-linux](../../_includes/backup/operations/install-agent-linux.md) %}

После этого ВМ можно привязать к [политике резервного копирования](../concepts/policy.md).

Также чтобы подключить существующую ВМ к {{ backup-name }}, вы можете [сделать](../../compute/operations/disk-control/create-snapshot.md) снимки дисков этой ВМ и [создать](../../compute/operations/vm-create/create-from-snapshots.md) новую ВМ из этих снимков, выбрав опцию резервного копирования.

{% note info %}

{% include [lvm-restoration-notice](../../_includes/backup/lvm-restoration-notice.md) %}

{% endnote %}

#### См. также {#see-also}

* [{#T}](create-vm.md)
* [Привязать виртуальную машину к политике резервного копирования](policy-vm/update.md#update-vm-list)
* [{#T}](policy-vm/create.md)
* [{#T}](backup-vm/recover.md)
