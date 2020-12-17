# Updating subclusters

You can perform the following actions for any subcluster:

* [Change the number of hosts](#change-host-number).

* [Change the host class](#change-resource-preset).

* [Change the autoscaling rule](#change-autoscaling-rule)

* [Increase storage size](#change-disk-size).

## Changing the number of hosts {#change-host-number}

You can change the number of hosts in `DATANODE` and `COMPUTENODE` clusters:

1. In [management console]({{ link-console-main }}), select the folder with the cluster whose subcluster you want to change.
1. Select {{ dataproc-name }} and the desired cluster.
1. Go to **Subclusters**.
1. Click ![image](../../_assets/options.svg) for the appropriate subcluster and select **Edit**.
1. Enter or select the required number of hosts in the **Hosts** field.
1. Specify an optional [decommissioning](../concepts/decommission.md) timeout.
1. Click **Save changes**.

{{ dataproc-name }} runs the add host operation.

## Change the host class {#change-resource-preset}

You can change the computing power of hosts in a separate subcluster:

{% list tabs %}

- Management console

    To change the [host class](../concepts/instance-types.md) for a subcluster:
    1. In [management console]({{ link-console-main }}), select the folder with the cluster whose subcluster you want to change.
    1. Select {{ dataproc-name }} and the desired cluster.
    1. Go to **Subclusters**.
    1. Click ![image](../../_assets/options.svg) for the appropriate subcluster and select **Edit**.
    1. Select the required platform and configuration under **Host class**.
    1. Specify an optional [decommissioning](../concepts/decommission.md) timeout.
    1. Click **Save changes**.

    {{ dataproc-name }} runs the update subcluster operation. Note that all the hosts in the updated subcluster will be restarted.

{% endlist %}

## Changing the autoscaling rule for Compute subclusters {#change-autoscaling-rule}

You can set up the autoscaling rule for `COMPUTENODE` hosts:

1. In the [management console]({{ link-console-main }}), select the folder with the cluster whose subcluster you want to update.
1. Select {{ dataproc-name }} and the desired cluster.
1. Go to **Subclusters**.
1. Click ![image](../../_assets/options.svg) for the appropriate subcluster and select **Edit**.
1. Enter or select the minimum size of the scaling group in the **Minimum number of hosts** field.
1. Enter or select the maximum size of the scaling group in the **Maximum group size** field.
1. Set the utilization measurement period.
1. Enter the instance warmup period in minutes or seconds.
1. Enter the stabilization period.
1. Set the target CPU performance level.
1. Click **Save changes**.

{{ dataproc-name }} saves the autoscaling settings for the subcluster.

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
