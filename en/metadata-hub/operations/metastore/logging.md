---
title: Transferring {{ metastore-full-name }} cluster logs to {{ cloud-logging-full-name }}
description: Follow this guide to set up the transfer of {{ metastore-name }} cluster logs to {{ cloud-logging-name }}.
---

# Transferring {{ metastore-name }} cluster logs to {{ cloud-logging-full-name }}

You can set up regular collection of {{ metastore-name }} cluster performance logs. Logs will be delivered to a [log group](../../../logging/concepts/log-group.md) in {{ cloud-logging-full-name }}. You can choose between these two types of log groups:

* Default log group of the cluster folder.
* Custom log group.

## Getting started {#before-you-begin}

1. [Create a service account](../../../iam/operations/sa/create.md) named `metastore-logging-sa`.
1. [Assign the `{{ roles.metastore.integrationProvider }}` role](../../../iam/operations/sa/assign-role-for-sa.md) to the service account.
1. [Set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) in the subnet the cluster will connect to. This will enable the cluster to work with {{ yandex-cloud }} services.
1. [Configure the security group](configure-security-group.md).

## Transferring data to the default log group {#default}

1. Create a {{ metastore-name }} cluster:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder you need.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
      1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
      1. Specify `metastore-cluster` as the cluster name.
      1. In the **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** field, select `metastore-logging-sa`.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network and subnet with a NAT gateway configured. Specify the security group you configured.
      1. Under **{{ ui-key.yacloud.logging.label_title }}**:

         1. Enable **{{ ui-key.yacloud.logging.field_logging }}**.
         1. To write logs to the default log group, select **{{ ui-key.yacloud.common.folder }}** in the **{{ ui-key.yacloud.logging.label_destination }}** field.
         1. Specify the folder whose log group you want to use.
         1. Select the minimum logging level.

            The execution log will contain logs of this level or higher. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default is `INFO`.

      1. Click **{{ ui-key.yacloud.common.create }}**.

   - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      {{ yc-metastore }} cluster create \
         --name metastore-cluster \
         --service-account-id <service_account_ID> \
         --version <{{ metastore-name }}_version> \
         --subnet-ids <subnet_IDs> \
         --security-group-ids <security_group_IDs> \
         --resource-preset-id <ID_of_computing_resources> \
         --log-enabled \
         --log-folder-id <folder_ID> \
         --log-min-level <logging_level>
      ```

      Where:

      * `--service-account-id`: ID of the `metastore-logging-sa` service account you created [earlier](#before-you-begin).
      * `--subnet-ids`: ID of the subnet where you set up the NAT gateway.
      * `--security-group-ids`: ID of the security group you configured [earlier](#before-you-begin).
      * `--log-folder-id`: Specify the ID of the folder whose log group you want to use.
      * `--log-min-level`: Logging level. The execution log will contain logs of this level or higher. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default is `INFO`.

      [Learn more about creating a cluster](cluster-create.md).

    - REST API {#api}

        1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and save it as an environment variable:

            {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

        1. Create a file named `body.json` and paste the following code into it:

            ```json
            {
              "folderId": "<folder_ID>",
              "name": "metastore-cluster",
              "version": "<{{ metastore-name }}_version>",
              "configSpec": {
                "resources": {
                "resourcePresetId": "<resource_configuration_ID>"
                }
              },
              "serviceAccountId": "<service_account_ID>",
              "logging": {
                "enabled": true,
                "folderId": "<folder_ID>",
                "minLevel": "<logging_level>"
              },
              "network": {
                "subnetIds": [ "<list_of_subnet_IDs>" ],
                "securityGroupIds": [ "<list_of_security_group_IDs>" ]
              },
            }
            ```

            Where:

            * `serviceAccountId`: ID of the `metastore-logging-sa` service account you created [earlier](#before-you-begin).
            * `logging.folderId`: Specify the ID of the folder whose log group you want to use.
            * `logging.minLevel`: Logging level. The execution log will contain logs of this level or higher. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default is `INFO`.
            * `network.subnetIds`: ID of the subnet where you set up the NAT gateway.
            * `network.securityGroupIds`: ID of the security group you configured [earlier](#before-you-begin).

            [Learn more about creating a cluster](cluster-create.md).

        1. Use the [Cluster.Create](../../api-ref/Cluster/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request POST \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-metastore }}/managed-metastore/v1/clusters' \
                --data '@body.json'
            ```

        1. View the [server response](../../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

    - gRPC API {#grpc-api}

        1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and save it as an environment variable:

            {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

        1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

        1. Create a file named `body.json` and paste the following code into it:

            ```json
            {
              "folder_id": "<folder_ID>",
              "name": "metastore-cluster",
              "version": "<{{ metastore-name }}_version>",
              "config_spec": {
                "resources": {
                  "resource_preset_id": "<resource_configuration_ID>"
                }
              },
              "service_account_id": "<service_account_ID>",
              "logging": {
                "enabled": true,
                "folder_id": "<folder_ID>",
                "min_level": "<logging_level>"
              },
              "network": {
                "subnet_ids": [ "<list_of_subnet_IDs>" ],
                "security_group_ids": [ "<list_of_security_group_IDs>" ]
              },
            }
            ```

            Where:

            * `service_account_id`: ID of the `metastore-logging-sa` service account you created [earlier](#before-you-begin).
            * `logging.folder_id`: Specify the ID of the folder whose log group you want to use.
            * `logging.min_level`: Logging level. The execution log will contain logs of this level or higher. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default is `INFO`.
            * `network.subnet_ids`: ID of the subnet where you set up the NAT gateway.
            * `network.security_group_ids`: ID of the security group you configured [earlier](#before-you-begin).

            [Learn more about creating a cluster](cluster-create.md).

        1. Use the [ClusterService.Create](../../api-ref/grpc/Cluster/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d @ \
                {{ api-host-metastore }}:{{ port-https }} \
                yandex.cloud.metastore.v1.ClusterService.Create \
                < body.json
            ```

        1. View the [server response](../../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

   {% endlist %}

1. Test the transfer of cluster logs to the log group:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the management console, navigate to the relevant folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
      1. Click the row with the `default` log group.

      The page that opens will show the log group entries.

   - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      To view the entries in JSON format, run this command:

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

      To view log group entries, use the [LogReadingService.Read](../../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

   {% endlist %}

   For more information, see [{#T}](../../../logging/operations/read-logs.md).

## Sending data to a custom log group {#custom}

1. [Create a log group](../../../logging/operations/create-group.md) named `metastore-log-group`.
1. Create a {{ metastore-name }} cluster:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder you need.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
      1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
      1. Specify `metastore-cluster` as the cluster name.
      1. In the **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** field, select `metastore-logging-sa`.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network and subnet with a NAT gateway configured. Specify the security group you configured.
      1. Under **{{ ui-key.yacloud.logging.label_title }}**:

         1. Enable **{{ ui-key.yacloud.logging.field_logging }}**.
         1. To write logs to a custom log group, select **{{ ui-key.yacloud.logging.label_loggroup }}** in the **{{ ui-key.yacloud.logging.label_destination }}** field.
         1. Specify the `metastore-log-group` log group.
         1. Select the minimum logging level.

            The execution log will contain logs of this level or higher. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default is `INFO`.

      1. Click **{{ ui-key.yacloud.common.create }}**.

   - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      {{ yc-metastore }} cluster create \
         --name metastore-cluster \
         --service-account-id <service_account_ID> \
         --version <{{ metastore-name }}_version> \
         --subnet-ids <subnet_IDs> \
         --security-group-ids <security_group_IDs> \
         --resource-preset-id <ID_of_computing_resources> \
         --log-enabled \
         --log-group-id <log_group_ID> \
         --log-min-level <logging_level>
      ```

      Where:

      * `--service-account-id`: ID of the `metastore-logging-sa` service account you created [earlier](#before-you-begin).
      * `--subnet-ids`: ID of the subnet where you set up the NAT gateway.
      * `--security-group-ids`: ID of the security group you configured [earlier](#before-you-begin).
      * `--log-group-id`: `metastore-log-group` log group ID.
      * `--log-min-level`: Logging level. The execution log will contain logs of this level or higher. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default is `INFO`.

      [Learn more about creating a cluster](cluster-create.md).

    - REST API {#api}

        1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and save it as an environment variable:

            {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

        1. Create a file named `body.json` and paste the following code into it:

            ```json
            {
              "folderId": "<folder_ID>",
              "name": "metastore-cluster",
              "version": "<{{ metastore-name }}_version>",
              "configSpec": {
                "resources": {
                "resourcePresetId": "<resource_configuration_ID>"
                }
              },
              "serviceAccountId": "<service_account_ID>",
              "logging": {
                "enabled": true,
                "logGroupId": "<log_group_ID>",
                "minLevel": "<logging_level>"
              },
              "network": {
                "subnetIds": [ "<list_of_subnet_IDs>" ],
                "securityGroupIds": [ "<list_of_security_group_IDs>" ]
              },
            }
            ```

            Where:

            * `serviceAccountId`: ID of the `metastore-logging-sa` service account you created [earlier](#before-you-begin).
            * `logging.logGroupId`: `metastore-log-group` log group ID.
            * `logging.minLevel`: Logging level. The execution log will contain logs of this level or higher. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default is `INFO`.
            * `network.subnetIds`: ID of the subnet where you set up the NAT gateway.
            * `network.securityGroupIds`: ID of the security group you configured [earlier](#before-you-begin).

            [Learn more about creating a cluster](cluster-create.md).

        1. Use the [Cluster.Create](../../api-ref/Cluster/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request POST \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-metastore }}/managed-metastore/v1/clusters' \
                --data '@body.json'
            ```

        1. View the [server response](../../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

    - gRPC API {#grpc-api}

        1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and save it as an environment variable:

            {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

        1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

        1. Create a file named `body.json` and paste the following code into it:

            ```json
            {
              "folder_id": "<folder_ID>",
              "name": "metastore-cluster",
              "version": "<{{ metastore-name }}_version>",
              "config_spec": {
                "resources": {
                  "resource_preset_id": "<resource_configuration_ID>"
                }
              },
              "service_account_id": "<service_account_ID>",
              "logging": {
                "enabled": true,
                "log_group_id": "<log_group_ID>",
                "min_level": "<logging_level>"
              },
              "network": {
                "subnet_ids": [ "<list_of_subnet_IDs>" ],
                "security_group_ids": [ "<list_of_security_group_IDs>" ]
              },
            }
            ```

            Where:

            * `service_account_id`: ID of the `metastore-logging-sa` service account you created [earlier](#before-you-begin).
            * `logging.log_group_id`: `metastore-log-group` log group ID.
            * `logging.min_level`: Logging level. The execution log will contain logs of this level or higher. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default is `INFO`.
            * `network.subnet_ids`: ID of the subnet where you set up the NAT gateway.
            * `network.security_group_ids`: ID of the security group you configured [earlier](#before-you-begin).

            [Learn more about creating a cluster](cluster-create.md).

        1. Use the [ClusterService.Create](../../api-ref/grpc/Cluster/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d @ \
                {{ api-host-metastore }}:{{ port-https }} \
                yandex.cloud.metastore.v1.ClusterService.Create \
                < body.json
            ```

        1. View the [server response](../../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

   {% endlist %}

1. Test the transfer of cluster logs to the log group:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the management console, navigate to the relevant folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
      1. Click the row with the `metastore-log-group` log group.

      The page that opens will show the log group entries.

   - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      To view the entries in JSON format, run this command:

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

      To view log group entries, use the [LogReadingService.Read](../../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

   {% endlist %}

   For more information, see [{#T}](../../../logging/operations/read-logs.md).

{% include [metastore-trademark](../../../_includes/metadata-hub/metastore-trademark.md) %}
