# Getting started with {{ mos-name }}

To get started with the service:
1. [{#T}](#create-cluster).
1. [{#T}](#configure-security-groups).
1. [{#T}](#connect).
1. [{#T}](#dashboards-connect).

## Before you begin {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}) or register if you haven't yet.

1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. Connect to the {{ OS }} cluster. You can do this both from {{ yandex-cloud }} and the internet:

   * To connect from inside {{ yandex-cloud }}, [create a Linux VM](../compute/quickstart/quick-create-linux.md) in the same network as the cluster.

   {% if stage == "preview" %}

   * To connect to a cluster from the internet, when creating a cluster, request public access to hosts with the _Data node_ role.

   {% else %}

   * To connect to a cluster from the internet, when creating a cluster, [request public access](operations/cluster-create.md#change-data-node-settings) to hosts with the [_Data node_ role](concepts/hosts-roles.md#data-node).

   {% endif %}

{% note info %}

These instructions assume that you're connecting to the cluster from the internet.

{% endnote %}

## Create a cluster {#create-cluster}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
1. Select **{{ mos-name }}**.
1. Click **Create cluster**. {% if stage != "preview" %} This process is described in detail in [{#T}](operations/cluster-create.md). {% endif %}
1. Set the cluster parameters.

   To use the {{ OS }} Dashboards web interface, request public access. To do this, go to **Resources** → **Data node** and select **Public access**.

   {% include [mos-tip-public-dashboards](../_includes/mdb/mos/tip-connecting-to-public-dashboards.md) %}

1. Click **Create**.
1. Wait until the cluster is ready: its status on the {{ mos-name }} dashboard changes to **Creating** and then to **Alive**. This may take some time.

## Configure security groups {#configure-security-groups}

{% if stage == "preview" %}

Configure security groups for the cloud network to enable all the relevant traffic between the cluster and the connecting host.

{% else %}

[Configure security groups](operations/cluster-connect.md#configuring-security-groups) for the cloud network to enable all the relevant traffic between the cluster and the connecting host.

{% endif %}

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the internet

   [Configure all the cluster security groups](../vpc/operations/security-group-add-rule.md) to allow incoming traffic from any IP on ports 443 (Dashboards) and 9200 ({{ OS }}). To do this, create the following rules for incoming traffic:

   - Port range: `443`, `9200`.
   - Protocol: `TCP`.
   - Source: `CIDR`.
   - CIDR blocks: `0.0.0.0/0`.

   A separate rule is created for each port.

- With a VM in Yandex.Cloud

   1. [Configure all security groups](../vpc/operations/security-group-add-rule.md) of your cluster to allow incoming traffic on ports 443 (Dashboards) and 9200 ({{ OS }}) from the security group where your VM is located. To do this, create the following rules for incoming traffic in these security groups:

      - Protocol: `TCP`.
      - Port range: `443`, `9200`.
      - Source: `Security group`.
      - Security group: If a cluster and a VM are in the same security group, select `Self` (`Self`) as the value. Otherwise, specify the VM security group.

      A separate rule is created for each port.

   1. [Configure all security groups](../vpc/operations/security-group-add-rule.md) where your VM is located to allow connections to the VM and traffic between the VM and the cluster hosts.

      Example of rules for a VM:

      - For incoming traffic:

         - Port range: `22`, `443`, and `9200`.
         - Protocol: `TCP`.
         - Source: `CIDR`.
         - CIDR blocks: `0.0.0.0/0`.

         A separate rule is created for each port.

      - For outgoing traffic:

         - Port range: `{{ port-any }}`.
         - Protocol: ``Any``.
         - Source type: `CIDR`.
         - CIDR blocks: `0.0.0.0/0`.

         This rule allows all outgoing traffic, which lets you both connect to the cluster and install the certificates and utilities that the VMs need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If the security group settings are incomplete or incorrect, you might lose access the cluster.

{% endnote %}

{% if stage != "preview" %}

For more information about security groups, see [{#T}](concepts/network.md#security-groups).

{% endif %}

## Connect to the cluster {#connect}

It is assumed that all the steps below are performed on Linux.

To connect to a cluster:

1. Install an SSL certificate:

   {% include [install-certificate](../_includes/mdb/mos/install-certificate.md) %}

1. Connect to the cluster using [cURL](https://curl.haxx.se/):

   {% include [default-connstring](../_includes/mdb/mos/default-connstring.md) %}

   To connect, enter the username and password used when [creating a cluster](#create-cluster).

   A message like this is displayed if the connection is successful:

   ```bash
   {
     "name" : "....{{ dns-zone }}",
     "cluster_name" : "...",
     "cluster_uuid" : "...",
     "version" : {
     "distribution" : "opensearch",
     ...
     },
     "tagline" : "The OpenSearch Project: https://opensearch.org/"
   }
   ```

## Connect to {{ OS }} Dashboards {#dashboards-connect}

1. In the browser, connect to the [{{ OS }} Dashboards]({{ os.docs }}/dashboards/index/) web interface:

   1. Make sure that hosts with the `DASHBOARDS` role are publicly accessible.
   1. Install the [SSL certificate](https://{{ s3-storage-host }}{{ pem-path }}) in the browser's trusted root certificate store ([instructions](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) for Mozilla Firefox).
   1. On the cluster page, in the management console, click **OpenSearch Dashboards** and go to `https://c-<{{ OS }} cluster ID>.rw.{{ dns-zone }}>` in your browser.
   1. Enter the username and password that you set when [creating a cluster](#create-cluster).

1. Explore a set of sample data:

   1. On the {{ OS }} Dashboards welcome screen, click **Add sample data**.
   1. Next, click **View data** for the desired dataset.

Learn more about working with {{ OS }} Dashboards, in the [{{ OS }} documentation]({{ os.docs }}/dashboards/index/).

{% if stage != "preview" %}

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to a cluster](operations/connect.md).

{% endif %}
