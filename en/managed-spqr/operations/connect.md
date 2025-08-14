---
title: Connecting to a {{ SPQR }} cluster
description: Follow this guide to connect to a {{ SPQR }} cluster.
---

# Connecting to a {{ SPQR }} cluster

You can connect to {{ mspqr-name }} cluster hosts:

* Over the internet, if you configured public access for the appropriate host. You can only access such hosts over an SSL connection.

* From {{ yandex-cloud }} VMs located in the same [cloud network](../../vpc/concepts/network.md). If the host is not publicly accessible, there is no need to use SSL for connections from such virtual machines.

You can connect to all [host types](../concepts/index.md): `INFRA`, `ROUTER`, `COORDINATOR`, {{ PG }} cluster hosts. The connection is established through port {{ port-mpg }}. In the case of `COORDINATOR` hosts and the {{ SPQR }} admin console, you must connect as the `spqr-console` user to the `spqr-console` database. You can use the admin console to configure sharding rules. For more information, see the [SPQR documentation](https://pg-sharding.tech/welcome/get_started).


## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the connection method you select:

{% list tabs group=connection_method %}

- Over the internet {#internet}

    [Configure all the cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port {{ port-mpg }} from any IP address. To do this, create the following rule for inbound traffic:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mpg }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

- From a VM in {{ yandex-cloud }} {#cloud}

    1. [Configure all the cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port {{ port-mpg }} from the security group where the VM is located. To do this, create the following rule for incoming traffic in these groups:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mpg }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM are in the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). Otherwise, specify the VM security group.

    1. [Configure the security group](../../vpc/operations/security-group-add-rule.md) where the VM is located to enable connections to the VM and traffic between the VM and the cluster hosts.

        For example, you can set the following rules for a VM:

        * For incoming traffic:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

            This rule allows you to [connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to a VM over SSH.

        * For outgoing traffic:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

            This rule allows all outgoing traffic, thus enabling you not only to connect to the cluster but also to install the certificates and utilities your VM needs for the connection.

{% endlist %}

{% note info %}

You can specify more granular rules for your security groups, such as only allowing traffic within specific subnets.

You must configure security groups correctly for all subnets in which the cluster hosts will reside.

{% endnote %}


## Getting an SSL certificate {#get-ssl-cert}

{{ SPQR }} hosts with public access only support encrypted connections. To use them, get an SSL certificate:

{% include [install-certificate](../../_includes/mdb/mpg/install-certificate.md) %}

## {{ SPQR }} host FQDN {#fqdn}

To connect to a host, you need its fully qualified domain name (FQDN).

You can view the FQDN in the management console:

1. Navigate to the cluster page.
1. Navigate to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

## Connecting with Bash {#bash}

Before connecting, install the following dependencies:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

    1. Connect to a database:

        ```bash
        psql "host=<host_FQDN> \
              port={{ port-mpg }} \
              sslmode=disable \
              dbname=<DB_name> \
              user=<username> \
              target_session_attrs=read-write"
        ```

        Where `target_session_attrs` defines the type of request to the host. For example, `read-write` enables both reading and writing. For more information, see the [SPQR documentation](https://pg-sharding.tech/routing/hints#spqr-target-session-attrs).

        After running the command, enter the user password to complete the connection process.

    1. To check the connection, run this query:

        ```bash
        SELECT version();
        ```

- Connecting via SSL {#with-ssl}

    1. Connect to a database:

        ```bash
        psql "host=<host_FQDN> \
              port={{ port-mpg }} \
              sslmode=verify-full \
              dbname=<DB_name> \
              user=<username> \
              target_session_attrs=read-write"
        ```

        Where `target_session_attrs` defines the type of request to the host. For example, `read-write` enables both reading and writing. For more information, see the [SPQR documentation](https://pg-sharding.tech/routing/hints#spqr-target-session-attrs).

        After running the command, enter the user password to complete the connection process.

    1. To check the connection, run this query:

        ```bash
        SELECT version();
        ```

{% endlist %}

## Connecting from {{ pgadmin }} {#connection-pgadmin}

The connection was tested for [{{ pgadmin }}](https://www.pgadmin.org) version 9.1 on Windows 10.

You can only use {{ pgadmin }} to connect to public cluster hosts [using an SSL certificate](#get-ssl-cert).

Create a new server connection:

1. Select **Object** → **Register** → **Server...**.
1. On the **General** tab, in the **Name** field, specify the name for the cluster. This name will be shown in the {{ pgadmin }} interface. You can set any name.
1. In the **Connection** tab, specify the connection parameters:

    * **Host name/address**: [Host FQDN](#fqdn).
    * **Port**: `{{ port-mpg }}`.
    * **Maintenance database**: DB you want to connect to.
    * **Username**: Username for connection.
    * **Password**: User password.

1. In the **Parameters** tab:

    * Set the **SSL mode** parameter to `verify-full`.
    * Add a new **Root certificate** parameter and specify the path to the saved SSL certificate file in it.

1. Click **Save** to save the server connection settings.

As a result, the cluster appears in the server list in the navigation menu.
