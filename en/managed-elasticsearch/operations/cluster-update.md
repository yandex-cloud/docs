---
title: Changing Elasticsearch cluster settings
description: After you create an Elasticsearch cluster, you can change host class settings, increase storage size, or change additional settings for the cluster.
keywords:
  - Elasticsearch settings
  - Elasticsearch cluster settings
  - Elasticsearch
---

# Updating {{ ES }} cluster settings

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

After creating a cluster, you can:

* [Change service account settings](#change-service-account).
* [Change the host class](#change-resource-preset).
[Increase storage size](#change-disk-size).
* [Configure](#change-elasticsearch-config) {{ ES }} servers as described in the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html).
* [Changing the admin password](#change-admin-password).
* [Change additional cluster settings](#change-additional-settings).

Learn more about other cluster updates:

* [{#T}](cluster-version-update.md).
* [Migrating cluster hosts to a different availability zone](host-migration.md).


## Changing service account settings {#change-service-account}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **Managed Service for&nbsp;Elasticsearch**.
    1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Select the service account you need from the list or [create a new one](../../iam/operations/sa/create.md). For more information about setting up a service account, see [Configuring access to {{ objstorage-name }} from a cluster](s3-access.md).

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the settings of the service account used to work with the cluster:

    1. View the description of the CLI command to update the cluster:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. Specify the service account ID in the update cluster command:

        ```bash
        {{ yc-mdb-es }} cluster update <cluster_name_or_ID> \
          --service-account-id <service_account_ID>
        ```

        You can request the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    {{ mes-short-name }} will run the service account update for the cluster.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

       For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. In the `service_account_id` field, enter the service account ID:

        ```hcl
        resource "yandex_mdb_elasticsearch_cluster" "<cluster_name>" {
          ...
          service_account_id = <service_account_ID>
        }
        ```

    1. Make sure the settings are correct.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

    To change service account settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

    * Cluster ID in the `clusterId` parameter.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

    * ID of the service account used for cluster operations in the `serviceAccountId` parameter.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}


## Changing the host class {#change-resource-preset}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **Managed Service for&nbsp;Elasticsearch**.
  1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. To change the class of {{ ES }} hosts with the *Data node* role:
     1. Go to the **Data node** tab.
     1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}** , select the class for the host.
  1. To change the class of {{ ES }} hosts with the *Master node* role:
     1. Go to the **Master node** tab.
     1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}** , select the class for the host.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the [host class](../concepts/instance-types.md) for the cluster:

    1. View the description of the CLI command to update the cluster:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. Specify the host class you need with the _Data node_ and _Master node_ roles in the update cluster command:

        ```bash
        {{ yc-mdb-es }} cluster update <cluster_name_or_ID> \
          --datanode-resource-preset <class_of_hosts_with_the_Data_node_role> \
          --masternode-resource-preset <class_of_hosts_with_the_Master_node_role>
        ```

    You can request the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mes-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

  1. In the {{ mes-name }} cluster description, change the `resource_preset_id` attribute value under `config.data_node.resources` or `config.master_node.resources`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster_name>" {
        ...
        config {
          data_node {
            resources {
              resource_preset_id = "<host_class>"
              ...
            }
          }

          master_node {
            resources {
              resource_preset_id = "<host_class>"
              ...
            }
          }
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

  To change the host class, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

  * Cluster ID in the `clusterId` parameter.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

  * Host class in the following parameters:
      * `configSpec.elasticsearchSpec.dataNode.resources.resourcePresetId`: For hosts with the *Data node* role.
      * `configSpec.elasticsearchSpec.masterNode.resources.resourcePresetId`: For hosts with the *Master node* role.

      To request a [list](../api-ref/ResourcePreset/list.md) of supported values, use the list method for the `ResourcePreset` resources.

  * List of settings to update in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Increasing storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To increase the cluster storage size:

  1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **Managed Service for&nbsp;Elasticsearch**.
  1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. To increase the disk size for {{ ES }} hosts with the *Data node* role:
     1. Go to the **Data node** tab.
     1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**, specify the disk size.
  1. To increase the disk size for {{ ES }} hosts with the *Master node* role:
     1. Go to the **Master node** tab.
     1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**, specify the disk size.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To increase the cluster storage size:

    1. View a description of the CLI update configuration command:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. Specify new [storage settings](../concepts/storage.md) for hosts with the _Data node_ and _Master node_ roles in the update cluster command:

        ```bash
        {{ yc-mdb-es }} cluster update <cluster_name_or_ID> \
          --datanode-disk-size <Data_node_storage_size_in_GB> \
          --masternode-disk-size <Master_node_storage_size_in_GB>
        ```

        Where:

        * `--datanode-disk-size`: Storage size in GB for hosts with the Data node role.
        * `--masternode-disk-size`: Storage size in GB for hosts with the Master node role.

    You can request the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  To increase the cluster storage size:

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mes-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

  1. In the {{ mes-name }} cluster description, change the `disk_size` attribute value under `config.data_node.resources` or `config.master_node.resources`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster_name>" {
        ...
        config {
          data_node {
            resources {
              disk_size = <storage_size_in_GB>
              ...
            }
          }

          master_node {
            resources {
              disk_size = <storage_size_in_GB>
              ...
            }
          }
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}


- API {#api}

  To increase the cluster storage size, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

  * Cluster ID in the `clusterId` parameter.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

  * Required storage size (in bytes) in the following parameters:
    * `configSpec.elasticsearchSpec.dataNode.resources.diskSize`: For hosts with the *Data node* role.
    * `configSpec.elasticsearchSpec.masterNode.resources.diskSize`: For hosts with the *Master node* role.
  * List of settings to update in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}


{% endlist %}

## Changing {{ ES }} settings {#change-elasticsearch-config}

You can change the DBMS settings of the hosts in your cluster.

{% note warning %}

You cannot update {{ ES }} settings with the {{ ES }} API.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the folder dashboard and select **Managed Service for&nbsp;Elasticsearch**.
    1. Select a cluster and click ![Pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Change the [{{ ES }} settings](../concepts/settings-list.md) by clicking **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** under **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
    1. Click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change [{{ ES }} server](../concepts/settings-list.md) settings:

    1. View the full list of settings specified for the cluster:

        ```bash
        {{ yc-mdb-es }} cluster get <cluster_name_or_ID> --full
        ```

    1. View the description of the CLI command to update the cluster configuration:

        ```bash
        {{ yc-mdb-es }} cluster update-config --help
        ```

    1. Set the required parameter values:

        ```bash
        {{ yc-mdb-es }} cluster update-config <cluster_name_or_ID> \
           --set <parameter_1_name>=<value_1>,<parameter_2_name>=<value_2>,...
        ```

        All the supported parameters are listed in [{#T}](../concepts/settings-list.md).

- API {#api}

    To change {{ ES }} settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

    * Cluster ID in the `clusterId` parameter.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

    * Required DBMS values in the `configSpec.elasticsearchSpec.dataNode.elastcsearchConfig_7` parameter.
    * List of settings to update in the `updateMask` parameter. If you skip this parameter, the API method will reset any cluster settings that are not explicitly specified in the request to their default values.

    All supported settings are described in the [{#T}](../concepts/settings-list.md) section and the [API reference](../api-ref/Cluster/update.md).

{% endlist %}

## Changing the admin password {#change-admin-password}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **Managed Service for&nbsp;Elasticsearch**.
  1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Specify the `admin` user password in the **{{ ui-key.yacloud.mdb.forms.section_user }}** section.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the `admin` user's cluster password:

    1. View the description of the CLI command to update the cluster:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. Specify a new password in the cluster update command using one of the available methods:

       * Entering a password in interactive mode.

         ```bash
         {{ yc-mdb-es }} cluster update <cluster_name> \
           --read-admin-password
         ```

       * Entering a password as plain text (less secure method).

         ```bash
         {{ yc-mdb-es }} cluster update <cluster_name> \
           --admin-password <new_password>
         ```

       * Generating a password automatically. The generated password will be output to the console.

         ```bash
         {{ yc-mdb-es }} cluster update <cluster_name> \
           --generate-admin-password
         ```

    {{ mes-short-name }} will run the `admin` password update command for the cluster.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mes-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

  1. In the {{ mes-name }} cluster description, change the `admin_password` attribute value under `config`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster_name>" {
        ...
        config {
          admin_password = "<new_admin_user_password>"
          ...
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

  To update the `admin` user's password, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

  * Cluster ID in the `clusterId` parameter.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

  * New password in the `configSpec.adminPassword` parameter. The maximum password length is 128 characters.
  * List of settings to update (in this case, `configSpec.adminPassword`) in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **Managed Service for&nbsp;Elasticsearch**.
    1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Change additional cluster settings:

        {% include [extra-settings](../../_includes/mdb/mes/extra-settings.md) %}

    1. Set the DBMS settings:

        You can configure the `Fielddata cache size` parameter: a percentage or an absolute value of the dynamic memory structure allocated for the `fielddata` cache. For example, 10% or 512 MB.

    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View the description of the CLI command to update the cluster:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. Run the following command with the list of settings to update:

        ```bash
        {{ yc-mdb-es }} cluster update <cluster_name_or_ID> \
           --plugins <plugin_1_name>,...,<plugin_N_name> \
           --maintenance-window type=<maintenance_type>,`
                               `day=<day_of_week>,`
                               `hour=<hour> \
           --deletion-protection=<deletion_protection>
        ```

    You can change the following settings:

    * `--plugins`: List of [{{ ES }} plugins](cluster-plugins.md#elasticsearch) available in the cluster. Plugins that are not on the list will be disabled.

    * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters), where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

    You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mes-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

  1. {% include [Maintenance window](../../_includes/mdb/mes/terraform/maintenance-window.md) %}

  1. To change the list of [{{ ES }} plugins](cluster-plugins.md#elasticsearch), change the value of the `plugins` parameter under `config` in the cluster description:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster_name>" {
        ...
        config {
          plugins = [ "<list_of_plugin_names>" ]
        }
      }
      ```

      Plugins that are not on the list will be disabled.

  1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster_name>" {
        ...
        deletion_protection = <deletion_protection>
      }
      ```

      Where `deletion_protection` is the cluster deletion protection, `true` or `false`.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

    To change additional cluster settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

    * Cluster ID in the `clusterId` parameter.
    
      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

    * List of [{{ ES }} plugins](cluster-plugins.md#elasticsearch) in the `plugins` parameter.

    * [Maintenance](../concepts/maintenance.md) window settings (including for disabled clusters) in the `maintenanceWindow` parameter.

    * Cluster deletion protection settings in the `deletionProtection` parameter.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

    * Settings for access from [{{ data-transfer-full-name }}](../../data-transfer/index.yaml) in the `configSpec.access.dataTransfer` parameter.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
