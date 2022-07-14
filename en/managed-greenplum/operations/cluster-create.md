# Creating clusters

A {{ mgp-name }} cluster consists of master hosts that accept client requests and segment hosts that provide data processing and storage.

For more information, see [{#T}](../concepts/index.md).

## How to create a {{ mgp-name }} cluster {#create-cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a database cluster.
   1. Select **{{ mgp-name }}**.
   1. Click **Create cluster**.
   1. Enter a name for the cluster. It must be unique within the folder.
   1. (optional) Enter a cluster description.
   1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
      * `PRODUCTION`: For stable versions of your apps.
      * `PRESTABLE`: For testing, including the {{ mgp-full-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
   1. Select a {{ GP }} version.
      {% if product == "yandex-cloud" %}
   1. (optional) Select groups of [dedicated hosts](../../compute/concepts/dedicated-host.md) to deploy the cluster.

      {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}
      {% endif %}

   1. Under **Network settings**:
      * Select the cloud network for the cluster.
      * In the **Security groups** parameter, specify the [security group](../operations/connect.md#configuring-security-groups) that contains the rules allowing all incoming and outgoing traffic over any protocol from any IP address.

         {% note alert %}

         For a {{ mgp-name }} cluster to work properly, at least one of its security groups should have rules allowing all incoming and outgoing traffic from any IP address.

         {% endnote %}

      * Select the availability zone and subnet for the cluster. To create a new subnet, click **Create new** subnet next to the availability zone.
      * Select **Public access** to allow connecting to the cluster from the internet.
   1. Specify the administrative user's settings. This is a special user that is needed to manage clusters and cannot be deleted. For more information, see [{#T}](../concepts/cluster-users.md).

      * **Username** may contain Latin letters, numbers, hyphens, and underscores, but can't begin with a hyphen. It can be between 1 and 32 characters long.

         {% note info %}

         Such names as `admin`, `gpadmin`, `mdb_admin`, `mdb_replication`, `monitor`, `none`, `postgres`, `public`, `repl` are reserved for {{ mgp-name }}. You cannot create users with these names.

         {% endnote %}

      * **Password** must be between 8 and 128 characters.

   1. If necessary, configure additional cluster settings:

      {% include [extra-settings](../../_includes/mdb/mgp/extra-settings.md) %}

   1. Specify the master host parameters on the **Master** tab. For the recommended configuration, see [Calculating the cluster configuration](calculate-specs.md#master).

      * The host class: it defines the technical properties of the VMs where the cluster's master hosts will be deployed.

   1. Specify the parameters of segment hosts on the **Segment** tab. For the recommended configuration, see [Calculating the cluster configuration](calculate-specs.md#segment).

      * The number of segment hosts.
      * The number of segments per host. The maximum value of this parameter depends on the host class.
      * The host class: it defines the technical properties of the VMs where the cluster's segment hosts will be deployed.

   1. Under **Storage**:

      * Select the [storage type](../concepts/storage.md).

         {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

      * Select the size of storage to be used for data.

   1. Click **Create cluster**.

- API

   Use the [create](../api-ref/Cluster/create.md) API method and pass the following information in the request:

   * In the `folderId` parameter, the ID of the folder where the cluster should be placed.
   * The cluster name in the `name` parameter.
   * The environment of the cluster, in the `environment` parameter.
   * {{ GP }} version, in the `config.version` parameter.
   * Username, in the `userName` parameter.
   * User password, in the `userPassword` parameter.
   * Network ID, in the `networkId` parameter.
   * [Security group](../concepts/network.md#security-groups) identifiers, in the `securityGroupIds` parameter.
   * Configuration of master hosts, in the `masterConfig` parameter.
   * Configuration of segment hosts, in the `segmentConfig` parameter.

   If necessary, pass additional cluster settings:

   * Public access settings, in the `assignPublicIp` parameter.
   * Backup window settings, in the `config.backupWindowStart` parameter.
   * Settings of access from [{{ datalens-full-name }}](../../datalens/concepts/index.md), in the `config.access.dataLens` parameter.
   * {% include [Maintenance window](../../_includes/mdb/api/maintenance-window.md) %}
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
