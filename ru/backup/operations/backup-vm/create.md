---
title: Как создать резервную копию виртуальной машины или сервера {{ baremetal-full-name }} в {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете создать резервную копию виртуальной машины или сервера {{ baremetal-name }}.
---

# Создать резервную копию виртуальной машины или сервера {{ baremetal-full-name }}

Чтобы создать резервную копию виртуальной машины или сервера {{ baremetal-name }}, [подключите](../../concepts/vm-connection.md) их к {{ backup-name }} и [привяжите](../policy-vm/attach-and-detach-vm.md#attach-vm) хотя бы к одной [политике резервного копирования](../../concepts/policy.md). Все резервные копии создаются только в рамках политик.

{% include [baremetal-note](../../../_includes/backup/baremetal-note.md) %}

О том, как создать резервную копию [сервера {{ baremetal-name }}](../../../baremetal/concepts/servers.md), см. в инструкции [Запуск создания резервной копии](../backup-baremetal/backup-baremetal.md#execute-policy).

Резервные копии в {{ backup-name }} создаются автоматически по расписанию, указанному в политике.

Чтобы создать резервную копию вне расписания:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% note info %}

  В настоящий момент с помощью консоли управления можно создавать резервные копии только для виртуальных машин {{ compute-full-name }}. Чтобы вне расписания создать резервную копию сервера {{ baremetal-name }}, используйте {{ yandex-cloud }} CLI.

  {% endnote %}

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

  1. Узнайте идентификатор виртуальной машины, резервную копию которой нужно создать:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

      Чтобы узнать идентификатор сервера {{ baremetal-name }}, в [консоли управления]({{ link-console-main }}) в списке сервисов нужного [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**. Идентификатор указан в поле **{{ ui-key.yacloud.common.id }}** в строке с нужным сервером.

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