---
title: "Pre-configuration for connection to a {{ CH }} cluster in {{ mch-full-name }}"
description: "Follow this guide to prepare for connection to a database in a {{ CH }} cluster."
---

# Pre-configuration for connection to a {{ CH }} cluster

You can connect to {{ mch-short-name }} cluster hosts:

{% include [cluster-connect-note](../../../_includes/mdb/mch/cluster-connect-note.md) %}


You can connect to a cluster using encryption via ports `{{ port-mch-cli }}` for [clickhouse-client]({{ ch.docs }}/interfaces/cli/) and `{{ port-mch-http }}` for the [HTTP interface]({{ ch.docs }}/interfaces/http/) or without encryption via ports `9000` and `8123`, respectively.



## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the connection method you select:

{% list tabs group=connection_method %}

- Over the internet {#internet}

   [Configure all the cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on ports 8443 and 9440 from any IP address. To do this, create the following rules for incoming traffic:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `8443`, `9440`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

   A separate rule is created for each port.

- From a VM in {{ yandex-cloud }} {#cloud}

   1. [Configure all the cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on ports 8123, 8443, 9000, and 9440 from the security group where your VM is located. To do this, create the following rules for incoming traffic in these security groups:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `8123` (or any of the other ports listed).
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM are in the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`) as the value. Otherwise, specify the VM security group.

      A separate rule is created for each port.

   1. [Configure the security group](../../../vpc/operations/security-group-add-rule.md) where the VM is located to enable connections to the VM and traffic between the VM and the cluster hosts.

      For example, you can set the following rules for a VM:

      * For incoming traffic:
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         This rule allows you to [connect](../../../compute/operations/vm-connect/ssh.md#vm-connect) to a VM over SSH.

      * For outgoing traffic:
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         This rule allows all outgoing traffic, which enables you not only to connect to the cluster but also to install the certificates and utilities your VM needs for the connection.

{% endlist %}

{% note info %}

You can specify more detailed rules for your security groups, e.g., to allow traffic only in specific subnets.

You must configure security groups correctly for all subnets in which the cluster hosts will reside. If security group settings are incomplete or incorrect, you may lose access to the cluster.

{% endnote %}

For more information about security groups, see [DB network and clusters](../../concepts/network.md#security-groups).


## Getting SSL certificates {#get-ssl-cert}

To use an encrypted connection, get SSL certificates:

{% include [install-certificate](../../../_includes/mdb/mch/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## What's next {#whats-next}

* [Get the FQDN of the host](fqdn.md) you want to connect to.
* [Connect](clients.md) to the cluster using a browser, graphical IDE, or CLI.
* [Integrate](code-examples.md) the cluster connection into your aplication code.

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
