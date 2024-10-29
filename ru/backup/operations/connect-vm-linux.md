---
title: Как подключить виртуальную машину на Linux к {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете подключить виртуальную машину на Linux к {{ backup-name }}.
---

# Подключить виртуальную машину на Linux к {{ backup-name }}

Вы можете создавать резервные копии [виртуальных машин](../../compute/concepts/vm.md) {{ compute-name }} c [поддерживаемыми операционными системами на базе Linux](../concepts/vm-connection.md#linux).

{% include [requirements](../../_includes/backup/requirements.md) %}

{% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

Если вы [удалили](delete-vm.md) ВМ из {{ backup-name }} и хотите подключить ее к сервису заново, воспользуйтесь инструкцией ниже.

Чтобы подключить виртуальную машину на Linux к {{ backup-name }}:

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с [ролью](../security/index.md#backup-editor) `backup.editor`.
1. [Подключите](../../compute/operations/vm-control/vm-update.md) к ВМ сервисный аккаунт, созданный ранее.
1. [Настройте](../concepts/vm-connection.md#vm-network-access) сетевой доступ для ВМ.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по SSH.
1. Выполните команды:

    {% list tabs group=operating_system %}

    - Ubuntu {#ubuntu}

      ```bash
      sudo apt update && \
      sudo apt install -y jq && \
      curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash
      ```

      Результат:

      ```text
      ...
      Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
      ```

    - CentOS {#centos}

      ```bash
      sudo yum install epel-release -y && \
      sudo yum update -y && \
      sudo yum install jq -y && \
      curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash
      ```

      Результат:

      ```text
      ...
      Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
      ```

    {% endlist %}

После этого ВМ можно привязать к [политике резервного копирования](../concepts/policy.md).

Также чтобы подключить существующую ВМ к {{ backup-name }}, вы можете [сделать](../../compute/operations/disk-control/create-snapshot.md) снимки дисков этой ВМ и [создать](../../compute/operations/vm-create/create-from-snapshots.md) новую ВМ из этих снимков, выбрав опцию резервного копирования.

#### См. также {#see-also}

* [{#T}](create-vm.md)
* [Привязать виртуальную машину к политике резервного копирования](./policy-vm/update.md#update-vm-list)
* [{#T}](./policy-vm/create.md)
* [{#T}](./backup-vm/recover.md)
