---
title: How to get started with {{ mkf-full-name }}
description: Follow this guide to create and set up an {{ KF }} cluster.
---

# Getting started with {{ mkf-name }}

To get started with the service:
1. [Create a cluster](#cluster-create).
1. [Create a topic](#topic-create).
1. [Create a user](#account-create).
1. [Connect to the cluster](#connect).


## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Make sure](../iam/operations/roles/get-assigned-roles.md) your account has the [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) role and [{{ roles.mkf.editor }} role or higher](security/index.md#roles-list) for creating a cluster.
1. You can connect to an {{ KF }} cluster from both inside and outside {{ yandex-cloud }}:

   * To connect from inside {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md) virtual machine in the same network as the cluster.

   * To connect to a cluster from the internet, enable public access to the cluster when [creating](operations/cluster-create.md) it.

   {% note info %}

   The next step assumes that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM over SSH.

1. Install the `kafkacat` utility, an open source application that can function as a universal data producer or consumer:

   ```bash
   sudo apt-get install kafkacat
   ```


## Create a cluster {#cluster-create}

To create a cluster:
1. In the management console, select the folder where you want to create a cluster.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Set the cluster parameters and click **{{ ui-key.yacloud.common.create }}**. For more information, see [Creating clusters](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mkf-name }} dashboard will change to `Running` and its state, to `Alive`. This may take some time.

Then create a topic in the cluster.

## Create the topic {#topic-create}

A [topic](concepts/topics.md) is a way to group message streams into categories. [Producers](concepts/producers-consumers.md) write messages to a topic and [consumers](concepts/producers-consumers.md) read messages from it.

To create a topic:
1. In the management console, select the folder where the cluster is located.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
1. Click the name of the cluster you created and select the **{{ ui-key.yacloud.kafka.label_topics }}** tab.
1. Click **{{ ui-key.yacloud.kafka.button_create-topic }}**.
1. Specify the topic settings and click **{{ ui-key.yacloud.common.create }}**. This process is described in detail in [{#T}](operations/cluster-topics.md).

Then create users for producers and consumers.

## Create a user {#account-create}

User settings let you manage [producer and consumer](./concepts/producers-consumers.md) permissions to cluster topics.

To create a user:
1. In the management console, select the folder where the cluster is located.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
1. Click the name of the cluster you created and select the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
1. Enter a username and password (from 8 to 128 characters).
1. Click **![image](../_assets/console-icons/plus.svg) {{ ui-key.yacloud.kafka.button_add-topic }}** and select the previously created topic from the drop-down list.
1. Add permissions to this topic for the producer and consumer. For more information, see [User management](operations/cluster-accounts.md).
1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_add }}**.

Then connect to the cluster using this username.

## Connect to the cluster {#connect}

You can connect the producer and consumer to the cluster on behalf of one user. Both the producer and consumer will only be able to work with the topics that this user is allowed to access.

To connect to a cluster:


1. If using security groups for a cloud network, [configure](operations/connect/index.md#configuring-security-groups) them to enable all relevant traffic between the cluster and the connecting host.


1. Install an SSL certificate on the VM:

   {% include [install-certificate](../_includes/mdb/mkf/install-certificate.md) %}

1. To send a message to a topic, run the command:

   {% include [default-get-string](../_includes/mdb/mkf/default-send-string.md) %}

   In the command, specify the broker FQDN, the topic name, and the username and password of the {{ KF }} user that you created in the previous step.

   {% include [fqdn](../_includes/mdb/mkf/fqdn-host.md) %}

1. To get messages from a topic, run the following command:

   {% include [default-get-string](../_includes/mdb/mkf/default-get-string.md) %}

   In the command, specify the broker FQDN, the topic name, and the username and password of the {{ KF }} user that you created in the previous step.

   {% include [fqdn](../_includes/mdb/mkf/fqdn-host.md) %}

For more information about connecting to a {{ mkf-name }} cluster, see [Connecting to topics in a cluster](operations/connect/clients.md).

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to a cluster](operations/connect/index.md).
