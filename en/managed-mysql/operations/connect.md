---
title: "How to connect to a database in a {{ MY }} cluster in {{ mmy-full-name }}"
description: "Follow this guide to connect to a database in a {{ MY }} cluster."
---

# Connecting to a database in a {{ MY }} cluster

You can connect to {{ mmy-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/mmy/cluster-connect-note.md) %}

{% note warning %}

If only some cluster hosts have public access configured, the master may not be accessible from the internet when it [changes automatically](../concepts/replication.md#master-failover).

{% endnote %}

The maximum number of connections is defined by the [Max connections](../concepts/settings-list.md#setting-max-connections) setting that [depends on the host class](../concepts/settings-list.md#settings-instance-dependent).

For more information, see [{#T}](../concepts/network.md).


## Configuring security groups {#configure-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the connection method you select:

{% list tabs group=connection_method %}

- Over the internet {#internet}

   [Configure all the cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port {{ port-mmy }} from any IP address. To do this, create the following rule for incoming traffic:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mmy }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

- From a VM in {{ yandex-cloud }} {#cloud}

   1. [Configure all the cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on the {{ port-mmy }} port from the security group where the VM is located. To do this, create the following rule for incoming traffic in these groups:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mmy }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
      * Security group: If a cluster and a VM are in the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`) as the value. Otherwise, specify the VM security group.

   1. [Configure the security group](../../vpc/operations/security-group-add-rule.md) where the VM is located to enable connections to the VM and traffic between the VM and the cluster hosts.

      For example, you can set the following rules for a VM:

      * For incoming traffic:
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         This rule allows you to [connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.

      * For outgoing traffic:
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         This rule allows all outgoing traffic, thus enabling you not only to connect to the cluster but also to install the certificates and utilities your VM needs for the connection.

{% endlist %}

{% note info %}

You can specify more detailed rules for your security groups, e.g., to allow traffic only in specific subnets.

You must configure security groups correctly for all subnets in which the cluster hosts will reside. If security group settings are incomplete or incorrect, you may lose access to the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).


## Getting an SSL certificate {#get-ssl-cert}

{{ MY }} hosts with public access only support encrypted connections. To use them, get an SSL certificate:

{% include [install-certificate](../../_includes/mdb/mmy/install-certificate.md) %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## {{ MY }} host FQDN {#fqdn}

To connect to a host, you need its fully qualified domain name ([FQDN](../concepts/network.md#hostname)). You can obtain it in one of the following ways:

* [Request a list of cluster hosts](../operations/hosts.md#list).
* In the [management console]({{ link-console-main }}), copy the command for connecting to the cluster. This command contains the host FQDN. To get the command, go to the cluster page and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-connect }}**.
* Look up the FQDN in the management console:

   1. Go to the cluster page.
   1. Go to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

Cluster hosts also use [special FQDNs](#special-fqdns).

## Special FQDNs {#special-fqdns}

Alongside regular FQDNs, {{ mmy-name }} provides several special FQDNs, which can also be used when connecting to a cluster.

{% note warning %}

If, when the [master host is changed automatically](../concepts/replication.md#master-failover), a host with no public access becomes a new master or the most recent replica, you will not be able to access them from the internet. To avoid this, [enable public access](../operations/hosts.md#update) for all cluster hosts.

{% endnote %}

### Current master {#fqdn-master}

Such FQDN as `c-<cluster_ID>.rw.{{ dns-zone }}` always points to the current cluster master host. You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

When connecting to this FQDN, both read and write operations are allowed.

Here is an example of connecting to a master host for a cluster with the `c9qash3nb1v9********` ID:

```bash
mysql --host=c-c9qash3nb1v9********.rw.{{ dns-zone }} \
      --port=3306 \
      --ssl-ca=~/.mysql/root.crt \
      --ssl-mode=VERIFY_IDENTITY \
      --user=<username> \
      --password \
      <DB_name>
```

### Most recent replica {#fqdn-replica}

Such FQDN as `c-<cluster_ID>.ro.{{ dns-zone }}` points to the most recent [replica](../concepts/replication.md), i.e., the one most up-to-date with the master host. You can request the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

**Specifics:**

* When connecting to this FQDN, only read operations are allowed.
* If there are no active replicas in a cluster, you cannot connect to this FQDN, as the respective DNS CNAME record will point to a `null` object.

Here is an example of connecting to the most recent replica for a cluster with the `c9qash3nb1v9********` ID:

```bash
mysql --host=c-c9qash3nb1v9********.ro.{{ dns-zone }} \
      --port=3306 \
      --ssl-ca=~/.mysql/root.crt \
      --ssl-mode=VERIFY_IDENTITY \
      --user=<username> \
      --password \
      <DB_name>
```

## Connecting from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to public cluster hosts using SSL certificates.

{% include [note-connection-ide](../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

   1. Create a data source:
      1. Select **File** → **New** → **Data Source** → **{{ MY }}**.
      1. On the **General** tab:
         1. Specify the connection parameters:
            * **Host**: [Any {{ MY }} host FQDN](#fqdn) or a [special FQDN](#special-fqdns).
            * **Port**: `{{ port-mmy }}`.
            * **User**, **Password**: DB user's name and password.
            * **Database**: Name of the DB to connect to.
         1. Click **Download** to download the connection driver.
      1. On the **SSH/SSL** tab:
         1. Enable the **Use SSL** setting.
         1. In the **CA file** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
   1. To test the connection, click **Test Connection**. If the connection is successful, you will see the connection status and information about the DBMS and driver.
   1. Click **OK** to save the data source.

- DBeaver {#dbeaver}

   1. Create a new DB connection:
      1. In the **Database** menu, select **New connection**.
      1. Select **{{ MY }}** from the DB list.
      1. Click **Next**.
      1. Specify the connection parameters on the **Main** tab:
         * **Server**: [FQDN of any {{ MY }} host](#fqdn) or a [special FQDN](#special-fqdns).
         * **Port**: `{{ port-mmy }}`.
         * **Database**: DB to connect to.
         * **Username**, **Password**: DB username and password.
      1. On the **SSL** tab:
         1. Enable **Use SSL**.
         1. In the **Root certificate** field, specify the path to the saved [SSL certificate](#get-ssl-cert) file.
         1. Under **Advanced**:
            1. Enable **Require SSL**.
            1. Enable **Verify server certificate**.
   1. Click **Test connection ...** to test the connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
   1. Click **Ready** to save the database connection settings.

{% endlist %}


## Connecting to a cluster from your browser {#browser}

Use [{{ websql-full-name }}](../../websql) to connect to {{ MY }} clusters in {{ yandex-cloud }}.

{% include notitle [preview](../../_includes/note-preview.md) %}

{% include notitle [connect-to-cluster](../../_includes/websql/connect-to-cluster.md) %}

{% include notitle [execute-sql](../../_includes/websql/execute-sql.md) %}


## Before you connect from a Docker container {#connection-docker}

To connect to a {{ mmy-name }} cluster from a Docker container, add the following lines to the Dockerfile:

{% list tabs group=connection %}


- Connecting without SSL {#without-ssl}

   ```bash
   RUN apt-get update && \
       apt-get install mysql-client --yes
   ```


- Connecting via SSL {#with-ssl}

   ```bash
   RUN apt-get update && \
       apt-get install wget mysql-client --yes && \
       mkdir --parents ~/.mysql && \
       wget "{{ crt-web-path }}" \
            --output-document ~/.mysql/root.crt && \
       chmod 0600 ~/.mysql/root.crt
   ```

{% endlist %}

## Examples of connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

You can only connect to publicly accessible {{ MY }} hosts using an SSL certificate.

{% include [mmy-connection-strings](../../_includes/mdb/mmy/code-examples.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
