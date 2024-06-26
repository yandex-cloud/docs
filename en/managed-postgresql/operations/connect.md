---
title: "Connecting to a {{ PG }} cluster in {{ mos-full-name }}"
description: "You can connect to {{ PG }} cluster hosts from the internet if you set up public access to the appropriate host and from {{ yandex-cloud }} VMs located in the same virtual network."
---

# Connecting to a database in a {{ PG }} cluster

You can connect to {{ mpg-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/mpg/cluster-connect-note.md) %}

{% note warning %}

If only some cluster hosts have public access configured, the master may not be accessible from the internet when it [changes automatically](../concepts/replication.md#replication-auto).

{% endnote %}


## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the connection method you select:

{% list tabs group=connection_method %}

- Over the internet {#internet}

   [Configure all the cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port 6432 from any IP. To do this, create the following rule for incoming traffic:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `6432`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

- From a VM in {{ yandex-cloud }} {#cloud}

   1. [Configure all the cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port 6432 from the security group where the VM is located. To do this, create the following rule for incoming traffic in these groups:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `6432`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM are in the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). Otherwise, specify the VM security group.

   1. [Configure the security group](../../vpc/operations/security-group-add-rule.md) where the VM is located to enable connections to the VM and traffic between the VM and the cluster hosts.

      For example, you can set the following rules for a VM:

      * For incoming traffic:
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         This rule allows you to [connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.

      * For outgoing traffic:
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         This rule allows all outgoing traffic, thus enabling you not only to connect to the cluster but also to install the certificates and utilities your VM needs for the connection.

{% endlist %}

{% note info %}

You can specify more detailed rules for your security groups, e.g., to allow traffic only in specific subnets.

You must configure security groups correctly for all subnets in which the cluster hosts will reside. If security group settings are incomplete or incorrect, you may lose access to the cluster if the master is switched [manually](hosts.md#update) or [automatically](../concepts/replication.md#replication-auto).

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).


## Getting an SSL certificate {#get-ssl-cert}

{{ PG }} hosts with public access only support encrypted connections. To use them, get an SSL certificate:

{% include [install-certificate](../../_includes/mdb/mpg/install-certificate.md) %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## {{ PG }} host FQDN {#fqdn}

To connect to a host, you need its fully qualified domain name ([FQDN](../concepts/network.md#hostname)). You can obtain it in one of the following ways:

* [Request a list of cluster hosts](../operations/hosts.md#list-hosts).
* In the [management console]({{ link-console-main }}), copy the command for connecting to the cluster. This command contains the host FQDN. To get the command, go to the cluster page and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
* Look up the FQDN in the management console:

   1. Go to the cluster page.
   1. Go to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

Cluster hosts also use [special FQDNs](#special-fqdns).

## Special FQDNs {#special-fqdns}

Alongside [regular FQDNs](#fqdn), {{ mpg-name }} provides several special FQDNs, which can also be used when connecting to a cluster.

{% note warning %}

If, when the [master host is changed automatically](../concepts/replication.md#replication-auto), a host with no public access becomes a new master or the most recent replica, you will not be able to access them from the internet. To avoid this, [enable public access](hosts.md#update) for all cluster hosts.

{% endnote %}

### Current master {#fqdn-master}

Such FQDN as `c-<cluster_ID>.rw.{{ dns-zone }}` always points to the current cluster master host. You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

When connecting to this FQDN, both read and write operations are allowed.

{% note info %}

Connect using special master host FQDNs to make sure your cluster is available even after a master fail over.

{% endnote %}

Here is an example of connecting to a master host for a cluster with the `c9qash3nb1v9********` ID:

```bash
psql "host=c-c9qash3nb1v9********.rw.{{ dns-zone }} \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB_name> \
      user=<username> \
      target_session_attrs=read-write"
```

### Most recent replica {#fqdn-replica}

Such FQDN as `c-<cluster_ID>.ro.{{ dns-zone }}` points to the most recent [replica](../concepts/replication.md), i.e., the one most up-to-date with the master host. You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

**Specifics:**

* When connecting to this FQDN, only read operations are allowed.
* If there are no active replicas in the cluster, this FQDN will point to the current master host.

Here is an example of connecting to the most recent replica for a cluster with the `c9qash3nb1v9********` ID:

```bash
psql "host=c-c9qash3nb1v9********.ro.{{ dns-zone }} \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB_name> \
      user=<username> \
      target_session_attrs=any"
```

## Automatic master host selection {#automatic-master-host-selection}

To guarantee a connection to the master host:

1. In the `host` argument, provide one of the following:

   * [Special master host FQDN](#fqdn-master) as shown in the [examples below](#connection-string).
   * [FQDNs](#fqdn) of all cluster hosts.

1. Provide the `target_session_attrs=read-write` parameter. This parameter is supported by the `libpq` library starting with [version 10](https://www.postgresql.org/docs/10/static/libpq-connect.html).

To upgrade the library version used by the `psql` utility:

* For Debian-based Linux distributions, install the `postgresql-client-10` package or higher (for example, using an [APT repository](https://www.postgresql.org/download/linux/ubuntu/)).
* For operating systems that use RPM packages, use the {{ PG }} distribution available from the [yum repository](https://yum.postgresql.org/).

## Connecting from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to public cluster hosts using SSL certificates.

{% include [note-connection-ide](../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

   1. Create a data source:
      1. Select **File** → **New** → **Data Source** → **{{ PG }}**.
      1. Specify the connection parameters on the **General** tab:
         * **User**, **Password**: DB user's name and password.
         * **URL**: Connection string:

            ```http
            jdbc:postgresql://<special_FQDN>:{{ port-mpg }}>/<DB_name>
            ```

            You can also use a list of all the cluster host [FQDNs](#fqdn) in the connection string:

            ```http
            jdbc:postgresql://<{{ PG }}_host_1:{{ port-mpg }}>,...,<{{ PG }}_host_N:{{ port-mpg }}>/<DB_name>
            ```

         * Click **Download** to download the connection driver.
      1. On the **SSH/SSL** tab:
         1. Enable the **Use SSL** setting.
         1. In the **CA file** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
   1. Click **Test Connection** to test the connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
   1. Click **OK** to save the data source.

- DBeaver {#dbeaver}

   1. Create a new DB connection:
      1. In the **Database** menu, select **New connection**.
      1. Select **{{ PG }}** from the DB list.
      1. Click **Next**.
      1. Specify the connection parameters on the **Main** tab:
         * **Host**: [Special master host FQDN](#fqdn-master) or [regular host FQDN](#fqdn).
         * **Port**: `{{ port-mpg }}`.
         * **Database**: DB to connect to.
         * Under **Authentication**, specify the DB user's name and password.
      1. On the **SSL** tab:
         1. Enable **Use SSL**.
         1. In the **Root certificate** field, specify the path to the saved [SSL certificate](#get-ssl-cert) file.
   1. Click **Test connection ...** to test the connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
   1. Click **Ready** to save the database connection settings.

{% endlist %}


## Connecting to a cluster from your browser {#browser}

{% include notitle [preview](../../_includes/note-preview.md) %}

Use [{{ websql-full-name }}](../../websql) to connect to a {{ PG }} cluster in {{ yandex-cloud }}.

{% include notitle [connect-to-cluster](../../_includes/websql/connect-to-cluster.md) %}

{% include notitle [execute-sql](../../_includes/websql/execute-sql.md) %}


## Connecting from {{ pgadmin }} {#connection-pgadmin}

The connection was tested for [{{ pgadmin }}](https://www.pgadmin.org) ver. 7.0 on Ubuntu 20.04.

You can only use {{ pgadmin }} to connect to public cluster hosts [using SSL certificates](#get-ssl-cert).

Create a new server connection:

1. Select **Object** → **Register** → **Server...**
1. On the **General** tab, in the **Name** field, specify the name for the cluster. This name will be shown in the {{ pgadmin }} interface. You can set any name.
1. In the **Connection** tab, specify the connection parameters:

   * **Host name/address**: [Special master host FQDN](#fqdn-master) or regular host [FQDN](../concepts/network.md#hostname).
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

   * **Host name or IP address**: [Special master host FQDN](#fqdn-master) or regular host [FQDN](../concepts/network.md#hostname).
   * **Port**: `{{ port-mpg }}`.
   * **Database**: DB to connect to.
   * **Username**: Username for connection.
   * **Password**: User password.

1. Select **Enable SSL** and **Enable client authentication**.
1. Specify the certificate files and the client private key in the respective fields:

   * **Server certificate**: Select the `CA.pem` file.
   * **Client certificate**: Select the `cert.pem` file.
   * **Client private key**: Select the `private.pem` file.

1. Click **Authenticate**.

## Before you connect from a Docker container {#connection-docker}

To connect to a {{ mpg-name }} cluster from a Docker container, add the following lines to the Dockerfile:


{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

   ```bash
   RUN apt-get update && \
       apt-get install postgresql-client --yes
   ```

   You can find an example of a connection from {{ serverless-containers-full-name }} in [this tutorial](../../serverless-containers/tutorials/pg-connect.md).

- Connecting via SSL {#with-ssl}

   ```bash
   RUN apt-get update && \
       apt-get install wget postgresql-client --yes && \
       mkdir --parents ~/.postgresql && \
       wget "{{ crt-web-path }}" \
            --output-document ~/.postgresql/root.crt && \
       chmod 0600 ~/.postgresql/root.crt
   ```

{% endlist %}


## Examples of connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mpg-conn-strings-env.md) %}

You can only connect to public {{ PG }} hosts using an SSL certificate. Prior to connecting to such hosts, [generate a certificate](#get-ssl-cert).

The examples below assume that the `root.crt` SSL certificate is located in the directory:

* `/home/<home_directory>/.postgresql/` for Ubuntu.
* `$HOME\AppData\Roaming\postgresql` for Windows.

Connecting without an SSL certificate is only supported for non-public hosts. If this is the case, internal cloud network traffic will not be encrypted for connecting to a database.

You can connect to a cluster using both regular host [FQDNs](../concepts/network.md#hostname) (you can send a comma-separated list consisting of several such FQDNs) and [special FQDNs](#special-fqdns). The examples use a special FQDN of the current master host.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mpg-connection-strings](../../_includes/mdb/mpg-conn-strings.md) %}

If the connection to the cluster and the test query are successful, the {{ PG }} version is output.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
