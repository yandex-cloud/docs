---
title: Viewing backup log
description: Follow this guide to find detailed VM backup information in the backup log.
---

# Viewing backup log

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. In the left-hand panel, click ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud_billing.backup.label_instances }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the VM you need and select `{{ ui-key.yacloud.backup.label_navigate-to-journal-action }}`.

      To open the backup log, you can also hover over the last operation status and follow the link in the pop-up window.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view the backup log:

      ```bash
      yc backup vm list-tasks --help
      ```

  1. Run this command:

      ```bash
      yc backup vm list-tasks <VM_ID>
      ```

      Result:

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

  Use the [listTasks](../backup/api-ref/Resource/listTasks.md) REST API method for the [Resource](../backup/api-ref/Resource/index.md) resource or the [ResourceService/ListTasks](../backup/api-ref/grpc/Resource/listTasks.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [VM connection statuses](../concepts/vm-connection.md#statuses)
* [{#T}](get-connection-status.md)