---
title: Transferring {{ maf-full-name }} cluster logs to {{ cloud-logging-full-name }}
description: Follow this guide to set up the transfer of {{ maf-name }} cluster logs to {{ cloud-logging-name }}.
---

# Transferring {{ maf-name }} cluster logs to {{ cloud-logging-full-name }}

You can set up regular collection of {{ maf-name }} cluster performance logs. Logs will be delivered to a [log group](../../logging/concepts/log-group.md) in {{ cloud-logging-name }}. You can choose between these two types of log groups:

* Log group used by default in the cluster folder.
* Custom log group.

## Transferring data to the default log group {#default}

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `managed-airflow.integrationProvider` [role](../../iam/roles-reference.md#managed-airflow-integrationProvider) to the cluster service account.
1. Specify logging settings in the {{ maf-name }} cluster:

   {% list tabs group=instructions %}

   * Management console {#console}

      1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
      1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
      1. Under **{{ ui-key.yacloud.logging.label_title }}**, enable **{{ ui-key.yacloud.logging.field_logging }}**.
      1. To write logs to the default log group, select **{{ ui-key.yacloud.common.folder }}** in the **{{ ui-key.yacloud.logging.label_destination }}** field.
      1. Specify the folder whose log group you want to be using.
      1. Select the minimum logging level.

         Logs of the specified level and higher will be written to the execution log. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default level is `INFO`.

   * CLI {#cli}

      Specify the following logging parameters in the cluster create command:

      ```bash
      yc managed-airflow cluster update \
         ...
         --log-enabled \
         --log-folder-id <folder_ID> \
         --log-min-level <logging_level>
      ```

      Specify the folder whose log group you want to be using.

      Logs of the specified level and higher will be written to the execution log. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default level is `INFO`.

   * {{ TF }} {#tf}

      Specify the following parameters in the configuration file with the cluster description:

      ```hcl
      resource "yandex_airflow_cluster" "<cluster_name>" {
        ...
        logging = {
          enabled   = true
          folder_id = "<folder_ID>"
          min_level = "<logging_level>"
        }
      }
      ```

      Specify the folder whose log group you want to be using.

      Logs of the specified level and higher will be written to the execution log. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default level is `INFO`.

   * API {#api}

      In the body of the cluster update request ([Cluster.Update](../api-ref/Cluster/update.md) in the REST API or [ClusterService.Update](../api-ref/grpc/Cluster/update.md) in the gRPC API), specify the following parameters:

      ```json
      {
         ...
         "logging": {
            "enabled": true,
            "minLevel": "<logging_level>",
            "folderId": "<folder_ID>"
         }
      }
      ```

      Specify the folder whose log group you want to be using.

      Logs of the specified level and higher will be written to the execution log. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default level is `INFO`.

   {% endlist %}

1. Test the transfer of cluster logs to the log group.

   {% list tabs group=instructions %}

   * Management console {#console}

      1. In the management console, go to the relevant folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
      1. Click the row with the `default` log group.

      The page that opens will show the log group records.

   * CLI {#cli}

      To view the records in JSON format, run this command:

      ```bash
      yc logging read --group-name=default --format=json
      ```

      Result:

      ```text
      [
        {
          "uid": "3:74********",
          "resource": {
            "type": "managed-airflow.cluster",
            "id": "c9qv4tnjqdpa********"
          },
          "timestamp": "2024-10-31T11:14:53.740223Z",
          "ingested_at": "2024-10-31T11:14:55.633Z",
          "saved_at": "2024-10-31T11:14:57.231685Z",
          "level": "INFO",
          "message": "10.253.244.40 - - \"GET /health HTTP/1.1\" 200 283 \"-\" \"kube-probe/1.25\"",
          "json_payload": {
            "file": "/home/airflow/.local/lib/python3.8/site-packages/gunicorn/glogging.py",
            "instance": "airflow-c9qv4tnjqdpa********-webserver-68********-q5***",
            "line": 363,
            "resource_id": "c9qv4tnjqdpa********",
            "stream_name": "webserver",
            "thread": "MainThread"
          },
          "stream_name": "webserver"
        }
      ]
      ```

   * API {#api}

      To view log group records, use the [LogReadingService.Read](../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

   {% endlist %}

   For more information, see [{#T}](../../logging/operations/read-logs.md).

## Sending data to a custom log group {#custom}

1. [Create a log group](../../logging/operations/create-group.md) named `airflow-log-group`.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `managed-airflow.integrationProvider` [role](../../iam/roles-reference.md#managed-airflow-integrationProvider) to the cluster service account.
1. Specify logging settings in the {{ maf-name }} cluster:

   {% list tabs group=instructions %}

   * Management console {#console}

      1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
      1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
      1. Under **{{ ui-key.yacloud.logging.label_title }}**, enable **{{ ui-key.yacloud.logging.field_logging }}**.
      1. To write logs to a custom log group, select **{{ ui-key.yacloud.logging.label_loggroup }}** in the **{{ ui-key.yacloud.logging.label_destination }}** field.
      1. Specify the log group, `airflow-log-group`.
      1. Select the minimum logging level.

         Logs of the specified level and higher will be written to the execution log. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default level is `INFO`.

   * CLI {#cli}

      Specify the following logging parameters in the cluster create command:

      ```bash
      yc managed-airflow cluster create \
         ...
         --log-enabled \
         --log-group-id <log_group_ID> \
         --log-min-level <logging_level>
      ```

      Logs of the specified level and higher will be written to the execution log. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default level is `INFO`.

   * {{ TF }} {#tf}

      Specify the following parameters in the configuration file with the cluster description:

      ```hcl
      resource "yandex_airflow_cluster" "<cluster_name>" {
        ...
        logging = {
          enabled      = true
          log_group_id = "<log_group_ID>"
          min_level    = "<logging_level>"
        }
      }
      ```

      Logs of the specified level and higher will be written to the execution log. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default level is `INFO`.

   * API {#api}

      In the body of the cluster update request ([Cluster.Update](../api-ref/Cluster/update.md) in the REST API or [ClusterService.Update](../api-ref/grpc/Cluster/update.md) in the gRPC API), specify the following parameters:

      ```json
      {
         ...
         "logging": {
            "enabled": true,
            "minLevel": "<logging_level>",
            "logGroupId": "<log_group_ID>"
         }
      }
      ```

      Logs of the specified level and higher will be written to the execution log. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default level is `INFO`.

   {% endlist %}

1. Test the transfer of cluster logs to the log group.

   {% list tabs group=instructions %}

   * Management console {#console}

      1. In the management console, go to the relevant folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
      1. Click the row with the `airflow-log-group` log group.

      The page that opens will show the log group records.

   * CLI {#cli}

      To view the records in JSON format, run this command:

      ```bash
      yc logging read --group-name=airflow-log-group --format=json
      ```

      Result:

      ```text
      [
        {
          "uid": "3:74********",
          "resource": {
            "type": "managed-airflow.cluster",
            "id": "c9qv4tnjqdpa********"
          },
          "timestamp": "2024-10-31T11:14:53.740223Z",
          "ingested_at": "2024-10-31T11:14:55.633Z",
          "saved_at": "2024-10-31T11:14:57.231685Z",
          "level": "INFO",
          "message": "10.253.244.40 - - \"GET /health HTTP/1.1\" 200 283 \"-\" \"kube-probe/1.25\"",
          "json_payload": {
            "file": "/home/airflow/.local/lib/python3.8/site-packages/gunicorn/glogging.py",
            "instance": "airflow-c9qv4tnjqdpa********-webserver-68********-q5***",
            "line": 363,
            "resource_id": "c9qv4tnjqdpa********",
            "stream_name": "webserver",
            "thread": "MainThread"
          },
          "stream_name": "webserver"
        }
      ]
      ```

   * API {#api}

      To view log group records, use the [LogReadingService.Read](../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

   {% endlist %}

   For more information, see [{#T}](../../logging/operations/read-logs.md).
