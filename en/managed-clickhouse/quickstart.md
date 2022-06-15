# Getting started with {{ mch-name }}

To get started with the service:
* [Create a DB cluster](#cluster-create).
* [Connect to the DB](#connect).

{% if audience == "internal" %}

For the internal MDB service, the [web interface]({{ console-link }}) is deployed where you can manually create a database cluster. For more information about [quotas]({{ link-console-quotas }}) and the correlation between ABC services and clouds and folders, see [{#T}](../mdb/access.md).

## Access to DB clusters {#access}

The rules for accessing MDB clusters are already given in [Puncher](https://puncher.yandex-team.ru/): from [Yandex server networks](https://puncher.yandex-team.ru/?id=5ce6a766d89cb04f14acafb3) and for [developers](https://puncher.yandex-team.ru/?id=61f8da624928bbfd5d61d651).

If you need more rules, request access to the `_PGAASINTERNALNETS_` macro. To connect to {{ CH }} hosts, you need access to ports 8443 (HTTPS) and 9440 (native TLS-enabled protocol).

## CLI setup {#cli-setup}

If you plan to use the CLI, install and configure it by following the [instructions](../cli/quickstart.md).

If you did everything correctly, the list clusters query should now work:

```bash
{{ yc-mdb-ch }} cluster list
```

{% else %}

## Before you begin {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.
1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to DB clusters from both inside and outside {{ yandex-cloud }}:
   * To connect from inside {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md)- or [Windows](../compute/quickstart/quick-create-windows.md)-based VM in the same network as the DB cluster.
   * To be able to connect to the cluster from the internet, request public access to hosts when creating the cluster.

   {% note info %}

   The next steps assume that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the virtual machine over SSH.
1. Add the {{ CH }} [DEB repository](https://{{ ch-domain }}/docs/en/getting-started/install/#install-from-deb-packages):

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

   ```bash
   mkdir -p ~/.clickhouse-client && wget "https://{{ s3-storage-host }}/mdb/clickhouse-client.conf.example" -O ~/.clickhouse-client/config.xml
   ```

{% endif %}

## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ mch-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. When the cluster is ready, its status on the {{ mch-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the DB {#connect}

1. [Configure security groups](operations/connect.md#configuring-security-groups) for the cloud network to enable all the relevant traffic between the cluster and the connecting host.
1. To connect to the DB server, get an SSL certificate:

   {% if audience != "internal" %}

   1. Create a folder:

      ```bash
      mkdir ~/.clickhouse
      ```

   1. Get a certificate:

      ```bash
      wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.clickhouse/root.crt
      ```

   1. Configure permissions to the certificate:

      ```bash
      chmod 0600 ~/.clickhouse/root.crt
      ```

   {% else %}

   1. Create a folder:

      ```bash
      mkdir ~/.clickhouse
      ```

   1. Get a certificate:

      ```bash
      wget "{{ pem-path }}" -O ~/.clickhouse/root.crt
      ```

   1. Configure permissions to the certificate:

      ```bash
      chmod 0600 ~/.clickhouse/root.crt
      ```

   {% endif %}

1. Use the ClickHouse CLI to connect:
   1. Specify the path to the SSL certificate in the [configuration file](https://{{ ch-domain }}/docs/en/interfaces/cli/#interfaces_cli_configuration) in the `<caConfig>` element:

      ```xml
      <config>
        <openSSL>
          <client>
            <loadDefaultCAFile>true</loadDefaultCAFile>
            <caConfig>~/.clickhouse/root.crt</caConfig>
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

      ```bash
      clickhouse-client --host <host's FQDN> \
        -s \
        --user <DB user name> \
        --password <DB user password> \
        -q "<DB query>" \
        --port 9440
      ```

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to the database](operations/connect.md).
* Read [questions and answers](qa/general.md).