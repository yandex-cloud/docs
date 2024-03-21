---
title: "Getting started with {{ mrd-full-name }}"
description: "In this tutorial, you will learn how to create a {{ RD }} cluster and connect to it."
---

# Getting started with {{ mrd-name }}

To get started with the service:
1. [Create a cluster](#cluster-create).
1. [Connect to the cluster](#connect).


## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or create an account if you do not have one yet.
1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. If no public access is set up for a cluster, you can only connect to it from inside {{ yandex-cloud }}. To connect to a cluster, create a VM in the same cloud network as the {{ RD }} cluster (with [Linux](../compute/quickstart/quick-create-linux.md)).
1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM over SSH.
1. Install the [redis-cli](https://redis.io/topics/rediscli) utility on the VM. For example (for [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts)):

   ```bash
   sudo apt install redis-tools
   ```


## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a cluster {{ RD }}.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Set the cluster parameters and click **{{ ui-key.yacloud.mdb.forms.button_create }}**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mrd-name }} dashboard will change to **Running** and its state to **Alive**. This may take some time.

## Connect to the cluster {#connect}

1. If TLS support is enabled in your cluster, get an SSL certificate:

   {% include [install-certificate](../_includes/mdb/mrd/install-certificate.md) %}


1. If you are using security groups for a cloud network, [configure them](operations/connect/index.md#configuring-security-groups) to enable all relevant traffic between the cluster and the connecting host.


1. Connect to the cluster using `redis-cli`.

   {% note info %}

   To connect to an SSL-enabled cluster, [download](https://redis.io/download) an archive with the utility's source code and build a version of the utility with TLS support using the `make BUILD_TLS=yes` command.

   {% endnote %}

   {% include [see-fqdn-in-console](../_includes/mdb/see-fqdn-in-console.md) %}

   {% list tabs group=cluster %}

   - Non-sharded cluster {#non-sharded}

      **To connect using [Sentinel](https://redis.io/topics/sentinel) (without SSL)**:

      1. Get the address of the master host by using Sentinel and any {{ RD }} host:

         ```bash
         redis-cli -h <FQDN_of_any_{{ RD }}_host> \
           -p {{ port-mrd-sentinel }} \
           sentinel get-master-addr-by-name <{{ RD }}_cluster_name> | head -n 1
         ```

      1. Connect to the host with this address:

         {% include [default-connstring](../_includes/mdb/mrd/default-connstring.md) %}

      **To connect directly to the master (without SSL):**

      ```bash
      redis-cli -h c-<cluster_ID>.rw.{{ dns-zone }} \
        -p {{ port-mrd }} \
        -a <{{ RD }}_password>
      ```

      **To connect directly to the master (with SSL):**

      ```bash
      redis-cli -h c-<cluster_ID>.rw.{{ dns-zone }} \
        -p {{ port-mrd-tls }} \
        -a <{{ RD }}_password> \
        --tls \
        --cacert ~/.redis/{{ crt-local-file }}
      ```

   - Sharded cluster {#sharded}

      **To connect without SSL:**

      ```bash
      redis-cli -h <FQDN_of_master_host_in_any_shard> \
        -p {{ port-mrd }} \
        -a <{{ RD }}_password>
      ```

      **To connect with SSL:**

      ```bash
      redis-cli -h <FQDN_of_master_host_in_any_shard> \
        -p {{ port-mrd-tls }} \
        -a <{{ RD }}_password> \
        --tls \
        --cacert ~/.redis/{{ crt-local-file }}
      ```

   {% endlist %}

1. Once connected, send the `PING` command. {{ RD }} should return `PONG` in response.

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to a cluster](operations/connect/index.md).
* Read [questions and answers](qa/general.md).
