---
title: Pre-configuring {{ MG }} cluster connection in {{ mmg-full-name }}
description: Follow this guide to pre-configure a connection to a database in a {{ MG }} cluster.
---

# Pre-configuring a connection to a {{ MG }} cluster

You can connect to {{ mmg-short-name }} cluster hosts:

{% include [cluster-connect-note](../../../_includes/mdb/mmg/cluster-connect-note.md) %}

To connect to cluster hosts, use port:

* `{{ port-mmg }}`: For a non-sharded cluster
* `{{ port-mmg-sharded }}`: For a [sharded](../../concepts/sharding.md) cluster

Write requests will be automatically routed to the primary cluster replica.

{% note info %}

To connect to the cluster from the internet, make sure to set up public access on the primary replica.

If public access is only configured for certain hosts, [automatic primary replica change](../../concepts/replication.md) may make the cluster unavailable over the internet.

{% endnote %}



## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the connection method you select:

{% list tabs group=connection_method %}

- Over the internet {#internet}

    [Configure all the cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic from any IP address on port `{{ port-mmg }}` for an unsharded cluster or on port `{{ port-mmg-sharded }}` for a [sharded](../shards.md) one. To do this, create the following rule for incoming traffic:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**:
        * `{{ port-mmg }}` for a non-sharded cluster
        * `{{ port-mmg-sharded }}` for a sharded cluster
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

- From a VM in {{ yandex-cloud }} {#cloud}

    1. [Configure all the cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic from the security group where your VM is located on port `{{ port-mmg }}` for an unsharded cluster and on port `{{ port-mmg-sharded }}` for a [sharded](../shards.md) one. To do this, create the following rule for incoming traffic in these groups:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**:
            * `{{ port-mmg }}` for a non-sharded cluster
            * `{{ port-mmg-sharded }}` for a sharded cluster
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Security group assigned to the VM. If it is the same as the configured group, specify `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).
        
    1. [Configure the security group](../../../vpc/operations/security-group-add-rule.md) where the VM is located to enable connections to the VM and traffic between the VM and the cluster hosts.

        For example, you can set the following rules for a VM:

        * For incoming traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

            This rule allows you to connect to a VM over SSH.

        * For outgoing traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

            This rule allows all outgoing traffic, thus enabling you not only to connect to the cluster but also to install the certificates and utilities your VM needs for the connection.

{% endlist %}

{% note info %}

You can specify more detailed rules for your security groups, e.g., to allow traffic only in specific subnets.

You must configure security groups correctly for all subnets in which the cluster hosts will reside. If security group settings are incomplete or incorrect, you may lose access to the cluster if the [primary replica fails over automatically](../../concepts/replication.md).

{% endnote %}

For more information, see [{#T}](../../concepts/network.md#security-groups).


## Getting an SSL certificate {#get-ssl-cert}

To connect to public {{ MG }} hosts, get an SSL certificate:

{% include [install-certificate](../../../_includes/mdb/mmg/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Getting FQDNs of {{ MG }} hosts {#get-fqdn}

To connect to a host, you need its fully qualified domain name ([FQDN](../../concepts/network.md#hostname)). You can obtain it in one of the following ways:

* [Request a list of cluster hosts](../hosts.md#list-hosts).
* Look up the FQDN in the [management console]({{ link-console-main }}):

    1. Go to the cluster page.
    1. Go to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

* In the management console, copy the command for connecting to the cluster. This command contains the host FQDN. To get the command, go to the cluster page and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.


## Connection limits {#connection-limits}

{% include [mmg-conn-limits](../../../_includes/mdb/mmg/conn-limits.md) %}

A host's RAM amount depends on its class. All available options are listed under [Host classes](../../concepts/instance-types.md).

## What's next {#whats-next}

* [Connect](clients.md) to a cluster using command line tools, graphical IDE, or Docker container.
* [Integrate](code-examples.md) the cluster connection into your aplication code.
