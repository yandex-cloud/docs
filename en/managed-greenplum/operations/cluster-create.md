# Creating clusters

A {{ mgp-name }} cluster consists of master hosts that accept client requests and segment hosts that provide data processing and storage.

For more information, see [{#T}](../concepts/index.md).

## How to create a Managed Service for Greenplum<sup>®</sup> cluster {#create-cluster}

{% list tabs %}

* Management console

    1. In the management console, select the folder where you want to create a database cluster.

    1. Select **{{ mgp-name }}**.

    1. Click **Create cluster**.

    1. Enter a name for the cluster. It must be unique within the folder.

    1. (Optional) Enter a cluster description.

    1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
        * `PRODUCTION`: For stable versions of your apps.
        * `PRESTABLE`: For testing, including the {{ mgp-full-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

    1. Select the {{ GP }} version.

    1. (Optional) Select groups of [dedicated hosts](../../compute/concepts/dedicated-host.md) to host the cluster on.

        {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

    1. Under **Network settings**:
        * Select the cloud network for the cluster.
        * In the **Security groups** parameter, specify the [default security group](../../vpc/concepts/security-groups.md#default-security-group). It already contains all the settings required for the cluster to work.
        * Select the availability zone and subnet for the cluster. To create a new subnet, click **Create new subnet** next to the desired availability zone.
        * Select **Public access** to allow connecting to the cluster from the internet.

    1. Enter the username and password.

        {% include [username-and-password-limits](../../_includes/mdb/mgp/note-info-user-name-and-pass-limits.md) %}

    1. If necessary, configure additional cluster settings:

        {% include [additional cluster settings](../../_includes/mdb/mgp/extra-settings.md) %}

    1. Specify the master host parameters on the **Master** tab:
        * The number of master hosts:
            * `1` to create a cluster without master host mirroring.
            * `2` to create a cluster with master host mirroring.
        * The host class: it defines the technical properties of the VMs where the cluster's master hosts will be deployed.
        * Under **Storage**:
            * Select the type of storage, either a more flexible network type (`network-hdd`, `network-ssd`, or `network-ssd-nonreplicated`) or faster local SSD storage (`local-ssd`).

              When selecting a storage type, remember that:
              * The size of the local storage can only be changed in 100 GB increments.
              * The size of non-replicated network storage can only be changed in 93 GB increments.

            * Select the size of storage to be used for data.

    1. Specify the parameters of segment hosts on the **Segment** tab.
        * The number of segment hosts.
        * The number of segments per host. The maximum value of this parameter depends on the host class.
        * The host class: it defines the technical properties of the VMs where the cluster's segment hosts will be deployed.
        * Under **Storage**:
            * Select the type of storage, either a more flexible network type (`network-hdd`, `network-ssd`, or `network-ssd-nonreplicated`) or faster local SSD storage (`local-ssd`).

              When selecting a storage type, remember that:
              * The size of the local storage can only be changed in 100 GB increments.
              * The size of non-replicated network storage can only be changed in 93 GB increments.

            * Select the size of storage to be used for data.

    1. Click **Create cluster**.

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

