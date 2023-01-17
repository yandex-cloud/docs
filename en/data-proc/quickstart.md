# Getting started with {{ dataproc-name }}

{% if product == "yandex-cloud" %}

{% include [mdb-grant-note](../_includes/mdb/mdb-grant-note.md) %}

{% endif %}

To get started with the service:

1. [Create a cluster](#cluster-create).
1. [Connect to the cluster](#connect).
1. [Connect to component interfaces](#connect-components).

{% if audience != "internal" %}

## Before you begin {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.

1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. {% if audience != "internal" %}[Set up a NAT gateway](../vpc/operations/create-nat-gateway.md){% else %}Set up a NAT gateway{% endif %} in the subnet to host the cluster.
1. [Set up a security group](operations/cluster-create.md#change-security-groups) for the cluster's service traffic.
1. You can connect to an {{ dataproc-name }} cluster from both inside and outside {{ yandex-cloud }}:

   * To connect from inside {{ yandex-cloud }}, create a [Linux-](../compute/quickstart/quick-create-linux.md){% if product == "cloud-il" %}or [Windows-based](../compute/quickstart/quick-create-windows.md){% endif %} virtual machine, which must be in the same network as the cluster.

   * To be able to connect to the cluster from the internet, request public access to subclusters when creating the cluster.

   {% note info %}

   The next step assumes that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via {% if lang == "ru" %}[SSH](../glossary/ssh-keygen.md){% else %}SSH{% endif %}.

{% endif %}

## Create a cluster {#cluster-create}

To create a cluster:

1. In the management console, open the folder to create your cluster in and select **{{ dataproc-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Wait until the cluster is ready for use: its status changes to **Alive**. This may take some time.

## Connect to the cluster {#connect}

To connect to a cluster:

{% if audience != "internal" %}

1. [Configure security groups](operations/connect.md#configuring-security-groups) for the cloud network to enable all the relevant traffic between the cluster and the connecting host.

{% endif %}

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
