---
title: Updating an {{ SPRK }} cluster
description: After creating an {{ SPRK }} cluster, you can edit its basic and advanced settings.
keywords:
  - Updating an {{ SPRK }} cluster
  - '{{ SPRK }} cluster'
  - '{{ SPRK }}'
---

# Updating an {{ SPRK }} cluster

After creating a cluster, you can edit its basic and advanced settings:

* [Cluster name and description](#change-basic-settings)
* [Service account](#change-sa)
* [Security groups](#change-sg)
* [Driver and executor configuration](#change-configuration)
* [Additional cluster settings](#change-additional-settings)

Learn more about other cluster updates:

* [Upgrading the {{ SPRK }} version](cluster-version-update.md)
* [Setting up maintenance](cluster-maintenance.md)

## Changing the cluster name and description {#change-basic-settings}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder.
    1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Select a cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** on the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, update the cluster name, description, and labels.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the cluster name and description:

  1. View the description of the CLI command for updating a cluster:

     ```bash
     {{ yc-mdb-sp }} cluster update --help
     ```

  1. To change cluster name and description, run this command:

     ```bash
     {{ yc-mdb-sp }} cluster update <cluster_name_or_ID> \
       --new-name <cluster_name> \
       --description <cluster_description> 
     ```

     Where:

     * `--new-name`: Cluster name, unique within the cloud.
     * `--description`: Cluster description.

     You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.   

- {{ TF }} {#tf}

    {% note alert %}

    Do not change the cluster name using {{ TF }}. This will delete the existing cluster and create a new one.

    {% endnote %}

    1. Open the current {{ TF }} configuration file with the infrastructure plan.

        To learn how to create this file, refer to [Creating a cluster](cluster-create.md).
        
    1. Edit the `description` parameter in the cluster's description:
      
        ```hcl
        resource "yandex_spark_cluster" "<cluster_name>" {
          ...
          description = "<cluster_description>"
          ...
        }
        ```

        Where `description` is the cluster's description.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": {
            "paths": [
              <list_of_settings_to_update>
            ]
          },
          "name": "<cluster_name>",
          "description": "<cluster_description>"
        }
        ```

        Where:

        * `cluster_id`: Cluster ID.
            
            You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

        * `update_mask`: List of parameters to update as an array of strings (`paths[]`).

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

            When you update a cluster, all parameters of the object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

            {% endnote %}

        * `name`: Cluster name, unique within the cloud.
        * `description`: Cluster description.

    1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

    1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing a service account {#change-sa}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder.
    1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Select a cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** on the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, select a service account or [create a new one](../../iam/operations/sa/create.md#create-sa) with the `managed-spark.integrationProvider` role. The cluster will thus get the permissions it needs to work with other resources.

        To change your service account in a {{ msp-name }} cluster, [make sure](../../iam/operations/roles/get-assigned-roles.md) your {{ yandex-cloud }} account has the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher.

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update a service account:

  1. View the description of the CLI command for updating a cluster:

     ```bash
     {{ yc-mdb-sp }} cluster update --help
     ```

  1. Update your service account using this command:

     ```bash
     {{ yc-mdb-sp }} cluster update <cluster_name_or_ID> \
       --service-account-id <service_account_ID>
     ```

     Where `--service-account-id` is the ID of the service account for access to {{ yandex-cloud }} services. Make sure to assign the `managed-spark.integrationProvider` role to this service account:

     You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.   

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with the infrastructure plan.

       Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. Edit the `service_account_id` parameter in the cluster's description:
      
        ```hcl
        resource "yandex_spark_cluster" "<cluster_name>" {
          ...
          service_account_id  = "<service_account_ID>"
          ...
        }
        ```

        Where `service_account_id` is the service account ID.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": {
            "paths": [
              "service_account_id"
            ]
          },
          "service_account_id": "<service_account_ID>"
        }
        ```

        Where:

        * `cluster_id`: Cluster ID.
            
            You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

        * `update_mask`: List of parameters to update as an array of strings (`paths[]`).

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

            When you update a cluster, all parameters of the object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

            {% endnote %}

        * `service_account_id`: Service account ID.

    1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

    1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Updating security groups {#change-sg}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder.
    1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Select a cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** on the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select security groups for the cluster.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To update security groups:

    1. View the description of the CLI command for updating a cluster:

       ```bash
       {{ yc-mdb-sp }} cluster update --help
       ```

    1. Update security groups using this command:

       ```bash
       {{ yc-mdb-sp }} cluster update <cluster_name_or_ID> \
         --security-group-ids <list_of_security_group_IDs>
       ```

       Where `--security-group-ids` is the list of security group IDs.

       You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.   

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with the infrastructure plan.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. Edit the `security_group_ids` parameter in the cluster's description:
      
        ```hcl
        resource "yandex_spark_cluster" "<cluster_name>" {
          ...
          security_group_ids  = [<list_of_security_group_IDs>]
          ...
        }
        ```

        Where `security_group_ids` is the list of security group IDs.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": {
            "paths": [
              "network_spec.security_group_ids"
            ]
          },
          "network_spec": {
            "security_group_ids": [ <list_of_security_group_IDs> ]
          }
        }
        ```

        Where:

        * `cluster_id`: Cluster ID.
            
            You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

        * `update_mask`: List of parameters to update as an array of strings (`paths[]`).

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

            When you update a cluster, all parameters of the object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

            {% endnote %}

        * `network_spec`: Network settings:

            * `security_group_ids`: List of security group IDs.

    1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

    1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Updating the driver and executor configuration {#change-configuration}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder.
    1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Select a cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** on the top panel.
    1. Under **{{ ui-key.yacloud.spark.section_driver }}** and **{{ ui-key.yacloud.spark.section_executor }}**, specify the number of instances and [computing resource configuration](../concepts/instance-types.md). The number of instances can be either fixed or autoscalable.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To update the driver and executor configuration:

    1. View the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-sp }} cluster update --help
        ```

    1. Update the driver and executor configuration by running this command:

       ```bash
       {{ yc-mdb-sp }} cluster update <cluster_name_or_ID> \
         --driver-preset-id <driver_resource_ID> \
         --driver-fixed-size <number_of_driver_instances> \
         --executor-preset-id <executor_resource_ID> \
         --executor-fixed-size <number_of_executor_instances> \
       ```

       Where:

       * `--driver-preset-id`: Driver [host class](../concepts/instance-types.md).
       * `--driver-fixed-size`: Fixed number of driver hosts.
       * `--driver-min-size`: Minimum number of driver hosts for autoscaling.
       * `--driver-max-size`: Maximum number of driver hosts for autoscaling.

       Specify either a fixed number of hosts (`--driver-fixed-size`) or minimum and maximum number of hosts (`--driver-min-size` and `--driver-max-size`) for autoscaling.

       * `--executor-preset-id`: Executor [host class](../concepts/instance-types.md).
       * `--executor-fixed-size`: Fixed number of executor hosts.
       * `--executor-min-size`: Minimum number of executor hosts for autoscaling.
       * `--executor-max-size`: Maximum number of executor hosts for autoscaling.

       Specify either a fixed number of hosts (`--executor-fixed-size`) or minimum and maximum number of hosts (`--executor-min-size` and `--executor-max-size`) for autoscaling.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with the infrastructure plan.

       Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. Update the driver and executor configuration under `driver` and `executor` respectively:
      
        ```hcl
        resource "yandex_spark_cluster" "<cluster_name>" {
          ...
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
          ...
        }
        ```
        
        Where:
        
        * `driver`: Host configuration to run {{ SPRK }} drivers. In this section, specify:

          * `resource_preset_id`: [Host class](../concepts/instance-types.md).
          * `size`: Fixed number of instances. 
          * `min_size`: Minimum number of hosts if autoscaling is on.
          * `max_size`: Maximum number of hosts if autoscaling is on.

        * `executor`: Host configuration to run {{ SPRK }} executors. In this section, specify:

          * `resource_preset_id`: [Host class](../concepts/instance-types.md).
          * `size`: Fixed number of instances. 
          * `min_size`: Minimum number of hosts if autoscaling is on.
          * `max_size`: Maximum number of hosts if autoscaling is on.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": {
            "paths": [ 
              <list_of_settings_to_update>
              ]
          },
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
            }
          }
        }
        ```

        Where:

        * `cluster_id`: Cluster ID.
            
            You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

        * `update_mask`: List of parameters to update as an array of strings (`paths[]`).

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

            When you update a cluster, all parameters of the object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

            {% endnote %}

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

    1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

    1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Configuring advanced cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. Select a cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** on the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**:
     
     * Select **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_dependencies-type_wJq6n }}**:

        * **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_software-configuration-type-environment_wJq6n }}**: You can use base and custom environments. If you need a custom environment, you have to [create one yourself](environment-create.md).
        * **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_software-configuration-type-packages_wJq6n }}**:

           * **Version**: {{ SPRK }} version.
           * **{{ ui-key.yacloud.mdb.forms.title_pip-packages }}** and **{{ ui-key.yacloud.mdb.forms.title_deb-packages }}**: Pip and deb package names, space-separated, for installing additional libraries and applications.

              You can set version restrictions for the installed packages, e.g.:

              ```text
              py4j>=0.10.9.7 pandas>=1.05 grpcio>=1.48,<1.57 grpcio-status>=1.48,<1.57 googleapis-common-protos==1.56.4
              ```
                
              The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.

           {% note warning %}
           
           Adding packages without creating an environment is deprecated and will soon be unavailable. Use a base environment or [create a custom one](environment-create.md) containing the packages you need.
           
           {% endnote %}
      
     * In the **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** setting, update cluster [maintenance time](../concepts/maintenance.md):

        {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}
      
     * **{{ ui-key.yacloud.spark.label_metastore }}**: Select a [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md) cluster to connect as a metadata storage.
     * **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}**: Cluster protection from accidental deletion by a user.
     * **{{ ui-key.yacloud.spark.label_history-server }}**: Allows using the service to monitor [Spark History Server](https://spark.apache.org/docs/latest/monitoring.html) applications.
     * **{{ ui-key.yacloud.logging.field_logging }}**: Enables logging of Spark applications in the cluster:
        1. Select the log destination:
           * **{{ ui-key.yacloud.common.folder }}**: Select a folder from the list.
           * **{{ ui-key.yacloud.logging.label_group }}**: Select a [log group](../../logging/concepts/log-group.md) from the list or create a new one.
        1. Select **{{ ui-key.yacloud.logging.label_minlevel }}** from the list.

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change advanced cluster settings:

  1. View the description of the CLI command for updating a cluster:

     ```bash
     {{ yc-mdb-sp }} cluster update --help
     ```
  1. Update additional cluster settings using this command:

     ```bash
     {{ yc-mdb-sp }} cluster update <cluster_name_or_ID> \
       --history-server-enabled <use_Spark_History_Server> \
       --metastore-cluster-id <Apache_Hive™_Metastore_cluster_ID> \
       --pip-packages <list_of_pip_packages> \
       --deb-packages <list_of_deb_packages> \
       --log-enabled \
       --log-folder-id <folder_ID> \
       --maintenance-window type=<maintenance_type>,`
                           `day=<day_of_week>,`
                           `hour=<hour> \
       --deletion-protection
     ```

     Where:

     * `--history-server-enabled`: Enables the [Spark History Server](https://spark.apache.org/docs/latest/monitoring.html) monitoring service.
     * `--metastore-cluster-id`: {{ metastore-name }} cluster ID. This setting connects the [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md) metadata storage.

     * `--pip-packages`: List of pip packages.
     * `--deb-packages`: List of deb packages.

        Use lists of packages to install additional libraries and applications in the cluster.

        You can set version restrictions for the installed packages, e.g.:

        ```bash
        --pip-packages pandas==2.1.1,scikit-learn>=1.0.0,clickhouse-driver~=0.2.0
        ```

        The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.

     * `--log-enabled`: Enables logging.
     * `--log-folder-id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
     * `--log-group-id`: Custom log group ID. Logs will be written to this group.

        Specify either `--log-folder-id` or `--log-group-id`.

     * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings that apply to both running and stopped clusters. The `type` setting defines the maintenance type:

       {% include [Maintenance window](../../_includes/managed-spark/maintenance-window-console.md) %}

     * `--deletion-protection`: Enables cluster protection against accidental deletion.

       Even with deletion protection on, one can still connect to the cluster manually and delete it.

     You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

