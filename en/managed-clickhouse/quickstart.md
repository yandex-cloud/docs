# Getting started with {{ mch-short-name }}

To get started with the service:

- [Create a DB cluster](#cluster-create).
- [Connect to the DB](#connect).

{% if audience == "internal" %}

For the internal MDB service, the [web interface]({{console-link}}) is deployed where you can manually create a database cluster. For more about quotas and the correlation between ABC services and clouds and folders, see [{#T}](../mdb/access.md).

## Access to DB clusters {#access}

The rules for accessing MDB clusters are already given in [Puncher](https://puncher.yandex-team.ru/): from [Yandex server networks](https://puncher.yandex-team.ru/tasks?id=5cb878a6d5626d264a13ff8a) and [for developers](https://puncher.yandex-team.ru/tasks?id=5d0254aad89cb03fee5006d4).

If you need more rules, request access to the `_PGAASINTERNALNETS_` macro. To connect to {{ CH }} hosts, you need access to ports 8443 (HTTPS) and 9440 (native TLS-enabled protocol).

{% include [cli-setup](../_includes/mdb/internal/cli-setup.md) %}

   If you did everything correctly, the list clusters query should now work:

   ```bash
   {{ yc-mdb-ch }} cluster list
   ```

{% else %}

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to Yandex.Cloud or sign up if you don't have an account.

1. If you don't have a folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

You can connect to DB clusters from both inside and outside of the Cloud:

1. To connect to a DB cluster from inside the Cloud, create a VM in the same network as the DB cluster (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md))
1. To connect to a cluster from the internet, request public access to the hosts when creating the cluster.

{% endif %}

## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ mch-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. When the cluster is ready to operate, its status on the {{ mch-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the DB {#connect}

1. To connect to the DB server, get an SSL certificate:

    {% if audience != "internal" %}

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

    {% else %}

    1. Create a folder:

        ```bash
        $ mkdir ~/.clickhouse
        ```

    1. Get a certificate:

        ```bash
        $ wget "{{ pem-path }}" -O ~/.clickhouse/root.crt
        ```

    1. Configure permissions to the certificate:

        ```bash
        $ chmod 0600 ~/.clickhouse/root.crt
        ```

    {% endif %}

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

