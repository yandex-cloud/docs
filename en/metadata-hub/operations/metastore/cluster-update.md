---
title: How to update a {{ metastore-full-name }} cluster
description: Follow this guide to update a {{ metastore-full-name }} cluster.
---

# Updating a cluster {{ metastore-full-name }}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to update a cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. In the cluster row, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:
  
        1. Edit the cluster name and description.
        1. Delete or add new [{{ yandex-cloud }} labels](../../../resource-manager/concepts/labels.md).
        1. Select another [service account](../../../iam/concepts/users/service-accounts.md) or create a new one with the `{{ roles.metastore.integrationProvider }}` role.
        1. Switch your {{ metastore-name }} version.

            {% include [metastore-version](../../../_includes/metadata-hub/metastore-version-cluster-create.md) %}

  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select another [security group](configure-security-group.md) or create a new one.
  1. Under **{{ ui-key.yacloud.metastore.label_resource-preset }}**, update the [cluster configuration](../../concepts/metastore.md#presets).
  1. Under **{{ ui-key.yacloud.logging.label_title }}**, enable or disable logging. If logging is enabled, do the following:
      * Specify the log group or folder to write logs to.
      * Select the minimum logging level. 
      
      For more information, see [Transferring cluster logs](logging.md).
  1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, enable or disable cluster deletion protection.
  1. Click **{{ ui-key.yacloud.common.edit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To change a {{ metastore-name }} cluster’s settings:

  1. View the description of the CLI command for updating a cluster:
 
      ```bash
      {{ yc-metastore }} cluster update --help
      ```

  1. Provide a list of settings to update in the update cluster command:

      ```bash
      {{ yc-metastore }} cluster update <cluster_name_or_ID> \
         --new-name <cluster_name> \
         --description <cluster_description> \
         --labels <label_list> \
         --service-account-id <service_account_ID> \
         --version <Apache_Hive™_Metastore_version> \
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

      * `--new-name`: New cluster name.

      {% include [CLI cluster parameters description, part 1](../../../_includes/metadata-hub/metastore-cluster-parameters-cli-part-1.md) %}

      {% include [CLI cluster parameters description, part 2](../../../_includes/metadata-hub/metastore-cluster-parameters-cli-part-2.md) %}

      You can get the cluster name and ID from the [folder’s cluster list](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "updateMask": "<list_of_parameters_to_update>",
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
          "networkSpec": {
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

        * `updateMask`: List of parameters to update as a single string, separated by commas.

          {% note warning %}

          When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

          {% endnote %}

        {% include [REST cluster parameters description](../../../_includes/metadata-hub/metastore-cluster-parameters-rest.md) %}

        * `networkSpec`: Network settings:
          * `securityGroupIds`: List of [security group](../../../vpc/concepts/network.md#security-groups) IDs.

        * {% include [metastore-maintenance-window-rest](../../../_includes/metadata-hub/metastore-maintenance-window-rest.md) %}

    1. Use the [Cluster.Update](../../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-metastore }}/managed-metastore/v1/clusters/<cluster_ID>' \
            --data '@body.json'
        ```

        You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

    1. Check the [server response](../../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": "<list_of_parameters_to_update>",
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
          "network_spec": {
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

          * `cluster_id`: Cluster ID. You can get it with the [list of clusters in a folder](cluster-list.md#list-clusters).
          * `update_mask`: List of parameters to update as an array of `paths[]` strings.

              {% cut "Format for listing settings" %}

              ```yaml
              "update_mask": {
                  "paths": [
                      "<setting_1>",
                      "<setting_2>",
                      ...
                      "<setting_N>"
                  ]
              }
              ```

              {% endcut %}

              {% note warning %}

              When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

              {% endnote %}

          {% include [gRPC cluster parameters description](../../../_includes/metadata-hub/metastore-cluster-parameters-grpc.md) %}

          * `network_spec`: Network settings:
            * `security_group_ids`: List of [security group](../../../vpc/concepts/network.md#security-groups) IDs.

          * {% include [metastore-maintenance-window-grpc](../../../_includes/metadata-hub/metastore-maintenance-window-grpc.md) %}

    1. Use the [ClusterService.Update](../../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-metastore }}:{{ port-https }} \
            yandex.cloud.metastore.v1.ClusterService.Update \
            < body.json
        ```

    1. View the [server response](../../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [metastore-trademark](../../../_includes/metadata-hub/metastore-trademark.md) %}
