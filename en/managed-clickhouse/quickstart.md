---
title: "Getting started with {{ mch-full-name }}"
description: "In this tutorial, you'll learn how to create a {{ CH }} cluster and connect to it."
---

# Getting started with {{ mch-name }}

{% if product == "yandex-cloud" and audience != "internal" %}

{% include [mdb-grant-note](../_includes/mdb/mdb-grant-note.md) %}

{% endif %}

To get started with the service:
* [Create a DB cluster](#cluster-create).
* [Connect to the DB](#connect).

{% if audience == "internal" %}

For the internal MDB service, the [web interface]({{ console-link }}) is deployed where you can manually create a database cluster. For more information about [quotas]({{ link-console-quotas }}) and the correlation between ABC services and clouds and folders, see [{#T}](../mdb/access.md).

{% include [Internal access](../_includes/mdb/internal-access.md) %}

## CLI setup {#cli-setup}

If you plan to use the CLI, install and configure it by following the [instructions](../cli/quickstart.md).

If you did everything correctly, the list clusters query should now work:

```bash
{{ yc-mdb-ch }} cluster list
```

{% else %}

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.

1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to DB clusters from both inside and outside {{ yandex-cloud }}:

   * To connect from inside {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md){% if product == "cloud-il" %} or [Windows](../compute/quickstart/quick-create-windows.md){% endif %}-based VM in the same network as the DB cluster.

   * To be able to connect to the cluster from the internet, request public access to hosts when creating the cluster.

   {% note info %}

   The next steps assume that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM over {% if lang == "ru" and audience != "internal" %}[SSH](../glossary/ssh-keygen.md){% else %}SSH{% endif %}.

1. Connect the [DEB repository]({{ ch.docs }}/getting-started/install/#install-from-deb-packages) {{ CH }}:

   ```bash
   sudo apt update && sudo apt install -y apt-transport-https ca-certificates dirmngr && \
   sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
   echo "deb https://repo.{{ ch-domain }}/deb/stable/ main/" | sudo tee \
   /etc/apt/sources.list.d/clickhouse.list
   ```

1. Install the dependencies and the `clickhouse-client` client application:

   ```bash
   sudo apt update && sudo apt install -y clickhouse-client
   ```

1. Download the configuration file for `clickhouse-client`:

   {% include [ClickHouse client config](../_includes/mdb/mch/client-config.md) %}

{% endif %}

## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ mch-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mch-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the DB {#connect}

{% if audience != "internal" %}

1. [Configure security groups](operations/connect.md#configuring-security-groups) for the cloud network to enable all the relevant traffic between the cluster and the connecting host.

{% endif %}

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
