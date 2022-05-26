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

        This will enable you to use [{{ objstorage-name }} buckets](../../storage/concepts/bucket.md), [UI Proxy](../concepts/ui-proxy.md), and cluster [autoscaling](../concepts/autoscaling.md).

If you plan to use multiple security groups for a cluster, enable all traffic between these groups.

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts.

{% endnote %}

You can set up security groups for [connections to cluster hosts](connect.md) via an intermediate VM after creating a cluster.

## Create a cluster {#create}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.

   1. Click **Create resource** and select **{{ dataproc-name }} cluster** from the drop-down list.

   1. Name the cluster in the **Cluster name** field. The cluster name must be unique within the folder. Naming requirements:

      {% include [name-format.md](../../_includes/name-format.md) %}

   1. Select a relevant [image version](../concepts/environment.md) and the services you want to use in the cluster.

      {% note info %}

      Note that some components require other components to work. For example, to use Spark, you need YARN.

      {% endnote %}

   1. Enter the public part of your SSH key in the **SSH key** field. For information about how to generate and use SSH keys, see the [{{ compute-full-name }} documentation](../../compute/operations/vm-connect/ssh.md).
   1. Select or create a [service account](../../iam/concepts/users/service-accounts.md) to be granted cluster access.
   1. Select the availability zone for the cluster.
   1. If necessary, configure the [properties of cluster components](../concepts/settings-list.md), jobs, and the environment.
   1. Select the name of the bucket in {{ objstorage-name }} to store dependencies and execution results for the jobs.
   1. Select a network for the cluster.
   1. Select security groups that have the required permissions.

      {% note warning %}

      When creating a cluster, security group settings are verified. If a cluster cannot function with these settings, a warning is issued. A sample functional configuration is provided [above](#change-security-groups).

      {% endnote %}

   1. Enable the **UI Proxy** option to access the [web interfaces of {{ dataproc-name }} components](../concepts/ui-proxy.md).
   1. Cluster logs are saved in [{{ cloud-logging-full-name }}](../../logging/). Select a log group from the list or [create a new one](../../logging/operations/create-group.md).

      To enable this functionality, assign the [cluster service account](../../iam/operations/roles/grant.md#access-to-sa) the `logging.writer` role. For more information, see the [{{ cloud-logging-full-name }} documentation](../../logging/security/index.md).

   1. Configure subclusters: no more than one main subcluster with a **Master** host and subclusters for data storage or computing.

      The roles of `Compute` and `Data` subcluster are different: you can deploy data storage components on `Data` subclusters, and data processing components on `Compute` subclusters. Storage on a `Compute` subcluster is only used to temporarily store processed files.

   1. For each subcluster, you can configure:

      * The number of hosts.
      * The [host class](../concepts/instance-types.md), which dictates the platform and computing resources available to the host.
      * [Storage](../../compute/concepts/filesystem.md) size and type.
      * The subnet of the network where the cluster is located.

         NAT to the internet must be enabled in the subnet for the subcluster with the `Master` role. For more information, see [{#T}](#setup-network).

   1. To access a cluster from the internet, select the **Public access** option in the primary subcluster settings. This way, you can only connect to the cluster over an SSL connection. For more information, see [{#T}](connect.md).

      {% note warning %}

      You can't request public access after creating a cluster.

      {% endnote %}


   1. For `Compute` subclusters, you can specify the [autoscaling](../concepts/autoscaling.md) parameters.

      {% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}

      1. Under **Add subcluster**, click **Add**.
      1. In the **Roles** field, select `COMPUTENODE`.
      1. Under **Scalability**, enable **Automatic scaling**.
      1. Set autoscaling parameters.
      1. The default metric used for autoscaling is `yarn.cluster.containersPending`. To enable scaling based on CPU usage, disable the **Default scaling** option and set the target CPU utilization level.
      1. Click **Add**.

   1. If necessary, configure additional cluster settings:

      **Deletion protection**: Manages cluster protection from accidental deletion by a user.

      Enabled protection will not prevent a manual connection to a cluster to delete data.

   1. Click **Create cluster**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster:

   1. View a description of the CLI's create cluster command:

      ```bash
      yc dataproc cluster create --help
      ```

   1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

      ```bash
      yc dataproc cluster create <cluster name> \
        --zone <cluster availability zone> \
        --service-account-name <cluster service account name> \
        --version <image version> \
        --services <component list> \
        --subcluster name=<name of MASTERNODE subcluster>,`
                    `role=masternode,`
                    `resource-preset=<host class>,`
                    `disk-type=<storage type>,`
                    `disk-size=<storage size, GB>,`
                    `subnet-name=<subnet name>,`
                    `hosts-count=1 \
        --subcluster name=<name of DATANODE subcluster>,`
                    `role=datanode,`
                    `resource-preset=<host class>,`
                    `disk-type=<storage type>,`
                    `disk-size=<storage size, GB>,`
                    `subnet-name=<subnet name>,`
                    `hosts-count=<host count> \
        --bucket <bucket name> \
        --ssh-public-keys-file <path to public portion of SSH key> \
        --security-group-ids <security group ID list> \
        --deletion-protection=<cluster deletion protection: true or false> \
        --log-group-id <log group ID>
      ```

      {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

   1. To create a cluster deployed on [groups of dedicated hosts](../../compute/concepts/dedicated-host.md), specify host IDs as a comma-separated list in the `--host-group-ids` parameter:

      ```bash
      yc dataproc cluster create <cluster name> \
        ...
        --host-group-ids <IDs of dedicated host groups>
      ```

      {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}

- API

   To create a cluster, use the API [../api-ref/Cluster/create](create) method and pass the following in the request:

   * ID of the folder to host the cluster, in the `folderId` parameter.
   * The cluster name in the `name` parameter.
   * Cluster configuration in the `configSpec` parameter, including:
      * [Image](../concepts/environment.md) version, in the `configSpec.versionId` parameter.
      * Component list, in the `configSpec.hadoop.services` parameter.
      * Public portion of the SSH key, in the `configSpec.hadoop.sshPublicKeys` parameter.
      * Subcluster settings, in the `confibSpec.subclustersSpec` parameter.
   * Cluster availability zone, in the `zoneId` parameter.
   * Service account ID, in the `serviceAccountId` parameter.
   * Bucket name, in the `bucket` parameter.
   * Cluster security group IDs, in the `hostGroupIds` parameter.
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

   To create a cluster deployed on [groups of dedicated hosts](../../compute/concepts/dedicated-host.md), pass a list of host IDs in the `hostGroupIds` parameter.

   {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a cluster:

    1. View a description of the CLI's create cluster command:

        ```bash
        yc dataproc cluster create --help
        ```

    1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

        ```bash
        yc dataproc cluster create <cluster name> \
            --zone <cluster availability zone> \
            --service-account-name <cluster service account name> \
            --version <image version> \
            --services <component list> \
            --subcluster name=<name of MASTERNODE subcluster>,`
                        `role=masternode,`
                        `resource-preset=<host class>,`
                        `disk-type=<storage type>,`
                        `disk-size=<storage size, GB>,`
                        `subnet-name=<subnet name>,`
                        `hosts-count=1 \
            --subcluster name=<name of DATANODE subcluster>,`
                        `role=datanode,`
                        `resource-preset=<host class>,`
                        `disk-type=<storage type>,`
                        `disk-size=<storage size, GB>,`
                        `subnet-name=<subnet name>,`
                        `hosts-count=<host count> \
            --bucket <bucket name> \
            --ssh-public-keys-file <path to public portion of SSH key> \
            --security-group-ids <security group ID list> \
            --deletion-protection=<cluster deletion protection: true or false> \
            --log-group-id <log group ID>
        ```

        {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. To create a cluster deployed on [groups of dedicated hosts](../../compute/concepts/dedicated-host.md), specify host IDs as a comma-separated list in the `--host-group-ids` parameter:

        ```bash
        yc dataproc cluster create <cluster name> \
            ...
            --host-group-ids <IDs of dedicated host groups>
        ```

        {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}

- API

    To create a cluster, use the API [create](../api-ref/Cluster/create.md) method and pass the following in the request:

    * ID of the folder to host the cluster, in the `folderId` parameter.
    * The cluster name in the `name` parameter.
    * Cluster configuration in the `configSpec` parameter, including:
        * [Image](../concepts/environment.md) version, in the `configSpec.versionId` parameter.
        * Component list, in the `configSpec.hadoop.services` parameter.
        * Public portion of the SSH key, in the `configSpec.hadoop.sshPublicKeys` parameter.
        * Subcluster settings, in the `confibSpec.subclustersSpec` parameter.
    * Cluster availability zone, in the `zoneId` parameter.
    * Service account ID, in the `serviceAccountId` parameter.
    * Bucket name, in the `bucket` parameter.
    * Cluster security group IDs, in the `hostGroupIds` parameter.
    * Cluster deletion protection settings in the `deletionProtection` parameter.

        {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

    To create a cluster deployed on [groups of dedicated hosts](../../compute/concepts/dedicated-host.md), pass a list of host IDs in the `hostGroupIds` parameter.

    {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}

{% endlist %}

{{ dataproc-name }} runs the create cluster operation. After the cluster status changes to **Running**, you can [connect](connect.md) to any active subcluster using the specified SSH key.
