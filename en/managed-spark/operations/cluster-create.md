---
title: Creating a {{ SPRK }} cluster
description: Each {{ SPRK }} cluster contains computing resources to run Spark applications.
keywords:
  - creating an {{ SPRK }} cluster
  - '{{ SPRK }} cluster'
  - '{{ SPRK }}'
---

# Creating a {{ SPRK }} cluster

{% include notitle [preview](../../_includes/note-preview.md) %}

Each {{ SPRK }} cluster contains computing resources to run Spark applications.

## Roles for creating a cluster {#roles}

To create a {{ SPRK }} cluster, your {{ yandex-cloud }} account needs the following roles:

* [managed-spark.admin](../security.md#managed-spark-admin): To create a cluster.
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user): To use the cluster [network](../../vpc/concepts/network.md#network).
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user): To link a service account to the cluster.

Make sure to assign the `managed-spark.integrationProvider` and `storage.editor` roles to the cluster service account. The cluster will thus get the permissions it needs to work with user resources.


For more information about assigning roles, see the [{{ iam-full-name }} documentation](../../iam/operations/roles/grant.md).


## Creating a cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ SPRK }} cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Give the cluster a name. The name must be unique within the folder.
        1. Optionally, enter a description for the cluster.
        1. Optionally, create [labels](../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.

        1. Select an existing [service account](../../iam/concepts/users/service-accounts.md) or [create a new one](../../iam/operations/sa/create.md).

            Make sure to assign the `managed-spark.integrationProvider` role to the service account.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select a [network](../../vpc/operations/network-create.md), [subnet](../../vpc/operations/subnet-create.md), and [security group](../../vpc/concepts/security-groups.md) for the cluster.

    1. Specify the computing resources to run Spark applications on:

       * Driver configuration: Number of driver hosts and [their class](../concepts/instance-types.md). It can be either fixed or autoscalable.
       * Executor configuration: Number of executor hosts and [their class](../concepts/instance-types.md). It can be either fixed or autoscalable.

    1. Configure additional cluster settings, if required:
        
        1. **{{ ui-key.yacloud.mdb.forms.title_pip-packages }}** and **{{ ui-key.yacloud.mdb.forms.title_deb-packages }}**: Pip and deb package names for installing additional libraries and applications.
           
           To specify multiples packages, click **{{ ui-key.yacloud.common.add }}**.

           The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.
        
        1. **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: Maintenance window settings:

           {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        1. **{{ ui-key.yacloud.spark.label_metastore }}**: [Metastore server](../../metadata-hub/concepts/metastore.md) connected to your cluster.

        1.  **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}**: Manages cluster protection against accidental deletion.
        1. Enable the **{{ ui-key.yacloud.spark.label_history-server }}** setting to allow using the service to monitor [Spark History Server](https://spark.apache.org/docs/latest/monitoring.html) applications. After creating a cluster, the service will be available via a link.
        1. Configure logging:

            1. Enable the **{{ ui-key.yacloud.logging.field_logging }}** setting.
            1. Select the log destination:
                * **{{ ui-key.yacloud.common.folder }}**: Select a folder from the list.
                * **{{ ui-key.yacloud.logging.label_group }}**: Select a [log group](../../logging/concepts/log-group.md) from the list or create a new one.
            1. Select **{{ ui-key.yacloud.logging.label_minlevel }}** from the list.

    1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    To create a {{ msp-name }} cluster:

    1. In the configuration file, describe the resources you are creating:

        * {{ msp-name }} cluster: Cluster description.

        * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

        * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

        {% include [Terraform cluster parameters description](../../_includes/mdb/msp/terraform/cluster-parameters.md) %}

    1. If necessary, configure additional DBMS settings:
    
        {% include [Terraform cluster additional parameters description](../../_includes/mdb/msp/terraform/cluster-parameters-additional.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a {{ msp-name }} cluster.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        This will create all the resources you need in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-msp }}).

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:
    
       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
    
    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    
    1. Create a file named `body.json` and add the following contents to it:

       ```json
       {
         "folder_id": "<folder_ID>",
         "name": "<cluster_name>",
         "description": "<cluster_description>",
         "labels": { <label_list> },
         "config": {
           "resource_pools": {
             "driver": {
               "resource_preset_id": "<resource_ID>",
               "scale_policy": {
                 "fixed_scale": {
                   "size": "<number_of_instances>"
                 }
               }
             },
             "executor": {
               "resource_preset_id": "<resource_ID>",
               "scale_policy": {
                 "auto_scale": {
                   "min_size": "<minimum_number_of_instances>",
                   "max_size": "<maximum_number_of_instances>"
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
             "cluster_id": "<cluster_ID>"
           }
         },
         "network": {
           "subnet_ids": [ <list_of_subnet_IDs> ],
           "security_group_ids": [ <list_of_security_group_IDs> ]
         },
         "deletion_protection": <deletion_protection>,
         "service_account_id": "<service_account_ID>",
         "logging": {
           "enabled": <use of_logging>,
           "folder_id": "<folder_ID>"
         }
       }
       ```

       Where:

       * `folder_id`: Folder ID. You can request it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
       * `name`: Cluster name.
       * `description`: Cluster description.
       * `labels`: List of labels. Provide labels in `"<key>": "<value>"` format.
       * `config`: Cluster configuration:

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

                   The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.

               * `metastore`: Metastore parameters.

                   * `cluster_id`: [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md) cluster ID.

           * `network`: Network settings:

               * `subnet_ids`: Subnet IDs list.
               * `security_group_ids`: List of security group IDs.

           * `deletion_protection`: Enables cluster protection against accidental deletion. The possible values are `true` or `false`.

              Even if it is enabled, one can still connect to the cluster manually and delete it.

           * `service_account_id`: Service account ID.

           * `logging`: Logging parameters:
               * `enabled`: Enables logging. Logs generated by Spark applications will go to {{ cloud-logging-full-name }}. The possible values are `true` or `false`.
               * `folder_id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
               * `log_group_id`: Custom log group ID. Logs will be written to this group.

               Specify one of the two parameters: `folder_id` or `log_group_id`.

    1. Use the [ClusterService/Create](../api-ref/grpc/Cluster/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

       ```bash
       grpcurl \
           -format json \
           -import-path ~/cloudapi/ \
           -import-path ~/cloudapi/third_party/googleapis/ \
           -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
           -rpc-header "Authorization: Bearer $IAM_TOKEN" \
           -d @ \
           {{ api-host-spark }}:{{ port-https }} \
           yandex.cloud.spark.v1.ClusterService.Create \
           < body.json
       ```
    
    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
