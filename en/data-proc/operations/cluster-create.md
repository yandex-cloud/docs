# Creating a {{ dataproc-name }} cluster

## Configure a network {#setup-network}

In the subnet that the {{ dataproc-name }} subcluster will connect to with the `Master` role, [enable NAT to the internet](../../vpc/operations/enable-nat.md). This will enable the subcluster to interact with {{ yandex-cloud }} services or hosts on other networks.

## Configure security groups {#change-security-groups}

{% note warning %}

Security groups must be created and configured before creating a cluster. If the selected security groups don't have the required rules, {{ yandex-cloud }} disables cluster creation.

{% endnote %}

1. [Create](../../vpc/operations/security-group-create.md) one or more security groups for cluster service traffic.

1. [Add rules](../../vpc/operations/security-group-update.md#add-rule):

    * One rule for inbound and outbound service traffic:

        * Port range: `{{ port-any }}`.
        * Protocol: `Any`.
        * Source type: `Security group`.
        * Destination: Current security group (`Self`).

    * A separate rule for outgoing HTTPS traffic:

        * Port range: `{{ port-https }}`.
        * Protocol: `TCP`.
        * Source type: `CIDR`.
        * Destination: `0.0.0.0/0`.

        This will allow you to use [{{ objstorage-name }} buckets](../../storage/concepts/bucket.md), [UI Proxy](../concepts/ui-proxy.md), and [automatic scaling](../concepts/autoscaling.md) of clusters.

If you plan to use multiple security groups for a cluster, enable all traffic between these groups.

{% note info %}

You can set more detailed rules for security groups, such as to allow traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts.

{% endnote %}

You can set up security groups for [connections to cluster hosts](./connect.md) via an intermediate VM after creating a cluster.

## Create a cluster {#create}

{% list tabs %}

* Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.

  1. Click **Create resource** and select **{{ dataproc-name }} cluster** from the drop-down list.

  1. Enter a name for the cluster in the **Cluster name** field. The cluster name must be unique within the folder.

  1. Select a relevant [image version](../concepts/environment.md) and the components you want to use in the cluster.

     {% note info %}

     Note that some components require other components to work. For example, to use Spark, you need YARN.

     {% endnote %}

  1. Enter the public part of your SSH key in the **Public key** field. For information about how to generate and use SSH keys, see the [{{ compute-full-name }} documentation](../../compute/operations/vm-connect/ssh.md).

  1. Select or create a [service account](../../iam/concepts/users/service-accounts.md) that you want to grant access to the cluster.

  1. Select the availability zone for the cluster.

  1. If necessary, configure the [properties of cluster components, jobs, and the environment](../concepts/settings-list.md).

  1. Select or create a network for the cluster.

  1. Select security groups that have the required permissions.

      {% note warning %}

      When creating a cluster, security group settings are verified. If a cluster cannot function with these settings, you get a warning. See [above](#change-security-groups) for an example of working settings.

      {% endnote %}

  1. Enable the **UI Proxy** option to access the [web interfaces of {{ dataproc-name }} components](../concepts/ui-proxy.md).

  1. To send cluster logs to [{{ cloud-logging-name }}](../../logging/), select a log group from the list. If necessary, [create a new log group](../../logging/operations/create-group.md).

      To enable this feature, [assign the cluster service account](../../iam/operations/roles/grant.md#access-to-sa) the `logging.writer` role. For more information, see the [{{ cloud-logging-full-name }} documentation](../../logging/security/index.md).

  1. Configure subclusters: no more than one main subcluster with a **Master** host and subclusters for data storage or computing.

     The roles of `Compute` and `Data` subcluster are different: you can deploy data storage components on `Data` subclusters, and data processing components on `Compute` subclusters. Storage on a `Compute` subcluster is only used to temporarily store processed files.

  1. For each subcluster, you can configure:

     * The number of hosts.
     * [The host class](../concepts/instance-types.md), which dictates the platform and computing resources available to the host.
     * Storage size and type.
     * A subnet.

       NAT to the internet must be enabled in the subnet for the subcluster with the `Master` role. To learn more, see [{#T}](#setup-network).

  1. For `Compute` subclusters, you can specify the [autoscaling](../concepts/autoscaling.md) parameters.

     {% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}
	 
     1. Under **Add subcluster**, click **Add**.
     1. In the **Roles** field, select _COMPUTENODE_.
     1. Under **Scalability**, enable **Automatic scaling**.
     1. Set autoscaling parameters.
     1. The default metric used for autoscaling is `yarn.cluster.containersPending`. To enable scaling based on CPU usage, disable the **Default scaling** option and set the target CPU utilization level.
     1. Click **Add**.

  1. If necessary, configure additional cluster settings:

      **Deletion protection**: Manages cluster protection from accidental deletion by a user.

      Enabled protection will not prevent a manual connection to a cluster to delete data.

  1. Click **Create cluster**.

{% endlist %}

{{ dataproc-name }} runs the create cluster operation. After the cluster status changes to **Running**, you can [connect](connect.md) to any active subcluster using the specified SSH key.

