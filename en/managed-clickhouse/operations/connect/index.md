---
title: Pre-configuring a {{ CH }} cluster connection in {{ mch-full-name }}
description: Follow this guide to pre-configure a connection to a database in a {{ CH }} cluster.
---

# Pre-configuring a {{ CH }} cluster connection

You can connect to {{ mch-short-name }} cluster hosts:

{% include [cluster-connect-note](../../../_includes/mdb/mch/cluster-connect-note.md) %}


You can connect to a cluster either with encryption (on ports `{{ port-mch-cli }}` for [clickhouse-client]({{ ch.docs }}/interfaces/cli/) and `{{ port-mch-http }}` for the [HTTP interface]({{ ch.docs }}/interfaces/http/)) or without it (on ports `9000` and `8123`, respectively).



## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the connection method you select:

{% list tabs group=connection_method %}

- Over the internet {#internet}

  [Configure all the cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on ports 8443 and 9440 from any IP address. To do this, create the following rules for incoming traffic:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `8443` and `9440`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

  Create a separate rule for each port.

  {% note warning %}

  For a more secure cluster, specify only trusted IP addresses or subnets in the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field.

  {% endnote %}

- From a {{ yandex-cloud }} VM {#cloud}

    1. [Configure all the cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic from your VM's security group on ports 8123, 8443, 9000, and 9440. To do this, create the following rules for incoming traffic in these security groups:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `8123` (or any of the other ports listed).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM are in the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). Otherwise, specify the VM security group.

       Create a separate rule for each port.

    1. [Configure the VM security group](../../../vpc/operations/security-group-add-rule.md) to allow VM connections and traffic between the VM and cluster hosts.

       For example, you can set the following rules for your VM:

        * For incoming traffic:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

          This rule allows inbound VM [connections](../../../compute/operations/vm-connect/ssh.md#vm-connect) over SSH.

        * For outgoing traffic:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

          This rule allows all outgoing traffic, so that you can connect to the cluster as well as install the certificates and utilities your VM needs for connection.

{% endlist %}

{% note info %}

You can specify more granular rules for your security groups, e.g., to allow traffic only in specific subnets.

Make sure to configure the security groups properly for all subnets where the cluster hosts will reside. With incomplete or incorrect security group settings, you may lose access to the cluster.

{% endnote %}

For more information about security groups, see [Network and database clusters](../../concepts/network.md#security-groups).


## Getting SSL certificates {#get-ssl-cert}

To use an encrypted connection, get an SSL certificate:

{% include [install-certificate](../../../_includes/mdb/mch/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## What's next {#whats-next}

* [Get the FQDN of the host](fqdn.md) you want to connect to.
* [Connect](clients.md) to the cluster using a browser, graphical IDE, or CLI.
* [Integrate](code-examples.md) the cluster connection into your application code.

## See also {#see-also}

* [{{ CH }} connection FAQ](../../qa/connection.md)

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
