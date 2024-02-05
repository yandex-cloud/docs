---
title: "How to connect to a database in a {{ CH }} cluster in {{ mch-full-name }}"
description: "Follow this guide to connect to a database in a {{ CH }} cluster."
---

# Connecting to a database in a {{ CH }} cluster

You can connect to {{ mch-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/mch/cluster-connect-note.md) %}


You can connect to a cluster both using encryption via ports `{{ port-mch-cli }}` for [clickhouse-client]({{ ch.docs }}/interfaces/cli/) and `{{ port-mch-http }}` for the [HTTP interface]({{ ch.docs }}/interfaces/http/) and without encryption via ports `9000` and `8123`, respectively.



## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the connection method you select:

{% list tabs %}

- Over the internet

   [Configure all security groups](../../vpc/operations/security-group-add-rule.md) in a cluster to allow incoming traffic on ports 8443 and 9440 from any IP address. To do this, create the following rules for incoming traffic:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `8443`, `9440`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

   A separate rule is created for each port.

- From a VM in {{ yandex-cloud }}

   1. [Configure all the security groups](../../vpc/operations/security-group-add-rule.md) of your cluster to allow incoming traffic on ports 8123, 8443, 9000, and 9440 from the security group where your VM is located. To do this, create the following rules for incoming traffic in these security groups:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `8123` (or any of the other ports listed).
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM are in the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`) as the value. Otherwise, specify the VM security group.

      A separate rule is created for each port.

   1. [Configure the security group](../../vpc/operations/security-group-add-rule.md) where the VM is located to enable connections to the VM and traffic between the VM and the cluster hosts.

      For example, you can set the following rules for a VM:

      * For incoming traffic:
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         This rule allows you to [connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.

      * For outgoing traffic:
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         This rule allows all outgoing traffic, which enables you to both connect to the cluster and install the certificates and utilities the VMs need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If the security group settings are incomplete or incorrect, you might lose access the cluster.

{% endnote %}

For more information about security groups, see [DB network and clusters](../concepts/network.md#security-groups).


## Getting your SSL certificates {#get-ssl-cert}

To use an encrypted connection, get your SSL certificates:

{% include [install-certificate](../../_includes/mdb/mch/install-certificate.md) %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## {{ CH }} host FQDN {#fqdn}

To connect to a host, you need its fully qualified domain name ([FQDN](../concepts/network.md#hostname)). You can obtain it in one of the following ways:

* [Request a list of cluster hosts](../operations/hosts.md#list-hosts).
* In the [management console]({{ link-console-main }}), copy the command for connecting to the cluster. This command contains the host FQDN. To get the command, go to the cluster page and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-connect }}**.
* Look up the FQDN in the management console:

   1. Go to the cluster page.
   1. Go to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

Cluster hosts also use [special FQDNs](#auto).

### Selecting an available host automatically {#auto}

If you do not want to manually connect to another host in case the current one becomes unavailable, use a special FQDN. It can be in one of the following formats:

* `c-<cluster_ID>.rw.{{ dns-zone }}` : To connect to an available cluster host.

* `<shard_name>.c-<cluster_ID>.rw.{{ dns-zone }}` : To connect to an available [shard](../concepts/sharding.md) host.

If the host an FQDN points to becomes unavailable, there may be a slight delay before the FQDN starts pointing to another available host.

{% note warning %}

If, under [cluster maintenance](../concepts/maintenance.md#maintenance-order), a special FQDN points to a host with no public access enabled, the cluster cannot be connected to from the internet. To avoid this, [enable public access](hosts.md#update) for all cluster hosts.

{% endnote %}

## Connecting from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to public cluster hosts using SSL certificates.

{% include [note-connection-ide](../../_includes/mdb/note-connection-ide.md) %}

{% list tabs %}

- DataGrip

   1. Create a data source:
      1. Select **File** → **New** → **Data Source** → **{{ CH }}**.
      1. On the **General** tab:
         1. Specify the connection parameters:
            * **Host**: [Any {{ CH }} host FQDN](#fqdn) or a [special FQDN](#auto).
            * **Port**: `{{ port-mch-http }}`.
            * **User**, **Password**: DB user's name and password.
            * **Database**: Name of the DB to connect to.
         1. Click **Download** to download the connection driver.
      1. On the **SSH/SSL** tab:
         1. Enable the **Use SSL** setting.
         1. Specify the path to the directory that contains the file with the downloaded [SSL certificate for the connection](#get-ssl-cert).
   1. Click **Test Connection** to test the connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
   1. Click **OK** to save the data source.

- DBeaver

   1. Create a new DB connection:
      1. In the **Database** menu, select **New connection**.
      1. Select **{{ CH }}** from the DB list.
      1. Click **Next**.
      1. Specify the connection parameters on the **Main** tab:
         * **Host**: [FQDN of any {{ CH }} host](#fqdn) or a [special FQDN](#auto).
         * **Port**: `{{ port-mch-http }}`.
         * **DB/Schema**: Name of the DB to connect to.
         * Under **Authentication**, specify the DB user's name and password.
      1. On the **Driver properties** tab:
         1. Click **Download** in a new window with an invitation to download the driver files.
         1. Specify the [SSL connection](#get-ssl-cert) parameters in the driver property list:
            * `ssl:true`
            * `sslrootcert:<path_to_SSL_certificate_file_saved>`
   1. Click **Test connection ...** to test the connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
   1. Click **Ready** to save the database connection settings.

{% endlist %}

## Before you connect from a Docker container {#connection-docker}

To connect to a {{ mch-name }} cluster from a Docker container, add the following lines to the Dockerfile:

{% list tabs group=connection %}


- Connecting without SSL {#without-ssl}

   ```bash
   # Connect the DEB repository.
   RUN apt-get update && \
       apt-get install wget --yes apt-transport-https ca-certificates dirmngr && \
       apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD******** && \
       echo "deb https://packages.{{ ch-domain }}/deb stable main" | tee \
       /etc/apt/sources.list.d/clickhouse.list && \
       # Install dependencies.
       apt-get update && \
       apt-get install wget clickhouse-client --yes && \
       # Upload a configuration file for clickhouse-client.
       mkdir --parents ~/.clickhouse-client && \
       wget "https://{{ s3-storage-host }}/doc-files/clickhouse-client.conf.example" \
            --output-document ~/.clickhouse-client/config.xml
   ```


- Connecting via SSL {#with-ssl}


   ```bash
   # Connect the DEB repository.
   RUN apt-get update && \
       apt-get install wget --yes apt-transport-https ca-certificates dirmngr && \
       apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD******** && \
       echo "deb https://packages.{{ ch-domain }}/deb stable main" | tee \
       /etc/apt/sources.list.d/clickhouse.list && \
       # Install dependencies.
       apt-get update && \
       apt-get install wget clickhouse-client --yes && \
       # Upload a configuration file for clickhouse-client.
       mkdir --parents ~/.clickhouse-client && \
       wget "https://{{ s3-storage-host }}/doc-files/clickhouse-client.conf.example" \
            --output-document ~/.clickhouse-client/config.xml && \
       # Get SSL certificates.
       mkdir --parents {{ crt-local-dir }} && \
       wget "{{ crt-web-path-root }}" \
            --output-document {{ crt-local-dir }}{{ crt-local-file-root }} && \
       wget "{{ crt-web-path-int }}" \
            --output-document {{ crt-local-dir }}{{ crt-local-file-int }} && \
       chmod 655 \
            {{ crt-local-dir }}{{ crt-local-file-root }} \
            {{ crt-local-dir }}{{ crt-local-file-int }} && \
       update-ca-certificates
   ```


{% endlist %}


## Connecting to a cluster from your browser {#browser-connection}

To run SQL queries from your browser, use:

* [Management console](#console)

* [Built-in SQL editor](#inline-editor)


* [{{ websql-full-name }} service](#websql)


When connecting from the browser, SQL queries are executed separately, without creating a session shared with the {{ CH }} server. Therefore, queries running within a session (for example, `USE` or `SET`) have no impact.

### Management console {#console}

{% include [web-sql-warning](../../_includes/mdb/mch/note-web-sql-console.md) %}

To connect to a {{ mch-name }} cluster, log in to the [management console]({{ link-console-main }}), open the cluster page you need, and go to the **{{ ui-key.yacloud.clickhouse.cluster.switch_explore }}** tab.

To allow connections, activate the **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}** option when [creating a cluster](cluster-create.md) or [changing its settings](update.md#change-additional-settings).

For more information, see [{#T}](web-sql-query.md).

### Built-in SQL editor {#inline-editor}



To connect to a cluster host from the built-in SQL editor, specify the following in the browser address bar:

```text
https://<FQDN_of_any_{{ CH }}_host>:8443/play
```

You can only connect to publicly accessible cluster hosts. To learn how to get a host FQDN, see [this guide](#fqdn).

To connect to a cluster by [selecting an available host automatically](#auto), use the following URL:

* `https://c-<cluster_ID>.rw.{{ dns-zone }}:8443/play` to connect to the available cluster host.
* `https://<shard_name>.c-<cluster_ID>.rw.{{ dns-zone }}:8443/play` to connect to the available [shard](../concepts/sharding.md) host.

To make a query to the database, specify the username and password in the upper-right corner.



### {{ websql-full-name }} service {#websql}

{% include notitle [preview](../../_includes/note-preview.md) %}

In [{{ websql-full-name }}](../../websql), create a connection to a {{ CH }} cluster in {{ yandex-cloud }}.

{% include notitle [connect-to-cluster](../../_includes/websql/connect-to-cluster.md) %}

{% include notitle [execute-sql](../../_includes/websql/execute-sql.md) %}


## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

You can only connect to public {{ CH }} cluster hosts with your SSL certificates. Before connecting, [prepare your certificates](#get-ssl-cert).

In the examples below, it is assumed that the `{{ crt-local-file-root }}` and `{{ crt-local-file-int }}` certificates:
* Are located in the `{{ crt-local-dir }}` directory (for Ubuntu).
* Are imported to the Trusted Root Certificate store (for Windows).

Connecting without any SSL certificates is only supported for hosts that are not publicly accessible. For connections to the database, traffic inside the virtual network is not encrypted in this case.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

If the connection to the cluster and the test query are successful, the {{ CH }} version is output.

{% include [mch-connection-strings](../../_includes/mdb/mch-conn-strings.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
