---
title: Посмотреть журнал резервного копирования
description: Следуя данной инструкции, вы сможете узнать подробности о резервном копировании ВМ в журнале резервного копирования.
---

# Посмотреть журнал резервного копирования

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева нажмите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud_billing.backup.label_instances }}**.
  1. В строке с нужной ВМ нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите `{{ ui-key.yacloud.backup.label_navigate-to-journal-action }}`.

      Также чтобы открыть журнал резервного копирования, вы можете навести указатель мыши на статус последней операции и перейти по ссылке во всплывающем окне.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра журнала резервирования:

      ```bash
      yc backup vm list-tasks --help
      ```

  1. Выполните команду:

      ```bash
      yc backup vm list-tasks <идентификатор_ВМ>
      ```

      Результат:

      ```bash
      +---------------------+-----------+----------------------+--------------+-----------------------+-----------+---------------------+---------------------+-------------+
      |       TASK ID       | POLICY ID |     INSTANCE ID      |     TYPE     |       PROGRESS        |  STATUS   |     STARTED AT      |    COMPLETED AT     | RESULT CODE |
      +---------------------+-----------+----------------------+--------------+-----------------------+-----------+---------------------+---------------------+-------------+
      | 15588663203******** | 999...18a | epd5fs8ojqhg******** | BACKUP       | current:94 total:100  | COMPLETED | 2025-03-05 07:00:02 | 2025-03-05 07:05:10 | OK          |
      | 15588519218******** | 999...18a | epd5fs8ojqhg******** | BACKUP       | current:100 total:100 | COMPLETED | 2025-03-05 06:00:02 | 2025-03-05 06:05:19 | OK          |
      | 15588436116******** | 894...2d1 | epd5fs8ojqhg******** | APPLY_POLICY |                       | COMPLETED | 2025-03-05 05:25:24 | 2025-03-05 05:25:24 | OK          |
      +---------------------+-----------+----------------------+--------------+-----------------------+-----------+---------------------+---------------------+-------------+
      ```

- API {#api}

  Воспользуйтесь методом REST API [listTasks](../backup/api-ref/Resource/listTasks.md) для ресурса [Resource](../backup/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/ListTasks](../backup/api-ref/grpc/Resource/listTasks.md).

{% endlist %}

#### См. также {#see-also}

* [Статусы подключения ВМ](../concepts/vm-connection.md#statuses)
* [{#T}](get-connection-status.md)