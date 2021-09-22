# Getting started with {{ mgp-short-name }}

To get started with the service:

1. [Create a cluster](#cluster-create).
1. [Connect to the cluster](#connect).

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if you don't have an account yet.

1. If you don't have a folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. You can only connect to the cluster from within {{ yandex-cloud }}. To do this, [create](../compute/operations/vm-create/create-linux-vm.md) an intermediate VM running Linux on the same cloud network as the {{ GP }} cluster.

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via SSH.

1. Install the necessary dependencies and the PostgreSQL client:

    ```bash
    sudo apt update && sudo apt install postgresql-client --yes
    ```

## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ mgp-name }}**.
1. Click **Create cluster**.

{% if state == "public-preview" %}

1. Enter a name for the cluster in the **Cluster name** field. It must be unique within the folder.

1. (Optional) Enter a cluster description.

1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
    * `PRODUCTION`: For stable versions of your apps.
    * `PRESTABLE`: For testing, including the {{ mgp-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

1. Select the DBMS version.

1. Under **Network settings**:
    * Select a network.
    * Select subnets in each availability zone for this network. To [create a new subnet](../vpc/operations/subnet-create.md), click **Create new subnet** next to the availability zone.
    * Under **Security groups**, specify the [default security group](../vpc/concepts/security-groups.md#default-security-group). The default group already contains all the settings required for the cluster to work.

1. Enter the username and password.

    {% include [username-and-password-limits](../_includes/mdb/mgp/note-info-user-name-and-pass-limits.md) %}

1. Specify the host parameters on the **Master** and **Segment** tabs.

    {% list tabs %}

    * Master

        * Specify the number of master hosts:
            * `1` to create a cluster without master host mirroring.
            * `2` to create a cluster with master host mirroring.

        * Specify the host class: it defines the technical properties of the virtual machines where the cluster's master hosts will be deployed. Changing this parameter changes the properties of all the previously created master hosts.

        * Under **Storage**:

            * Select the type of storage, either a more flexible network type (`network-hdd` or `network-ssd`) or faster local SSD storage (`local-ssd`).

                Which selecting the type of storage, note that local storage can only be changed in 100 GB increments.

            * Select the size of storage to be used for data.

    * Segment
        * Specify the number of segment hosts.
        * Specify the number of segments per host. The maximum value of this parameter depends on the host class.
        * Specify the host class: it defines the technical properties of the virtual machines where the cluster's segment hosts will be deployed. Changing this parameter changes the properties of all the previously created segment hosts.
        * Under **Storage**:
            * Select the type of storage, either a more flexible network type (`network-hdd` or `network-ssd`) or faster local SSD storage (`local-ssd`).

                Which selecting the type of storage, note that local storage can only be changed in 100 GB increments.

            * Select the size of storage to be used for data.

    {% endlist %}

1. If necessary, configure additional cluster settings:

    * **Backup start time (UTC)**: UTC time when you want to start creating a cluster backup (in 24-hour format). If the time is not set, the backup will start at 22:00 UTC.

    * **Access from {{ datalens-name }}**: enable this option to be able to analyze cluster data in [{{ datalens-full-name }}](../datalens/concepts/index.md).

1. Click **Create cluster**.

{% else %}

1. Set the cluster parameters and click **Create cluster**. {% if audience == "draft" %}This process is described in detail in [{#T}](operations/cluster-create.md).{% endif %}
 
{% endif %}

1. Wait until the cluster is ready: its status on the {{ mgp-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the cluster {#connect}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the intermediate VM via SSH.

1. Connect to the {{ GP }} cluster master host using `psql`:

    ```bash
    psql --host <master host FQDN> \
         --username <username> \
         --dbname postgres
    ```

    To get the master host FQDN:
    1. Go to the folder page and select **{{ mgp-name }}**.
    1. Click on the name of the cluster you need and select the **Hosts** tab.

1. After connecting, run the following query:

    ```sql
    SELECT version();
    ```

    The cluster will return the {{ PG }} and {{ GP }} versions used.

{% if state != "public-preview" %}

## What's next {#whats-next}

* Read about [service concepts](./concepts/index.md).
{% if audience == "draft" %}* Learn more about [creating clusters](./operations/cluster-create.md) and [connecting to clusters](./operations/connect.md).{% endif %}

{% endif %}

{% include [greenplum-trademark](../_includes/mdb/mgp/trademark.md) %}

