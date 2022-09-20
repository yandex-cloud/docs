---
title: Changing Elasticsearch cluster settings
description: 'After creating the cluster, you can change the host class settings, increase the storage size, or change additional settings for the Elasticsearch cluster.'
keywords:
  - Elasticsearch settings
  - Elasticsearch cluster settings
  - Elasticsearch
---

# Changing cluster settings

After creating a cluster, you can:

* [{#T}](#change-service-account).
* [{#T}](#change-resource-preset).
* [{#T}](#change-disk-size){% if audience != "internal" %} (unavailable for non-replicated SSD [storage](../concepts/storage.md)){% endif %}.
* [{#T}](#change-elasticsearch-config).
* [{#T}](#change-admin-password).
* [{#T}](#change-additional-settings).

You can also update the {{ ES }} version or edition. For more information, see [{#T}](./cluster-version-update.md).

## Change service account settings {#change-service-account}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Select the cluster and click **Edit** in the top panel.

   {% if audience != "internal" %}

   1. Select the desired service account from the list or [create a new one](../../iam/operations/sa/create.md). For more information about setting up service accounts, see [{#T}](s3-access.md).

   {% else %}

   1. Select the desired service account from the list or create a new one. For more information about setting up service accounts, see [{#T}](s3-access.md).

   {% endif %}

        {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

{% endlist %}


## Changing the host class {#change-resource-preset}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Select the cluster and click **Edit** in the top panel.
   1. To change the class of {{ ES }} hosts with the *Data node* role:
      1. Go to the **Data node** tab.
      1. Under **Host class**, select the class for the host.
   1. To change the class of {{ ES }} hosts with the *Master node* role:
      1. Go to the **Master node** tab.
      1. Under **Host class**, select the class for the host.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [host class](../concepts/instance-types.md) for the cluster:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-es }} cluster update --help
      ```

   1. Set the desired host class with the _Data node_ and _Master node_ roles in the update cluster command:

      ```bash
      {{ yc-mdb-es }} cluster update <cluster ID or name> \
        --datanode-resource-preset <class of hosts with the Data node role> \
        --masternode-resource-preset <class of hosts with the Master node role>
      ```

   You can request a cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mes-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

   1. In the {{ mes-name }} cluster description, change the `resource_preset_id` attribute value under `config.data_node.resources` or `config.master_node.resources`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
        ...
        config {
          data_node {
            resources {
              resource_preset_id = "<host class>"
              ...
            }
          }

          master_node {
            resources {
              resource_preset_id = "<host class>"
              ...
            }
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Host class in the parameters:
      * `configSpec.elasticsearchSpec.dataNode.resources.resourcePresetId` (for hosts with the *Data node* role).
      * `configSpec.elasticsearchSpec.masterNode.resources.resourcePresetId` (for hosts with the *Master node* role).

      To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for `ResourcePreset` resources.

   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## {% if audience != "internal" %}Increasing{% else %}Modifying{% endif %} storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Management console

   To {% if audience != "internal" %}increase{% else %}modify{% endif %} a cluster's storage size:

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Select the cluster and click **Edit** in the top panel.
   1. To {% if audience != "internal" %}increase{% else %}modify{% endif %} disk size for {{ ES }} hosts with the *Data node* role:
      1. Go to the **Data node** tab.
      1. Under **Storage**, specify the disk size.
   1. To {% if audience != "internal" %}increase{% else %}modify{% endif %} disk size for {{ ES }} hosts with the *Master node* role:
      1. Go to the **Master node** tab.
      1. Under **Storage**, specify the disk size.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To {% if audience != "internal" %}increase{% else %}modify{% endif %} a cluster's storage size:

   1. View a description of the CLI update configuration command:

      ```bash
      {{ yc-mdb-es }} cluster update --help
      ```

   1. Specify new [storage settings](../concepts/storage.md) for hosts with the _Data node_ and _Master node_ roles in the update cluster command:

      ```bash
      {{ yc-mdb-es }} cluster update <cluster ID or name> \
        --datanode-disk-size <storage size in GB for hosts with the Data node role> \
        --masternode-disk-size <storage size in GB for hosts with the Master node role>
      ```

   You can request a cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   To {% if audience != "internal" %}increase{% else %}modify{% endif %} a cluster's storage size:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mes-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

   1. In the {{ mes-name }} cluster description, change the `disk_size` attribute value under `config.data_node.resources` or `config.master_node.resources`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
        ...
        config {
          data_node {
            resources {
              disk_size = <storage size, GB>
              ...
            }
          }

          master_node {
            resources {
              disk_size = <storage size, GB>
              ...
            }
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

{% if api != "noshow" %}

- API

   To {% if audience != "internal" %}increase{% else %}modify{% endif %} a cluster's storage size, use the [update](../api-ref/Cluster/update.md) method and pass the following in in the call:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Required storage size (in bytes) in the parameters:
      * `configSpec.elasticsearchSpec.dataNode.resources.diskSize` (for hosts with the *Data node* role).
      * `configSpec.elasticsearchSpec.masterNode.resources.diskSize` (for hosts with the *Master node* role).
   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endif %}

{% endlist %}

## Changing {{ ES }} settings {#change-elasticsearch-config}

You can change the DBMS settings of the hosts in your cluster.

{% note warning %}

You cannot update {{ ES }} settings with the {{ ES }} API.

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mes-name }}**.
   1. Select a cluster and click **![Pencil](../../_assets/pencil.svg) Edit cluster** on the top panel.
   1. Change the [{{ ES }} settings](../concepts/settings-list.md) by clicking **Configure** under **DBMS settings**.
   1. Click **Save**.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change [{{ ES }} server](../concepts/settings-list.md) settings:

   1. View the full list of settings specified for the cluster:

      ```bash
      {{ yc-mdb-es }} cluster get <cluster ID or name> --full
      ```

   1. View a description of the CLI's update cluster configuration command:

      ```bash
      {{ yc-mdb-es }} cluster update-config --help
      ```

   1. Set the required parameter values:

      ```bash
      {{ yc-mdb-es }} cluster update-config <cluster ID or name> \
         --set <parameter1 name>=<value1>,<parameter2 name>=<value2>,...
      ```

      All the supported parameters are listed in [{#T}](../concepts/settings-list.md).

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. You can retrieve it with a [list of clusters in the folder](./cluster-list.md#list-clusters).
   * Required DBMS values in the `configSpec.elasticsearchSpec.dataNode.elastcsearchConfig_7` parameter.
   * List of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

   All supported settings are described in [{#T}](../concepts/settings-list.md) and the [API reference](../api-ref/Cluster/update.md).

{% endlist %}

## Changing the admin password {#change-admin-password}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Select the cluster and click **Edit** in the top panel.
   1. Enter a new password for `admin` in the **User** section.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the `admin` password for a cluster:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-es }} cluster update --help
      ```

   1. Specify a new password in the cluster update command using one of the available methods:

      * Entering a password in interactive mode.

         ```bash
         {{ yc-mdb-es }} cluster update <cluster name> \
           --read-admin-password
         ```

      * Entering a password as plain text (less secure method).

         ```bash
         {{ yc-mdb-es }} cluster update <cluster name> \
           --admin-password <new password>
         ```

      * Generating a password automatically. The generated password will be output to the console.

         ```bash
         {{ yc-mdb-es }} cluster update <cluster name> \
           --generate-admin-password
         ```

   {{ mes-short-name }} will launch the `admin` password update for a cluster.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mes-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

   1. In the {{ mes-name }} cluster description, change the `admin_password` attribute value under `config`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
        ...
        config {
          admin_password = "<new administrator password>"
          ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The new password in the `configSpec.adminPassword` parameter. The maximum password length is 128 characters.
   * List of settings to update (`configSpec.adminPassword` in this case) in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Select the cluster and click **Edit** in the top panel.
   1. To change the service account used to work with the cluster, select an account from the drop-down list.
   1. Change additional cluster settings:

      {% include [MES cluster extra settings](../../_includes/mdb/mes/extra-settings.md) %}

   1. Set the DBMS settings:

      You can configure the `Fielddata cache size` parameter: a percentage or an absolute value of the dynamic memory structure allocated for the `fielddata` cache. For example, 10% or 512 MB.

   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-es }} cluster update --help
      ```

   1. Run the command with a list of settings to update:

      ```bash
      {{ yc-mdb-es }} cluster update <cluster ID or name> \
         --plugins <plugin 1 name>,...,<plugin N name> \
         --maintenance-window type=<maintenance type: anytime or weekly>,`
                             `day=<day of week for weekly>,`
                             `hour=<hour for weekly> \
         --deletion-protection=<cluster deletion protection: true or false>
      ```

   You can change the following settings:

   * `--plugins`: List of [{{ ES }} plugins](cluster-plugins.md#elasticsearch) available in the cluster. Plugins that are not included in the list will be disabled.

   * `--maintenance-window`: Settings for the [maintenance window](../concepts/maintenance.md) (including disabled clusters):

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

   * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [Cluster deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

   You can find out the cluster ID and name in the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mes-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

   1. To change the service account used for cluster operations, specify the ID of another service account in the `service_account_id` cluster description field:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
        ...
        service_account_id = <ID of another service account>
      }
      ```

   1. {% include [Maintenance window](../../_includes/mdb/mes/terraform/maintenance-window.md) %}

   1. To change the list of [{{ ES }} plugins](cluster-plugins.md#elasticsearch), change the value of the `plugins` parameter under `config` in the cluster description:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
        ...
        config {
          plugins = [ "<list of plugin names>" ]
        }
      }
      ```

      Plugins that are not included in the list will be disabled.

   1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
        ...
        deletion_protection = <protect cluster from deletion: true or false>
      }
      ```

      {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).

   * The list of [{{ ES }} plugins](cluster-plugins.md#elasticsearch) in the `plugins` parameter.

   {% if audience != "internal" %}

   * ID of the [service account](../../iam/concepts/users/service-accounts.md) used for cluster operations in the `serviceAccountId` parameter.

   {% else %}

   * ID of the service account used for cluster operations in the `serviceAccountId` parameter.

   {% endif %}

   * Settings for the [maintenance window](../concepts/maintenance.md) (including for disabled clusters) in the `maintenanceWindow` parameter.

   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [Cluster deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
