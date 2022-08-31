# Getting started with {{ mes-name }}

To get started with the service:
1. [{#T}](#cluster-create).
1. [{#T}](#configuring-security-groups).
1. [{#T}](#connect).
1. [{#T}](#connect-kibana).

{% if audience == "internal" %}

For the internal MDB service, the [web interface]({{ console-link }}) is deployed, where you can manually create a database cluster. For more about [quotas]({{ link-console-quotas }}) and the correlation between ABC services and clouds and folders, see [{#T}](../mdb/access.md).

## Access to DB clusters {#access}

The rules for accessing MDB clusters are already given in [Puncher](https://puncher.yandex-team.ru/): from [Yandex server networks](https://puncher.yandex-team.ru/?id=5ce6a766d89cb04f14acafb3) and for [developers](https://puncher.yandex-team.ru/?id=61f8da624928bbfd5d61d651).

If you need more rules, request access to the `_PGAASINTERNALNETS_` macro. To connect to {{ ES }}, specify port 9200 (Elasticsearch) and/or port 443 (Kibana) in your request.

## CLI setup

If you plan to use the CLI, install and configure it by following the [instructions](../cli/quickstart.md).

If you did everything correctly, the list clusters query should now work:

```bash
{{ yc-mdb-es }} cluster list
```

{% else %}

## Before you start {#before-you-begin}

1. Log in the [management console]({{ link-console-main }}) or sign up if you aren't registered yet.
1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to an {{ ES }} cluster from both inside and outside {{ yandex-cloud }}:
   * To connect from inside {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md)-{% if product == "cloud-il" %} or [Windows](../compute/quickstart/quick-create-windows.md)-{% endif %}based virtual machine, which must be in the same network as the cluster.
   * To connect to a cluster from the internet, [request public access](operations/cluster-create.md#change-data-node-settings) to hosts with the [_Data node_ role](concepts/hosts-roles.md#data-node) when creating a cluster.

{% note info %}

These instructions assume that you're connecting to the cluster from the internet.

{% endnote %}

{% endif %}

## Create a cluster {#cluster-create}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
1. Select the service **{{ mes-name }}**.
1. Click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Set the cluster parameters.

   To access the Kibana web interface, request public access:

   1. Under **Hosts**, change the settings of the host with the _Data node_ role by clicking ![image](../_assets/pencil.svg) for the host.
   1. Select **Public access**.
   1. Click **Save**.

   Public access can be requested for one or more hosts with the role _Data node_. After creating the cluster, you can [connect to Kibana](#connect-kibana) on these hosts. You may need to additionally [set up the security groups](operations/cluster-connect.md#configuring-security-groups) to connect to the cluster.

   {% include [mes-tip-public-kibana](../_includes/mdb/mes-tip-connecting-to-public-kibana.md) %}

1. Click **Create cluster**.
1. Wait until the cluster is ready: its status on the {{ mes-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Configure security groups {#configuring-security-groups}

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
   1. Install the [SSL certificate](https://{{ s3-storage-host }}{{ pem-path }}) in the browser's trusted root certificate store ([instructions](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) for Mozilla Firefox).
   1. In the browser, go to `https://<FQDN of the publicly available {{ ES }} host with the Data node role>`.
   1. Enter the username and password that you set when [creating a cluster](#cluster-create).
1. Upload one or more test datasets to {{ ES }} using Kibana:
   1. On the Kibana welcome screen, click **Try our sample data**.
   1. Add data from one or more datasets by clicking **Add data** for the selected dataset.
1. Explore the data with Kibana and {{ ES }} by clicking **View data** for a dataset.

Learn more about working with Kibana, in the [{{ ES }} documentation](https://www.elastic.co/guide/en/kibana/current/connect-to-elasticsearch.html).

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating clusters](operations/cluster-create.md) and [connecting to clusters](operations/cluster-connect.md).
