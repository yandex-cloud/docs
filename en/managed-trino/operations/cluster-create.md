---
title: Creating a {{ TR }} cluster
description: Every {{ mtr-name }} cluster consists of a set of {{ TR }} components, each of which can be represented in multiple instances. The instances may reside in different availability zones.
keywords:
  - creating an {{ TR }} cluster
  - '{{ TR }} cluster'
  - '{{ TR }}'
---

# Creating a {{ TR }} cluster

{% include [preview](../../_includes/managed-trino/note-preview.md) %}

Each {{ mtr-name }} cluster comprises a set of {{ TR }} components: coordinator and workers, which can be represented in multiple instances.

## Roles for creating a cluster {#roles}

To create a {{ mtr-name }} cluster, your {{ yandex-cloud }} account needs the following roles:

* [managed-trino.admin](../security.md#managed-trino-admin): To create a cluster.
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user): To use the cluster [network](../../vpc/concepts/network.md#network).
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user): To link a service account to the cluster.

Make sure to assign the `managed-trino.integrationProvider` and `storage.editor` roles to the cluster service account. The cluster will thus get the permissions it needs to work with user resources. For more information, see [Impersonation](../concepts/impersonation.md).

For more information about assigning roles, see the [{{ iam-full-name }}](../../iam/operations/roles/grant.md) documentation.

## Creating a cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the management console, select the folder where you want to create a {{ mtr-name }} cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Specify a name for the cluster. The name must be unique within the folder.
        1. (Optional) Enter a cluster description.
        1. Optionally, create [labels](../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.

        1. Select an existing [service account](../../iam/concepts/users/service-accounts.md) or [create a new one](../../iam/operations/sa/create.md).

            Make sure to assign the `managed-trino.integrationProvider` and `storage.editor` to the service account.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select a [network](../../vpc/operations/network-create.md), [subnet](../../vpc/operations/subnet-create.md), and [security group](../../vpc/concepts/security-groups.md) for the cluster.
    1. Configure the [coordinator](../concepts/index.md#coordinator) and [workers](../concepts/index.md#workers).
    1. Under **{{ ui-key.yacloud.trino.title_catalogs }}**, add the required [folders](../concepts/index.md#catalog). You can do this either when creating the cluster or later.

        1. Specify a name for the folder. The name must be unique within the cloud.
        1. Select **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}**.
        1. Under **Folder settings**, set the parameters depending on the selected type:

            * For Hive, Iceberg, and Delta Lake [connectors](../concepts/index.md#connector):

                * **URI** to connect to the Metastore cluster in this format: `thrift://<IP_address>:<port>`.
                * **File storage**: Select the file storage type): **Yandex Object Storage** or **External storage**. For external storage, specify the following settings:
                    * AWS-compatible static access key ID.
                    * AWS-compatible static access key secret key.
                    * File storage endpoint, such as `{{ s3-storage-host }}`.
                    * File storage region, such as `{{ region-id }}`.

            * For {{ PG }} and {{ CH }} connectors:

                * **URL** to connect to a cluster in this format: `jdbc:<DBMS>://<host_address>:<port>/<DB_name>`, where `DBMS` is `postgresql` or `clickhouse`.
                * **Username** to connect to the cluster.
                * User **Password**.

            * [TPC-H](https://trino.io/docs/current/connector/tpch.html) and [TPC-DS](https://trino.io/docs/current/connector/tpcds.html) connectors provide access to test data and do not require configuration.

        1. Optionally, specify additional folder settings in `key:value` format.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**:

        1. Optionally, enable cluster deletion protection.
        1. Optionally, configure logging:

            1. Enable the **{{ ui-key.yacloud.logging.field_logging }}** setting.
            1. Select where the logs will be stored:
                * **{{ ui-key.yacloud.common.folder }}**: Select a folder from the list.
                * **{{ ui-key.yacloud.logging.label_group }}**: Select a [log group](../../logging/concepts/log-group.md) from the list or create a new one.
            1. Select **{{ ui-key.yacloud.logging.label_minlevel }}** from the list.

    1. Click **{{ ui-key.yacloud.common.create }}**.

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and add the following contents to it:

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

    1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and add the following contents to it:

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

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}
