---
title: Как создать резервную копию виртуальной машины или сервера в {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете создать резервную копию виртуальной машины или сервера в {{ backup-full-name }}.
---

# Создать резервную копию защищаемого ресурса


Чтобы создать резервную копию [защищаемого ресурса](../../concepts/index.md#protected-resources), [подключите](../../concepts/vm-connection/index.md) его к {{ backup-name }} и [привяжите](../policy-vm/attach-and-detach-vm.md#attach-vm) хотя бы к одной [политике резервного копирования](../../concepts/policy.md). Все резервные копии создаются только в рамках политик.

Резервные копии в {{ backup-name }} создаются автоматически по расписанию, указанному в политике.

Чтобы создать резервную копию вне расписания:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится политика резервного копирования.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![resources](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_connected-resources }}**.
  1. В зависимости от типа ресурса, для которого вы хотите создать резервную копию, откройте вкладку:

      * **{{ ui-key.yacloud.backup.label_instances }}** — для виртуальных машин {{ compute-name }}.
      * **{{ ui-key.yacloud.backup.label_baremetal-instances }}** — для серверов {{ baremetal-name }}.
      * **{{ ui-key.yacloud.backup.label_external-vm-instances }}** — для внешних виртуальных машин.
      * **{{ ui-key.yacloud.backup.label_external-server-instances }}** — для внешних серверов.

  1. В строке с нужным ресурсом нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.action_start_backup }}**.
  1. В открывшемся окне выберите политику резервного копирования, в соответствии с которой будет создана резервная копия, и нажмите **{{ ui-key.yacloud.common.create }}**.

  Запустится процесс создания резервной копии. Прогресс создания копии будет отображаться в строке соответствующего ресурса в поле **{{ ui-key.yacloud.backup.column_baremetal-instance-status }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания резервной копии:

      ```bash
      yc backup policy execute --help
      ```

  1. Узнайте идентификатор политики резервного копирования, в соответствии с которой нужно создать резервную копию:

      {% include [get-backup-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Узнайте идентификатор [защищаемого ресурса](../../concepts/index.md#protected-resources), резервную копию которого нужно создать:

      {% include [get-resource-ids](../../../_includes/backup/operations/get-resource-ids.md) %}

  1. Создайте резервную копию:

      ```bash
      yc backup policy execute \
        --id <идентификатор_политики> \
        --instance-id <идентификатор_защищаемого_ресурса>
      ```

      Где:

      * `--id` — идентификатор политики резервного копирования, в соответствии с которой нужно создать резервную копию.
      * `--instance-id` — идентификатор [виртуальной машины {{ compute-name }}](../../concepts/vm-connection/compute.md), [сервера {{ baremetal-name }}](../../concepts/vm-connection/baremetal.md) или [внешнего ресурса](../../concepts/vm-connection/external-resources.md), резервную копию которых нужно создать.

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

- API {#api}

  Воспользуйтесь методом REST API [execute](../../backup/api-ref/Policy/execute.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Execute](../../backup/api-ref/grpc/Policy/execute.md).

{% endlist %}