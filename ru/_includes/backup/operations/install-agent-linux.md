1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по SSH.
1. Установите агент {{ backup-name }} на ВМ. Для этого в терминале Linux выполните команду:

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

    {% note info %}

    В случае появления ошибки `Failed to parse cloudbackup from instance attributes IAM token and instance registration id are empty, unable to provide authorization` убедитесь, что к ВМ [привязан](../../../backup/operations/connect-vm-linux.md#connect-sa-to-vm) сервисный аккаунт с [ролью](../../../backup/security/index.md#backup-editor) `backup.editor`.

    {% endnote %}