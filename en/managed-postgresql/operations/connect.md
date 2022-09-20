# Connecting to a database in a {{ PG }} cluster

You can connect to {{ mpg-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

{% note info %}

If your cluster has public access configured for certain hosts only, an [automatic master switch](../concepts/replication.md#replication-auto) may make the master inaccessible over the internet.

{% endnote %}

## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the internet
   {% if audience != "internal" %}

   [Configure all security groups](../../vpc/operations/security-group-add-rule.md) in your cluster to allow incoming traffic on port 6432 from any IP. To do this, create the following rule for incoming traffic:

   {% else %}

   Configure all security groups in your cluster to allow incoming traffic on port 6432 from any IP. To do this, create the following rule for incoming traffic:

   {% endif %}

   * Port range: `6432`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

- With a VM in {{ yandex-cloud }} 
   {% if audience != "internal" %}

   1. [Configure all security groups](../../vpc/operations/security-group-add-rule.md) in your cluster to allow incoming traffic on port 6432 from the security group where the VM is located. To do this, create the following rule for incoming traffic in these groups:

   {% else %}

   1. Configure all security groups in your cluster to allow incoming traffic on port 6432 from the security group where the VM is located. To do this, create the following rule for incoming traffic in these groups:

   {% endif %}

   * Port range: `6432`.
   * Protocol: `TCP`.
   * Source: `Security group`.
   * Security group: If a cluster and a VM are in the same security group, select `Self` (`Self`) as the value. Otherwise, specify the VM security group.
      {% if audience != "internal" %}

   1. [Configure the security group](../../vpc/operations/security-group-add-rule.md) where the VM is located to allow connections to the VM and traffic between the VM and the cluster hosts.

   {% else %}

   1. Configure the security group where the VM is located to allow connections to the VM and traffic between the VM and the cluster hosts.

   {% endif %}

   Example of rules for a VM:

   * For incoming traffic:
      * Port range: `22`.
      * Protocol: `TCP`.
      * Source: `CIDR`.
      * CIDR blocks: `0.0.0.0/0`.

      This rule lets you connect to the VM over SSH.

   * For outgoing traffic:
      * Port range: `{{ port-any }}`.
      * Protocol: ``Any``.
      * Source type: `CIDR`.
      * CIDR blocks: `0.0.0.0/0`.

      This rule allows all outgoing traffic, which lets you both connect to the cluster and install the certificates and utilities that the VMs need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If security group settings are incomplete or incorrect, you may lose access to the cluster if the master is switched [manually](hosts.md#update) or [automatically](../concepts/replication.md#replication-auto).

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

## Automatic master host selection {#automatic-master-host-selection}

### Using libpq {#using-libpq}

To guarantee a connection to the master host, specify the FQDNs of all the cluster hosts in the `host` argument and pass the `target_session_attrs=read-write` parameter.

To upgrade the library version used by the `psql` utility:

* For Debian-based Linux distributions, install the `postgresql-client-10` package or higher (for example, using an [APT repository](https://www.postgresql.org/download/linux/ubuntu/)).
* For operating systems using RPM packages, a {{ PG }} distribution is available from a [yum repository](https://yum.postgresql.org/).

### With a special master host FQDN {#using-fqdn-master}

To avoid listing all the cluster hosts in a connection string, use a [special master host FQDN](#fqdn-master) as shown [in the examples below](#connection-string).

## Getting an SSL certificate {#get-ssl-cert}

{{ PG }} hosts with public access only support encrypted connections. To use them, get an SSL certificate:

{% list tabs %}

- Linux (Bash)

  {% include [install-certificate](../../_includes/mdb/mpg/install-certificate.md) %}

- Windows (PowerShell)

   {% if audience != "internal" %}

   ```powershell
   mkdir $HOME\AppData\Roaming\postgresql; `
   curl.exe -o $HOME\AppData\Roaming\postgresql\root.crt https://{{ s3-storage-host }}{{ pem-path }}
   ```

   {% else %}

   ```powershell
   mkdir $HOME\AppData\Roaming\postgresql; `
   curl.exe -o $HOME\AppData\Roaming\postgresql\root.crt {{ pem-path }}
   ```

   {% endif %}

{% endlist %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to public cluster hosts using SSL certificates. Before connecting [prepare a certificate](#get-ssl-cert).

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
            jdbc:postgresql://<special FQDN>:{{ port-mpg }}>/<DB name>
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
         * **Host**: Host FQDN or a [special FQDN](#special-fqdns).
         * **Port**: `{{ port-mpg}}`.
         * **Database**: Name of the DB to connect to.
         * Under **Authentication**, specify the DB user's name and password.
      1. On the **SSL** tab:
         1. Enable **Use SSL**.
         1. In the **CA certificate** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
   1. Click **Test connection ...** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
   1. Click **Ready** to save the database connection settings.

{% endlist %}

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

## Special FQDNs {#special-fqdns}

Just like usual FQDNs, which can be requested with a [list of cluster hosts](hosts.md#list), {{ mpg-name }} provides a number of special FQDNs, which can also be used when connecting to a cluster.

### Current master {#fqdn-master}

A FQDN like `c-<cluster ID>.rw.{{ dns-zone }}` Always points to the current cluster master host. The cluster ID can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

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

FQDN like `c-<cluster ID>.ro.{{ dns-zone }}` Points to the least lagging [replica](../concepts/replication.md). The cluster ID can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

**Specifics:**

* When connecting to this FQDN, only read operations are allowed.
* If there are no active replicas in the cluster, you can't connect to this FQDN: the corresponding CNAME record in the DNS will point to nowhere (`null`).

An example of connecting to the least lagging replica for a cluster with the ID `c9qash3nb1v9ulc8j9nm`:

```bash
psql "host=c-c9qash3nb1v9ulc8j9nm.ro.{{ dns-zone }} \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB name> \
      user=<username> \
      target_session_attrs=any"
```
