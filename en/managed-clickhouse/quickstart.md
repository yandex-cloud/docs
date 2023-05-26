---
title: "Getting started with {{ mch-full-name }}"
description: "In this tutorial, you will learn how to create a {{ CH }} cluster and connect to it."
---

# Getting started with {{ mch-name }}


{% include [mdb-grant-note](../_includes/mdb/mdb-grant-note.md) %}


To get started with the service:
* [Create a DB cluster](#cluster-create).
* [Connect to the DB](#connect).


## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or create an account if you do not have one yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to DB clusters from both inside and outside {{ yandex-cloud }}:

   * To connect from inside {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md)-based VM in the same network as the DB cluster.

   * To be able to connect to the cluster from the internet, request public access to hosts when creating the cluster.

   {% note info %}

   The next steps assume that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM over SSH.

1. Connect the [DEB repository]({{ ch.docs }}/getting-started/install/#install-from-deb-packages) {{ CH }}:

   ```bash
   sudo apt update && sudo apt install -y apt-transport-https ca-certificates dirmngr && \
   sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
   echo "deb https://packages.{{ ch-domain }}/deb stable main" | sudo tee \
   /etc/apt/sources.list.d/clickhouse.list
   ```

1. Install the dependencies and the `clickhouse-client` client application:

   ```bash
   sudo apt update && sudo apt install -y clickhouse-client
   ```

1. Download the configuration file for `clickhouse-client`:

   {% include [ClickHouse client config](../_includes/mdb/mch/client-config.md) %}


## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ mch-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. For details, see [Creating clusters](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mch-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the DB {#connect}


1. If you are using security groups for a cloud network, [configure them](operations/connect.md#configuring-security-groups) to enable all relevant traffic between the cluster and the connecting host.

   {% include [preview-pp.md](../_includes/preview-pp.md) %}

   {% include [security-groups-note-services](../_includes/vpc/security-groups-note-services.md) %}



1. To connect to the DB server, get an SSL certificate:

   {% include [install-certificate](../_includes/mdb/mch/install-certificate.md) %}

1. Use the ClickHouse CLI to connect:

   1. Specify the path to the SSL certificate in the [configuration file]({{ ch.docs }}/interfaces/cli/#interfaces_cli_configuration) in the `<caConfig>` element:

      ```xml
      <config>
        <openSSL>
          <client>
            <loadDefaultCAFile>true</loadDefaultCAFile>
            <caConfig>{{ crt-local-dir }}{{ crt-local-file }}</caConfig>
            <cacheSessions>true</cacheSessions>
            <disableProtocols>sslv2,sslv3</disableProtocols>
            <preferServerCiphers>true</preferServerCiphers>
            <invalidCertificateHandler>
              <name>RejectCertificateHandler</name>
            </invalidCertificateHandler>
          </client>
        </openSSL>
      </config>
      ```

   1. Run the {{ CH }} CLI with the following parameters:

      {% include [default-connstring](../_includes/mdb/mch/default-connstring.md) %}

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to the database](operations/connect.md).
* Read [questions and answers](qa/general.md).
