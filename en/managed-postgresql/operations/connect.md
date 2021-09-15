# Connecting to a database in a {{ PG }} cluster

You can connect to {{ mpg-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

{% note info %}

If public access in your cluster is configured only for certain hosts, [automatic master change](../concepts/replication.md#replication-auto) may make the master unavailable over the internet.

{% endnote %}

## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the Internet

  [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on port 6432 from any IP address. To do this, create the following rule for incoming traffic:
  * Protocol: `TCP`.
  * Port range: `6432`.
  * Source type: `CIDR`.
  * Source: `0.0.0.0/0`.

- With a VM in Yandex.Cloud

  1. [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on port 6432 from the security group assigned to the VM. To do this, create the following rule for incoming traffic in these groups:
     * Protocol: `TCP`.
     * Port range: `6432`.
     * Source type: `Security group`.
     * Source: Security group assigned to the VM. If it is the same as the configured group, specify **Current**.

  1. [Set up the security group](../../vpc/operations/security-group-update.md#add-rule) assigned to the VM to allow connections to the VM and traffic between the VM and the cluster hosts.

     Example of rules for a VM:

     * For incoming traffic:
       * Protocol: `TCP`.
       * Port range: `22`.
       * Source type: `CIDR`.
       * Source: `0.0.0.0/0`.

       This rule lets you connect to the VM over SSH.

     * For outgoing traffic:
        * Protocol: `Any`.
        * Port range: `0-65535`.
        * Destination type: `CIDR`.
        * Destination: `0.0.0.0/0`.

       This rule allows any outgoing traffic: this lets you both connect to the cluster and install certificates and utilities you might need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, e.g., to allow traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If security group settings are incomplete or incorrect, you may lose access to the cluster if switching the master host [manually](hosts.md#update) or [automatically](../concepts/replication.md#replication-auto).

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

## Automatic master host selection {#automatic-master-host-selection}

### Using libpq {#using-libpq}

To guarantee a connection to the master host, specify the FQDNs of all the cluster hosts in the `host` argument and pass the `target_session_attrs=read-write` parameter as shown in [most of the examples](#connection-string) below. This parameter is supported by the `libpq` library starting from [version 10](https://www.postgresql.org/docs/10/static/libpq-connect.html):

To upgrade the library version used by the `psql` utility:

* For Debian-based Linux distributions, install the `postgresql-client-10` package or higher (for example, using an [APT repository](https://www.postgresql.org/download/linux/ubuntu/)).
* For operating systems that use RPM packages, a {{ PG }} distribution is available from a [YUM repository](https://yum.postgresql.org/).

### With a driver that supports only one host {#with-a-driver-that-supports-only-one-host}

If your database connection driver doesn't support passing multiple hosts in the connection string (for example, [pg in Node.js](https://www.npmjs.com/package/pg)), use a [special FQDN](#fqdn-master) that points to the host master.

## Getting an SSL certificate {#get-ssl-cert}

{{ PG }} hosts with public access only support encrypted connections. To use them, get an SSL certificate:

{% list tabs %}

- Linux (Bash)

  
  ```bash
  mkdir ~/.postgresql && \
  wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.postgresql/root.crt && \
  chmod 0600 ~/.postgresql/root.crt
  ```

- Windows (PowerShell)

  
  ```powershell
  mkdir $HOME\AppData\Roaming\postgresql; curl.exe -o $HOME\AppData\Roaming\postgresql\root.crt https://{{ s3-storage-host }}{{ pem-path }}
  ```

{% endlist %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to public cluster hosts using SSL certificates. Before connecting, [prepare a certificate](#get-ssl-cert).

{% list tabs %}

- DataGrip

  1. Create a data source:
     1. Select **File** → **New** → **Data Source** → **{{ PG }}**.
     1. Specify the connection parameters on the **General** tab:
        * **User**, **Password**: DB user's name and password.

        * **URL**: Connection string:

          ```http
          jdbc:postgresql://<{{ PG }} host 1:{{ port-mpg }}>,...,<{{ PG }} host N:{{ port-mpg }}>/<DB name>
          ```

          You can also use [special FQDNs](#special-fqdns) in the connection string:

          ```http
          jdbc:postgresql://<special FQDN:{{ port-mpg }}>/<DB name>
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
     1. Select the **{{ PG }}** database from the list.
     1. Click **Next**.
     1. Specify the connection parameters on the **Main** tab:
        * **Host**: FQDN of the host or a [special FQDN](#special-fqdns).
        * **Port**: `{{ port-mpg}}`.
        * **Database**: Name of the DB to connect to.
        * Under **Authentication**, specify the DB user's name and password.
     1. On the **SSL** tab:
         1. Enable the **Use SSL** setting.
         1. In the **Root certificate** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
  1. Click **Test Connection ...** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
  1. Click **Done** to save the database connection settings.

{% endlist %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to public cluster hosts using SSL certificates. Before connecting, [prepare a certificate](#get-ssl-cert).

{% list tabs %}

- DataGrip

  1. Create a data source:
     1. Select **File** → **New** → **Data Source** → **{{ PG }}**.
     1. Specify the connection parameters on the **General** tab:
        * **User**, **Password**: DB user's name and password.
        * **URL**: Connection string:

          ```http
          jdbc:postgresql://<{{ PG }} host 1:{{ port-mpg }}>,...,<{{ PG }} host N:{{ port-mpg }}>/<DB name>
          ```

          You can also use [special FQDNs](#special-fqdns) in the connection string:

          ```http
          jdbc:postgresql://<special FQDN:{{ port-mpg }}>/<DB name>
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
     1. Select the **{{ PG }}** database from the list.
     1. Click **Next**.
     1. Specify the connection parameters on the **Main** tab:
        * **Host**: FQDN of the host or a [special FQDN](#special-fqdns).
        * **Port**: `{{ port-mpg}}`.
        * **Database**: Name of the DB to connect to.
        * Under **Authentication**, specify the DB user's name and password.
     1. On the **SSL** tab:
         1. Enable the **Use SSL** setting.
         1. In the **Root certificate** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
  1. Click **Test Connection ...** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
  1. Click **Done** to save the database connection settings.

{% endlist %}

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

You can connect to public {{ PG }} hosts only if you use an SSL certificate. Before connecting to such hosts, [prepare the certificate](#configuring-an-ssl-certificate).

The examples below assume that the `root.crt` SSL certificate is located in the directory:
* `/home/<home directory>/.postgresql/` for Ubuntu.
* `$HOME\AppData\Roaming\postgresql` for Windows.

Connecting without an SSL certificate is only supported for hosts that are not publicly accessible. For connections to the database, traffic inside the virtual network isn't encrypted in this case.

You can connect to a cluster using both regular FQDN hosts (you can send a list of several such comma-separated FQDNs) and [special FQDNs](#special-fqdns).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mpg-connection-strings](../../_includes/mdb/mpg-conn-strings.md) %}

If the connection to the cluster and the test query are successful, the {{ PG }} version is output.

## Special FQDNs {#special-fqdns}

Just like usual FQDNs, which can be requested with a [list of cluster hosts](hosts.md#list), {{ mpg-name }} provides a number of special FQDNs, which can also be used when connecting to a cluster.

### Current master {#fqdn-master}

An FQDN like `c-<cluster ID>.rw.{{ dns-zone }}` always points to the current master host in the cluster. The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

When connecting to this FQDN, both read and write operations are allowed.

An example of connecting to a master host for a cluster with the ID `c9qash3nb1v9ulc8j9nm`:

```bash
psql "host=c-c9qash3nb1v9ulc8j9nm.rw.{{ dns-zone }} \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB name> \
      user=<username> \
      target_session_attrs=read-write"
```

### The least lagging replica {#fqdn-replica}

An FQDN like `c-<cluster ID>.ro.{{ dns-zone }}` points to the [replica](../concepts/replication.md) that is least lagging from the master host. The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

**Specifics:**

* When connecting to this FQDN, only read operations are allowed.
* If there are no active replicas in the cluster, you can't connect to this FQDN: the corresponding CNAME entry in the DNS will read `"null"`.

An example of connecting to the least lagging replica for a cluster with the ID `c9qash3nb1v9ulc8j9nm`:

```bash
psql "host=c-c9qash3nb1v9ulc8j9nm.ro.{{ dns-zone }} \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB name> \
      user=<username> \
      target_session_attrs=any"
```

