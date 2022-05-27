# Managing subclusters {{ dataproc-name }}

In addition to [updating the settings](subcluster-update.md) of a particular subcluster, you can create new and delete existing subclusters.

{% note warning %}

Each cluster may have only 1 `MASTERNODE` subcluster, which is why you can't create or delete such subclusters. You can't delete `DATANODE` subclusters, either.

{% endnote %}

## Getting a list of subclusters in a {#list-subclusters} cluster

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.

   1. Click on the name of the desired cluster and then select the **Subclusters** tab.

{% endlist %}


## Adding a subcluster {#add-subcluster}

The number of hosts in {{ dataproc-name }} clusters is limited by [quotas]({{ link-console-quotas }}) by the number of vCPUs and the amount of RAM that VMs in your cloud can use. To view the resources available, go to the [Quotas]({{ link-console-quotas }}) section and find **Compute Cloud**.

To add a subcluster:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ dataproc-name }}** and the desired cluster.
   1. Go to **Subclusters**.
   1. Click **Add subcluster**.
   1. Select the number of hosts.
   1. Select **Roles** in the subcluster. To do this, decide what services should be deployed on the hosts:

      * In `COMPUTENODE` subclusters, you can deploy:
         * YARN NodeManager
         * Spark libraries
      * In `DATANODE` subclusters, you can deploy:
         * HDFS Datanode
         * YARN NodeManager
         * HBase RegionServer
         * Spark libraries

   1. Select the other subcluster settings:
      * The [host class](../concepts/instance-types.md), which dictates the platform and computing resources available to the host.
      * Type and size of storage.
      * Format to specify the network.
      * The subnet of the network where the cluster is located.
      * (optional) Enable **Autoscaling**.

   1. Click **Add subcluster**.

   {{ dataproc-name }} runs the create subcluster operation.

{% endlist %}

## Deleting a subcluster {#remove-host}

{% note warning %}

You can't delete `DATANODE` subclusters

{% endnote %}

{% list tabs %}

- Management console

   To delete a subcluster:

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ dataproc-name }}** and the desired cluster.
   1. Go to **Subclusters**.
   1. Click the ![image](../../_assets/options.svg) icon for the desired subcluster and select **Delete**.
   1. (optionally) Specify the [decommissioning](../concepts/decommission.md) timeout.
   1. Confirm the deletion.

   {{ dataproc-name }} runs the delete subcluster operation.

{% endlist %}
