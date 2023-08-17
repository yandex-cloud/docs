# Connecting to a database

Because the {{ GP }} DBMS is based on {{ PG }}, the same tools are used to connect to both DBMSs.

You can connect to a {{ mgp-short-name }} cluster only via the [primary master host](../concepts/index.md). To identify host roles, get a [list of hosts in the cluster](./hosts/cluster-hosts.md#list-hosts).

You can connect to a cluster:

{% include [cluster-connect-note-monolithic](../../_includes/mdb/cluster-connect-note-monolithic.md) %}


## Configuring security groups {#configuring-security-groups}

{% include [security-groups-note-services](../../_includes/vpc/security-groups-note-services.md) %}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

To ensure {{ mgp-name }} cluster functionality and network connectivity between its hosts, you need at least one cluster security group to include rules allowing any incoming and outgoing traffic from any IPs using any protocol.

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the internet

   {% include [Cluster security group rules](../../_includes/mdb/mgp/cluster-sg-rules.md) %}

- With a VM in {{ yandex-cloud }}

   1. {% include [Cluster security group rules](../../_includes/mdb/mgp/cluster-sg-rules.md) %}

   1. [Configure the security group](../../vpc/operations/security-group-add-rule.md) where the VM is located to allow connections to the VM and traffic between the VM and the cluster hosts.

      Example of rules for a VM:

      * For incoming traffic:
         * Port range: `22`.
         * Protocol: `TCP`.
         * Source: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

         This rule allows you to connect to the VM over SSH.

      * For outgoing traffic:
         * Port range: `{{ port-any }}`.
         * Protocol: `Any`.
         * Destination type: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

         This rule allows all outgoing traffic, which enables you to both connect to the cluster and install the certificates and utilities the VMs need to connect to the cluster.

{% endlist %}



## Automatic primary master host selection {#automatic-master-host-selection}

To automatically select a host to connect to a cluster, use a [special primary master FQDN](#fqdn-master).

## Getting an SSL certificate {#get-ssl-cert}

To use an SSL connection, get a certificate:

{% include [install-certificate](../../_includes/mdb/mgp/install-certificate.md) %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to a public cluster using SSL certificates.

{% include [note-connection-ide](../../_includes/mdb/note-connection-ide.md) %}

{% list tabs %}

* DataGrip

   1. Create a data source:

      1. Select **File** → **New** → **Data Source** → **{{ GP }}**.
      1. On the **General** tab:

         1. Specify the connection parameters:

            * **User**, **Password**: DB user's name and password.
            * **URL**: Connection string. Use the [special primary master FQDN](#fqdn-master):

               ```http
               jdbc:postgresql://c-<cluster ID>.rw.{{ dns-zone }}:{{ port-mgp }}/<db name>
               ```

         1. Click **Download** to download the connection driver.
      1. On the **SSH/SSL** tab:
         1. Enable the **Use SSL** setting.
         1. In the **CA file** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
   1. Click **Test Connection** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
   1. Click **OK** to save the data source.

* DBeaver

   1. Create a new DB connection:
      1. In the **Database** menu, select **New connection**.
      1. Select **{{ GP }}** from the DB list.
      1. Click **Next**.
      1. Specify the connection parameters on the **Main** tab:
         * **Host**: [Special primary master FQDN](#fqdn-master): `c-<clusterID>.rw.{{ dns-zone }}`.
         * **Port**: `{{ port-mgp }}`.
         * **Database**: Name of the DB to connect to.
         * Under **Authentication**, specify the DB user's name and password.
      1. On the **SSL** tab:
         1. Enable **Use SSL**.
         1. In the **Root certificate** field, specify the path to the saved [SSL certificate](#get-ssl-cert) file.
   1. Click **Test connection ...** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
   1. Click **Ready** to save the database connection settings.

{% endlist %}

## Connecting from {{ pgadmin }} {#connection-pgadmin}

The connection has been checked for [{{ pgadmin }}](https://www.pgadmin.org) ver. 7.1 on macOS Ventura 13.0 and Microsoft Windows 10 Pro 21H1.

You can only use {{ pgadmin }} to connect to public cluster hosts [using SSL certificates](#get-ssl-cert).

Create a new server connection:

1. Select **Object** → **Register** → **Server...**
1. On the **General** tab, in the **Name** field, specify the name for the cluster. This name will be shown in the {{ pgadmin }} interface. You can set any name.
1. In the **Connection** tab, specify the connection parameters:

   * **Host name/address**: [Special master host FQDN](#fqdn-master) or regular host FQDN.
   * **Port**: `{{ port-mgp }}`.
   * **Maintenance database**: Name of the `postgres` maintenance database.
   * **Username**: Name of the user to connect under.
   * **Password**: User password.

1. In the **Parameters** tab:

   * Set the **SSL mode** parameter to `verify-full`.
   * Add a new **Root certificate** parameter and specify the path to the saved SSL certificate file in it.

1. Click **Save** to save the server connection settings.

As a result, the cluster appears in the server list in the navigation menu.

To monitor the cluster status, use [{{ monitoring-full-name }}](monitoring.md) instead of the **Dashboard** tab in {{ pgadmin }} which might generate an error:

```text
column "wait_event_type" does not exist LINE 10: wait_event_type || ': ' || wait_event AS wait_event, ^
```

This error does not occur in other tabs in {{ pgadmin }}.

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mgp/conn-strings-env.md) %}

When creating a {{ GP }} cluster, the user database is not created. To test the connection, use the `postgres` service database.

To connect to a publicly accessible cluster, prepare an [SSL certificate](#get-ssl-cert). The examples assume that the `root.crt` SSL certificate is located in the directory:

* `/home/<home directory>/.postgresql/` for Ubuntu.
* `$HOME\AppData\Roaming\postgresql` for Windows.

You can connect to a cluster using both a regular primary master FQDN or its [special FQDN](#fqdn-master).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mgp-connection-strings](../../_includes/mdb/mgp/conn-strings.md) %}

## Special primary master FQDN {#fqdn-master}

Just like usual FQDNs, which can be requested with a list of cluster hosts, {{ mgp-name }} provides a special FQDN, which can also be used when connecting to a cluster.

A FQDN like `c-<cluster ID>.rw.{{ dns-zone }}` always points to the primary master host in the cluster. Connection to this FQDN is permitted and both read and write operations are allowed.

An example of connecting to a primary master host in a cluster with the ID `c9qash3nb1v9ulc8j9nm`:

```bash
psql "host=c-c9qash3nb1v9ulc8j9nm.rw.{{ dns-zone }} \
      port={{ port-mgp }} \
      sslmode=verify-full \
      dbname=<DB name> \
      user=<username>"
```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
