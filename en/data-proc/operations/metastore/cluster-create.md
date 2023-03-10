---
noIndex: true
---

# Creating a {{ metastore-name }} server

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a server.
   1. Click **Create resource** and select ![image](../../../_assets/data-proc/data-proc.svg) **{{ dataproc-name }} cluster** from the drop-down list.
   1. In the left panel, click ![image](../../../_assets/data-proc/metastore.svg) **Metastore server**.
   1. Click **Create cluster**.
   1. Enter the server name in the **Cluster name** field. The name must be unique within the folder.
   1. Select the {{ metastore-name }} version from the drop-down list.
   1. Specify the minimum and maximum number of {{ metastore-name }} servers per availability zone.
   1. Under **Network settings**, select the network and subnet where the {{ metastore-name }} server will be hosted.
   1. If needed, enable the server protection from accidental deletion by user.

       With the protection enabled, you will still be able to connect to the server manually and delete the data.

   1. Click **Create**.

{% endlist %}
