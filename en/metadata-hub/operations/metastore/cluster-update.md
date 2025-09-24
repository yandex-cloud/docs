---
title: How to update a {{ metastore-full-name }} cluster
description: Follow this guide to update a {{ metastore-full-name }} cluster.
---

# Updating an cluster {{ metastore-full-name }}

{% include [Preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to update a cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. In the cluster row, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:
  
        1. Edit the cluster name and description.
        1. Delete or add new [{{ yandex-cloud }} labels](../../../resource-manager/concepts/labels.md).
        1. Select another [service account](../../../iam/concepts/users/service-accounts.md) or create a new one with the `{{ roles.metastore.integrationProvider }}` role.
        1. Switch your {{ metastore-name }} version.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select another [security group](configure-security-group.md) or create a new one.
  1. Under **{{ ui-key.yacloud.metastore.label_resource-preset }}**, update the computing resource configuration for your cluster. The following configurations are available:

        * **standard**: 2 vCPUs and 8 GB RAM
        * **cpu-optimized**: 2 vCPUs and 4 GB RAM

  1. Under **{{ ui-key.yacloud.logging.label_title }}**, enable or disable logging. If logging is enabled, do the following:
      * Specify the log group or folder to write logs to.
      * Select the minimum logging level. 
      
      For more information, see [Transferring cluster logs](logging.md).
  1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, enable or disable cluster deletion protection.
  1. Click **{{ ui-key.yacloud.common.edit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To change a {{ metastore-name }} cluster’s settings:

  1. View the description of the CLI command to update a cluster:
 
      ```bash
      {{ yc-metastore }} cluster update --help
      ```

  1. Provide a list of settings to update in the update cluster command:

      ```bash
      {{ yc-metastore }} cluster update <cluster_name_or_ID> \
         --new-name <cluster_name> \
         --description <cluster_description> \
         --labels <label_list> \
         --service-account-id <service_account_ID> \
         --version <version> \
         --security-group-ids <security_group_IDs> \
         --resource-preset-id <ID_of_computing_resources> \
         --maintenance-window type=<maintenance_type>,`
                              `day=<day_of_week>,`
                              `hour=<hour> \
         --deletion-protection \
         --log-enabled \
         --log-folder-id <folder_ID> \
         --log-min-level <logging_level>
      ```
      Where:

      * `--new-name`: New cluster name.

      {% include [CLI cluster parameters description, part 1](../../../_includes/metadata-hub/metastore-cluster-parameters-cli-part-1.md) %}

      {% include [CLI cluster parameters description, part 2](../../../_includes/metadata-hub/metastore-cluster-parameters-cli-part-2.md) %}

      You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).


{% endlist %}
