# Deleting a {{ metastore-full-name }} cluster

You can delete a {{ metastore-name }} cluster along with its stored data.

## Before deleting a cluster {#before-you-delete}

Disable deletion protection for the cluster if it is enabled.

## Delete the cluster {#delete}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. In the left-hand panel, select ![image](../../../_assets/data-proc/metastore.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
   1. Click ![image](../../../_assets/options.svg) for the required cluster and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.mdb.cluster.delete-dialog.popup-confirm_button_delete }}**.

{% endlist %}
