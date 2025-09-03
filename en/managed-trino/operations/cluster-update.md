---
title: Updating a {{ TR }} cluster
description: After creating a {{ TR }} cluster, you can edit its basic and advanced settings.
keywords:
  - Updating an {{ TR }} cluster
  - '{{ TR }} cluster'
  - '{{ TR }}'
---

# Updating a {{ TR }} cluster

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
    1. Under **Retry policy**, update the [fault-tolerant query execution](../concepts/retry-policy.md) parameters:
        * Change the **Retry object type**.
        * Add or delete additional parameters in `key:value` format in the **Retry parameters** field. For more information about parameters, see the [{{ TR }} documentation](https://trino.io/docs/current/admin/fault-tolerant-execution.html#advanced-configuration).
        * Add or delete additional Exchange Manager storage parameters in `key: value` format in the **Storage parameters** field. For more information about parameters, see the [{{ TR }} documentation](https://trino.io/docs/current/admin/fault-tolerant-execution.html#id1).
    1. Change the configuration of the [coordinator](../concepts/index.md#coordinator) and [workers](../concepts/index.md#workers).
    1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**:
        * Enable or disable cluster deletion protection.
        * Update the cluster [maintenance](../concepts/maintenance.md) time.
        * Enable or disable logging. If logging is enabled, select:

            * Log destination: custom [log group](../../logging/concepts/log-group.md) or default log group in the selected folder.
            * Minimum logging level.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    1. Provide a list of settings to update in the update cluster command:

        ```bash
        {{ yc-mdb-tr }} cluster update <cluster_name_or_ID> \
            --new-name <new_cluster_name> \
            --description <cluster_description> \
            --labels <label_list> \
            --service-account-id <service_account_ID> \
            --security-group-ids <security_group_IDs> \
            --retry-policy-enabled \ 
            --retry-policy <object_type_for_retry> \
            --retry-policy-additional-properties <list_of_additional_parameters> \
            --retry-policy-exchange-manager-service-s3 \
            --retry-policy-exchange-manager-additional-properties <list_of_additional_parameters> \
            --coordinator resource-preset-id=<host_class> \
            --worker min-count=<minimum_number_of_instances>,`
                    `max-count=<maximum_number_of_instances>,`
                    `resource-preset-id=<host_class> \
            --deletion-protection \
            --maintenance-window type=<maintenance_type>,`
                                `day=<day_of_week>,`
                                `hour=<hour> \
            --log-enabled \
            --log-folder-id <folder_ID> \
            --log-min-level <logging_level>
        ```

        Where:

        * `--new-name`: New cluster name. It must be unique within the folder.
        * `--description`: Cluster description.
        * `--labels`: List of labels. Provide labels in `<key>=<value>` format.
        * `--service-account-id`: Service account ID.
        * `--security-group-ids`: List of security group IDs.
        
        * [Fault-tolerant query execution](../concepts/retry-policy.md) parameters:

          * `--retry-policy-enabled`: Enables a retry policy.
          * `--retry-policy`: Query retry method. The possible values are:

              * `query`: Retries all [stages of the query](../concepts/index.md#query-execution) in which the worker failed.
              * `task`: Retries the intermediate task within the query that caused worker failure.

          * `--retry-policy-additional-properties`: Additional query retry parameters in `<key>=<value>` format. [Learn more about parameters in the {{ TR }} documentation]({{ tr.docs }}/admin/fault-tolerant-execution.html#advanced-configuration).
          * `--retry-policy-exchange-manager-service-s3`: Enables the use of an {{ objstorage-name }} service bucket as an Exchange Manager storage for intermediate data.
          * `--retry-policy-exchange-manager-additional-properties`: Additional Exchange Manager storage parameters in `<key>=<value>` format. [Learn more about parameters in the {{ TR }} documentation]({{ tr.docs }}/admin/fault-tolerant-execution.html#id1).

        * `--coordinator`, `--worker`: Configuration of {{ TR }} cluster [components](../concepts/index.md).

          * `resource-preset-id`: [Class](../concepts/instance-types.md) of coordinator and worker hosts.

          * `min-count`, `max-count`: Set the minimum and maximum range boundaries for the worker count to be automatically adjusted to load.
          * `count`: Set a fixed number of workers.

            You can specify either `min-count` and `max-count`, or `count`.

        * `--deletion-protection`: Enables cluster protection against accidental deletion. Even if it is enabled, one can still connect to the cluster manually and delete it.
        * `--maintenance-window`: Maintenance window settings (including for disabled clusters), where `type` is the maintenance type:

            {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

        * Logging parameters:

          * `--log-enabled`: Enables logging. Logs generated by {{ TR }} will be sent to {{ cloud-logging-full-name }}.
          * `--log-folder-id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
          * `--log-group-id`: Custom log group ID. Logs will be written to this group.

            You can specify only one of the parameters: `--log-folder-id` or `--log-group-id`.

          * `--log-min-level`: Minimum logging level. Possible values: `TRACE`, `DEBUG`, `INFO` (default), `WARN`, `ERROR`, and `FATAL`.

        You can request the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).   

- {{ TF }} {#tf}

    To change the cluster settings:

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [this guide](cluster-create.md).

        For a complete list of available {{ mtr-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mtr }}).

    1. To change cluster settings, change the required fields' values in the configuration file.

        {% note alert %}

        Do not change the cluster name using {{ TF }}. This will delete the existing cluster and create a new one.

        {% endnote %}

        {% include [Terraform cluster parameters description](../../_includes/managed-trino/terraform/cluster-parameters.md) %}

    1. To enable sending {{ TR }} logs to [{{ cloud-logging-full-name }}](../../logging/), add the `logging` section to the cluster description:

        {% include [Terraform logging parameters description](../../_includes/managed-trino/terraform/logging-parameters.md) %}

    1. To enable a [fault-tolerant query execution](../concepts/retry-policy.md) policy, add a `retry_policy` section to the cluster description:

        {% include [Terraform retry policy parameters description](../../_includes/managed-trino/terraform/retry-policy-parameters.md) %}

    1. To change the maintenance time (including for disabled clusters), provide the following settings in the `maintenance_window` section:

        {% include [Terraform maintenance window parameters description](../../_includes/managed-trino/terraform/maintenance-window-parameters.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    To change the cluster settings:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

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
                "resourcePresetId": "<host_class>"
              }
            },
            "workerConfig": {
              "resources": {
                "resourcePresetId": "<host_class>"
              },
              "scalePolicy": {
                "autoScale": {
                  "minCount": "<minimum_number_of_instances>",
                  "maxCount": "<maximum_number_of_instances>"
                }
              }
            }
          },
          "retryPolicy": {
            "policy": "<object_type_for_retry>",
            "exchangeManager": {
              "storage": {
                "serviceS3": {}
              },
              "additionalProperties": {<additional_storage_parameters>}
            },
            "additionalProperties": {<additional_retry_parameters>}
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

               * `resources.resourcePresetId`: [Class](../concepts/instance-types.md) of coordinator hosts.
              
            * `workerConfig`: Worker configuration.

               * `resources.resourcePresetId`: [Class](../concepts/instance-types.md) of worker hosts.

               * `scalePolicy`: Worker scaling policy:

                    * `fixedScale`: Fixed scaling policy.

                       * `count`: Number of workers.

                    * `autoScale`: Autoscaling policy.

                       * `minCount`: Minimum number of workers.
                       * `maxCount`: Maximum number of workers.

                    Specify one of the two parameters: `fixedScale` or `autoScale`. 

            * `retryPolicy`: [Fault-tolerant query execution](../concepts/retry-policy.md) parameters.

               * `policy`: Query retry method. The possible values are:

                  * `TASK`: Retries the intermediate task within the query that caused worker failure.
                  * `QUERY`: Retries all [stages of the query](../concepts/index.md#query-execution) where worker failure occurred.

               * `exchangeManager.additionalProperties`: Additional Exchange Manager storage parameters in `key: value` format. For more information about parameters, see the [{{ TR }} documentation](https://trino.io/docs/current/admin/fault-tolerant-execution.html#id1).

               * `additionalProperties`: Additional parameters in `key: value` format. For more information about parameters, see the [{{ TR }} documentation](https://trino.io/docs/current/admin/fault-tolerant-execution.html#advanced-configuration).

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

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    To change the cluster settings:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

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
                "resource_preset_id": "<host_class>"
              }
            },
            "worker_config": {
              "resources": {
                "resource_preset_id": "<host_class>"
              },
              "scale_policy": {
                "auto_scale": {
                  "min_count": "<minimum_number_of_instances>",
                  "max_count": "<maximum_number_of_instances>"
                }
              }
            },
            "retry_policy": {
              "policy": "<object_type_for_retry>",
              "exchange_manager": {
                "storage": {
                  "service_s3": ""
                },
                "additional_properties": {<additional_storage_parameters>}
              },
              "additional_properties": {<additional_retry_parameters>}
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

               * `resources.resource_preset_id`: [Class](../concepts/instance-types.md) of coordinator hosts.
              
            * `worker_config`: Worker configuration.

               * `resources.resource_preset_id`: [Class](../concepts/instance-types.md) of worker hosts.

               * `scale_policy`: Worker scaling policy:

                    * `fixed_scale`: Fixed scaling policy.

                       * `count`: Number of workers.

                    * `auto_scale`: Autoscaling policy.

                       * `min_count`: Minimum number of workers.
                       * `max_count`: Maximum number of workers.

                    Specify one of the two parameters: `fixed_scale` or `auto_scale`. 

            * `retry_policy`: [Fault-tolerant query execution](../concepts/retry-policy.md) parameters.

               * `policy`: Query retry method. The possible values are:

                  * `TASK`: Retries the intermediate task within the query that caused worker failure.
                  * `QUERY`: Retries all [stages of the query](../concepts/index.md#query-execution) where worker failure occurred.

               * `exchange_manager.additional_properties`: Additional Exchange Manager storage parameters in `key: value` format. For more information about parameters, see the [{{ TR }} documentation](https://trino.io/docs/current/admin/fault-tolerant-execution.html#id1).

               * `additional_properties`: Additional parameters in `key: value` format. For more information about parameters, see the [{{ TR }} documentation](https://trino.io/docs/current/admin/fault-tolerant-execution.html#advanced-configuration).

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

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
