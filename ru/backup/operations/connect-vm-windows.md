---
title: Как подключить виртуальную машину на Windows Server к {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете подключить виртуальную машину на Windows Server к {{ backup-name }}.
---

# Подключить существующую виртуальную машину на Windows Server к {{ backup-name }}

Вы можете создавать резервные копии [виртуальных машин](../../compute/concepts/vm.md) {{ compute-name }} c [поддерживаемыми операционными системами на базе Windows](../concepts/vm-connection.md#windows).

{% include [requirements](../../_includes/backup/requirements.md) %}

{% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

Если вы [удалили](delete-vm.md) ВМ из {{ backup-name }} и хотите подключить ее к сервису заново, воспользуйтесь инструкцией ниже.

Чтобы подключить ВМ на Windows к {{ backup-name }}:

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

1. [Подключитесь к ВМ по RDP](../../compute/operations/vm-connect/rdp.md).
1. Запустите Windows PowerShell.

    {% include [ps-note](../../_includes/backup/ps-note.md) %}

1. Выполните следующую команду:

    ```powershell
    . { iwr -useb https://{{ s3-storage-host }}/backup-distributions/agent_installer.ps1 } | iex
    ```

    Результат:

    ```text
    ...
    Backup agent installation complete after 190 s!
    ```

После этого ВМ можно привязать к [политике резервного копирования](../concepts/policy.md).


#### См. также {#see-also}

* [{#T}](create-vm.md)
* [Привязать виртуальную машину к политике резервного копирования](./policy-vm/update.md#update-vm-list)
* [{#T}](./backup-vm/recover.md)
* [{#T}](./backup-vm/delete.md)
* [{#T}](./policy-vm/create.md)