- {{ TF }} {#tf}

    To change the cluster settings:

    1. Open the current {{ TF }} configuration file with the infrastructure plan.

        To learn how to create this file, refer to [Creating a cluster](cluster-create.md).

    1. To change cluster settings, change the required field values in the configuration file.

        Here is an example of the configuration file structure:

        ```hcl
        resource "yandex_spark_cluster" "my_spark_cluster" {

          deletion_protection = <protect_cluster_from_deletion>

          config = {
            ...
            history_server = {
              enabled = <use_Spark_History_Server>
            } 
            metastore = {
              cluster_id = "<Apache_Hive™_Metastore_cluster_ID>"
            }
            dependencies = {
              deb_packages = ["<list_of_deb_packages>"]
              pip_packages = ["<list_of_pip_packages>"]
            }
          }

          maintenance_window = {
            type = "<maintenance_type>"
            day  = "<day_of_week>"
            hour = "<sequence_number_of_hour_interval>"
          }

          logging = {
            enabled      = <enable_logging>
            folder_id    = "<folder_ID>"
          }

        }
        ```

        Where:

        * `deletion_protection`: Cluster deletion protection, `true` or `false`.
        * `maintenance_window`: [Maintenance](../concepts/maintenance.md) window settings (including for disabled clusters). In this section, specify:

          * `type`: Maintenance type. The possible values include:
            * `ANYTIME`: Any time.
            * `WEEKLY`: On a schedule.
          * `day`: Day of week for the `WEEKLY` maintenance type, `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
          * `hour`: UTC hour interval for the `WEEKLY` maintenance type, from `1` to `24`.

             > For example, `1` stands for the interval from `00:00` to `01:00`, and `5`, from `04:00` to `05:00`.

        * `history_server`: Connecting {{ SPRK }} History Server. To use the service, set the `enabled` parameter to `true`.

        * `metastore`: Connecting a [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md) metadata storage. Specify a {{ metastore-name }} cluster ID in the `cluster_id` parameter.

        * `dependencies`: Additional deb and pip packages for running {{ SPRK }} jobs. In this section, specify:
          * `deb_packages`: Names of deb packages. Their format depends on the `apt install` installation command.
          * `pip_packages`: Names of pip packages. Their format depends on the `pip install` installation command.

        * `logging`: Logging parameters. Logs generated by {{ SPRK }} components will be sent to {{ cloud-logging-full-name }}. To enable logging:

          * Set it to `enabled = true`.
          * Specify one of two log storage locations:

             * `folder_id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
             * `log_group_id`: Custom log group ID. Logs will be written to this group.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-maf }}).

