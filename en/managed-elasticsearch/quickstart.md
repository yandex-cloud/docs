# Getting started with {{ mes-name }}

{% include [Elasticsearch-end-of-service](../_includes/mdb/mes/note-end-of-service.md) %}

To get started with the service:

1. [{#T}](#cluster-create)


1. [{#T}](#configuring-security-groups)


1. [{#T}](#connect)

1. [{#T}](#connect-kibana)


## Getting started {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}) or register if you haven't yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to an {{ ES }} cluster from both inside and outside {{ yandex-cloud }}:

   * To connect from inside {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md) virtual machine, which must be in the same network as the cluster.

   * To connect to a cluster from the internet, when creating a cluster, [request public access](operations/cluster-create.md#change-data-node-settings) to hosts with the [_Data node_ role](concepts/hosts-roles.md#data-node).

{% note info %}

These instructions assume that you're connecting to the cluster from the internet.

{% endnote %}


## Create a cluster {#cluster-create}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
1. Select **{{ mes-name }}**.
1. Click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Set the cluster parameters.

   To access the Kibana web interface, request public access:
   1. Under **Hosts**, change the settings of the host with the _Data node_ role by clicking ![image](../_assets/pencil.svg) for the host.
   1. Select **Public access**.
   1. Click **Save**.

   Public access can be requested for one or more hosts with the role _Data node_. After creating the cluster, you can [connect to Kibana](#connect-kibana) on these hosts. You may also need to [set up security groups](operations/cluster-connect.md#configuring-security-groups) to connect to the cluster. 

   {% include [mes-tip-public-kibana](../_includes/mdb/mes-tip-connecting-to-public-kibana.md) %}

1. Click **Create**.
1. Wait until the cluster is ready: its status on the {{ mes-name }} dashboard changes to **Creating** and then to **Alive**. This may take some time.


## Configure security groups {#configuring-security-groups}

{% note info %}

{% include [security-groups-note](../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

[Configure security groups](operations/cluster-connect.md#configuring-security-groups) for the cloud network to enable all the relevant traffic between the cluster and the connecting host.


## Connect to the cluster {#connect}

It is assumed that all the steps below are performed on Linux.

To connect to a cluster:

1. Install an SSL certificate:

   {% include [install-certificate](../_includes/mdb/mes/install-certificate.md) %}

1. Connect to the cluster using [cURL](https://curl.haxx.se/):

   {% include [default-connstring](../_includes/mdb/mes/default-connstring.md) %}

   To connect, enter the username and password used when [creating a cluster](#cluster-create).

   A message like this is displayed if the connection is successful:

   ```bash
   {
     "name" : "....{{ dns-zone }}",
     "cluster_name" : "...",
     "cluster_uuid" : "...",
     ...
     "tagline" : "You Know, for Search"
   }
   ```

## Connect to Kibana {#connect-kibana}

1. In the browser, connect to the [Kibana](https://www.elastic.co/kibana/features) web interface.

   To connect:
   1. Install the [SSL certificate]({{ crt-web-path }}) in the browser's trusted root certificate store ([instructions](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) for Mozilla Firefox).
   1. In the browser, go to `https://<FQDN of the publicly available {{ ES }} host with the Data node role>`.
   1. Enter the username and password that you set when [creating a cluster](#cluster-create).
1. Upload one or more test datasets to {{ ES }} using Kibana:
   1. On the Kibana welcome screen, click **Try our sample data**.
   1. Add data from one or more datasets by clicking **Add data** for the selected dataset.
1. Explore the data with Kibana and {{ ES }} by clicking **View data** for a dataset.

Learn more about working with Kibana, in the [{{ ES }} documentation](https://www.elastic.co/guide/en/kibana/current/connect-to-elasticsearch.html).

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to a cluster](operations/cluster-connect.md).
