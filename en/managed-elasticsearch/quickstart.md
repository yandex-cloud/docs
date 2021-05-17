# Getting started with {{ mes-name }}

To get started with the service:

1. [Create a cluster](#cluster-create).
1. [Connect to the cluster](#connect).
1. [Connect to Kibana](#connect-kibana).

{% if audience == "internal" %}

For the internal MDB service, the [web interface]({{ console-link }}) is deployed, where you can manually create a database cluster. For more about quotas and the correlation between ABC services and clouds and folders, see [{#T}](../mdb/access.md).

## Access to DB clusters {#access}

The rules for accessing MDB clusters are already given in [Puncher](https://puncher.yandex-team.ru/): from [Yandex server networks](https://puncher.yandex-team.ru/tasks?id=5cb878a6d5626d264a13ff8a) and [for developers](https://puncher.yandex-team.ru/tasks?id=5d0254aad89cb03fee5006d4).

If you need more rules, request access to the `_PGAASINTERNALNETS_` macro. To connect to {{ ES }}, specify port 9200 (Elasticsearch) and/or port 443 (Kibana) in your request.

## CLI setup

If you plan to use the CLI, install and configure it according to the [instructions](../cli/quickstart.md).

   If you did everything correctly, the list clusters query should now work:

   ```bash
   {{ yc-mdb-es }} cluster list
   ```

{% else %}

## Before you start {#before-you-begin}

1. Log in [management console]({{ link-console-main }}) or sign up if you aren't registered yet.

1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to an {{ ES }} cluster from both inside and outside {{ yandex-cloud }}:
   - To connect from inside {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md)- or [Windows](../compute/quickstart/quick-create-windows.md)-based virtual machine, which must be in the same network as the cluster.
   - To connect to a cluster from the internet, when creating a cluster, [request public access](operations/cluster-create.md#change-data-node-settings) to hosts with the _Data node_ role.

{% note info %}

This instruction assumes that you're connecting to the cluster from the internet.

{% endnote %}

{% endif %}

## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a cluster.

1. Select **{{ mes-name }}**.

1. Click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).

1. Set the cluster parameters.

   To access the Kibana web interface, request public access:
   1. Change the settings of the host with the _Data node_ role by clicking ![image](../_assets/pencil.svg) for the host.
   1. Select **Public access**.
   1. Click **Save**.

   Public access can be requested for one or more hosts with this role. After creating the cluster, you can [connect to Kibana](#connect-kibana) located on these hosts.

   {% include [mes-tip-public-kibana](../_includes/mdb/mes-tip-connecting-to-public-kibana.md) %}

1. Click **Create cluster**.

1. Wait until the cluster is ready: its status on the {{ mes-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the cluster {#connect}

It is assumed that all the steps below are performed on Linux.

To connect to a cluster:

1. Install an SSL certificate:

   ```
   $ mkdir -p ~/.elasticsearch
   $ wget  "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.elasticsearch/root.crt
   $ chmod 0600 ~/.elasticsearch/root.crt
   ```

1. Connect to the cluster using [cURL](https://curl.haxx.se/):

   ```
   $ curl \
     --user <username>:<password> \
     --cacert ~/.elasticsearch/root.crt \
     -X GET 'https://<FQDN of the publicly available {{ ES }} host with the Data node role>:9200'
   ```

   To connect, you need to enter the username and password used for [creating a cluster](#cluster-create).

   A message like this one is displayed if the connection is successful:

   ```
   {
     "name" : "....mdb.cloud.yandex.net",
     "cluster_name" : "...",
     "cluster_uuid" : "...",
     ...
     "tagline" : "You Know, for Search"
   }
   ```

## Connect to Kibana {#connect-kibana}

1. In the browser, connect to the [Kibana](https://www.elastic.co/kibana/features) web interface.

   To connect:
   1. Install the [SSL certificate](https://storage.yandexcloud.net/cloud-certs/CA.pem) in the browser's trusted root certificate store ([instructions](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) for Mozilla Firefox).
   1. In the browser, go to `https://<FQDN of the publicly available host {{ ES }} with the Data node role>`.
   1. Enter the username and password that you set when [creating a cluster](#cluster-create).

1. Upload to {{ ES }} one or more test datasets using Kibana:
   1. On the Kibana welcome screen, click **Try our sample data**.
   1. Add data from one or more datasets by clicking **Add data** for the selected dataset.

1. Explore the data with Kibana and {{ ES }} by clicking **View data** for the dataset of interest.

To learn more about Kibana, see the [documentation for {{ ES }}](https://www.elastic.co/guide/en/kibana/current/tutorial-sample-data.html).

## What's next {#whats-next}

- Read about [service concepts](concepts/index.md).
- Learn more about [creating clusters](operations/cluster-create.md) and [connecting to clusters](operations/cluster-connect.md).