- gRPC API {#grpc-api}

    To change the cluster settings:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": {
            "paths": [ "<list_of_settings_to_update>" ]
          },
          "config_spec": {
            "history_server": {
              "enabled": <use_Spark_History_Server>
            },
            "metastore": {
              "cluster_id": "<Apache_Hive™_Metastore_cluster_ID>"
            },
            "environment_id": "<environment_ID>"
          },
          "deletion_protection": <deletion_protection>,
          "logging": {
            "enabled": <use_of_logging>,
            "log_group_id": "<log_group_ID>",
            "folder_id": "<folder_ID>"
          },
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<day_of_week>",
              "hour": "<sequence_number_of_hour_interval>"
            }
          }
        }
        ```

        Where:

        * `cluster_id`: Cluster ID. You can get it with the [list of clusters in the folder](cluster-list.md#list-clusters).
        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

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
        * `labels`: List of labels provided in `"<key>": "<value>"` format.
        * `config_spec`: Cluster configuration:

           * `history_server`: History server parameters.
              * `enabled`: Flag to enable history server. It allows using the service to monitor Spark History Server applications.

           * `metastore`: Parameters of the cluster’s metadata storage.

              * `cluster_id`: [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md) cluster ID.

           * `dependencies`: Lists of packages to install in the cluster:

              * `pip_packages`: List of pip packages.
              * `deb_packages`: List of deb packages.

              The package name format and version are defined by the install commands: `pip install` for pip packages and `apt install` for deb packages.

           * `spark_version`: {{ SPRK }} version.

           * `environment_id`: Base or custom environment ID. Call the [EnvironmentService/List](../environment/api-ref/grpc/Environment/list.md) method to get the custom environment ID or [EnvironmentService/ListBase](../environment/api-ref/grpc/Environment/listBase.md) to get the base environment ID.

              To connect an environment instead of using the deprecated `spark_version` and `dependencies` parameters, add `config_spec.environment_id`, `config_spec.spark_version`, and `config_spec.dependencies` to `update_mask.paths`. Provide only `environment_id` to `config_spec`. This will clear the {{ SPRK }} version and the package lists you specified earlier manually.

           {% note warning %}

           Specify either `environment_id` or `spark_version` and `dependencies` in the request. Updating the version and adding packages without creating an environment is deprecated and will soon be unavailable. Use a base environment or [create a custom one](environment-create.md) containing the packages you need.

           {% endnote %}

           * `network`: Network settings:

               * `security_group_ids`: List of [security group](../../vpc/concepts/security-groups.md) IDs.

           * `deletion_protection`: Enables cluster protection against accidental deletion. The possible values are `true` or `false`.

              Even with deletion protection on, one can still connect to the cluster manually and delete it.

           * `logging`: Logging parameters:
               * `enabled`: Enables logging. The possible values are `true` or `false`. Logs generated by {{ SPRK }} components will be sent to {{ cloud-logging-full-name }}. The possible values are `true` or `false`.
               * `folder_id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
               * `log_group_id`: Custom log group ID. Logs will be written to this group.

               Specify either `folder_id` or `log_group_id`.

           * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings, applying to both running and stopped clusters. Provide one of these two properties:

               * `anytime`: Maintenance takes place at any time.
               * `weekly_maintenance_window`: Maintenance takes place once a week at the specified time:

                   * `day`: Day of week, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                   * `hour`: UTC hour interval, from `1` to `24`.

                     > For example, `1` stands for the interval from `00:00` to `01:00`, and `5`, from `04:00` to `05:00`.
                     
    1. Call the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
