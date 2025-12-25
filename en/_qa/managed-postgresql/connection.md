#### Can I access a cluster from within {{ yandex-cloud }}? {#conn-from-yc}

You can connect to {{ mpg-short-name }} cluster hosts:
* Via the internet, if you configured public access for these hosts. These hosts can only be accessed over SSL.
* From {{ yandex-cloud }} virtual machines located in the same cloud network. For hosts without public access, SSL is not required to connect to them from these virtual machines.
* From a [{{ serverless-containers-full-name }} container](../../serverless-containers/concepts/index.md). For hosts without public access, this container must be located in the same cloud network.

For more information, see the [service documentation](../../managed-postgresql/operations/connect.md).

#### Can I connect to a cluster from a Docker container? {#conn-from-docker}

Yes, you can. To do this, [configure the Dockerfile](../../managed-postgresql/operations/connect.md#connection-docker).

See a {{ serverless-containers-full-name }} container connection example in [this tutorial](../../serverless-containers/tutorials/pg-connect.md).

#### How do I obtain an SSL certificate for connecting to {{ mpg-name }} on Windows? {#get-ssl}

You can obtain an SSL certificate using PowerShell:

```powershell
mkdir $HOME\.postgresql; curl.exe --output $HOME\.postgresql\root.crt {{ crt-web-path }}
```

The certificate will be saved to the `$HOME\.postgresql\root.crt` file.

For details on obtaining a certificate and connecting to a database, see the [service documentation](../../managed-postgresql/operations/connect.md).

#### How do I install an SSL certificate to connect Power BI to {{ mpg-name }} via psql? {#power-bi}

1. Install [Windows Subsystem for Linux]({{ ms.docs }}/windows/wsl/) (WSL) and run the following command in the terminal:

   ```bash
   mkdir /mnt/c/temp && \
   curl "{{ crt-web-path }}" --output /mnt/c/temp/CA.pem && \
   openssl pkcs12 -export -out /mnt/c/temp/CA.pfx -nokeys -in /mnt/c/temp/CA.pem
   ```

   The certificate will be located at `C:\temp\CA.pfx`.

1. [Install the obtained certificate in the Windows Certificate Store](https://docs.microsoft.com/en-us/skype-sdk/sdn/articles/installing-the-trusted-root-certificate).

#### Can I connect to cluster hosts over SSH? {#connect-ssh}

{% include [connect-via-ssh](../../_includes/mdb/connect-via-ssh.md) %}

#### What is the maximum allowed number of concurrent connections per host in {{ mpg-name }}? {#host-conn}

The number of concurrent connections is configured at the cluster level using the [**Max connections** setting](../../managed-postgresql/concepts/settings-list.md#setting-max-connections). By default it is set to the maximum value calculated using the following formula:

```text
200 × <number_of_vCPUs_per_host>
```

For instructions on updating {{ PG }} settings at the cluster level, see [this guide](../../managed-postgresql/operations/update.md#change-postgresql-config).

#### What is the maximum allowed number of connections per user? {#user-conn}

By default, a cluster reserves 50 connections per host for each user. You can change this number in the [**Conn limit** setting](../../managed-postgresql/concepts/settings-list.md#setting-conn-limit).

If the user’s connection limit is reached, new connection attempts will fail with the following error:

```text
too many active clients for user (pool_size for user <username> reached <limit_value>)
```

For instructions on updating {{ PG }} settings at the user level, see [this guide](../../managed-postgresql/operations/cluster-users.md#update-settings).

#### Why am I getting an error when trying to connect to a database from {{ google-looker }}? {#google-looker}

To connect from {{ google-looker }}, you need to generate a client certificate file and a private key and specify them in the connection settings. For more information, see [Connecting from {{ google-looker }}](../../managed-postgresql/operations/connect.md#connection-google-looker).

#### How to ensure I am always connecting to the master host? {#connect-to-master}

To connect to the current master host, use a [special FQDN](../../managed-postgresql/operations/connect.md#special-fqdns) in the `c-<cluster_ID>.rw.{{ dns-zone }}` format. This FQDN supports read and write access.

{% cut "Example command for connecting to the master host" %}

  ```bash
  psql "host=c-<cluster_ID>.rw.{{ dns-zone }} \
        port={{ port-mpg }} \
        sslmode=verify-full \
        dbname=<DB_name> \
        user=<username>"
  ```

{% endcut %}

#### How to ensure I am always connecting to the most up-to-date replica? {#connect-to-replica}

To connect to the most up-to-date replica, use a [special FQDN](../../managed-postgresql/operations/connect.md#special-fqdns) in the `c-<cluster_ID>.ro.{{ dns-zone }}` format. This FQDN only supports read access. 

{% cut "Example command for connecting to a replica" %}

```bash
psql "host=c-<cluster_ID>.ro.{{ dns-zone }} \
      port={{ port-mpg }} \
      sslmode=verify-full \
      dbname=<DB_name> \
      user=<username>"
```

{% endcut %}

If there are no active replicas in the cluster, this FQDN will point to the current master host.

#### How do I connect to the postgres database? {#postgres-db}

`postgres` is a system database. For security reasons, you cannot connect to system databases.

#### How do I get the postgres user's password? {#postgres-user}

For security reasons, the system does not permit obtaining the `postgres` user's password to connect to the database on their behalf.
