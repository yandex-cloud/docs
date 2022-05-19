# Getting started with {{ mkf-name }}

To get started with the service:
1. [Create a cluster](#cluster-create).
1. [Create a topic](#topic-create).
1. [Create an account](#account-create).
1. [Connect to the cluster](#connect).

{% if audience == "internal" %}

For the internal MDB service, the [web interface]({{ console-link }}) is deployed, where you can manually create a database cluster. For more about [quotas]({{ link-console-quotas }}) and the correlation between ABC services and clouds and folders, see [{#T}](../mdb/access.md).

## Access to DB clusters {#access}

The rules for accessing MDB clusters are already given in [Puncher](https://puncher.yandex-team.ru/): from [Yandex server networks](https://puncher.yandex-team.ru/?id=5ce6a766d89cb04f14acafb3) and [for developers](https://puncher.yandex-team.ru/?id=61f8da624928bbfd5d61d651).

If you need more rules, request access to the `_PGAASINTERNALNETS_` macro. To connect to {{ KF }}, specify port 9091 (SASL_TLS) in your request.

## CLI setup {#cli-setup}

If you plan to use the CLI, install and configure it according to the [instructions](../cli/quickstart.md).

If you did everything correctly, the list clusters query should now work:

```bash
{{ yc-mdb-kf }} cluster list
```

{% else %}

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if you don't have an account yet.
1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to an {{ KF }} cluster from both inside and outside {{ yandex-cloud }}:
   * To connect from inside {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md)- or [Windows](../compute/quickstart/quick-create-windows.md)-based virtual machine, which must be in the same network as the cluster.
   * To connect to a cluster from the internet, enable public access to the cluster when [creating](operations/cluster-create.md) it.

   {% note info %}

   The next step assumes that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via SSH.
1. Install the `kafkacat` utility, an open source application that can work as a universal data producer or consumer:

   ```bash
   sudo apt-get install kafkacat
   ```

{% endif %}

## Create a cluster {#cluster-create}

To create a cluster:
1. In the management console, select the folder where you want to create a cluster.
1. Select **{{ mkf-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mkf-name }} dashboard changes to **Running** and its state becomes **Alive**. This may take some time.

Then create a topic in the cluster.

## Create the topic {#topic-create}

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

You can connect producers and consumers to clusters using one account. Both the producer and consumer will only be able to work with the topics that they are allowed to access within a specific account.

To connect to a cluster:
1. [Configure security groups](operations/connect.md#configuring-security-groups) for the cloud network to enable all the relevant traffic between the cluster and the connecting host.
1. Install an SSL certificate on the VM:

   {% if audience != "internal" %}

   ```bash
   $ sudo mkdir -p /usr/local/share/ca-certificates/Yandex
   $ sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexCA.crt
   $ sudo chmod 655 /usr/local/share/ca-certificates/Yandex/YandexCA.crt
   ```

   {% else %}

   ```bash
   wget "{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexCA.crt
   chmod 655 /usr/local/share/ca-certificates/Yandex/YandexCA.crt
   ```

   {% endif %}

1. To send a message to a topic, run the command:

   ```bash
   echo "test message" | kafkacat -P \
     -b <broker FQDN>:9091 \
     -t <topic name> \
     -X security.protocol=SASL_SSL \
     -X sasl.mechanisms=SCRAM-SHA-512 \
     -X sasl.username="<producer username>" \
     -X sasl.password="<producer password>" \
     -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexCA.crt -Z -K:
   ```

   In the command, specify the broker FQDN, the topic name, and the username and password of the {{ KF }} account that you created in the previous step.

   {% include [see-fqdn-in-console](../_includes/mdb/see-fqdn-in-console.md) %}

1. To get messages from a topic, run the command:

   ```bash
   kafkacat -C \
     -b <broker FQDN>:9091 \
     -t <topic name> \
     -X security.protocol=SASL_SSL \
     -X sasl.mechanisms=SCRAM-SHA-512 \
     -X sasl.username="<consumer username>" \
     -X sasl.password="<consumer password>" \
     -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexCA.crt -Z -K:
   ```

   In the command, specify the broker FQDN, the topic name, and the username and password of the {{ KF }} account that you created in the previous step.

   {% include [see-fqdn-in-console](../_includes/mdb/see-fqdn-in-console.md) %}

For more information about connecting to {{ mkf-name }} clusters, see [{#T}](operations/connect.md).

## What's next {#whats-next}

* Read about [service concepts](./concepts/index.md).
* Learn more about [creating clusters](./operations/cluster-create.md) and [connecting to clusters](./operations/connect.md).