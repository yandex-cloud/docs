# Getting started with {{ mrd-short-name }}


To get started with the service:

1. [Create a cluster](#cluster-create).
1. [Connect to the cluster](#connect).

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if you don't have an account yet.

1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can only connect to the cluster from within {{ yandex-cloud }}. To connect to a cluster, create a VM in the same cloud network as the {{ RD }} cluster (with [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md)).

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via SSH.

1. Install the [redis-cli](https://redis.io/topics/rediscli) utility on the VM. For example, like this (for Ubuntu 20.04 LTS):

   ```bash
   sudo apt install redis-tools
   ```

## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a cluster {{ RD }}.
1. Select **{{ mrd-full-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mrd-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the cluster {#connect}

1. If your cluster is deployed with version 6 or higher and supports TLS, configure an SSL certificate:

    1. Create a folder:

        ```bash
        $ mkdir ~/.redis
        ```

    1. Get a certificate:

        ```bash
        $ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.redis/YandexInternalRootCA.crt
        ```

    1. Configure permissions to the certificate:

        ```bash
        $ chmod 0600 ~/.redis/YandexInternalRootCA.crt
        ```

1. [Configure security groups](operations/connect.md#configuring-security-groups) for the cloud network to enable all the relevant traffic between the cluster and the connecting host.

1. Connect to the {{ RD }} cluster master host using `redis-cli`.

   {% note info %}

   To connect to a SSL-enabled cluster, [download](https://redis.io/download) an archive with the utility's source code and build a version of the utility with TLS support using the `make BUILD_TLS=yes` command.

   {% endnote %}

   {% include [see-fqdn-in-console](../_includes/mdb/see-fqdn-in-console.md) %}

   To connect:

   - To the master via any cluster host using [Sentinel](https://redis.io/topics/sentinel) (without SSL):

     1. Get the address of the master host by using Sentinel and any {{ RD }} host:

        ```bash
        redis-cli -h <FQDN of any {{ RD }} host> -p {{ port-mrd-sentinel }} sentinel get-master-addr-by-name <{{ RD }} cluster name> | head -n 1
        ```

     1. Connect to the host with this address:

        ```bash
        redis-cli -h <{{ RD }} master host address> -a <{{ RD }} password>
        ```

   - Directly to the master host:

      - Connecting without SSL:

        ```bash
        redis-cli -h <FQDN of {{ RD }} master host> -p {{ port-mrd }} -a <{{ RD }} password>
        ```

      - Connecting with SSL enabled:

        ```bash
        redis-cli -h <FQDN of {{ RD }} master host> -p {{ port-mrd-tls }} -a <{{ RD }} password> --tls --cacert ~/.redis/YandexInternalRootCA.crt
        ```

1. Once connected, send the `PING` command. {{ RD }} should return `PONG` in response.

## What's next {#whats-next}

- Read about [service concepts](./concepts/index.md).
- Learn more about [creating clusters](./operations/cluster-create.md) and [connecting to clusters](./operations/connect.md).
- Read [questions and answers](./qa/general.md).

