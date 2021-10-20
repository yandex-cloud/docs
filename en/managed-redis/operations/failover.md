# Changing the master

If a cluster consists of multiple hosts, you can make a replica of the master if necessary. It takes about two minutes on average to switch, and the cluster is available during that time.

{% note info %}

You can only select a different master in an unsharded cluster.

{% endnote %}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ mrd-name }}**.

    1. Select the cluster and click **Switch master** on the top panel.

        You can also switch masters using the **Switch master** button on the **Hosts** tab.

    1. In the resulting window, select **I want to switch the master** and click **Switch**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To switch the master, run the command:

    ```bash
    {{ yc-mdb-rd }} cluster start-failover \
       --name <cluster name>
    ```

    You can get the cluster name using a [folder cluster list](cluster-list.md).

- API

    You can switch masters in a cluster using the [startFailover](../api-ref/Cluster/startFailover.md) method.

{% endlist %}

