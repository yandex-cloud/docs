---
title: Getting started with {{ mmy-full-name }}
description: Follow this guide to create a {{ MY }} cluster and connect to it.
---

# Getting started with {{ mmy-name }}®

To get started with the service:
* [Create a database cluster](#cluster-create).
* [Connect to the DB](#connect).


## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.
1. If you do not have a [folder](../resource-manager/concepts/resources-hierarchy.md#folder) yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Make sure](../iam/operations/roles/get-assigned-roles.md) your account has the [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) role and [{{ roles.mmy.editor }} role or higher](security/index.md#roles-list) for creating a cluster.
1. You can connect to DB [clusters](concepts/index.md) from both inside and outside {{ yandex-cloud }}:
   * To connect to a DB cluster from inside {{ yandex-cloud }}, create a [VM](../compute/concepts/vm.md) in the same [cloud network](../vpc/concepts/network.md#network) as the DB cluster (with [Linux](../compute/quickstart/quick-create-linux.md)).
   * To connect to the {{ mmy-name }} cluster from the internet, request public access to hosts when creating the cluster.

   {% note info %}

   The next step assumes that you are connecting to the {{ mmy-name }} cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM over SSH.
1. Install the required dependencies and the {{ MY }} client:

   ```bash
   sudo apt update && sudo apt install -y mysql-client
   ```


## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Set the {{ mmy-name }} cluster parameters and click **{{ ui-key.yacloud.mdb.forms.button_create }}**. For more information, see [Creating clusters](operations/cluster-create.md).
1. Wait until the {{ mmy-name }} cluster is ready: its status on the {{ mmy-name }} dashboard will change to **Running**, and its state to **Alive**. This may take some time.

## Connect to the DB {#connect}


1. If you are using [security groups](../vpc/concepts/security-groups.md) for a cloud network, [configure them](operations/connect.md#configuring-security-groups) to enable all relevant traffic between the {{ mmy-name }} cluster and the connecting host.


1. To connect to the DB server, get an SSL certificate:

   {% include [install-certificate](../_includes/mdb/mmy/install-certificate.md) %}

1. Use the `mysql` command to connect:

   {% include [default-connstring](../_includes/mdb/mmy/default-connstring.md) %}

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a {{ mmy-name }} cluster](operations/cluster-create.md) and [connecting to the database](operations/connect.md).
* Read [questions and answers](qa/general.md).