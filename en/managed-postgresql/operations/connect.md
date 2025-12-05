---
title: Connecting to a {{ PG }} cluster in {{ mpg-full-name }}
description: You can connect to {{ PG }} cluster hosts from {{ yandex-cloud }} VMs residing in the same virtual network. The hosts with configured public access will also be available from the internet.
---

# Connecting to a database in a {{ PG }} cluster

You can connect to {{ mpg-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/mpg/cluster-connect-note.md) %}

{% note warning %}

If only some cluster hosts have public access, an [automatic master failover](../concepts/replication.md#replication-auto) can make the master host unreachable from the internet.

{% endnote %}


## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the chosen connection method:

{% list tabs group=connection_method %}

- Via the internet {#internet}

  [Configure all cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port 6432 from any IP address. To do this, create the following ingress rule:

  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `6432`
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

- From a {{ yandex-cloud }} VM {#cloud}

  1. [Configure all cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port 6432 from the target VM’s security group. To do this, create the following ingress rule in these groups:

     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `6432`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM are in the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). Otherwise, specify the VM security group.

  1. [Configure the VM security group](../../vpc/operations/security-group-add-rule.md) to allow VM connections and traffic between the VM and the cluster hosts.

     For example, you can set the following rules for your VM:

     * For incoming traffic:
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

       This rule allows VM [connections](../../compute/operations/vm-connect/ssh.md#vm-connect) over SSH.

     * For outgoing traffic:
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

       This rule allows all outgoing traffic, thus enabling you not only to connect to the cluster but also to install the certificates and utilities your VM needs for the connection.

{% endlist %}

{% note info %}

You can specify more granular rules for your security groups, such as allowing traffic only within specific subnets.

All subnets containing cluster hosts must have properly configured security groups. With incomplete or incorrect security group settings, you may lose access to the cluster if a [manual](hosts.md#update) or [automatic](../concepts/replication.md#replication-auto) master failover occurs.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).


## Obtaining an SSL certificate {#get-ssl-cert}

Publicly accessible {{ PG }} hosts only support encrypted connections. You must obtain an SSL certificate to connect to them:

{% include [install-certificate](../../_includes/mdb/mpg/install-certificate.md) %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## {{ PG }} host FQDN {#fqdn}

To connect to a host, you will need its [FQDN](../concepts/network.md#hostname). You can get it using one of the following methods:

* [Request a list of cluster hosts](../operations/hosts.md#list-hosts).
* In the [management console]({{ link-console-main }}), copy the command for connecting to the cluster. This command contains the host FQDN. To get the command, go to the cluster page and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
* View the FQDN in the management console:

   1. Navigate to the cluster page.
   1. Navigate to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

Cluster hosts also use [special FQDNs](#special-fqdns).

## Special FQDNs {#special-fqdns}

Alongside [regular FQDNs](#fqdn), {{ mpg-name }} offers special FQDNs that can be also used for cluster connections.

{% include [special-fqdns-info](../../_includes/mdb/special-fqdns-info.md) %}

### Current master {#fqdn-master}

An FQDN in `c-<cluster_ID>.rw.{{ dns-zone }}` format always points to the current master host in the cluster. You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

When connecting to this FQDN, you can perform read and write operations.

{% include [special-fqdns-warning](../../_includes/mdb/special-fqdns-warning.md) %}

### Most recent replica {#fqdn-replica}

An FQDN in `c-<cluster_ID>.ro.{{ dns-zone }}` format points to the most up-to-date [replica](../concepts/replication.md). You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

**Specifics:**

* When connecting to this FQDN, you can only perform read operations.
* If there are no active replicas in the cluster, this FQDN will point to the current master host.
* Replicas with a [manually configured replication source](../concepts/replication.md#replication-manual) cannot be selected as most up-to-date replicas when using this FQDN.

## Selecting an FQDN and cluster connection method {#automatic-master-host-selection}

You can connect to a cluster using its [host FQDNs](#fqdn) or [special FQDNs](#special-fqdns): If the cluster [consists of multiple hosts](../concepts/planning-cluster-topology.md) and has [autofailover](../concepts/replication.md#replication-auto) enabled, you must account for this when connecting. This is important because the current master can become a replica at any moment, and vice versa.

{% note warning %}

If automatic failover promotes a host without public access to master or most up-to-date replica, that host will be unreachable from the internet. To avoid this, [enable public access](hosts.md#update) for all cluster hosts.

{% endnote %}

Use one of the following methods to connect to the master host with read and write access:

* Connect using the [special FQDN](#fqdn-master) pointing to the current master.

    After a master failover, this FQDN may temporarily point to the previous master, now a replica, due to the time required for the DNS record to update.

    Therefore, applications using this FQDN must be designed to handle temporary master unavailability. For example, they should retry write requests after a short delay.

    {% cut "Connection example" %}

    In this example, we use the `c9qash3nb1v9********` cluster ID:

    ```bash
    psql "host=c-c9qash3nb1v9********.rw.{{ dns-zone }} \
          port={{ port-mpg }} \
          sslmode=verify-full \
          dbname=<DB_name> \
          user=<username>"
    ```

    {% endcut %}

* Connect by listing all cluster hosts and specifying `target_session_attrs=read-write`.

    {% cut "Connection example" %}

    Here, we list all the cluster’s hosts.

    The host IDs are `rc1a-be***.{{ dns-zone }}`, `rc1b-5r***.{{ dns-zone }}`, and `rc1d-t4***.{{ dns-zone }}`:

    ```bash
    psql "host=rc1a-be***.{{ dns-zone }},rc1b-5r***.{{ dns-zone }},rc1d-t4***.{{ dns-zone }} \
          port={{ port-mpg }} \
          sslmode=verify-full \
          dbname=<DB_name> \
          user=<username> \
          target_session_attrs=read-write"
    ```

    {% endcut %}

Use one of the following methods to connect to the host with read access:

* Connect using a [special FQDN](#fqdn-replica) pointing to the most up-to-date replica.

    {% cut "Connection example" %}

    In this example, we use the `c9qash3nb1v9********` cluster ID:

    ```bash
    psql "host=c-c9qash3nb1v9********.ro.{{ dns-zone }} \
          port={{ port-mpg }} \
          sslmode=verify-full \
          dbname=<DB_name> \
          user=<username>"
    ```

    {% endcut %}

* Connect by listing all cluster hosts and specifying `target_session_attrs=any`.

    {% cut "Connection example" %}

    Here, we list all the cluster’s hosts.

    The host IDs are `rc1a-be***.{{ dns-zone }}`, `rc1b-5r***.{{ dns-zone }}`, and `rc1d-t4***.{{ dns-zone }}`:

    ```bash
    psql "host=rc1a-be***.{{ dns-zone }},rc1b-5r***.{{ dns-zone }},rc1d-t4***.{{ dns-zone }} \
          port={{ port-mpg }} \
          sslmode=verify-full \
          dbname=<DB_name> \
          user=<username> \
          target_session_attrs=any"
    ```

    {% endcut %}

{% note info %}

You can use the `target_session_attrs` parameter when connecting via a client utilizing the `libpq` library.

Support for the `read-write` value in this parameter was introduced in `libpq` [version 10](https://www.postgresql.org/docs/10/static/libpq-connect.html).

{% cut "How to update the library version used by `psql`" %}

* For Debian-based Linux distributions, install the `postgresql-client-10` package or a newer version (e.g., from the [official APT repository](https://www.postgresql.org/download/linux/ubuntu/)).
* For RPM-based operating systems, install the {{ PG }} distribution from the [yum repository](https://yum.postgresql.org/).

{% endcut %}

{% endnote %}


## Connecting from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

From graphical IDEs, you can only connect to public cluster hosts using an SSL certificate.

{% include [note-connection-ide](../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

  1. Create a data source:
     1. Select **File** → **New** → **Data Source** → **{{ PG }}**.
     1. Specify the connection settings on the **General** tab:
        * **User**, **Password**: Database user name and password.
        * **URL**: Connection string:

          ```http
          jdbc:postgresql://<special_FQDN>:{{ port-mpg }}/<DB_name>
          ```

          You can also use a list of all cluster host [FQDNs](#fqdn) in the connection string:

          ```http
          jdbc:postgresql://<{{ PG }}_host_1>:{{ port-mpg }},...,<{{ PG }}_host_N>:{{ port-mpg }}/<DB_name>
          ```

        * Click **Download** to download the connection driver.
     1. On the **SSH/SSL** tab:
         1. Enable **Use SSL**.
         1. In the **CA file** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
  1. Click **Test Connection**. If the connection is successful, you will see the connection status and information about the DBMS and driver.
  1. Click **OK** to save the data source.

- DBeaver {#dbeaver}

  1. Create a new database connection:
     1. In the **Database** menu, select **New connection**.
     1. Select **{{ PG }}** from the database list.
     1. Click **Next**.
     1. Specify the connection settings on the **Main** tab:
        * **Host**: [Master FQDN](#fqdn-master) or [regular host FQDN](#fqdn).
        * **Port**: `{{ port-mpg }}`.
        * **Database**: Target database name.
        * Under **Authentication**, specify the database user name and password.
     1. On the **SSL** tab:
         1. Enable **Use SSL**.
         1. In the **Root certificate** field, specify the path to the saved [SSL certificate](#get-ssl-cert) file.
  1. Click **Test Connection ...**. If the connection is successful, you will see the connection status and information about the DBMS and driver.
  1. Click **Done** to save the database connection settings.

{% endlist %}




## Connecting from {{ websql-full-name }} {#websql}

{% include [WebSQL](../../_includes/mdb/mpg/websql.md) %}




## Connecting from {{ pgadmin }} {#connection-pgadmin}

Connection testing was performed for [{{ pgadmin }}](https://www.pgadmin.org) version 7.0 on Ubuntu 20.04.

Connections from {{ pgadmin }} are only permitted to publicly accessible cluster hosts and require an [SSL certificate](#get-ssl-cert).

Create a new server connection:

1. Select **Object** → **Register** → **Server...**
1. On the **General** tab, in the **Name** field, specify the cluster name to be shown in the {{ pgadmin }} interface. You can set any name.
1. In the **Connection** tab, specify the connection settings:

    * **Host name/address**: [Master FQDN](#fqdn-master) or regular host [FQDN](../concepts/network.md#hostname).
    * **Port**: `{{ port-mpg }}`.
    * **Maintenance database**: Target database name.
    * **Username**: Username used to establish the connection.
    * **Password**: User password.

1. In the **Parameters** tab:

    * Set the **SSL mode** parameter to `verify-full`.
    * Add a new **Root certificate** parameter and specify the path to the saved SSL certificate file in it.

1. Click **Save** to save the server connection settings.

Your cluster will appear in the server list located in the navigation menu.


## Connecting from {{ google-looker }} {#connection-google-looker}

Connections from [{{ google-looker }}](https://lookerstudio.google.com/overview) are only permitted to publicly accessible hosts.

1. Save the `CA.pem` [server certificate]({{ crt-web-path }}) to a local directory.
1. In the same directory, generate a client certificate with a private key:

    ```bash
    openssl req -newkey rsa:2048 -nodes -keyout private.pem -out cert.pem
    ```

    During certificate creation, the program will ask you to modify several settings. Press **Enter** to keep the default values.

    You will see two files in your local directory: `cert.pem` and `private.pem`.

1. On the [{{ google-looker }} navigation page](https://lookerstudio.google.com/navigation/reporting), select **Create** → **Data source**.
1. Select {{ PG }}.
1. Fill out the fields as follows:

    * **Host name or IP address**: [Master FQDN](#fqdn-master) or regular host [FQDN](../concepts/network.md#hostname).
    * **Port**: `{{ port-mpg }}`.
    * **Database**: Target database name.
    * **Username**: Username used to establish the connection.
    * **Password**: User password.

1. Check **Enable SSL** and **Enable client authentication**.
1. Specify the certificate files and the client private key in the appropriate fields:

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

    See the {{ serverless-containers-full-name }} connection example in [this tutorial](../../serverless-containers/tutorials/pg-connect.md).

- Connecting with SSL {#with-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install wget postgresql-client --yes && \
        mkdir --parents ~/.postgresql && \
        wget "{{ crt-web-path }}" \
             --output-document ~/.postgresql/root.crt && \
        chmod 0655 ~/.postgresql/root.crt
    ```

{% endlist %}


## Connection strings examples {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mpg-conn-strings-env.md) %}

Connections to public {{ PG }} hosts require an SSL certificate. [Prepare a certificate](#get-ssl-cert) before connecting to such hosts.

The examples below assume that the `root.crt` SSL certificate is located in the following directory:

* `/home/<home_directory>/.postgresql/` for Ubuntu.
* `$HOME\AppData\Roaming\postgresql` for Windows.

Connections without an SSL certificate are only supported for hosts that are not publicly accessible. In this case, internal cloud network traffic will not be encrypted during database connections.

You can connect to a cluster using either regular host [FQDNs](../concepts/network.md#hostname), including a comma-separated list of several FQDNs, or [special FQDNs](#special-fqdns). In our examples, we use the special FQDN pointing to the current master host.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mpg-connection-strings](../../_includes/mdb/mpg-conn-strings.md) %}

If your cluster connection and test query are successful, you will see the {{ PG }} version. One exception is the [userver framework example](#cpp-userver), where the `SELECT 1 as ping` test query will be executed for periodic {{ PG }} cluster availability checks.
