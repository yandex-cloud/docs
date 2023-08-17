# Подключить виртуальную машину Linux к {{ backup-name }}

Сервис {{ backup-name }} поддерживает резервное копирование [виртуальных машин {{ compute-name }}](../../compute/concepts/vm.md) с операционными системами семейства Linux — Ubuntu 20.04 и ниже и CentOS 7. Подробнее см. в разделе [{#T}](../concepts/vm-connection.md#os).

{% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с [ролью](../../iam/concepts/access-control/roles.md#backup-editor) `backup.editor`.
1. [Подключите](../../compute/operations/vm-control/vm-update.md) к ВМ сервисный аккаунт, созданный ранее.
1. Если у ВМ нет публичного IP-адреса, [подключите](../../compute/operations/vm-control/vm-attach-public-ip.md) его.
1. [Настройте](../../vpc/operations/security-group-add-rule.md) в группе безопасности [правила для работы с {{ backup-name }}](../concepts/vm-connection.md#security-groups).
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по SSH.
1. Выполните команды:

    {% list tabs %}

    - Ubuntu

      ```bash
      sudo apt update && \
      sudo apt install -y jq && \
      curl https://storage.yandexcloud.net/backup-distributions/agent_installer.sh | sudo bash
      ```

      Результат:

      ```text
      ...
      Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
      ```

    - CentOS

      ```bash
      sudo yum install epel-release -y && \
      sudo yum update -y && \
      sudo yum install jq -y && \
      curl https://storage.yandexcloud.net/backup-distributions/agent_installer.sh | sudo bash
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
