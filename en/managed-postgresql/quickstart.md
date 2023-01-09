---
title: "Getting started with {{ mpg-name }}"
description: "Following this guide you will learn how to get started with {{ mpg-name }}: create a DB cluster and connect to the DB."
---

# Getting started with {{ mpg-name }}


{% include [mdb-grant-note](../_includes/mdb/mdb-grant-note.md) %}


To get started with the service:
* [Create a DB cluster](#cluster-create).
* [Connect to the DB](#connect).


## Before you begin {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.

1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to DB clusters from both inside and outside {{ yandex-cloud }}:

   * To connect to a DB cluster from inside {{ yandex-cloud }}, create a VM in the same cloud network as the DB cluster (with [Linux](../compute/quickstart/quick-create-linux.md)).

   * To be able to connect to the cluster from the internet, request public access to hosts when creating the cluster.

   {% note info %}

   The next step assumes that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via SSH.

1. Install the necessary dependencies and the {{ PG }} client:

   ```bash
   sudo apt update && sudo apt install -y postgresql-client
   ```


## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ mpg-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mpg-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the DB {#connect}


1. [Configure security groups](operations/connect.md#configuring-security-groups) for the cloud network to enable all the relevant traffic between the cluster and the connecting host.


1. To connect to the DB server, get an SSL certificate:

   {% include [install-certificate](../_includes/mdb/mpg/install-certificate.md) %}

1. Use the `psql` command to connect:

   {% include [default-connstring](../_includes/mdb/mpg/default-connstring.md) %}

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to the database](operations/connect.md).
* Read [questions and answers](qa/general.md).
