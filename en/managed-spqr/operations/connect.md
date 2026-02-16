---
title: Connecting to a {{ SPQR }} cluster
description: Follow this guide to connect to a {{ SPQR }} cluster.
keywords:
  - keyword: connecting to a {{ SPQR }} cluster
  - keyword: '{{ SPQR }} cluster'
  - keyword: '{{ SPQR }}'
---

# Connecting to a {{ SPQR }} cluster

You can connect to {{ mspqr-name }} cluster hosts:

* Via the internet, if you configured public access for these hosts. You can only access such hosts over an SSL connection.

* From {{ yandex-cloud }} VMs located in the same [cloud network](../../vpc/concepts/network.md) For hosts without public access, SSL is not required to connect to them from these virtual machines.

You can connect to all [host types](../concepts/index.md): `INFRA`, `ROUTER`, `COORDINATOR`, {{ PG }} cluster hosts. The connection is established through port `{{ port-mpg }}`. In the case of `COORDINATOR` hosts and the {{ SPQR }} admin console, you must connect as the `spqr-console` user to the `spqr-console` database. You can use the admin console to configure sharding rules. For more information, see the [SPQR documentation](https://pg-sharding.tech/welcome/get_started).


## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Security group settings will vary depending on the connection method you choose:

{% list tabs group=connection_method %}

- Over the internet {#internet}

    [Configure all cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port `{{ port-mpg }}` from any IP address. To do this, create the following ingress rule:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mpg }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

    If the shared cluster and shard security group has rules configured to connect the router to shard hosts, no additional configuration of security groups is required to access the cluster over the internet.

- From a {{ yandex-cloud }} VM {#cloud}

    1. [Configure all cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port `{{ port-mpg }}` from your VM’s security group. To do this, create the following rule for incoming traffic in these groups:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mpg }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM share the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). Otherwise, specify the VM security group.

    1. [Configure the VM security group](../../vpc/operations/security-group-add-rule.md) to allow VM connections and traffic between the VM and cluster hosts.

        For example, you can set the following rules for your VM:

        * For incoming traffic:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

            This rule allows inbound VM [connections](../../compute/operations/vm-connect/ssh.md#vm-connect) over SSH.

        * For outgoing traffic:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

            This rule permits all outbound traffic, allowing you to connect to the cluster and install any necessary certificates and tools on your VM.

{% endlist %}

{% note info %}

You can specify more granular security group rules, such as allowing traffic only in specific subnets.

Make sure to properly configure security groups for all subnets where the cluster hosts will reside.

{% endnote %}


## Obtaining an SSL certificate {#get-ssl-cert}

Publicly accessible {{ SPQR }} hosts only support encrypted connections. To assess them, get an SSL certificate:

{% include [install-certificate](../../_includes/mdb/mpg/install-certificate.md) %}

## {{ SPQR }} host FQDN {#fqdn}

To connect to a host, you need its fully qualified domain name (FQDN).

You can view the FQDN in the management console:

1. Navigate to the cluster page.
1. Navigate to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

## Connecting with Bash {#bash}

Before connecting, install the required dependencies:

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

        After you run this command, enter the user password to complete the connection procedure.

    1. To check the connection, run the following query:

        ```bash
        SELECT version();
        ```

- Connecting with SSL {#with-ssl}

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

        After you run this command, enter the user password to complete the connection procedure.

    1. To check the connection, run the following query:

        ```bash
        SELECT version();
        ```

{% endlist %}

## Connecting from {{ pgadmin }} {#connection-pgadmin}

The connection was tested for [{{ pgadmin }}](https://www.pgadmin.org) version 9.1 on Windows 10.

You can only use {{ pgadmin }} to connect to public cluster hosts [using an SSL certificate](#get-ssl-cert).

Create a new server connection:

1. Select **Object** → **Register** → **Server...**.
1. On the **General** tab, in the **Name** field, specify the cluster name to be shown in the {{ pgadmin }} interface. You can set any name.
1. In the **Connection** tab, specify the connection settings:

    * **Host name/address**: [Host FQDN](#fqdn).
    * **Port**: `{{ port-mpg }}`.
    * **Maintenance database**: Target database name.
    * **Username**: Username used to establish the connection.
    * **Password**: User password.

1. In the **Parameters** tab:

    * Set the **SSL mode** parameter to `verify-full`.
    * Add a new **Root certificate** parameter and specify the path to the saved SSL certificate file in it.

1. Click **Save** to save the server connection settings.

As a result, the cluster appears in the server list in the navigation menu.
