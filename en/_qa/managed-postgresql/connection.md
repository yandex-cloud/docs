# Connecting to a {{ PG }} cluster

#### Is the cluster accessible from inside {{ yandex-cloud }}? {#conn-from-yc}

You can connect to {{ mpg-short-name }} cluster hosts:
* Over the internet, if you configured public access for the appropriate host. You can only connect to such hosts over an SSL connection.
* From {{ yandex-cloud }} virtual machines located in the same cloud network. If there is no public access to a host, using SSL for connections from such virtual machines is not required.

For more information, see the [service documentation](../../managed-postgresql/operations/connect.md).

#### Can I connect to a cluster from a Docker container? {#conn-from-docker}

Yes, you can. To do this, [configure the Dockerfile](../../managed-postgresql/operations/connect.md#connection-docker).

#### How do I obtain an SSL certificate to connect to {{ mpg-name }} on Windows? {#get-ssl}

You can obtain an SSL certificate using PowerShell:

```powershell
mkdir $HOME\AppData\Roaming\postgresql; `
curl.exe -o $HOME\AppData\Roaming\postgresql\root.crt {{ crt-web-path }}
```

The certificate will be available at `$HOME\AppData\Roaming\postgresql\root.crt`.

For more information about obtaining a certificate and connecting to a database, see the [service documentation](../../managed-postgresql/operations/connect.md).

#### How do I install an SSL certificate to connect Power BI to {{ mpg-name }} via psql? {#power-bi}

1. Install [Windows Subsystem for Linux]({{ ms.docs }}/windows/wsl/) (WSL) and run the following command in the terminal window:

   ```bash
   mkdir /mnt/c/temp && \
   curl "{{ crt-web-path }}" -o /mnt/c/temp/CA.pem && \
   openssl pkcs12 -export -out /mnt/c/temp/CA.pfx -nokeys -in /mnt/c/temp/CA.pem
   ```

   The certificate will be available at `C:\temp\CA.pfx`.

1. [Place the obtained certificate in the Windows certificate store](https://docs.microsoft.com/en-us/skype-sdk/sdn/articles/installing-the-trusted-root-certificate).

#### What should I do if I get the "SSL is required" error? {#ssl-req}

The error occurs because you are trying to connect to the cluster with a [public host](../../managed-postgresql/concepts/network.md#public-access-to-a-host). These hosts only support connections with an SSL certificate. You can:

* [Obtain an SSL certificate](../../managed-postgresql/operations/connect.md#get-ssl-cert) and add it to the application you are using to connect to the cluster.
* [Disable public access to hosts](../../managed-postgresql/operations/hosts.md#update) and connect to the cluster from a VM located in the same cloud network.

#### What is the maximum allowed number of concurrent connections to a single host in {{ mpg-name }}? {#host-conn}

The number of concurrent connections is specified at the cluster level in the [**Max connections** setting](../../managed-postgresql/concepts/settings-list.md#setting-max-connections). By default, the maximum value is set, which is calculated by the following formula:

```text
200 × <number_of_vCPUs_per_host>
```

For information about how to update the {{ PG }} settings at the cluster level, see our [documentation](../../managed-postgresql/operations/update.md#change-postgresql-config).

#### What is the allowed number of connections per user? {#user-conn}

By default, a cluster reserves 50 connections to each host per user. You can change this number in the [**Conn limit** setting](../../managed-postgresql/concepts/settings-list.md#setting-conn-limit).

If the connection limit per user is reached, any attempt to establish a new connection will fail with the following error:

```text
too many active clients for user (pool_size for user <username> reached <limit_value>)
```

To learn how to update the {{ PG }} settings at the user level, see our [documentation](../../managed-postgresql/operations/cluster-users.md#update-settings).

#### Why does an error occur when trying to connect to a database from {{ google-looker }}? {#google-looker}

To connect from {{ google-looker }}, be sure to generate a client certificate file and a private key and specify them in the connection settings. For more information about how to do this, see [Connecting from {{ google-looker }}](../../managed-postgresql/operations/connect.md#connection-google-looker).

#### Why does a connection fail? {#connection-error}

A {{ mpg-name }} cluster connection may be terminated with the following message:

```text
FATAL: terminating connection due to administrator command
```

This message does not indicate an error, it means that the session/transaction duration has exceeded the [Session duration timeout](../../managed-postgresql/concepts/settings-list.md#setting-session-duration-timeout) setting value (default value: 12 hours).
