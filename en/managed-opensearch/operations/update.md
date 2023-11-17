---
title: "Changing {{ OS }} cluster settings"
description: "After creating an {{ OS }} cluster, you can edit its service settings."
keywords:
  - OpenSearch settings
  - OpenSearch cluster settings
  - OpenSearch
---

# Changing {{ OS }} cluster settings

After creating a cluster, you can edit its service settings. You can also change the [host group configuration](host-groups.md#update-host-group) and [host group availability zone](host-migration.md) and change the [{{ OS }} version](cluster-version-update.md).

## Updating service settings {#change-service-settings}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Select a cluster and click ![pencil](../../_assets/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** on the top panel.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**:

      1. Change the `admin` user password.
      1. If required, change additional cluster settings:

         {% include [extra-settings](../../_includes/mdb/mos/extra-settings.md) %}

   1. Click **{{ ui-key.yacloud.common.save }}**.

- API

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
