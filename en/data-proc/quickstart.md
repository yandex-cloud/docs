# Getting started with {{ dataproc-name }}

To get started with the service:

1. [Create a cluster](#cluster-create).
1. [Connect to the cluster](#connect).
1. [Connect to component interfaces](#connect-components).


## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or create an account if you do not have one yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Set up a NAT gateway](../vpc/operations/create-nat-gateway.md) in the subnet to host the cluster.

1. If you use security groups, [configure them](operations/cluster-create.md#change-security-groups).

   {% include [preview-pp.md](../_includes/preview-pp.md) %}

1. You can connect to an {{ dataproc-name }} cluster from both inside and outside {{ yandex-cloud }}:

   * To connect from inside {{ yandex-cloud }}, create a [Linux-](../compute/quickstart/quick-create-linux.md) virtual machine, which must be in the same network as the cluster.

   * To be able to connect to the cluster from the internet, request public access to subclusters when creating the cluster.

   {% note info %}

   The next step assumes that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via SSH.


## Create a cluster {#cluster-create}

To create a cluster:

1. In the management console, open the folder to create your cluster in and select **{{ dataproc-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Wait until the cluster is ready for use: its status changes to **Alive**. This may take some time.

## Connect to the cluster {#connect}

To connect to a cluster:


1. If you are using security groups for a cloud network, [configure them](operations/connect.md#configuring-security-groups) to enable all relevant traffic between the cluster and the connecting host.

   {% include [preview-pp.md](../_includes/preview-pp.md) %}


1. Copy the SSL key that you specified when creating the {{ dataproc-name }} cluster to the VM.

1. Connect to the cluster via SSH and make sure that Hadoop commands are executed. Depending on the image version, specify the username:

   * For version 2.0: `ubuntu`.
   * For version 1.4: `root`.

For more information about connecting to {{ dataproc-name }} clusters, see [{#T}](operations/connect.md).

## Connect to component interfaces {#connect-components}

To connect to the {{ dataproc-name }} component interfaces using the web interface:

1. [Enable the setting](operations/connect-interfaces.md#ui-proxy-enable) **UI Proxy** in the cluster.
1. Get a list of interface URLs.

To connect to the {{ dataproc-name }} component interfaces via SSH with port forwarding:

1. Create an intermediate VM with a public IP address in the same network as the cluster and with a security group that allows incoming and outgoing traffic through the component ports.
1. Connect to the created VM via SSH with a redirect to the appropriate ports of the {{ dataproc-name }} host. Depending on the image version, specify the username:

   * For version 2.0: `ubuntu`.
   * For version 1.4: `root`.

For more information about connecting to {{ dataproc-name }} cluster component interfaces, see [{#T}](operations/connect-interfaces.md).

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating clusters](operations/cluster-create.md) and [working with jobs](operations/jobs.md).
* [Create a {{ metastore-full-name }} cluster](operations/metastore/cluster-create.md).
