# Updating subclusters

You can perform the following actions for any subcluster:

* [Change the number of hosts](#change-host-number).

* [Change the host class](#change-resource-preset).

* [Increase storage size](#change-disk-size).

## Changing the number of hosts {#change-host-number}

You can change the number of hosts in `DATANODE` and `COMPUTENODE` clusters:

1. In [management console]({{ link-console-main }}), select the folder with the cluster whose subcluster you want to change.
1. Select {{ dataproc-name }} and the desired cluster.
1. Go to **Subclusters**.
1. Click ![image](../../_assets/options.svg) for the appropriate subcluster and select **Edit**.
1. Enter or select the required number of hosts in the **Hosts** field.
1. Click **Save changes**.

{{ dataproc-name }} runs the add host operation.

## Changing the host class {#change-resource-preset}

You can change the computing power of hosts in a separate subcluster:

{% list tabs %}

- Management console

    To change the [host class](../concepts/instance-types.md) for a subcluster:
    1. In [management console]({{ link-console-main }}), select the folder with the cluster whose subcluster you want to change.
    1. Select {{ dataproc-name }} and the desired cluster.
    1. Go to **Subclusters**.
    1. Click ![image](../../_assets/options.svg) for the appropriate subcluster and select **Edit**.
    1. Select the required platform and configuration under **Host class**.
    1. Click **Save changes**.

    {{ dataproc-name }} runs the update subcluster operation. Note that all the hosts in the updated subcluster will be restarted.

{% endlist %}

## Increasing storage size {#change-disk-size}

You can increase the amount of storage available to each host in a particular subcluster.

{% note info %}

Currently, you cannot reduce storage size. If necessary, re-create the {{ dataproc-name }} subcluster.

{% endnote %}

{% list tabs %}

- Management console

    To change the storage size for a subcluster:
    1. In [management console]({{ link-console-main }}), select the folder with the cluster whose subcluster you want to change.
    1. Select {{ dataproc-name }} and the desired cluster.
    1. Go to **Subclusters**.
    1. Click ![image](../../_assets/options.svg) for the appropriate subcluster and select **Edit**.
    1. Enter or select the required amount of storage under **Storage size**.
    1. Click **Save changes**.

    {{ dataproc-name }} runs the update subcluster operation.

{% endlist %}

