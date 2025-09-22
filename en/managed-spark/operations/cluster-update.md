---
title: Updating an {{ SPRK }} cluster
description: After creating a {{ SPRK }} cluster, you can edit its basic and advanced settings.
keywords:
  - Updating an {{ SPRK }} cluster
  - '{{ SPRK }} cluster'
  - '{{ SPRK }}'
---

# Updating an {{ SPRK }} cluster

After creating a cluster, you can edit its basic and advanced settings.

{% list tabs group=instructions %}

- Management console {#console}

    To change the cluster settings:

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.

    1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:
       * Edit the cluster name and description.
       * Delete or add new [labels](../../resource-manager/concepts/labels.md).
       * Select a service account or [create a new one](../../iam/operations/sa/create.md#create-sa) with the `managed-spark.integrationProvider` role. The cluster will thus get the permissions it needs to work with other resources.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select a [security group](../../vpc/concepts/security-groups.md) for cluster network traffic.

    1. Under **{{ ui-key.yacloud.spark.section_driver }}** and **{{ ui-key.yacloud.spark.section_executor }}**, specify the number of instances and [computing resource configuration](../concepts/instance-types.md). The number of instances can be either fixed or autoscalable.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**:

        1. Delete or add names of pip and deb packages.

           The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.
        1. In the **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** setting, update the cluster maintenance time:

           {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        1. Select a [{{ metastore-name }} cluster](../../metadata-hub/concepts/metastore.md) to connect as a metadata storage.
        1. Enable or disable cluster deletion protection.
        1. Enable or disable **{{ ui-key.yacloud.spark.label_history-server }}**. This option allows using the service to monitor [Spark History Server](https://spark.apache.org/docs/latest/monitoring.html) applications.
        1. Enable or disable **{{ ui-key.yacloud.logging.field_logging }}**. This option enables logging of Spark applications in the cluster:
            1. Select the log destination:
                * **{{ ui-key.yacloud.common.folder }}**: Select a folder from the list.
                * **{{ ui-key.yacloud.logging.label_group }}**: Select a [log group](../../logging/concepts/log-group.md) from the list or create a new one.
            1. Select **{{ ui-key.yacloud.logging.label_minlevel }}** from the list.

    1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ TF }} {#tf}

    To change the cluster settings:

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. To change cluster settings, change the required fields' values in the configuration file.

        {% note alert %}

        Do not change the cluster name using {{ TF }}. This will delete the existing cluster and create a new one.

        {% endnote %}

        Here is an example of the configuration file structure:

        ```hcl
        resource "yandex_spark_cluster" "my_spark_cluster" {
          description         = "<cluster_description>"
          name                = "my-spark-cluster"
          folder_id           = "<folder_ID>"
          service_account_id  = "<service_account_ID>"
          deletion_protection = <protect_cluster_from_deletion>

          labels = {
            <label_list>
          }

          network = {
            subnet_ids         = ["<list_of_subnet_IDs>"]
            security_group_ids = ["<list_of_security_group_IDs>"]
          }

          config = {
            resource_pools = {
              driver = {
                resource_preset_id = "<host_class>"
                size               = <fixed_number_of_instances>
              }
              executor = {
                resource_preset_id = "<host_class>"
                size               = <fixed_number_of_instances>
              }
            }
            history_server = {
              enabled = <use_of_Apache_Spark_History_Server>
            } 
            metastore = {
              cluster_id = "<Metastore_cluster_ID>"
            }
            dependencies = {
              deb_packages = ["<list_of_deb_packages>"]
              pip_packages = ["<list_of_pip_packages>"]
            }
          }

          maintenance_window = {
            type = "<maintenance_type>"
            day  = "<day_of_week>"
            hour = "<hour>"
          }

          logging = {
            enabled      = <enable_logging>
            folder_id    = "<folder_ID>"
          }

        }
        ```

        Where:

        * `description`: Cluster description.
        * `service_account_id`: Service account ID.
        * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.
        * `labels`: List of labels. Provide labels in `<key> = "<value>"` format.
        * `security_group_ids`: List of security group IDs.
        * `driver`: Host configuration to run {{ SPRK }} drivers. In this section, specify:

          * [Host class](../concepts/instance-types.md) in the `resource_preset_id` parameter.
          * Number of instances. Specify a fixed number in the `size` parameter or the minimum and maximum number for autoscaling in the `min_size` and `max_size` parameters.

        * `executor`: Host configuration to run {{ SPRK }} executors. In this section, specify:

          * [Host class](../concepts/instance-types.md) in the `resource_preset_id` parameter.
          * Number of instances. Specify a fixed number in the `size` parameter or the minimum and maximum number for autoscaling in the `min_size` and `max_size` parameters.

        * `maintenance_window`: Maintenance window settings (including for disabled clusters). In this section, specify:

          * Maintenance type in the `type` parameter. The possible values include:
            * `ANYTIME`: Anytime.
            * `WEEKLY`: On a schedule.
          * Day of week for the `WEEKLY` maintenance type in the `day` parameter, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
          * UTC hour from `1` to `24` for the `WEEKLY` maintenance type in the `hour` parameter.

        * `history_server`: Connecting {{ SPRK }} History Server. To use the service, set the `enabled` parameter to `true`.

        * `metastore`: Connecting a [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md) metadata storage. Specify a {{ metastore-name }} cluster ID in the `cluster_id` parameter.

        * `dependencies`: Additional deb and pip packages for running {{ SPRK }} jobs. In this section, specify:
          * `deb_packages`: Names of deb packages. Their format depends on the `apt install` installation command.
          * `pip_packages`: Names of pip packages. Their format depends on the `pip install` installation command.

        * `logging`: Logging parameters. Logs generated by {{ SPRK }} components will be sent to {{ cloud-logging-full-name }}. To enable logging:

          * Set the `enabled = true` value.
          * Specify one of two log storage locations:

             * `folder_id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
             * `log_group_id`: Custom log group ID. Logs will be written to this group.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider article]({{ tf-provider-maf }}).

- gRPC API {#grpc-api}

    To change the cluster settings:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and add the following contents to it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": "<list_of_parameters_to_update>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "config_spec": {
           "resource_pools": {
             "driver": {
               "resource_preset_id": "<driver_resource_ID>",
               "scale_policy": {
                 "fixed_scale": {
                   "size": "<number_of_driver_instances>"
                 }
               }
             },
             "executor": {
               "resource_preset_id": "<executor_resource_ID>",
               "scale_policy": {
                 "auto_scale": {
                   "min_size": "<minimum_number_of_executor_instances>",
                   "max_size": "<maximum_number_of_executor_instances>"
                 }
               }
             }
           },
           "history_server": {
             "enabled": <use_of_Apache_Spark_History_Server>
           },
            "dependencies": {
              "pip_packages": [ <list_of_pip_packages> ],
              "deb_packages": [ <list_of_deb_packages> ]
            },
            "metastore": {
              "cluster_id": "<Metastore_cluster_ID>"
            }
          },
          "network_spec": {
            "security_group_ids": [ <list_of_security_group_IDs> ]
          },
          "deletion_protection": <deletion_protection>,
          "service_account_id": "<service_account_ID>",
          "logging": {
            "enabled": <use_of_logging>,
            "log_group_id": "<log_group_ID>",
            "folder_id": "<folder_ID>"
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

            When you update a cluster, all its parameters will reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

            {% endnote %}

        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels. Provide labels in `"<key>": "<value>"` format.
        * `config_spec`: Cluster configuration:

           * `resource_pools`: Resource pool configuration:

               * `driver`: Host configuration to run {{ SPRK }} drivers.

                   * `resource_preset_id`: Driver [host class](../concepts/instance-types.md).
                   * `scale_policy`: Host group scaling policy for the driver:
                       * `fixed_scale`: Fixed scaling policy.

                          * `size`: Number of driver hosts.

                       * `auto_scale`: Automatic scaling policy.

                           * `min_size`: Minimum number of driver hosts.
                           * `max_size`: Maximum number of driver hosts.

                       Specify one of the two parameters: `fixed_scale` or `auto_scale`.

               * `executor`: Host configuration to run {{ SPRK }} executors.

                   * `resource_preset_id`: Executor [host class](../concepts/instance-types.md).
                   * `scale_policy`: Host group scaling policy for the executor:

                       * `fixed_scale`: Fixed scaling policy.

                           * `size`: Number of executor hosts.

                       * `auto_scale`: Automatic scaling policy.

                           * `min_size`: Minimum number of executor hosts.
                           * `max_size`: Maximum number of executor hosts.

                       Specify one of the two parameters: `fixed_scale` or `auto_scale`.

               * `history_server`: History server parameters.

                   * `enabled`: Flag to enable history server. It allows using the service to monitor Spark History Server applications.

               * `dependencies`: Lists of packages enabling you to install additional libraries and applications on the cluster.

                   * `pip_packages`: List of pip packages.
                   * `deb_packages`: List of deb packages.

                   If required, you can set version restrictions for the installed packages, for example:

                   ```bash
                   "dependencies": {
                     "pip_packages": [
                       "pandas==2.0.2",
                       "scikit-learn>=1.0.0",
                       "clickhouse-driver~=0.2.0"
                     ]
                   }
                   ```

                   The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.

               * `metastore`: Parameters of the cluster’s metadata storage.

                   * `cluster_id`: [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md) cluster ID.

           * `network`: Network settings:

               * `security_group_ids`: List of [security group](../../vpc/concepts/security-groups.md) IDs.

           * `deletion_protection`: Enables cluster protection against accidental deletion. The possible values are `true` or `false`.

              Even if it is enabled, one can still connect to the cluster manually and delete it.

           * `service_account_id`: ID of the service account for access to {{ yandex-cloud }} services. Make sure to assign the `managed-spark.integrationProvider` role to the service account:

           * `logging`: Logging parameters:
               * `enabled`: Enables logging. The possible values are `true` or `false`. Logs generated by {{ SPRK }} will be sent to {{ cloud-logging-full-name }}. The possible values are `true` or `false`.
               * `folder_id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
               * `log_group_id`: Custom log group ID. Logs will be written to this group.

               Specify one of the two parameters: `folder_id` or `log_group_id`.

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-spark }}:{{ port-https }} \
            yandex.cloud.spark.v1.ClusterService.Update \
            < body.json
        ```

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
