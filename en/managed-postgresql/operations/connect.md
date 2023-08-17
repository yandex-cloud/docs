# Connecting to a database in a {{ PG }} cluster

You can connect to {{ mpg-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/mpg/cluster-connect-note.md) %}

{% note warning %}

If only some cluster hosts have public access configured, the master may not be accessible from the internet when it [changes automatically](../concepts/replication.md#replication-auto).

{% endnote %}


## Configuring security groups {#configuring-security-groups}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the connection method you select:

{% list tabs %}

- Over the internet

   [Configure all security groups](../../vpc/operations/security-group-add-rule.md) in your cluster to allow incoming traffic on port 6432 from any IP. To do this, create the following rule for incoming traffic:

   * Port range: `6432`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

- With a VM in {{ yandex-cloud }}

   1. [Configure all security groups](../../vpc/operations/security-group-add-rule.md) in your cluster to allow incoming traffic on port 6432 from the security group where the VM is located. To do this, create the following rule for incoming traffic in these groups:

      * Port range: `6432`.
      * Protocol: `TCP`.
      * Source: `Security group`.
      * Security group: If a cluster and a VM are in the same security group, select `Self` (`Self`) as the value. Otherwise, specify the VM security group.

   1. [Configure the security group](../../vpc/operations/security-group-add-rule.md) where the VM is located to allow connections to the VM and traffic between the VM and the cluster hosts.

      Example of rules for a VM:

      * For incoming traffic:
         * Port range: `22`.
         * Protocol: `TCP`.
         * Source: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

         This rule allows you to [connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.

      * For outgoing traffic:
         * Port range: `{{ port-any }}`.
         * Protocol: `Any`.
         * Destination type: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

         This rule allows all outgoing traffic, which enables you to both connect to the cluster and install the certificates and utilities the VMs need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If security group settings are incomplete or incorrect, you may lose access to the cluster if the master is switched [manually](hosts.md#update) or [automatically](../concepts/replication.md#replication-auto).

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).


## Special FQDNs {#special-fqdns}

Just like usual FQDNs, which can be requested with a [list of cluster hosts](hosts.md#list), {{ mpg-name }} provides a number of special FQDNs, which can also be used when connecting to a cluster.

{% note warning %}

If, when the [master host is changed automatically](../concepts/replication.md#replication-auto), a host with no public access becomes a new master or the most recent replica, you will not be able to access them from the internet. To avoid this, [enable public access](../operations/hosts.md#update) for all cluster hosts.

{% endnote %}

### Current master {#fqdn-master}

Such FQDN as `c-<cluster ID>.rw.{{ dns-zone }}` always points to the current cluster master host. The cluster ID can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

When connecting to this FQDN, both read and write operations are allowed.

{% note info %}

Connect using special master host FQDNs to make sure your cluster is available even after a master fail over.

{% endnote %}

Example of connecting to a master host for a cluster with the ID `c9qash3nb1v9ulc8j9nm`:

```bash
psql "host=c-c9qash3nb1v9ulc8j9nm.rw.{{ dns-zone }} \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB name> \
      user=<username> \
      target_session_attrs=read-write"
```

### Most recent replica {#fqdn-replica}

Such FQDN as `c-<cluster ID>.ro.{{ dns-zone }}` points to the most recent [replica](../concepts/replication.md), i.e., the one most up-to-date with the master host. The cluster ID can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

**Specifics:**

* When connecting to this FQDN, only read operations are allowed.
* If there are no active replicas in the cluster, this FQDN will point to the current master host.

Here is an example of connecting to the most recent replica for a cluster with the `c9qash3nb1v9ulc8j9nm` ID:

```bash
psql "host=c-c9qash3nb1v9ulc8j9nm.ro.{{ dns-zone }} \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB name> \
      user=<username> \
      target_session_attrs=any"
```

## Automatic master host selection {#automatic-master-host-selection}

To guarantee a connection to the master host:

1. In the `host` argument, provide one of the following:

   * [Special master host FQDN](#fqdn-master) as shown in the [examples below](#connection-string).
   * FQDNs of all cluster hosts.

1. Provide the `target_session_attrs=read-write` parameter. This parameter is supported by the `libpq` library starting with [version 10](https://www.postgresql.org/docs/10/static/libpq-connect.html).

To upgrade the library version used by the `psql` utility:

* For Debian-based Linux distributions, install the `postgresql-client-10` package or higher (for example, using an [APT repository](https://www.postgresql.org/download/linux/ubuntu/)).
* For operating systems that use RPM packages, use the {{ PG }} distribution available from the [yum repository](https://yum.postgresql.org/).

## Getting an SSL certificate {#get-ssl-cert}

{{ PG }} hosts with public access only support encrypted connections. To use them, get an SSL certificate:

{% include [install-certificate](../../_includes/mdb/mpg/install-certificate.md) %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to public cluster hosts using SSL certificates.

{% include [note-connection-ide](../../_includes/mdb/note-connection-ide.md) %}

{% list tabs %}

- DataGrip

   1. Create a data source:
      1. Select **File** → **New** → **Data Source** → **{{ PG }}**.
      1. Specify the connection parameters on the **General** tab:
         * **User**, **Password**: DB user's name and password.
         * **URL**: Connection string:

            ```http
            jdbc:postgresql://<special FQDN>:{{ port-mpg }}>/<DB name>
            ```

            You can also use a list of all the cluster host FQDNs in the connection string:

            ```http
            jdbc:postgresql://<{{ PG }} host 1:{{ port-mpg }}>,...,<{{ PG }} host N:{{ port-mpg }}>/<DB name>
            ```

         * Click **Download** to download the connection driver.
      1. On the **SSH/SSL** tab:
         1. Enable the **Use SSL** setting.
         1. In the **CA file** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
   1. Click **Test Connection** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
   1. Click **OK** to save the data source.

- DBeaver

   1. Create a new DB connection:
      1. In the **Database** menu, select **New connection**.
      1. Select **{{ PG }}** from the DB list.
      1. Click **Next**.
      1. Specify the connection parameters on the **Main** tab:
         * **Host**: [Special master host FQDN](#fqdn-master) or regular host FQDN.
         * **Port**: `{{ port-mpg }}`.
         * **Database**: DB you want to connect to.
         * Under **Authentication**, specify the DB user's name and password.
      1. On the **SSL** tab:
         1. Enable **Use SSL**.
         1. In the **Root certificate** field, specify the path to the saved [SSL certificate](#get-ssl-cert) file.
   1. Click **Test connection ...** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
   1. Click **Ready** to save the database connection settings.

{% endlist %}

## Connecting from {{ pgadmin }} {#connection-pgadmin}

The connection was tested for [{{ pgadmin }}](https://www.pgadmin.org) ver. 7.0 on Ubuntu 20.04.

You can only use {{ pgadmin }} to connect to public cluster hosts [using SSL certificates](#get-ssl-cert).

Create a new server connection:

1. Select **Object** → **Register** → **Server...**
1. On the **General** tab, in the **Name** field, specify the name for the cluster. This name will be shown in the {{ pgadmin }} interface. You can set any name.
1. In the **Connection** tab, specify the connection parameters:

   * **Host name/address**: [Special master host FQDN](#fqdn-master) or regular host FQDN.
   * **Port**: `{{ port-mpg }}`.
   * **Maintenance database**: DB you want to connect to.
   * **Username**: Username for connection.
   * **Password**: User password.

1. In the **Parameters** tab:

   * Set the **SSL mode** parameter to `verify-full`.
   * Add a new **Root certificate** parameter and specify the path to the saved SSL certificate file in it.

1. Click **Save** to save the server connection settings.

As a result, the cluster appears in the server list in the navigation menu.

## Connecting from {{ google-looker }} {#connection-google-looker}

You can only use [{{ google-looker }}](https://lookerstudio.google.com/overview) to connect to public cluster hosts.

1. Save the `CA.pem` [server certificate]({{ crt-web-path }}) to a local directory.
1. In the same directory, generate a client certificate with a private key:

   ```bash
   openssl req -newkey rsa:2048 -nodes -keyout private.pem -out cert.pem
   ```

   When creating a certificate, you will be prompted to change some settings. Press **Enter** to use their default values.

   You will see two files in your local directory: `cert.pem` and `private.pem`.

1. On the [{{ google-looker }} navigation page](https://lookerstudio.google.com/navigation/reporting), select **Create** → **Data source**.
1. Choose {{ PG }}.
1. Fill out the fields below:

   * **Host name or IP address**: [Special master host FQDN](#fqdn-master) or regular host FQDN.
   * **Port**: `{{ port-mpg }}`.
   * **Database**: DB you want to connect to.
   * **Username**: Username for connection.
   * **Password**: User password.

1. Select **Enable SSL** and **Enable client authentication**.
1. Specify the certificate files and the client private key in the respective fields:

   * **Server certificate**: Select the `CA.pem` file.
   * **Client certificate**: Select the `cert.pem` file.
   * **Client private key**: Select the `private.pem` file.

1. Click **Authenticate**.

## Connecting from a Docker container {#connection-docker}

You can only use Docker containers to connect to public cluster hosts [using SSL certificates](#get-ssl-cert).

To connect to a {{ mpg-name }} cluster, add the following lines to the Dockerfile:

```bash
RUN apt-get update && \
    apt-get install wget postgresql-client --yes && \
    mkdir -p ~/.postgresql && \
    wget "{{ crt-web-path }}" \
        --output-document ~/.postgresql/root.crt && \
    chmod 0600 ~/.postgresql/root.crt
```

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mpg-conn-strings-env.md) %}

You can only connect to publicly accessible {{ PG }} hosts using an SSL certificate. Prior to connecting to such hosts, [generate a certificate](#get-ssl-cert).

The examples below assume that the `root.crt` SSL certificate is located in the directory:

* `/home/<home directory>/.postgresql/` for Ubuntu.
* `$HOME\AppData\Roaming\postgresql` for Windows.

Connecting without an SSL certificate is only supported for hosts that are not publicly accessible. If this is the case, internal cloud network traffic will not be encrypted for connecting to a database.

You can connect to a cluster using both regular host FQDNs (you can send a comma-separated list consisting of several such FQDNs) and [special FQDNs](#special-fqdns). The examples use a special FQDN of the current master host.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mpg-connection-strings](../../_includes/mdb/mpg-conn-strings.md) %}

If the connection to the cluster and the test query are successful, the {{ PG }} version is output.
