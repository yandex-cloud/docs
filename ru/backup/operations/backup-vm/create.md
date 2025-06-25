---
title: Как создать резервную копию виртуальной машины или сервера {{ baremetal-full-name }} в {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете создать резервную копию виртуальной машины или сервера {{ baremetal-name }}.
---

# Создать резервную копию виртуальной машины или сервера {{ baremetal-full-name }}


Чтобы создать резервную копию виртуальной машины или сервера {{ baremetal-name }}, [подключите](../../concepts/vm-connection.md) их к {{ backup-name }} и [привяжите](../policy-vm/attach-and-detach-vm.md#attach-vm) хотя бы к одной [политике резервного копирования](../../concepts/policy.md). Все резервные копии создаются только в рамках политик.

Резервные копии в {{ backup-name }} создаются автоматически по расписанию, указанному в политике.

Чтобы создать резервную копию вне расписания:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится политика резервного копирования.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. В зависимости от ресурса, для которого вы хотите создать резервную копию, на панели слева выберите ![vm](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_instances }}** или ![bms](../../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.backup.label_baremetal-instances }}**.
  1. В строке с нужной виртуальной машиной или сервером {{ baremetal-name }} нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.backup.action_start_backup }}**.
  1. В открывшемся окне выберите политику резервного копирования, в соответствии с которой будет создана резервная копия, и нажмите **{{ ui-key.yacloud.common.create }}**.

  Запустится процесс создания резервной копии ВМ или сервера {{ baremetal-name }}. Прогресс создания копии будет отображаться в строке соответствующих ВМ или сервера {{ baremetal-name }} в поле **{{ ui-key.yacloud.backup.column_baremetal-instance-status }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания резервной копии:

      ```bash
      yc backup policy execute --help
      ```

  1. Узнайте идентификатор политики резервного копирования, в соответствии с которой нужно создать резервную копию:

      {% include [get-backup-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Узнайте идентификатор виртуальной машины, резервную копию которой нужно создать:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

      {% include [get-bms-ids](../../../_includes/backup/operations/get-bms-ids.md) %}

  1. Создайте резервную копию:

      ```bash
      yc backup policy execute \
        --id <идентификатор_политики> \
        --instance-id <идентификатор_ВМ_или_сервера_{{ baremetal-name }}>
      ```

      Где:

      * `--id` — идентификатор политики резервного копирования, в соответствии с которой нужно создать резервную копию.
      * `--instance-id` — идентификатор виртуальной машины или сервера {{ baremetal-name }}, резервную копию которых нужно создать.

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