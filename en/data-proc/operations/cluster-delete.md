---
title: "Deleting a {{ dataproc-name }} cluster"
description: "You can delete a {{ dataproc-name }} cluster along with all the data stored in it. Note that data backups are not created automatically: if you want to save data for cluster recovery or future use, you can do that, for example, using {{ objstorage-full-name }}."
---

# Deleting a {{ dataproc-name }} cluster

You can delete a cluster along with all the data stored in it. Note that data backups are not created automatically: if you want to save data for cluster recovery or future use, you can do that, for example, using [{{ objstorage-full-name }}]({{ link-cloud-services }}/storage).

To delete a {{ dataproc-name }} cluster, the user must be assigned the `editor` and `dataproc.agent` roles. For more information, see the [role description](../security/index.md#roles-list).

## Before deleting a cluster {#before-you-delete}

[Disable deletion protection](./cluster-update.md) for the cluster if it is enabled.

## Deleting a cluster {#delete}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the required cluster and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
   1. (Optional) Specify the [decommissioning](../concepts/decommission.md) timeout.
   1. In the window that opens, click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a cluster, run the command:

   ```bash
   {{ yc-dp }} cluster delete <cluster ID or name>
   ```

   You can request the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

{% endlist %}