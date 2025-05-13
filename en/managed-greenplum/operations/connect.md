# Connecting to a database

Because the {{ GP }} DBMS is based on {{ PG }}, the same tools are used to connect to both DBMSs.

You can connect to a {{ mgp-short-name }} cluster only via the [primary master host](../concepts/index.md). To identify host roles, get a [list of hosts in the cluster](cluster-list.md#get-hosts).

You can connect to a cluster:

{% include [cluster-connect-note-monolithic](../../_includes/mdb/cluster-connect-note-monolithic.md) %}


## Configuring security groups {#configuring-security-groups}

You can assign one or more security groups to a {{ mgp-name }} cluster. To connect to a cluster, security groups must include rules allowing traffic on {{ port-mgp }} port from certain IP addresses or other security groups.

{% note info %}

A security group assigned to a cluster controls traffic between the cluster and other cloud or external resources. You do not need to configure interaction between cluster hosts as it is controlled by a separate system security group.

{% endnote %}

Rule settings depend on the connection method you select:

{% list tabs group=connection_method %}

- Over the internet {#internet}

    {% include [Cluster security group rules](../../_includes/mdb/mgp/cluster-sg-rules.md) %}

- From a VM in {{ yandex-cloud }} {#cloud}

    1. Add the following rules to the cluster security group:

        1. For incoming traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mgp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM are in the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). Otherwise, specify the VM security group.

         1. For outgoing traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

            This rule enables {{ mgp-name }} to use external data sources, e.g., PXF or GPFDIST.

    1. [Configure the security group](../../vpc/operations/security-group-add-rule.md) where the VM is located to allow connections to the VM and traffic between the VM and the cluster hosts.

        * For incoming traffic:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: Range of addresses to connect from.

            This rule allows you to connect to a VM over SSH.

        * For outgoing traffic:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

            This rule allows all outgoing traffic, thus enabling you not only to connect to the cluster but also to install the certificates and utilities your VM needs for the connection.

{% endlist %}



## Getting an SSL certificate {#get-ssl-cert}

To use an SSL connection, get a certificate:

{% include [install-certificate](../../_includes/mdb/mgp/install-certificate.md) %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## {{ GP }} host FQDN {#fqdn}

To connect to a master host, you need its [FQDN](../concepts/network.md#hostname). You can use the FQDN of a particular host in the cluster or a [special FQDN](#fqdn-master) always pointing to the primary master host.

Host FQDN example:

```text
{{ host-name }}.{{ dns-zone }}
```

### Getting host FQDN {#get-fqdn}

You can obtain the {{ GP }} host FQDN by doing one of the following:

* Look up the FQDN in the management console:

    1. Go to the cluster page.
    1. Navigate to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

* In the [management console]({{ link-console-main }}), copy the command for connecting to the cluster. This command contains the host FQDN. To get the command, go to the cluster page and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.

* [Request a list of cluster hosts](cluster-list.md#get-hosts) using the CLI or API.

### Special primary master FQDN {#fqdn-master}

If you do not want to manually connect to another master host when the current one becomes unavailable, use a special FQDN in `c-<cluster_ID>.rw.{{ dns-zone }}` format. It always points to the primary master host in the cluster. Connection to this FQDN is permitted and both read and write operations are allowed.

Here is an example of connecting to a primary master host in a cluster with the `{{ cluster-id }}` ID:

```bash
psql "host=c-{{ cluster-id }}.rw.{{ dns-zone }} \
      port={{ port-mgp }} \
      sslmode=verify-full \
      dbname=<DB_name> \
      user=<username>"
```

## Connecting from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to a public cluster using SSL certificates.

{% include [note-connection-ide](../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

    1. Create a data source:

        1. Select **File** → **New** → **Data Source** → **{{ GP }}**.
        1. On the **General** tab:

            1. Specify the connection settings:

                * **User**, **Password**: DB user's name and password.
                * **URL**: Connection string. Use the [special primary master FQDN](#fqdn-master):

                    ```http
                    jdbc:postgresql://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mgp }}/<DB_name>
                    ```

            1. Click **Download** to download the connection driver.
        1. On the **SSH/SSL** tab:
            1. Enable the **Use SSL** setting.
            1. In the **CA file** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
    1. Click **Test Connection** to test the connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
    1. Click **OK** to save the data source.

- DBeaver {#dbeaver}

    1. Create a new DB connection:
        1. In the **Database** menu, select **New connection**.
        1. Select **{{ GP }}** from the DB list.
        1. Click **Next**.
        1. Specify the connection parameters on the **Main** tab:
            * **Host**: [Special FQDN of the primary master](#fqdn-master), `c-<cluster_ID>.rw.{{ dns-zone }}`.
            * **Port**: `{{ port-mgp }}`.
            * **Database**: DB to connect to.
            * Under **Authentication**, specify the DB user's name and password.
        1. On the **SSL** tab:
            1. Enable **Use SSL**.
            1. In the **Root certificate** field, specify the path to the saved [SSL certificate](#get-ssl-cert) file.
    1. Click **Test Connection ...** to test the connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
    1. Click **Ready** to save the database connection settings.

{% endlist %}

## Connecting from {{ pgadmin }} {#connection-pgadmin}

The connection has been checked for [{{ pgadmin }}](https://www.pgadmin.org) ver. 7.1 on macOS Ventura 13.0 and Microsoft Windows 10 Pro 21H1.

You can only use {{ pgadmin }} to connect to public cluster hosts [using an SSL certificate](#get-ssl-cert).

Create a new server connection:

1. Select **Object** → **Register** → **Server...**
1. On the **General** tab, in the **Name** field, specify the name for the cluster. This name will be shown in the {{ pgadmin }} interface. You can set any name.
1. In the **Connection** tab, specify the connection parameters:

    * **Host name/address**: [Special master host FQDN](#fqdn-master) or regular host FQDN.
    * **Port**: `{{ port-mgp }}`.
    * **Maintenance database**: Name of the `postgres` maintenance database.
    * **Username**: Username for connection.
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

## Before you connect from a Docker container {#connection-docker}

To connect to a {{ mgp-name }} cluster from a Docker container, add the following lines to the Dockerfile:

{% list tabs group=connection %}


- Connecting without SSL {#without-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install postgresql-client --yes
    ```


- Connecting via SSL {#with-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install wget postgresql-client --yes && \
        mkdir --parents ~/.postgresql && \
        wget "{{ crt-web-path }}" \
             --output-document ~/.postgresql/root.crt && \
        chmod 0655 ~/.postgresql/root.crt
    ```

{% endlist %}

## Examples of connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mgp/conn-strings-env.md) %}

When creating a {{ GP }} cluster, the user database is not created. To test the connection, use the `postgres` service database.

To connect to a publicly accessible cluster, prepare an [SSL certificate](#get-ssl-cert). The examples assume that the `root.crt` SSL certificate is located in the following directory:

* `/home/<home_directory>/.postgresql/` for Ubuntu.
* `$HOME\AppData\Roaming\postgresql` for Windows.

You can connect to a cluster using either a master host's regular FQDN or a primary master host's [special FQDN](#fqdn-master). To learn how to get host FQDN, see [this guide](#fqdn).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mgp-connection-strings](../../_includes/mdb/mgp/conn-strings.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
