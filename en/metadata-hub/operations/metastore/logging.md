# Transferring the {{ metastore-name }} cluster logs to {{ cloud-logging-full-name }}

You can set up regular collection of {{ metastore-name }} cluster performance logs. Logs are provided to a [log group](../../../logging/concepts/log-group.md) in {{ cloud-logging-full-name }}. You can choose between these two types of log groups:

* Log group used by default in the cluster folder
* Custom log group

## Getting started {#before-you-begin}

1. [Create a service account](../../../iam/operations/sa/create.md) named `metastore-logging-sa`.
1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles.metastore.integrationProvider }}` role to the service account.
1. [Set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) in the subnet the cluster will connect to. This will enable the cluster to work with {{ yandex-cloud }} services.
1. [Configure the security group](configure-security-group.md).

## Transferring data to the default log group {#default}

1. Create a {{ metastore-name }} cluster:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the appropriate folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
      1. In the left-hand panel, select the ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** page.
      1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
      1. Specify `metastore-cluster` as the cluster name.
      1. In the **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** field, select `metastore-logging-sa`.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network and subnet with a NAT gateway configured. Specify the security group you configured.
      1. Under **{{ ui-key.yacloud.logging.label_title }}**:

         1. Enable **{{ ui-key.yacloud.logging.field_logging }}**.
         1. To write logs to the default log group, select **{{ ui-key.yacloud.common.folder }}** in the **{{ ui-key.yacloud.logging.label_destination }}** field.
         1. Specify the folder whose log group you need to use.
         1. Select the minimum logging level.

            Logs of the specified level and higher will be written to the execution log. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default level is `INFO`.

      1. Click **{{ ui-key.yacloud.common.create }}**.

   {% endlist %}

1. Test the delivery of cluster logs to the log group.

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the management console, go to the relevant folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
      1. Click the row with the `default` log group.

      The page that opens will show the log group records.

   - CLI {#cli}

      To view the records in JSON format, run the command:

      ```bash
      yc logging read --group-name=default --format=json
      ```

      Result:

      ```text
      [
        {
          "uid": "23:6d******:3",
          "resource": {
            "type": "managed-metastore.cluster",
            "id": "c9qcv46p3g3a********"
          },
          "timestamp": "2024-11-18T09:45:23.092484Z",
          "ingested_at": "2024-11-18T09:45:24Z",
          "saved_at": "2024-11-18T09:45:25.559195Z",
          "level": "INFO",
          "message": "ugi=metastore\tip=10.253.89.135\tcmd=Done cleaning up thread local RawStore\t",
          "json_payload": {
            "instance": "metastore-server-5f9c7ff***-*****",
            "logger": "org.apache.hadoop.hive.metastore.HiveMetaStore.audit",
            "resource_id": "c9qcv46p3g3a********",
            "stream_name": "metastore-server",
            "thread": "pool-6-thread-79"
          },
          "stream_name": "metastore-server"
        }
      ]
      ```

   - API {#api}

      To view log group records, use the [LogReadingService.Read](../../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

   {% endlist %}

   For more information, see [{#T}](../../../logging/operations/read-logs.md).

## Sending data to a custom log group {#custom}

1. [Create a `metastore-log-group` log group](../../../logging/operations/create-group.md).
1. Create a {{ metastore-name }} cluster:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the appropriate folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
      1. In the left-hand panel, select the ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** page.
      1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
      1. Specify `metastore-cluster` as the cluster name.
      1. In the **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** field, select `metastore-logging-sa`.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network and subnet with a NAT gateway configured. Specify the security group you configured.
      1. Under **{{ ui-key.yacloud.logging.label_title }}**:

         1. Enable **{{ ui-key.yacloud.logging.field_logging }}**.
         1. To write logs to a custom log group, select **{{ ui-key.yacloud.logging.label_loggroup }}** in the **{{ ui-key.yacloud.logging.label_destination }}** field.
         1. Specify the log group, `metastore-log-group`.
         1. Select the minimum logging level.

            Logs of the specified level and higher will be written to the execution log. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default level is `INFO`.

      1. Click **{{ ui-key.yacloud.common.create }}**.

   {% endlist %}

1. Test the delivery of cluster logs to the log group.

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the management console, go to the relevant folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
      1. Click the row with the `metastore-log-group` log group.

      The page that opens will show the log group records.

   - CLI {#cli}

      To view the records in JSON format, run the command:

      ```bash
      yc logging read --group-name=metastore-log-group --format=json
      ```

      Result:

      ```text
      [
        {
          "uid": "23:6d******:3",
          "resource": {
            "type": "managed-metastore.cluster",
            "id": "c9qcv46p3g3a********"
          },
          "timestamp": "2024-11-18T09:45:23.092484Z",
          "ingested_at": "2024-11-18T09:45:24Z",
          "saved_at": "2024-11-18T09:45:25.559195Z",
          "level": "INFO",
          "message": "ugi=metastore\tip=10.253.89.135\tcmd=Done cleaning up thread local RawStore\t",
          "json_payload": {
            "instance": "metastore-server-5f9c7ff***-*****",
            "logger": "org.apache.hadoop.hive.metastore.HiveMetaStore.audit",
            "resource_id": "c9qcv46p3g3a********",
            "stream_name": "metastore-server",
            "thread": "pool-6-thread-79"
          },
          "stream_name": "metastore-server"
        }
      ]
      ```

   - API {#api}

      To view log group records, use the [LogReadingService.Read](../../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

   {% endlist %}

   For more information, see [{#T}](../../../logging/operations/read-logs.md).
