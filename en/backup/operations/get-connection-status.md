---
title: Viewing VM connection status
description: Follow this guide to find out the status of a {{ backup-name }} connection to a VM.
---

# Viewing VM connection status

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, click ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.

  In the **{{ ui-key.yacloud.compute.instances.column_cloud-backup }}** column, you will see the statuses of {{ backup-name }}'s connection to the VM.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view a list of VMs connected to {{ backup-name }}:

      ```bash
      yc backup vm list compute --help
      ```

  1. Run this command:

      ```bash
      yc backup vm list compute
      ```

      Result:

      ```text
      +----------------------+-------------+--------+---------+--------+-----------------+---------------------+---------------------+---------------------+--------+---------------------+---------------------+---------+
      |     INSTANCE ID      | RESOURCE ID | ONLINE | ENABLED | STATUS | STATUS PROGRESS |   STATUS DETAILS    |  LAST BACKUP TIME   |  NEXT BACKUP TIME   | ACTIVE |     CREATED AT      |     UPDATED AT      |  TYPE   |
      +----------------------+-------------+--------+---------+--------+-----------------+---------------------+---------------------+---------------------+--------+---------------------+---------------------+---------+
      | epdrmd2rpo6s******** | d0a6...1281 | true   | true    | OTHER  |               0 | no_policies_applied |                     |                     | true   | 2025-03-05 07:13:24 | 2025-03-05 07:13:24 | COMPUTE |
      | epd5fs8ojqhg******** | 68b1...2a82 | true   | true    | IDLE   |               0 |                     | 2025-03-05 07:05:10 | 2025-03-05 07:05:10 | true   | 2025-03-05 05:20:11 | 2025-03-05 07:05:22 | COMPUTE |
      +----------------------+-------------+--------+---------+--------+-----------------+---------------------+---------------------+---------------------+--------+---------------------+---------------------+---------+
      ```

      In the `STATUS` column, you will see the VM connection status.

      To view the connection status of a specific VM, run this command:

      ```bash
      yc backup vm get <VM_ID>
      ```

      Result:

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

  To view the connection statuses of all VMs, use the [list](../backup/api-ref/Resource/list.md) REST API method for the [Resource](../backup/api-ref/Resource/index.md) resource or the [ResourceService/List](../backup/api-ref/grpc/Resource/list.md) gRPC API call.

  To view the connection statuses of a specific VM, use the [get](../backup/api-ref/Resource/get.md) REST API method for the [Resource](../backup/api-ref/Resource/index.md) resource or the [ResourceService/Get](../backup/api-ref/grpc/Resource/get.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [VM connection statuses](../concepts/vm-connection.md#statuses)
* [{#T}](get-journal.md)