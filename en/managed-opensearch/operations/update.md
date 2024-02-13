---
title: "Changing {{ OS }} cluster settings"
description: "After creating an {{ OS }} cluster, you can edit its service settings."
keywords:
  - OpenSearch settings
  - OpenSearch cluster settings
  - OpenSearch
---

# Changing {{ OS }} cluster settings

After creating a cluster, you can edit its service settings. You can also change the [host group configuration](host-groups.md#update-host-group) and [host group availability zone](host-migration.md) and update the [{{ OS }} version](cluster-version-update.md).


## Updating service settings {#change-service-settings}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Select a cluster and click ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** on the top panel.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**:

      1. Change the `admin` user password.
      1. If required, change additional cluster settings:

         {% include [extra-settings](../../_includes/mdb/mos/extra-settings.md) %}

   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update service settings:

   1. Get the name and ID of the cluster you need with the list of all {{ OS }} clusters:

      ```bash
      {{ yc-mdb-os }} cluster list
      ```

   1. Update the settings using the command:

      ```bash
      {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
         --maintenance schedule=<maintenance_type>,`
                      `weekday=<day_of_week>,`
                      `hour=<hour_of_day> \
         --service-account-name <service_account_name> \
         --delete-protection <deletion_protection:_true_or_false>
      ```

      Where:

      * `--maintenance`: Maintenance time settings:

         * To allow maintenance at any time, specify `--maintenance schedule=anytime`.
         * To specify the preferred start time for maintenance, specify the `--maintenance schedule=weekly,weekday=<day_of_week>,hour=<hour_in_UTC>` parameter in the command. In this case, maintenance will take place every week on a specified day at a specified time. For example, if you specify `--maintenance schedule=weekly,weekday=mon,hour=14`, maintenance of the cluster will take place every Monday from 13:00 till 14:00.

         Both enabled and disabled clusters undergo maintenance. Maintenance may involve such operations as applying patches or updating DBMS's.

      * `--service-account-name`: Name of the service account.

      * `--delete-protection`: Cluster protection against accidental deletion by a user, `true` or `false`. Cluster deletion protection will not prevent a manual connection to a cluster to delete data.

- API {#api}

   Use the [update](../api-ref/Cluster/update.md) API method and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * New `admin` user password in the `configSpec.adminPassword` parameter.
   * List of plugins in the `configSpec.opensearchSpec.plugins` parameter. The plugins that are not included in the list will be disabled.
   * Settings for access from other services in the `configSpec.access` parameter.

   
   * ID of the [service account](../../iam/concepts/users/service-accounts.md) used for cluster operations in the `serviceAccountId` parameter.


   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   * Settings for the [maintenance window](../concepts/maintenance.md) (including those for disabled clusters) in the `maintenanceWindow` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
