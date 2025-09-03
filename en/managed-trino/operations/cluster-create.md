---
title: Creating a {{ TR }} cluster
description: Every {{ mtr-name }} cluster consists of a set of {{ TR }} components, each of which can be represented in multiple instances. The instances may reside in different availability zones.
keywords:
  - creating an {{ TR }} cluster
  - '{{ TR }} cluster'
  - '{{ TR }}'
---

# Creating a {{ TR }} cluster

Each {{ mtr-name }} cluster consists of a set of {{ TR }} components: a [coordinator](../concepts/index.md#coordinator) and workers – potentially several instances of these.

## Roles for creating a cluster {#roles}

To create a {{ mtr-name }} cluster, your {{ yandex-cloud }} account needs the following roles:

* [managed-trino.admin](../security.md#managed-trino-admin): To create a cluster.
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user): Required to access the cluster [network](../../vpc/concepts/network.md#network).
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user): To link a service account to the cluster.

Make sure to assign the `managed-trino.integrationProvider` and `storage.editor` roles to the cluster's [service account](../../iam/concepts/users/service-accounts.md). The cluster will thus get the permissions it needs to work with user resources. For more information, see [Impersonation](../concepts/impersonation.md).

For more information about assigning roles, see the [{{ iam-full-name }} documentation](../../iam/operations/roles/grant.md).

## Creating a cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ mtr-name }} cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Give the cluster a name. The name must be unique within the folder.
        1. Optionally, enter a description for the cluster.
        1. Optionally, create [labels](../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.

        1. Select an existing [service account](../../iam/concepts/users/service-accounts.md) or [create a new one](../../iam/operations/sa/create.md).

            Make sure to assign the `managed-trino.integrationProvider` and `storage.editor` to the service account.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select a [network](../../vpc/operations/network-create.md), [subnet](../../vpc/operations/subnet-create.md), and [security group](../../vpc/concepts/security-groups.md) for the cluster.
    1. Under **Retry policy**, specify the [fault-tolerant query execution](../concepts/retry-policy.md) parameters:
        1. Select an **Object type for retry**.
           * **Task**: Retries the intermediate task within the query that caused worker failure.
           * **Query**: Retries all [stages of the query](../concepts/index.md#query-execution) where worker failure occurred.
        1. Optionally, specify additional parameters in `key: value` format in the **Retry parameters** field. For more information about parameters, see the [{{ TR }} documentation](https://trino.io/docs/current/admin/fault-tolerant-execution.html#advanced-configuration).
        1. Optionally, specify additional Exchange Manager storage parameters in `key: value` format in the **Storage parameters** field. For more information about parameters, see the [{{ TR }} documentation](https://trino.io/docs/current/admin/fault-tolerant-execution.html#id1).

    1. Configure the [coordinator](../concepts/index.md#coordinator) and [workers](../concepts/index.md#workers).
    1. Under **{{ ui-key.yacloud.trino.title_catalogs }}**, add the required [{{ TR }} catalogs](../concepts/index.md#catalog). You can do this either when creating the cluster or later. For more information, see [Creating a {{ TR }} catalog](catalog-create.md).
    1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**:

        1. Optionally, enable cluster deletion protection.
        1. Optionally, select cluster [maintenance](../concepts/maintenance.md) time:

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        1. Optionally, configure logging:

            1. Enable the **{{ ui-key.yacloud.logging.field_logging }}** setting.
            1. Select the log destination:
                * **{{ ui-key.yacloud.common.folder }}**: Select a folder from the list. Logs will be written to the default log group for the selected folder.
                * **{{ ui-key.yacloud.logging.label_group }}**: Select a [log group](../../logging/concepts/log-group.md) from the list or create a new one.
            1. Select **{{ ui-key.yacloud.logging.label_minlevel }}** from the list.

    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a {{ mtr-name }} cluster:

    
    1. Check whether the folder has any subnets for the cluster hosts:

        ```bash
        yc vpc subnet list
        ```

        If your folder has no subnets, [create the required ones](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.


    1. See the description of the CLI command for creating a cluster:

        ```bash
        {{ yc-mdb-tr }} cluster create --help
        ```

    1. Specify cluster parameters in that command (our example does not use all available parameters):

        ```bash
        {{ yc-mdb-tr }} cluster create \
           --name <cluster_name> \
           --service-account-id <service_account_ID> \
           --subnet-ids <list_of_subnet_IDs> \
           --security-group-ids <list_of_security_group_IDs> \
           --coordinator resource-preset-id=<class_of_computing_resources> \
           --worker resource-preset-id=<class_of_computing_resources>,count=<number_of_workers> \
           --deletion-protection
        ```

        Where:

        * `--name`: Cluster name. It must be unique within the folder.
        * `--service-account-id`: Service account ID.
        * `--subnet-ids`: Subnet IDs list.
        * `--security-group-ids`: List of security group IDs.
        * `--coordinator`: [Coordinator](../concepts/index.md#coordinator) configuration.

            * `resource-preset-id`: [Class of the coordinator's computing resources](../concepts/instance-types.md).

        * `--worker`: [Worker](../concepts/index.md#workers) configuration:

            * `resource-preset-id`: [Class of the worker's computing resources](../concepts/instance-types.md).
            * `count`: Fixed number of workers.
            * `min_count`: Minimum number of workers for automatic scaling.
            * `maxCount`: Maximum number of workers for automatic scaling.

            Specify either a fixed number of workers (`count`), or minimum and maximum number of workers (`minCount`, `maxCount`) for automatic scaling.

        * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

            Even if it is enabled, one can still connect to the cluster manually and delete it.

    1. To enable sending of {{ TR }} logs to [{{ cloud-logging-full-name }}](../../logging/), specify logging parameters:

        ```bash
        {{ yc-mdb-tr }} cluster create <cluster_name> \
           ...
           --log-enabled \
           --log-folder-id <folder_ID> \
           --log-min-level <logging_level>
        ```

        Where:

        * `--log-enabled`: Enables logging.
        * `--log-folder-id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
        * `--log-group-id`: Custom log group ID. Logs will be written to this group.

            You can specify only one of the parameters: `--log-folder-id` or `--log-group-id`.

        * `--log-min-level`: Minimum logging level. Possible values: `TRACE`, `DEBUG`, `INFO` (default), `WARN`, `ERROR`, and `FATAL`.

    1. To enable a [fault-tolerant query execution](../concepts/retry-policy.md) policy, specify these parameters:

        ```bash
        {{ yc-mdb-tr }} cluster create <cluster_name> \
           ...
           --retry-policy-enabled \
           --retry-policy \
           --retry-policy-additional-properties <list_of_additional_retry_policy_parameters> \
           --retry-policy-exchange-manager-service-s3 \
           --retry-policy-exchange-manager-additional-properties <list_of_additional_storage_parameters>
        ```

        Where:

        * `--retry-policy-enabled`: Enables the retry policy.
        * `--retry-policy`: Query retry method. The possible values are:

            * `task`: Retries the intermediate task within the query that caused worker failure.
            * `query`: Retries all [stages of the query](../concepts/index.md#query-execution) in which the worker failed.

        * `--retry-policy-additional-properties`: Additional query retry parameters in `<key>=<value>` format. For more information about parameters, see the [{{ TR }} documentation]({{ tr.docs}}/admin/fault-tolerant-execution.html#advanced-configuration).
        * `--retry-policy-exchange-manager-service-s3`: Use an S3 storage to write data when retrying queries.
        * `--retry-policy-exchange-manager-additional-properties`: Additional storage parameters in `<key>=<value>` format. For more information about parameters, see the [{{ TR }} documentation]({{ tr.docs}}/admin/fault-tolerant-execution.html#id1).

    1. To set up a maintenance window (including for disabled clusters), provide the required value in the `--maintenance-window` parameter:

        ```bash
        {{ yc-mdb-tr }} cluster create <cluster_name> \
           ...
           --maintenance-window type=<maintenance_type>,`
                               `day=<day_of_week>,`
                               `hour=<hour> \
        ```

        Where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    To create a {{ mtr-name }} cluster:

    1. In the configuration file, describe the resources you are creating:

        * {{ mtr-name }} cluster: Cluster description.

        * {{ mtr-name }} catalog: Catalog description.

        * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

        * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

        {% include [Terraform cluster parameters description](../../_includes/managed-trino/terraform/cluster-parameters.md) %}

    1. To create [{{ TR }} catalogs](../concepts/index.md#catalog) in the cluster, add the required number of `yandex_trino_catalog` resources to the configuration file. You can do this either when creating the cluster or later. For more information, see [Creating a {{ TR }} catalog](catalog-create.md).

    1. To enable sending {{ TR }} logs to [{{ cloud-logging-full-name }}](../../logging/), add the `logging` section to the cluster description:

        {% include [Terraform logging parameters description](../../_includes/managed-trino/terraform/logging-parameters.md) %}

    1. To enable a [fault-tolerant query execution](../concepts/retry-policy.md) policy, add a `retry_policy` section to the cluster description:

        {% include [Terraform retry policy parameters description](../../_includes/managed-trino/terraform/retry-policy-parameters.md) %}

    1. To set up the maintenance window (for disabled clusters as well), add the `maintenance_window` section to the cluster description:

        {% include [Terraform maintenance window parameters description](../../_includes/managed-trino/terraform/maintenance-window-parameters.md) %}

    For more information about the resources you can create with {{ TF }}, see [this provider article]({{ tf-provider-mtr }}).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

       {% note info %}

       This example does not use all available parameters. For a list of all parameters, see the [API documentation](../api-ref/Cluster/create.md#yandex.cloud.trino.v1.CreateClusterRequest).

       {% endnote %}

        ```json
        {
          "folderId": "<folder_ID>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "trino": {
            "coordinatorConfig": {
              "resources": {
                "resourcePresetId": "<class_of_computing_resources>"
              }
            },
            "workerConfig": {
              "resources": {
                "resourcePresetId": "<class_of_computing_resources>"
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
          "network": {
            "subnetIds": [ <list_of_subnet_IDs> ],
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

        * `folderId`: Folder ID. You can request it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels. Provide labels in `"<key>": "<value>"` format.
        * `trino`: Configuration of {{ TR }} cluster [components](../concepts/index.md#cluster-architecture).

            * `coordinatorConfig`: Coordinator configuration.

               * `resources.resourcePresetId`: [Class of the coordinator's computing resources](../concepts/instance-types.md).

            * `workerConfig`: Worker configuration.

               * `resources.resourcePresetId`: [Class of the worker's computing resources](../concepts/instance-types.md).

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

        * `network`: Network settings:

            * `subnetIds`: Subnet IDs list.
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

    1. Use the [Cluster.create](../api-ref/Cluster/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters'
            --data '@body.json'
        ```

    1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

       {% note info %}

       This example does not use all available parameters. For a list of all parameters, see the [API documentation](../api-ref/grpc/Cluster/create.md#yandex.cloud.trino.v1.CreateClusterRequest).

       {% endnote %}

        ```json
        {
          "folder_id": "<folder_ID>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "trino": {
            "coordinator_config": {
              "resources": {
                "resource_preset_id": "<class_of_computing_resources>"
              }
            },
            "worker_config": {
              "resources": {
                "resource_preset_id": "<class_of_computing_resources>"
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
          "network": {
            "subnet_ids": [ <list_of_subnet_IDs> ],
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

        * `folder_id`: Folder ID. You can request it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels. Provide labels in `"<key>": "<value>"` format.
        * `trino`: Configuration of {{ TR }} cluster [components](../concepts/index.md#cluster-architecture).

            * `coordinator_config`: Coordinator configuration.

               * `resources.resource_preset_id`: [Class of the coordinator's computing resources](../concepts/instance-types.md).

            * `worker_config`: Worker configuration.

               * `resources.resource_preset_id`: [Class of the worker's computing resources](../concepts/instance-types.md).

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

        * `network`: Network settings:

            * `subnet_ids`: Subnet IDs list.
            * `security_group_ids`: List of security group IDs.

        * `deletion_protection`: Enables cluster protection against accidental deletion. The possible values are `true` or `false`.

            Even if it is enabled, one can still connect to the cluster manually and delete it.

        * `service_account_id`: Service account ID.
        * `logging`: Logging parameters:

            * `enabled`: Enables logging. Logs generated by {{ TR }} components will be sent to {{ cloud-logging-full-name }}. The possible values are `true` or `false`.
            * `min_level`: Minimum logging level. Possible values: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`.
            * `folder_id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
            * `log_group_id`: Custom log group ID. Logs will be written to this group.

            Specify one of the two parameters: `folder_id` or `log_group_id`.

    1. Use the [ClusterService/Create](../api-ref/grpc/Cluster/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.ClusterService.Create \
            < body.json
        ```

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Examples {#examples}

{% list tabs group=instructions %}

- CLI {#cli}

    Create a {{ mtr-name }} cluster with the following test specifications:

    * Name: `mytr`.
    * Service account: `ajev56jp96ji********`.
    * Subnet: `{{ subnet-id }}`.
    * Security group: `{{ security-group }}`.
    * Coordinator with [computing resource class](../concepts/instance-types.md) `c4-m16`.
    * Four workers with [computing resource class](../concepts/instance-types.md) `c4-m16`.
    * Cluster protection from accidental deletion.

    Run this command:

    ```bash
    {{ yc-mdb-tr }} cluster create \
       --name mytr \
       --service-account-id ajev56jp96ji******** \
       --subnet-ids {{ subnet-id }} \
       --security-group-ids {{ security-group }} \
       --coordinator resource-preset-id=c4-m16 \
       --worker resource-preset-id=c4-m16,count=4 \
       --deletion-protection
    ```

- {{ TF }} {#tf}

    Create a {{ mtr-name }} cluster and a network for it with the following test specifications:

    * Name: `mytr`.
    * Service account: `ajev56jp96ji********`.
    * Network: `mtr-network`.
    * Subnet: `mtr-subnet`. The subnet availability zone is `ru-central1-a`; the range is `10.1.0.0/16`.
    * Coordinator with [computing resource class](../concepts/instance-types.md) `c4-m16`.
    * Four workers with [computing resource class](../concepts/instance-types.md) `c4-m16`.
    * Cluster protection from accidental deletion.

    The configuration file for this cluster is as follows:

    ```hcl
    resource "yandex_trino_cluster" "mytr" {
      name                = "mytr"
      service_account_id  = "ajev56jp96ji********"
      deletion_protection = true
      subnet_ids          = [yandex_vpc_subnet.mtr-subnet.id]

      coordinator = {
        resource_preset_id = "c4-m16"
      }

      worker = {
        fixed_scale = {
          count = 4
        }
        resource_preset_id = "c4-m16"
      }
    }

    resource "yandex_vpc_network" "mtr-network" {
      name = "mtr-network"
    }

    resource "yandex_vpc_subnet" "mtr-subnet" {
      name           = "mtr-subnet"
      zone           = "ru-central1-a"
      network_id     = yandex_vpc_network.mtr-network.id
      v4_cidr_blocks = ["10.1.0.0/16"]
    }
    ```

{% endlist %}
