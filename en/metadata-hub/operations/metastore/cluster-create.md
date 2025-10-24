---
title: How to create a {{ metastore-full-name }} cluster
description: Follow this guide to create a {{ metastore-full-name }} cluster.
---

# Creating a {{ metastore-full-name }} cluster

To learn more about {{ metastore-name }} clusters in {{ metadata-hub-name }}, see [{#T}](../../concepts/metastore.md).

## Getting started {#before-you-begin}

1. To link a [service account](../../../iam/concepts/users/service-accounts.md) to a {{ metastore-name }} cluster, [make sure](../../../iam/operations/roles/get-assigned-roles.md) your {{ yandex-cloud }} account has the [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) role or higher.
1. [Set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) in the subnet the cluster will connect to. It is needed for the cluster to interact with {{ yandex-cloud }} services.
1. [Configure the security group](configure-security-group.md).
1. [Create a service account](../../../iam/operations/sa/create.md).
1. [Assign the `{{ roles.metastore.integrationProvider }}` role](../../../iam/operations/sa/assign-role-for-sa.md) to the service account. This role enables the cluster [to work with {{ yandex-cloud }} services](../../concepts/metastore-impersonation.md), e.g., {{ cloud-logging-full-name }} and {{ monitoring-full-name }}, under a service account.

    You can also add more roles. Their combination depends on your specific use case. To view the service roles, see the [{{ metastore-name }} section](../../security/metastore-roles.md), and for all available roles, see this [reference](../../../iam/roles-reference.md).

1. If you want to save cluster logs to a custom log group, [create one](../../../logging/operations/create-group.md).

    For more information, see [Transferring cluster logs](logging.md).

## Create a cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a server.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Enter a name for the cluster. It must be unique within the folder.
    1. Optionally, enter a description for the cluster.
    1. Optionally, add [{{ yandex-cloud }} labels](../../../resource-manager/concepts/labels.md) to break resources into logical groups.
    1. Specify the service account you created earlier.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network and subnet to host the {{ metastore-name }} cluster. Specify the security group you configured previously.
    1. Under **{{ ui-key.yacloud.metastore.label_resource-preset }}**, select the [cluster configuration](../../concepts/metastore.md#presets).
    1. Optionally, configure logging settings:

        1. Enable **{{ ui-key.yacloud.logging.field_logging }}**.
        1. Select where to write cluster logs to:

            * Default log group: Select **{{ ui-key.yacloud.common.folder }}** in the **{{ ui-key.yacloud.logging.label_destination }}** field and specify the folder. Logs will be stored in the selected folder's default log group.
            * Custom log group: Select **{{ ui-key.yacloud.logging.label_loggroup }}** in the **{{ ui-key.yacloud.logging.label_destination }}** field and specify the log group you created earlier.

        1. Select the minimum logging level.

            The execution log will contain logs of this level or higher. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default is `INFO`.
    1. If required, enable protection of the cluster from accidental deletion by a user.

        {% include [Cluster deletion protection limits](../../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To create a {{ metastore-name }} cluster:

  1. See the description of the CLI command for creating a cluster:
 
      ```bash
      {{ yc-metastore }} cluster create --help
      ```

  1. Specify the cluster properties in the creation command:

      ```bash
      {{ yc-metastore }} cluster create \
         --name <cluster_name> \
         --description <cluster_description> \
         --labels <label_list> \
         --service-account-id <service_account_ID> \
         --version <Apache_Hive™_Metastore_version> \
         --subnet-ids <subnet_IDs> \
         --security-group-ids <security_group_IDs> \
         --resource-preset-id <ID_of_computing_resources> \
         --maintenance-window type=<maintenance_type>,`
                              `day=<day_of_week>,`
                              `hour=<hour> \
         --deletion-protection \
         --log-enabled \
         --log-folder-id <folder_ID> \
         --log-min-level <logging_level>
      ```

      Where:

      * `--name`: Cluster name.

      {% include [CLI cluster parameters description, part 1](../../../_includes/metadata-hub/metastore-cluster-parameters-cli-part-1.md) %}

      * `--subnet-ids`: List of subnet IDs.

      {% include [CLI cluster parameters description, part 2](../../../_includes/metadata-hub/metastore-cluster-parameters-cli-part-2.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "folderId": "<folder_ID>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { "<label_list>" },
          "deletionProtection": <deletion_protection>,
          "version": "<Apache_Hive™_Metastore_version>",
          "configSpec": {
            "resources": {
            "resourcePresetId": "<resource_configuration_ID>"
            }
          },
          "serviceAccountId": "<service_account_ID>",
          "logging": {
            "enabled": <use_of_logging>,
            "folderId": "<folder_ID>",
            "minLevel": "<logging_level>"
          },
          "network": {
            "subnetIds": [ "<list_of_subnet_IDs>" ],
            "securityGroupIds": [ "<list_of_security_group_IDs>" ]
          },
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
            "day": "<day_of_week>",
            "hour": "<hour>"
            }
          }
        }
        ```
        Where:

        * `folderId`: Folder ID. You can get it with the [list of folders in the cloud](../../../resource-manager/operations/folder/get-id.md).

        {% include [REST cluster parameters description](../../../_includes/metadata-hub/metastore-cluster-parameters-rest.md) %}

        * `network`: Network settings:
          * `subnetIds`: List of subnet IDs.
          * `securityGroupIds`: List of [security group](../../../vpc/concepts/network.md#security-groups) IDs.

        * {% include [metastore-maintenance-window-rest](../../../_includes/metadata-hub/metastore-maintenance-window-rest.md) %}

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

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "folder_id": "<folder_ID>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": "{ <label_list> }",
          "deletion_protection": <deletion_protection>,
          "version": "<Apache_Hive™_Metastore_version>",
          "config_spec": {
            "resources": {
              "resource_preset_id": "<resource_configuration_ID>"
            }
          },
          "service_account_id": "<service_account_ID>",
          "logging": {
            "enabled": <use_of_logging>,
            "folder_id": "<folder_ID>",
            "min_level": "<logging_level>"
          },
          "network": {
            "subnet_ids": [ "<list_of_subnet_IDs>" ],
            "security_group_ids": [ "<list_of_security_group_IDs>" ]
          },
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          }
        }
        ```

        Where:

        * `folder_id`: Folder ID. You can get it with the [list of folders in the cloud](../../../resource-manager/operations/folder/get-id.md).

        {% include [gRPC cluster parameters description](../../../_includes/metadata-hub/metastore-cluster-parameters-grpc.md) %}

        * `network`: Network settings:
            * `subnet_ids`: List of subnet IDs.
            * `security_group_ids`: List of [security group](../../../vpc/concepts/network.md#security-groups) IDs.

        * {% include [metastore-maintenance-window-grpc](../../../_includes/metadata-hub/metastore-maintenance-window-grpc.md) %}

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

{% include [metastore-trademark](../../../_includes/metadata-hub/metastore-trademark.md) %}
