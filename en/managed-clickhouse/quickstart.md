---
title: Getting started with {{ mch-full-name }}
description: Follow this guide to create a {{ CH }} cluster and connect to it.
---

# Getting started with {{ mch-name }}

To get started with the service:
* [Create a database cluster](#cluster-create).
* [Connect to the DB](#connect).



## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.
1. If you do not have a [folder](../resource-manager/concepts/resources-hierarchy.md#folder) yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Assign](../iam/operations/roles/grant.md) the [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) role and the [{{ roles.mch.editor }} role or higher](security.md#roles-list) to your {{ yandex-cloud }} account. These roles allow you to create a cluster.

   To link the service account to a cluster, e.g., to [use {{ objstorage-full-name }}](operations/s3-access.md), your account also needs the [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) role or higher.

   {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. You can connect to DB [clusters](concepts/index.md) from both inside and outside {{ yandex-cloud }}:
   * To connect from inside {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md)-based [VM](../compute/concepts/vm.md) in the same [network](../vpc/concepts/network.md#network) as the DB cluster.
   * To connect to the cluster from the internet, request public access to hosts when creating the cluster.

   {% note info %}

   The next steps assume that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM over SSH.
1. Connect the {{ CH }} [DEB repository]({{ ch.docs }}/getting-started/install/#install-from-deb-packages):

   ```bash
   sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
   sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD******** && \
   echo "deb https://packages.{{ ch-domain }}/deb stable main" | sudo tee \
   /etc/apt/sources.list.d/clickhouse.list
   ```

1. Install the dependencies and the `clickhouse-client` client application:

   ```bash
   sudo apt update && sudo apt install --yes clickhouse-client
   ```

1. Download the configuration file for `clickhouse-client`:

   {% include [ClickHouse client config](../_includes/mdb/mch/client-config.md) %}


## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Set the cluster parameters and click **{{ ui-key.yacloud.mdb.forms.button_create }}**. For more information, see [Creating clusters](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mch-short-name }} dashboard will change to **Running** and its state, to **Alive**. This may take some time.

## Connect to the DB {#connect}


1. If you are using [security groups](../vpc/concepts/security-groups.md) for a cloud network, [configure them](operations/connect/index.md#configuring-security-groups) to enable all relevant traffic between the cluster and the connecting host.


1. To connect to the DB server, get SSL certificates:

   {% include [install-certificate](../_includes/mdb/mch/install-certificate.md) %}

1. Use the {{ CH }} CLI to connect:
   1. Specify the path to the `{{ crt-local-file-root }}` SSL certificate in the [configuration file]({{ ch.docs }}/interfaces/cli/#interfaces_cli_configuration), in the `<caConfig>` element:

      ```xml
      <config>
        <openSSL>
          <client>
            <loadDefaultCAFile>true</loadDefaultCAFile>
            <caConfig>{{ crt-local-dir }}{{ crt-local-file-root }}</caConfig>
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
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to the database](operations/connect/index.md).
* Read [questions and answers](qa/general.md).

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}