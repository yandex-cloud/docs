# Getting started with {{ mrd-short-name }}

{% if audience == "internal" %}

For the internal MDB service, the [web interface]({{ console-link }}) is deployed, where you can manually create a database cluster. For more about quotas and the correlation between ABC services and clouds and folders, see [{#T}](../mdb/access.md).

## Access to DB clusters {#access}

The rules for accessing MDB clusters are already given in [Puncher](https://puncher.yandex-team.ru/): from [Yandex server networks](https://puncher.yandex-team.ru/tasks?id=5cb878a6d5626d264a13ff8a) and [for developers](https://puncher.yandex-team.ru/tasks?id=5d0254aad89cb03fee5006d4).

If you need more rules, request access to the `_PGAASINTERNALNETS_` macro. To connect to {{ RD }} clusters, you need access to ports 26379 (Sentinel) and 6379 (Redis).

## CLI setup

If you plan to use the CLI, install and configure it according to the [instructions](../cli/quickstart.md).

   If you did everything correctly, the list clusters query should now work:

   ```bash
   {{ yc-mdb-rd }} cluster list
   ```

{% else %}

To get started with the service:

1. [Create a cluster](#cluster-create).
1. [Connect to the cluster](#connect).

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if you don't have an account yet.

1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can only connect to the cluster from within {{ yandex-cloud }}. To do this, create a [Linux](../compute/quickstart/quick-create-linux.md) VM in the same network as the cluster.

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via SSH.

1. Install the [redis-cli](https://redis.io/topics/rediscli) utility on the VM. For example, like this (for Ubuntu 20.04 LTS):

   ```bash
   sudo apt install redis-tools
   ```

{% endif %}

## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a cluster {{ RD }}.
1. Select **{{ mrd-full-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mrd-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the cluster {#connect}

1. Connect to the {{ RD }} cluster master host using `redis-cli`.

   {% include [see-fqdn-in-console](../_includes/mdb/see-fqdn-in-console.md) %}

   To connect:

   - To the master via any cluster host using [Sentinel](https://redis.io/topics/sentinel):

     1. Get the address of the master host by using Sentinel and any {{ RD }} host:

        ```bash
        redis-cli -h <FQDN of any {{ RD }} host> -p 26379 sentinel get-master-addr-by-name <{{ RD }} cluster name> | head -n 1
        ```

     1. Connect to the host with this address:

        ```bash
        redis-cli -c -h <{{ RD }} master host address> -a <{{ RD }} password>
        ```

   - Directly to the master host:

     ```bash
     redis-cli -c -h <FQDN of {{ RD }} master host> -p 6379 -a <password for {{ RD }}>
     ```

1. Once connected, send the `PING` command. {{ RD }} should return `PONG` in response.

## What's next

- Read about [service concepts](./concepts/index.md).
- Learn more about [creating clusters](./operations/cluster-create.md) and [connecting to clusters](./operations/connect.md).
- Read [questions and answers](./qa/general.md).

