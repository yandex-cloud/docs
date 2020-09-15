# Getting started with {{ mkf-name }}

To get started with the service:

1. [Create a cluster](#cluster-create).
1. [Create a topic](#topic-create).
1. [Create an account](#account-create).
1. [Connect to the cluster](#connect).

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to Yandex.Cloud or sign up if you don't have an account.

1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

You can only connect to a cluster from inside Yandex.Cloud. To do this, create a VM in the same network as the cluster (with [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md)).

## Create a cluster {#cluster-create}

To create a cluster:

1. In the management console, select the folder where you want to create a cluster.
1. Select **{{ mkf-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mkf-short-name }} dashboard changes to `Running` and its state to `Alive`. This may take some time.

Then create a topic in the cluster.

## Create a topic {#topic-create}

[Topic](./concepts/topics.md) is a way to group message streams into categories. [Producers](./concepts/producers-consumers.md) write messages to a topic and [consumers](./concepts/producers-consumers.md) read messages from it.

To create a topic:

1. In the management console, select the folder where the cluster is located.
1. Select **{{ mkf-name }}**.
1. Click on the name of the cluster you created and select the **Topics** tab.
1. Click **Create topic**.
1. Specify the topic settings and click **Create**. This process is described in detail in [{#T}](operations/cluster-topics.md).

Then create an account for producers and consumers.

## Create an account {#account-create}

Accounts let you manage producer and consumer permissions to cluster topics.

To create an account:

1. In the management console, select the folder where the cluster is located.
1. Select **{{ mkf-name }}**.
1. Click on the name of the cluster you created and select the **Users** tab.
1. Click **Add**.
1. Enter a name for the account (username) and password (from 8 to 128 characters).
1. Click **![image](../_assets/plus.svg) Add topic** and select the topic you created from the drop-down list.
1. Add permissions to this topic for the producer and consumer. This process is described in detail in [{#T}](operations/cluster-accounts.md).
1. Click **Add**.

Then connect to the cluster using this account.

## Connect to the cluster {#connect}

You can connect producers and consumers to clusters using accounts. Both the producer and consumer will only be able to work with the topics that they are allowed to access within a specific account.

1. [Create a Linux VM](../compute/quickstart/quick-create-linux.md) in the same [virtual network](../vpc/concepts/network.md) as the cluster.

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via SSH.

1. On the VM, install the kafkacat utility, an open source application that can work as a universal data producer or consumer:

   ```bash
   apt-get install kafkacat
   ```

1. To send a message to a topic, run the command:

   ```bash
   echo "test message" | kafkacat -P  \
         -b <broker FQDN> \
         -t <topic name> \
         -X security.protocol=SASL_PLAINTEXT \
         -X sasl.mechanisms=SCRAM-SHA-512 \
         -X sasl.username=<producer username> \
         -X sasl.password=<producer password> -Z -K:
   ```

   In the command, specify the broker FQDN, the topic name, and the username and password of the {{ KF }} account that you created in the previous step.

   {% include [see-fqdn-in-console](../_includes/mdb/see-fqdn-in-console.md) %}

1. To get messages from a topic, run the command:

   ```bash
   kafkacat -C \
         -b <broker FQDN> \
         -t <topic name> \
         -X security.protocol=SASL_PLAINTEXT \
         -X sasl.mechanisms=SCRAM-SHA-512 \
         -X sasl.username=<consumer username> \
         -X sasl.password=<consumer password>
   ```

   In the command, specify the broker FQDN, the topic name, and the username and password of the {{ KF }} account that you created in the previous step.

   {% include [see-fqdn-in-console](../_includes/mdb/see-fqdn-in-console.md) %}

For more information about connecting to {{ mkf-name }} clusters, see [{#T}](operations/connect.md).

## What's next

- Read about [service concepts](./concepts/index.md).
- Learn more about [creating clusters](./operations/cluster-create.md) and [connecting to clusters](./operations/connect.md).
