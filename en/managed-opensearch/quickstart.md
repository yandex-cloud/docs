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

1. You can connect to an {{ OS }} cluster from both inside {{ yandex-cloud }} and the internet:

   * To connect from inside {{ yandex-cloud }}, [create a Linux VM](../compute/quickstart/quick-create-linux.md) in the same network as the cluster.

   * To connect to a cluster from the internet, [request public access](operations/cluster-create.md) to hosts with the `DATA` [role](concepts/hosts-roles.md#data) when creating the cluster.

{% note info %}

These instructions assume that you're connecting to the cluster from the internet.

{% endnote %}

## Create a cluster {#create-cluster}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
1. Select **{{ mos-name }}**.
1. Click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Set the cluster parameters.

   To use the {{ OS }} Dashboards web interface, request public access. To do this, go to **Resources** → **Dashboards** and select **Public access**.

   {% if audience != "internal" %}

   {% include [mos-tip-public-dashboards](../_includes/mdb/mos/public-dashboards.md) %}

   {% endif %}

1. Click **Create**.
1. Wait until the cluster is ready: its status on the {{ mos-name }} dashboard changes to **Creating** and then to **Alive**. This may take some time.

{% if audience != "internal" %}

## Configure security groups {#configure-security-groups}

{% include notitle [Configuring security groups](../_includes/mdb/mos/configuring-security-groups.md) %}

{% endif %}

## Connect to the cluster {#connect}

It is assumed that all the steps below are performed on Linux.

To connect to a cluster:

1. Install an SSL certificate:

   {% include [install-certificate](../_includes/mdb/mos/install-certificate.md) %}

1. Connect to the cluster using [cURL](https://curl.haxx.se/):

   {% include [default-connstring](../_includes/mdb/mos/default-connstring.md) %}

   To connect, enter the `admin` username and password used when [creating your cluster](#create-cluster).

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
   1. Enter the `admin` username and password that you set when [creating a cluster](#create-cluster).

1. Explore a set of sample data:

   1. On the {{ OS }} Dashboards welcome screen, click **Add sample data**.
   1. Next, click **View data** for the desired dataset.

Learn more about working with {{ OS }} Dashboards, in the [{{ OS }} documentation]({{ os.docs }}/dashboards/index/).

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to a cluster](operations/connect.md).
