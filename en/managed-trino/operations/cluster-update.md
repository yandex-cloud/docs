---
title: Updating an {{ TR }} cluster
description: After creating a {{ TR }} cluster, you can edit its basic and advanced settings.
keywords:
  - Updating an {{ TR }} cluster
  - '{{ TR }} cluster'
  - '{{ TR }}'
---

# Updating an {{ TR }} cluster

{% include [preview](../../_includes/managed-trino/note-preview.md) %}

After creating a cluster, you can edit its basic and advanced settings.

{% list tabs group=instructions %}

- Management console {#console}

    To change the cluster settings:

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * Edit the cluster name and description.
        * Delete or add new [labels](../../resource-manager/concepts/labels.md).
        * Select a service account or [create a new one](../../iam/operations/sa/create.md#create-sa) with the `managed-trino.integrationProvider` and `storage.editor` roles. The cluster will thus get the permissions it needs to work with user resources. For more information, see [Impersonation](../concepts/impersonation.md).

            To change your service account in a {{ mtr-name }} cluster, [make sure](../../iam/operations/roles/get-assigned-roles.md) your {{ yandex-cloud }} account has the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher.

            {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the cluster security group.
    1. Change the configuration of the [coordinator](../concepts/index.md#coordinator) and [workers](../concepts/index.md#workers).
    1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, enable or disable cluster deletion protection.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, enable or disable logging. If logging is enabled, specify the log group or folder to write logs to and the minimum logging level.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- REST API {#api}

    To change the cluster settings:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and add the following contents to it:

       {% note info %}

       This example does not use all available parameters. For a list of all parameters, see the [API documentation](../api-ref/Cluster/update.md#yandex.cloud.trino.v1.UpdateClusterRequest).

       {% endnote %}

        ```json
        {
          "updateMask": "<list_of_parameters_to_update>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "trino": {
            "coordinatorConfig": {
              "resources": {
                "resourcePresetId": "<resource_ID>"
              }
            },
            "workerConfig": {
              "resources": {
                "resourcePresetId": "<resource_ID>"
              },
              "scalePolicy": {
                "autoScale": {
                  "minCount": "<minimum_number_of_instances>",
                  "maxCount": "<maximum_number_of_instances>"
                }
              }
            }
          },
          "networkSpec": {
            "securityGroupIds": [ <list_of_security_group_IDs> ]
          },
          "deletionProtection": "<deletion_protection>",
          "serviceAccountId": "<service_account_ID>",
          "logging": {
            "enabled": "<use of_logging>",
            "folderId": "<folder_ID>",
            "minLevel": "<logging_level>"
          }
        }
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            {% note warning %}

            When you update a cluster, all parameters of the object you are changing that were not explicitly provided in the request will be overriden by their defaults. To avoid this, list the settings you want to change in the `updateMask` parameter.

            {% endnote %}

        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels. Provide labels in `"<key>": "<value>"` format.
        * `trino`: Configuration of {{ TR }} cluster [components](../concepts/index.md#cluster-architecture).

            * `coordinatorConfig`: Coordinator configuration.

               * `resources.resourcePresetId`: ID of the coordinator’s computing resources. The possible values are:

                    * `c4-m16`: 4 vCPUs, 16 GB RAM
                    * `c8-m32`: 8 vCPUs, 32 GB RAM
              
            * `workerConfig`: Worker configuration.

               * `resources.resourcePresetId`: ID of the worker’s computing resources. The possible values are:

                    * `c4-m16`: 4 vCPUs, 16 GB RAM
                    * `c8-m32`: 8 vCPUs, 32 GB RAM
              
               * `scalePolicy`: Worker scaling policy:

                    * `fixedScale`: Fixed scaling policy.

                       * `count`: Number of workers.

                    * `fixed_scale`: Automatic scaling policy.

                       * `minCount`: Minimum number of workers.
                       * `maxCount`: Maximum number of workers.

                    Specify one of the two parameters: `fixedScale` or `autoScale`. 

        * `networkSpec`: Network settings:

            * `securityGroupIds`: List of security group IDs.

        * `deletionProtection`: Enables cluster protection against accidental deletion. The possible values are `true` or `false`.

            Even if it is enabled, one can still connect to the cluster manually and delete it.

        * `serviceAccountId`: Service account ID.
        * `logging`: Logging parameters:

            * `enabled`: Enables logging. Logs generated by {{ TR }} components will be sent to {{ cloud-logging-full-name }}. The possible values are `true` or `false`.
            * `minLevel`: Minimum logging level. Possible values: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`.
            * `folderId`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
            * `logGroupId`: Custom log group ID. Logs will be written to this group.

            Specify one of the two parameters: `folderId` or `logGroupId`.

    1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>'
            --data '@body.json'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    To change the cluster settings:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and add the following contents to it:

       {% note info %}

       This example does not use all available parameters. For a list of all parameters, see the [API documentation](../api-ref/grpc/Cluster/update.md#yandex.cloud.trino.v1.UpdateClusterRequest).

       {% endnote %}

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": "<list_of_parameters_to_update>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "trino": {
            "coordinator_config": {
              "resources": {
                "resource_preset_id": "<resource_ID>"
              }
            },
            "worker_config": {
              "resources": {
                "resource_preset_id": "<resource_ID>"
              },
              "scale_policy": {
                "auto_scale": {
                  "min_count": "<minimum_number_of_instances>",
                  "max_count": "<maximum_number_of_instances>"
                }
              }
            }
          },
          "network_spec": {
            "security_group_ids": [ <list_of_security_group_IDs> ]
          },
          "deletion_protection": "<deletion_protection>",
          "service_account_id": "<service_account_ID>",
          "logging": {
            "enabled": "<use of_logging>",
            "folder_id": "<folder_ID>",
            "min_level": "<logging_level>"
          }
        }
        ```

        Where:

        * `cluster_id`: Cluster ID. You can request it with the [list of clusters in a folder](cluster-list.md#list-clusters).
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

            When you update a cluster, all parameters of the object you are changing that were not explicitly provided in the request will be overriden by their defaults. To avoid this, list the settings you want to change in the `update_mask` parameter.

            {% endnote %}

        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels. Provide labels in `"<key>": "<value>"` format.
        * `trino`: Configuration of {{ TR }} cluster [components](../concepts/index.md#cluster-architecture).

            * `coordinator_config`: Coordinator configuration.

               * `resources.resource_preset_id`: ID of the coordinator’s computing resources. The possible values are:

                    * `c4-m16`: 4 vCPUs, 16 GB RAM
                    * `c8-m32`: 8 vCPUs, 32 GB RAM
              
            * `worker_config`: Worker configuration.

               * `resources.resource_preset_id`: ID of the worker’s computing resources. The possible values are:

                    * `c4-m16`: 4 vCPUs, 16 GB RAM
                    * `c8-m32`: 8 vCPUs, 32 GB RAM
              
               * `scale_policy`: Worker scaling policy:

                    * `fixed_scale`: Fixed scaling policy.

                       * `count`: Number of workers.

                    * `fixed_scale`: Automatic scaling policy.

                       * `min_count`: Minimum number of workers.
                       * `max_count`: Maximum number of workers.

                    Specify one of the two parameters: `fixed_scale` or `auto_scale`. 

        * `network_spec`: Network settings:

            * `security_group_ids`: List of security group IDs.

        * `deletion_protection`: Enables cluster protection against accidental deletion. The possible values are `true` or `false`.

            Even if it is enabled, one can still connect to the cluster manually and delete it.

        * `service_account_id`: Service account ID.
        * `logging`: Logging parameters:

            * `enabled`: Enables logging. Logs generated by {{ TR }} components will be sent to {{ cloud-logging-full-name }}. The possible values are `true` or `false`.
            * `min_level`: Minimum logging level. Possible values: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`.
            * `folder_id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
            * `log_group_id`: Custom log group ID. Logs will be written to this group.

            Specify either `folder_id` or `log_group_id`.

    1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.ClusterService.Update \
            < body.json
        ```

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}
