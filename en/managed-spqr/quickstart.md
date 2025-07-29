---
title: Getting started with {{ mspqr-full-name }}
description: Follow this guide to create a {{ SPQR }} cluster and connect to it.
---

# Getting started with {{ mspqr-name }}

{% include [preview](../_includes/note-service-preview.md) %}

To get started:
* [Create a {{ SPQR }} cluster](#cluster-create).
* [Create a shard in the {{ SPQR }} cluster](#shard-create).
* [Connect to the DB](#connect).

## Getting started {#before-you-begin}

1. Navigate to the [management console]({{ link-console-main }}) and either log in to {{ yandex-cloud }} or sign up if you do not have an account yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}


1. [Assign](../iam/operations/roles/grant.md) the [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) role to your {{ yandex-cloud }} account, and the `managed-spqr.editor` role for the folder. These roles allow you to create a cluster.


   {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. You can connect to DB clusters from both inside and outside {{ yandex-cloud }}:

   * To connect from inside {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md) VM in the same network as the DB cluster.

   * To connect to the cluster from the internet, enable public access to hosts when creating the cluster.

   {% note info %}

   The next step assumes that you are connecting to the {{ SPQR }} cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM over [SSH](https://en.wikipedia.org/wiki/Secure_Shell).

1. Install the required dependencies and the {{ PG }} client:

   ```bash
   sudo apt update && sudo apt install -y postgresql-client
   ```

## Create a cluster {#cluster-create}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ SPQR }} cluster.
1. Select **{{ mspqr-name }}**.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Specify your cluster settings and click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

   To learn more about the cluster properties, see [Creating a cluster](operations/cluster-create.md).

1. Wait until the cluster is ready for operation: its availability status on the {{ mspqr-short-name }} panel will change to **Alive**. This may take some time.

## Create a shard in the cluster {#shard-create}

1. In the [management console]({{ link-console-main }}), select the folder where you [created](#cluster-create) the {{ SPQR }} cluster.
1. [Create](../managed-postgresql/operations/cluster-create.md#create-cluster) a {{ mpg-name }} cluster in the same cloud network as the {{ SPQR }} cluster.
1. Open your {{ SPQR }} cluster and go to the ![image](../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}** in the top-right corner of the page.
1. In the window that opens:

   1. Specify the shard **{{ ui-key.yacloud.common.name }}**.
   1. In the **Managed Service for PostgreSQL cluster** field, select the {{ PG }} cluster you previously created.

      The {{ mpg-name }} cluster must be in the same folder and cloud network as the {{ mspqr-name }} cluster.

## Connect to the DB {#connect}

1. If you are using security groups for a cloud network, configure them to enable all relevant traffic between the cluster and the connecting host.

1. To connect to the DB server, get an SSL certificate:

    {% include [install-certificate](../_includes/mdb/mpg/install-certificate.md) %}

1. Use the `psql` command to connect:

    {% include [default-connstring](../_includes/mdb/mpg/default-connstring.md) %}

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md).

