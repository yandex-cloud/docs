---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Getting started with {{ mch-short-name }}

To get started with the service:

- [Create a DB cluster](#cluster-create).
- [Connect to the DB](#connect).


## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if you don't have an account yet.

1. If you don't have a folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to DB clusters from both inside and outside {{ yandex-cloud }}:
   - To connect from inside {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md)- or [Windows](../compute/quickstart/quick-create-windows.md)-based virtual machine in the same network as the DB cluster.
   - To be able to connect to the cluster from the internet, request public access to hosts when creating the cluster.

   {% note info %}

   The next steps assume that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via SSH.

1. Add the {{ CH }} [DEB repository](https://clickhouse.tech/docs/en/getting-started/install/#install-from-deb-packages):

   ```bash
   sudo apt update && sudo apt install -y apt-transport-https ca-certificates dirmngr && \
   sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
   echo "deb https://repo.clickhouse.tech/deb/stable/ main/" | sudo tee \
   /etc/apt/sources.list.d/clickhouse.list
   ```

1. Install the dependencies and the `clickhouse-client` client application:

   ```bash
   sudo apt update && sudo apt install -y clickhouse-client
   ```

1. Download the configuration file for `clickhouse-client`:

   ```bash
   mkdir -p ~/.clickhouse-client && wget "https://storage.yandexcloud.net/mdb/clickhouse-client.conf.example" -O ~/.clickhouse-client/config.xml
   ```

## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ mch-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. When the cluster is ready to operate, its status on the {{ mch-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the DB {#connect}

1. To connect to the DB server, get an SSL certificate:

    
    1. Create a folder:

        ```bash
        $ mkdir ~/.clickhouse
        ```

    1. Get a certificate:

        ```bash
        $ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.clickhouse/root.crt
        ```

    1. Configure permissions to the certificate:

        ```bash
        $ chmod 0600 ~/.clickhouse/root.crt
        ```

1. Use the ClickHouse CLI to connect:
    1. Specify the path to the SSL certificate in the [configuration file](https://clickhouse.yandex/docs/en/interfaces/cli/#interfaces_cli_configuration) in the `<caConfig>` element:

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
    1. Run the ClickHouse CLI with the following parameters:

    ```bash
    clickhouse-client --host <host FQDN> \
                      -s \
                      --user <DB user name> \
                      --password <DB user password> \
                      -q "<DB query>" \
                      --port 9440 
    ```

## What's next

- Read about [service concepts](./concepts/index.md).
- Learn more about [creating a cluster](./operations/cluster-create.md) and [connecting to the database](./operations/connect.md).
- Read [questions and answers](./qa/general.md).

