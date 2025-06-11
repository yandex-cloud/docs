---
title: Посмотреть статус подключения ВМ
description: Следуя данной инструкции, вы сможете узнать статус подключения сервиса {{ backup-name }} к виртуальной машине.
---

# Посмотреть статус подключения ВМ

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева нажмите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.

  В столбце **{{ ui-key.yacloud.compute.instances.column_cloud-backup }}** вы увидите статусы подключения {{ backup-name }} к ВМ.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра списка ВМ, подключенных к {{ backup-name }}:

      ```bash
      yc backup vm list compute --help
      ```

  1. Выполните команду:

      ```bash
      yc backup vm list compute
      ```

      Результат:

      ```text
      +----------------------+-------------+--------+---------+--------+-----------------+---------------------+---------------------+---------------------+--------+---------------------+---------------------+---------+
      |     INSTANCE ID      | RESOURCE ID | ONLINE | ENABLED | STATUS | STATUS PROGRESS |   STATUS DETAILS    |  LAST BACKUP TIME   |  NEXT BACKUP TIME   | ACTIVE |     CREATED AT      |     UPDATED AT      |  TYPE   |
      +----------------------+-------------+--------+---------+--------+-----------------+---------------------+---------------------+---------------------+--------+---------------------+---------------------+---------+
      | epdrmd2rpo6s******** | d0a6...1281 | true   | true    | OTHER  |               0 | no_policies_applied |                     |                     | true   | 2025-03-05 07:13:24 | 2025-03-05 07:13:24 | COMPUTE |
      | epd5fs8ojqhg******** | 68b1...2a82 | true   | true    | IDLE   |               0 |                     | 2025-03-05 07:05:10 | 2025-03-05 07:05:10 | true   | 2025-03-05 05:20:11 | 2025-03-05 07:05:22 | COMPUTE |
      +----------------------+-------------+--------+---------+--------+-----------------+---------------------+---------------------+---------------------+--------+---------------------+---------------------+---------+
      ```

      В столбце `STATUS` вы увидите статус подключения ВМ.

      Чтобы посмотреть статус подключения конкретной ВМ, выполните команду:

      ```bash
      yc backup vm get <идентификатор_ВМ>
      ```

      Результат:

      ```text
      compute_instance_id: epd5fs8ojqhg********
      created_at: "2025-03-05T05:20:11.391904178Z"
      updated_at: "2025-03-05T07:05:22.528557095Z"
      online: true
      enabled: true
      status: IDLE
      last_backup_time: "2025-03-05T07:05:10Z"
      next_backup_time: "2025-03-05T08:00:00Z"
      resource_id: 68b1e3f7-a855-45c7-8daf-13c8********
      is_active: true
      init_status: REGISTRED
      metadata: "null"
      type: COMPUTE
      ```

- API {#api}

  Чтобы посмотреть статусы подключения всех ВМ, воспользуйтесь методом REST API [list](../backup/api-ref/Resource/list.md) для ресурса [Resource](../backup/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/List](../backup/api-ref/grpc/Resource/list.md).

  Чтобы посмотреть статус подключения конкретной ВМ, воспользуйтесь методом REST API [get](../backup/api-ref/Resource/get.md) для ресурса [Resource](../backup/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Get](../backup/api-ref/grpc/Resource/get.md).

{% endlist %}

#### См. также {#see-also}

* [Статусы подключения ВМ](../concepts/vm-connection.md#statuses)
* [{#T}](get-journal.md)