---
title: Как создать резервную копию виртуальной машины в {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете создать резервную копию виртуальной машины.
---

# Создать резервную копию виртуальной машины

Чтобы создать резервную копию виртуальной машины, [подключите](../../concepts/vm-connection.md) ее к {{ backup-name }} и [привяжите](../policy-vm/attach-and-detach-vm.md#attach-vm) хотя бы к одной [политике резервного копирования](../../concepts/policy.md). Все резервные копии создаются только в рамках политик.

Резервные копии ВМ в {{ backup-name }} создаются автоматически по расписанию, указанному в политике.

Чтобы создать резервную копию ВМ вне расписания:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать резервную копию.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. Выберите ВМ в [статусе](../../../compute/concepts/vm-statuses.md#list-of-statuses) `Running`, резервную копию которой вы хотите создать.
  1. Перейдите на вкладку **Резервные копии**.
  1. Нажмите кнопку **Создать резервную копию**.
  1. В открывшемся окне выберите политику, в рамках которой необходимо создать резервную копию, и нажмите **Создать**.

  Запустится процесс создания копии ВМ.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания резервной копии:

      ```bash
      yc backup policy execute --help
      ```

  1. Узнайте идентификатор политики резервного копирования, в соответствии с которой нужно создать резервную копию:

      {% include [get-backup-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Узнайте идентификатор ВМ, резервную копию которой нужно создать:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

  1. Создайте резервную копию:

      ```bash
      yc backup policy execute \
        --id <идентификатор_политики> \
        --instance-id <идентификатор_ВМ>
      ```

      Где:

      * `--id` — идентификатор политики резервного копирования, в соответствии с которой нужно создать резервную копию.
      * `--instance-id` — идентификатор ВМ, резервную копию которой нужно создать.

      Результат:

      ```bash
      id: abcsdngawmqv********
      description: execute policy
      created_at: "2024-08-19T09:38:06.015732Z"
      created_by: def9k8luj4qf********
      modified_at: "2024-08-19T09:38:06.015732Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.backup.v1.ExecuteMetadata
        policy_id: hij86k3tu3pu********
        compute_instance_id: klmc87d7q49r********
      ```

  Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/execute.md).

{% endlist %}