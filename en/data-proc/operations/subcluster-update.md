---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Updating subclusters

You can perform the following actions for any subcluster:

* [{#T}](#change-host-number).
* [{#T}](#change-resource-preset).
* [{#T}](#change-autoscaling-rule).
* [{#T}](#change-disk-size).
* [{#T}](#change-sg-set).

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
    1. Specify an optional [decommissioning](../concepts/decommission.md) timeout.
    1. Click **Save changes**.

    {{ dataproc-name }} runs the update subcluster operation. Note that all the hosts in the updated subcluster will be restarted.

{% endlist %}

## Changing the autoscaling rule for Compute subclusters {#change-autoscaling-rule}

You can set up the [autoscaling](../concepts/autoscaling.md) rule for hosts with the `COMPUTENODE` role:

{% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
1. Select a cluster and open the **Subclusters** tab.
1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) for the appropriate subcluster and select **Edit**.
1. Under **Scalability**, enable **Automatic scaling** if it's not activated.
1. Set autoscaling parameters.
1. The default metric used for autoscaling is `yarn.cluster.containersPending`. To enable scaling based on CPU usage, disable the **Default scaling** option and set the target CPU utilization level.
1. Click **Save changes**.

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

## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ dataproc-name }}**.
    1. Click on the name of the cluster you want and select the **Hosts** tab.
    1. Click on the name of the host you want.
    1. Under **Network**, click ![image](../../_assets/vertical-ellipsis.svg) and select **Edit network interface**.
    1. Select the appropriate security groups.
    1. Click **Save**.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](./connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}
