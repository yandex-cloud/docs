---
title: Deleting a {{ dataproc-name }} cluster
description: 'You can delete a {{ dataproc-name }} cluster along with its stored data. Note that data backups are not created automatically: if you want to save data for cluster recovery or future use, you can do that using {{ objstorage-full-name }}.'
---

# Deleting a {{ dataproc-name }} cluster

You can delete a cluster along with all its stored data. Note that data backups are not created automatically: if you want to save data for cluster recovery or future use, you can do that using [{{ objstorage-full-name }}]({{ link-cloud-services }}/storage).

To delete a {{ dataproc-name }} cluster, the user must have the `dataproc.editor` role [assigned](../../iam/operations/roles/grant.md). For more information, see the [role descriptions](../security/index.md#roles-list).

## Before deleting a cluster {#before-you-delete}

[Disable deletion protection](./cluster-update.md) for the cluster if it is enabled.

## Deleting a cluster {#delete}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the cluster in question and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. Optionaly, specify the [decommissioning](../concepts/decommission.md) timeout.
  1. In the window that opens, click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a cluster, run this command:

  ```bash
  {{ yc-dp }} cluster delete <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

{% endlist %}