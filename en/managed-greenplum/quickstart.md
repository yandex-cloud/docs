---
title: "How to get started with {{ mgp-full-name }}"
description: "Follow this guide to create and set up a {{ GP }} cluster."
---

# Getting started with {{ mgp-short-name }}

To get started with the service:

1. [Create a cluster](#cluster-create).
1. [Connect to the DB](#connect).


## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and sign in to {{ yandex-cloud }} or sign up if you are not signed up yet.
1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to a cluster from both inside and outside {{ yandex-cloud }}:

   * To connect to a DB cluster from inside {{ yandex-cloud }}, create a VM in the same cloud network as the DB cluster (with [Linux](../compute/quickstart/quick-create-linux.md)).
   * To be able to connect to the cluster from the internet, request public access when creating the cluster.

   {% note info %}

   The next step assumes that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM over SSH.
1. Install the required dependencies and the PostgreSQL client:

   ```bash
   sudo apt update && sudo apt install postgresql-client --yes
   ```


## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Set the cluster parameters and click **{{ ui-key.yacloud.common.create }}**. For more information, see [Creating clusters](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mgp-short-name }} dashboard will change to **Running** and its state to **Alive**. This may take some time.

## Connect to the cluster {#connect}

1. To connect to the DB cluster, get an SSL certificate:

   {% include [install-certificate](../_includes/mdb/mgp/install-certificate.md) %}

1. Connect to the primary master host using [via a special FQDN](operations/connect.md#fqdn-master) using `psql`:

   {% include [default-connstring](../_includes/mdb/mgp/default-connstring.md) %}

1. After connecting, run the following query:

   ```sql
   SELECT version();
   ```

   The cluster will return the {{ PG }} and {{ GP }} versions used.

## What's next {#whats-next}

* Read about [service concepts](./concepts/index.md).
* Learn more about [creating a cluster](./operations/cluster-create.md) and [connecting to a cluster](./operations/connect.md).
* Install the [auxiliary utilities](./operations/greenplum-db.md).

{% include [greenplum-trademark](../_includes/mdb/mgp/trademark.md) %}
