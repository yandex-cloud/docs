# Getting started with {{ mrd-name }}

{% if product == "yandex-cloud" and audience != "internal" %}

{% include [mdb-grant-note](../_includes/mdb/mdb-grant-note.md) %}

{% endif %}

To get started with the service:
1. [Create a cluster](#cluster-create).
1. [Connect to the cluster](#connect).

{% if audience == "internal" %}

For the internal MDB service, the [web interface]({{ console-link }}) is deployed where you can manually create a database cluster. For more information about [quotas]({{ link-console-quotas }}) and the correlation between ABC services and clouds and folders, see [{#T}](../mdb/access.md).

{% include [Internal access](../_includes/mdb/internal-access.md) %}

## CLI setup {#cli-setup}

If you plan to use the CLI, install and configure it by following the [instructions](../cli/quickstart.md).

If you did everything correctly, the list clusters query should now work:

```bash
{{ yc-mdb-rd }} cluster list
```

{% else %}

## Before you begin {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.
1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can only connect to the cluster from within {{ yandex-cloud }}. To connect to a cluster, create a VM in the same cloud network as the {{ RD }} cluster (with [Linux](../compute/quickstart/quick-create-linux.md){% if product == "cloud-il" %} or [Windows](../compute/quickstart/quick-create-windows.md){% endif %}).
1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via SSH.
1. Install the [redis-cli](https://redis.io/topics/rediscli) utility on the VM. For example (for Ubuntu 20.04 LTS):

   ```bash
   sudo apt install redis-tools
   ```

{% endif %}

## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a cluster {{ RD }}.
1. Select **{{ mrd-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mrd-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the cluster {#connect}

1. If TLS support is enabled in your cluster, set up an SSL certificate:

   {% include [install-certificate](../_includes/mdb/mrd/install-certificate.md) %}

{% if audience != "internal" %}

1. [Configure security groups](operations/connect/index.md#configuring-security-groups) for the cloud network to enable all the relevant traffic between the cluster and the connecting host.

{% endif %}

1. Connect to the cluster using `redis-cli`.

   {% note info %}

   To connect to an SSL-enabled cluster, [download](https://redis.io/download) an archive with the utility's source code and build a version of the utility with TLS support using the `make BUILD_TLS=yes` command.

   {% endnote %}

   {% include [see-fqdn-in-console](../_includes/mdb/see-fqdn-in-console.md) %}

   {% list tabs %}

   - Non-sharded clusters

      **To connect using [Sentinel](https://redis.io/topics/sentinel) (without SSL)**:

      1. Get the address of the master host by using Sentinel and any {{ RD }} host:

         ```bash
         redis-cli -h <FQDN of any {{ RD }} host> \
           -p {{ port-mrd-sentinel }} \
           sentinel get-master-addr-by-name <{{ RD }} cluster name> | head -n 1
         ```

      1. Connect to the host with this address:

         {% include [default-connstring](../_includes/mdb/mrd/default-connstring.md) %}

      **To connect directly to the master (without SSL):**

      ```bash
      redis-cli -h c-<cluster ID>.rw.{{ dns-zone }} \
        -p {{ port-mrd }} \
        -a <{{ RD }} password>
      ```

      **To connect directly to the master (with SSL):**

      ```bash
      redis-cli -h c-<cluster ID>.rw.{{ dns-zone }} \
        -p {{ port-mrd-tls }} \
        -a <{{ RD }} password> \
        --tls \
        --cacert ~/.redis/{{ crt-local-file }}
      ```

   - Sharded clusters

      **To connect without SSL:**

      ```bash
      redis-cli -h <FQDN of the master host in any shard> \
        -p {{ port-mrd }} \
        -a <{{ RD }} password>
      ```

      **To connect with SSL:**

      ```bash
      redis-cli -h <FQDN of the master host in any shard> \
        -p {{ port-mrd-tls }} \
        -a <{{ RD }} password> \
        --tls \
        --cacert ~/.redis/{{ crt-local-file }}
      ```

   {% endlist %}

1. Once connected, send the `PING` command. {{ RD }} should return `PONG` in response.

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to a cluster](operations/connect/index.md).
* Read [questions and answers](qa/general.md).
