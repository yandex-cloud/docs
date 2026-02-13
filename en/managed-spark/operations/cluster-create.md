---
title: Creating a {{ SPRK }} cluster
description: Each {{ SPRK }} cluster contains computing resources to run Spark applications.
keywords:
  - creating an {{ SPRK }} cluster
  - '{{ SPRK }} cluster'
  - '{{ SPRK }}'
---

# Creating a {{ SPRK }} cluster

Each {{ SPRK }} cluster contains computing resources to run Spark applications.

## Roles for creating a cluster {#roles}

To create a {{ SPRK }} cluster, your {{ yandex-cloud }} account needs the following roles:

* [managed-spark.admin](../security.md#managed-spark-admin): To create a cluster.
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user): To use the cluster [network](../../vpc/concepts/network.md#network).
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user): To assign a service account to a cluster.

Make sure to assign the `managed-spark.integrationProvider` and `storage.editor` roles to the cluster service account. The cluster will thus get the permissions it needs to work with user resources.


For more information about assigning roles, see [this {{ iam-full-name }} guide](../../iam/operations/roles/grant.md).


## Creating a cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ SPRK }} cluster.
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Give the cluster a name. The name must be unique within the folder.
        1. Optionally, enter a description for the cluster.
        1. Optionally, create [labels](../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.

        1. Select an existing [service account](../../iam/concepts/users/service-accounts.md) or [create a new one](../../iam/operations/sa/create.md).

            Make sure to assign the `managed-spark.integrationProvider` role to this service account:

        1. Select the {{ SPRK }} version.

           {% include [change-version-note](../../_includes/managed-spark/change-version-note.md) %}

    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select a [network](../../vpc/operations/network-create.md), [subnet](../../vpc/operations/subnet-create.md), and [security group](../../vpc/concepts/security-groups.md) for the cluster.

    1. Specify the computing resources to run Spark applications on:

       * Driver configuration: Number of driver hosts and [their class](../concepts/instance-types.md). It can be either fixed or autoscalable.
       * Executor configuration: Number of executor hosts and [their class](../concepts/instance-types.md). It can be either fixed or autoscalable.

    1. If needed, configure advanced cluster settings:
        
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

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create an {{ SPRK }} cluster:

    1. Verify that your folder has subnets for cluster host placement:

        ```bash
        yc vpc subnet list
        ```

        If your folder contains no subnets, [create them](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.

    1. View the description of the CLI command for creating a cluster:

        ```bash
        {{ yc-mdb-sp }} cluster create --help
        ```

    1. Specify the cluster properties in this command (the example does not show all that are available):

        ```bash
        {{ yc-mdb-sp }} cluster create \
           --name <cluster_name> \
           --spark-version <<Apache_Spark_version>> \
           --service-account-id <service_account_ID> \
           --subnet-ids <list_of_subnet_IDs> \
           --security-group-ids <list_of_security_group_IDs> \
           --driver-preset-id=<class_of_driver_computing_resources> \
           --driver-fixed-size <number_of_driver_hosts> \
           --executor-preset-id <class_of_executor_computing_resources> \
           --executor-min-size <minimum_number_of_executor_hosts> \
           --executor-max-size <maximum_number_of_executor_hosts> \
           --pip-packages <list_of_pip_packages> \
           --deb-packages <list_of_deb_packages>\
           --history-server-enabled \ 
           --metastore-cluster-id <cluster_ID> \
           --deletion-protection
        ```

        Where:

        * `--name`: Cluster name. It must be unique within the folder.
        * `--version`: {{ SPRK }} version.

           {% include [change-version-note](../../_includes/managed-spark/change-version-note.md) %}

        * `--service-account-id`: Service account ID.
        * `--subnet-ids`: List of subnet IDs.
        * `--security-group-ids`: List of security group IDs.
        * `--driver-preset-id`: [Class](../concepts/instance-types.md) of [driver](../concepts/index.md#concepts) computing resources.
        * `--driver-fixed-size`: Fixed number of driver instances.
        * `--driver-min-size`: Minimum number of driver instances.
        * `--driver-max-size`: Maximum number of driver instances.

           Specify either a fixed number of drivers or minimum and maximum numbers of drivers for autoscaling.

        * `--executor-preset-id`: [Class](../concepts/instance-types.md) of executor computing resources.
        * `--executor-fixed-size`: Fixed number of executor instances.
        * `--executor-min-size`: Minimum number of executor instances.
        * `--executor-max-size`: Maximum number of executor instances.

           Specify either a fixed number of executors or minimum and maximum numbers of executors for autoscaling.

        * `--pip-packages`: List of pip packages enabling you to install additional libraries and applications in the cluster.

            The package name format and version are determined by the `pip install` command.

        * `--deb-packages`: List of deb packages enabling you to install additional libraries and applications in the cluster.

            The package name format and version are determined by the `apt install` command.

        * `--history-server-enabled`: Flag to enable history server. It allows using the service to monitor Spark History Server applications.

        * `--metastore-cluster-id`: ID of the [{{ metastore-name }} cluster](../../metadata-hub/concepts/metastore.md) to use as a metadata storage.

        * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

            Even with deletion protection on, one can still connect to the cluster manually and delete it.

    1. To enable sending of {{ SPRK }} logs to [{{ cloud-logging-full-name }}](../../logging/), specify logging parameters:

        ```bash
        {{ yc-mdb-sp }} cluster create <cluster_name> \
           ...
           --log-enabled \
           --log-folder-id <folder_ID>
        ```

        Where:

        * `--log-enabled`: Enables logging.
        * `--log-folder-id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
        * `--log-group-id`: Custom log group ID. Logs will be written to this group.

            Specify either a folder ID or a custom log group ID.

    1. To set up a maintenance window (including for disabled clusters), provide the required value in the `--maintenance-window` parameter:

        ```bash
        {{ yc-mdb-sp }} cluster create <cluster_name> \
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

    To create a {{ msp-full-name }} cluster:

    1. In the configuration file, describe the resources you are creating:

        * {{ msp-full-name }} cluster: Cluster description.

        * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

        * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

        {% include [Terraform cluster parameters description](../../_includes/mdb/msp/terraform/cluster-parameters.md) %}

    1. If necessary, configure additional DBMS settings:

        {% include [Terraform cluster additional parameters description](../../_includes/mdb/msp/terraform/cluster-parameters-additional.md) %}

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a {{ msp-full-name }} cluster.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        This will create all the resources you need in the specified folder. You can check the new resources and their settings in the [management console]({{ link-console-main }}).

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-msp }}).

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:
    
       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
    
    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    
    1. Create a file named `body.json` and paste the following code into it:

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
             },
             "spark_version": "<Apache_Spark_version>"
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
           "enabled": <use_of_logging>,
           "folder_id": "<folder_ID>"
         }
       }
       ```

       Where:

       * `folder_id`: Folder ID. You can request it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
       * `name`: Cluster name.
       * `description`: Cluster description.
       * `labels`: List of labels provided in `"<key>": "<value>"` format.
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

                           Specify either `fixed_scale` or `auto_scale`.

               * `executor`: Host configuration to run {{ SPRK }} executors.

                   * `resource_preset_id`: Executor [host class](../concepts/instance-types.md).
                   * `scale_policy`: Host group scaling policy for the executor:

                       * `fixed_scale`: Fixed scaling policy.
                           * `size`: Number of executor hosts.

                       * `auto_scale`: Automatic scaling policy.
                           * `min_size`: Minimum number of executor hosts.
                           * `max_size`: Maximum number of executor hosts.

                           Specify either `fixed_scale` or `auto_scale`. 

           * `history_server`: History server parameters.
              * `enabled`: Flag to enable history server. It allows using the service to monitor Spark History Server applications.

           * `dependencies`: Lists of packages enabling you to install additional libraries and applications on the cluster.
              * `pip_packages`: List of pip packages.
              * `deb_packages`: List of deb packages.

              The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.

           * `metastore`: Metastore parameters.
              * `cluster_id`: [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md) cluster ID.

           * `spark_version`: {{ SPRK }} version.

              {% include [change-version-note](../../_includes/managed-spark/change-version-note.md) %}

       * `network`: Network settings:
          * `subnet_ids`: List of subnet IDs.
          * `security_group_ids`: List of security group IDs.

       * `deletion_protection`: Enables cluster protection against accidental deletion. The possible values are `true` or `false`.

          Even with deletion protection on, one can still connect to the cluster manually and delete it.

       * `service_account_id`: Service account ID.

       * `logging`: Logging parameters:
          * `enabled`: Enables logging. Logs generated by Spark applications will go to {{ cloud-logging-full-name }}. The possible values are `true` or `false`.
          * `folder_id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
          * `log_group_id`: Custom log group ID. Logs will be written to this group.

          Specify either `folder_id` or `log_group_id`.

    1. Call the [ClusterService/Create](../api-ref/grpc/Cluster/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

    1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Examples {#examples}

{% list tabs group=instructions %}

- CLI {#cli}

    Create an {{ SPRK }} cluster with the following test specifications:

    * Name: `myspark`.
    * Service account: `ajev56jp96ji********`.
    * Subnet: `{{ subnet-id }}`.
    * Security group: `{{ security-group }}`.
    * Two drivers with [computing resource class](../concepts/instance-types.md): `c2-m16`.
    * Four executors with computing resource class: `c2-m16`.
    * History server enabled.
    * Accidental deletion protection enabled.

    Run this command:

    ```bash
    {{ yc-mdb-sp }} cluster create \
       --name myspark \
       --service-account-id ajev56jp96ji******** \
       --subnet-ids {{ subnet-id }} \
       --security-group-ids {{ security-group }} \
       --driver-preset-id c2-m16 \
       --driver-fixed-size 2 \
       --executor-preset-id c2-m16 \
       --executor-fixed-size 4 \
       --history-server-enabled \
       --deletion-protection
    ```

- {{ TF }} {#tf}

    Create an {{ SPRK }} cluster and its supporting network, using the following test specifications:

    * Name: `myspark`.
    * Service account: `ajev56jp96ji********`.
    * Network: `msp-network`.
    * Subnet: `msp-subnet`. The subnet availability zone is `ru-central1-a`; the range is `10.1.0.0/16`.
    * Two drivers with [computing resource class](../concepts/instance-types.md): `c2-m16`.
    * Four executors with computing resource class: `c2-m16`.
    * History server enabled.
    * Accidental deletion protection enabled.
    * Logging disabled.

    The configuration file for this cluster is as follows:

    ```hcl
    resource "yandex_spark_cluster" "myspark" {
      name                = "myspark"
      service_account_id  = "ajev56jp96ji********"
      deletion_protection = true

      network = {
        subnet_ids = [yandex_vpc_subnet.msp-subnet.id]
      }

      config = {
        resource_pools = {
          driver = {
            resource_preset_id = "c2-m16"
            size               = 2
          }
          executor = {
            resource_preset_id = "c2-m16"
            size               = 4
          }
        }
        history_server = {
          enabled = true
        }
      }

      logging = {
        enabled = false
      }
    }

    resource "yandex_vpc_network" "msp-network" {
      name = "msp-network"
    }

    resource "yandex_vpc_subnet" "msp-subnet" {
      name           = "msp-subnet"
      zone           = "ru-central1-a"
      network_id     = yandex_vpc_network.msp-network.id
      v4_cidr_blocks = ["10.1.0.0/16"]
    }
    ```

{% endlist %}
