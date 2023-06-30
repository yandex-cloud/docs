# Deleting a {{ metastore-full-name }} cluster

You can delete a {{ metastore-name }} cluster along with its stored data.

## Before deleting a cluster {#before-you-delete}

Disable deletion protection for the cluster if it is enabled.

## Delete the cluster {#delete}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. In the left-hand panel, click ![image](../../../_assets/data-proc/metastore.svg) **Metastore server**.
   1. Click the ![image](../../../_assets/options.svg) icon for the desired cluster and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
   1. In the window that opens, click **Delete**.

{% endlist %}
