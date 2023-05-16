---
noIndex: true
---

# Deleting a {{ metastore-name }} server

You can delete a server along with all the data stored on it.

## Before deleting a server {#before-you-delete}

Disable deletion protection for the server if it is enabled.

## Deleting a server {#delete}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. In the left-hand panel, click ![image](../../../_assets/data-proc/metastore.svg) **Metastore server**.
   1. Click ![image](../../../_assets/options.svg) for the appropriate server and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
   1. Confirm server deletion.

{% endlist %}
