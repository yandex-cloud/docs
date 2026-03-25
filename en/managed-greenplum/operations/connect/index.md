---
title: Pre-configuring a {{ GP }} cluster connection in {{ mgp-full-name }}
description: In this tutorial, you will learn how to pre-configure a database connection in a {{ GP }} cluster.
---

# Pre-configuring a {{ GP }} cluster connection

Since {{ GP }} is based on {{ PG }}, the same tools are used for connecting to both.

You can only connect to a {{ GP }} cluster through the [primary master host](../../concepts/index.md). To identify host roles, get a [list of hosts in the cluster](../cluster-list.md#get-hosts).

You can connect to a cluster:

{% include [cluster-connect-note-monolithic](../../../_includes/mdb/cluster-connect-note-monolithic.md) %}


## Configuring security groups {#configuring-security-groups}

You can assign one or more security groups to a {{ GP }} cluster. To connect to a cluster, security groups must include rules allowing traffic on port {{ port-mgp }} from certain IP addresses or other security groups.

{% note info %}

A security group assigned to a cluster controls traffic between the cluster and other cloud or external resources. You do not need to configure interaction between cluster hosts, as it is controlled by a separate system security group.

{% endnote %}

Rule settings depends on the connection method you select:

{% list tabs group=connection_method %}

- Over the internet {#internet}

    {% include [Cluster security group rules](../../../_includes/mdb/mgp/cluster-sg-rules.md) %}

- From a VM in {{ yandex-cloud }} {#cloud}

    1. Add the following rules to the cluster security group:

        1. For incoming traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mgp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM share the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`. Otherwise, specify the VM security group.

         1. For outgoing traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

            This rule enables {{ mgp-name }} to use external data sources, e.g., PXF or GPFDIST.

    1. [Configure the VM security group](../../../vpc/operations/security-group-add-rule.md) to allow connections to the VM as well as traffic between the VM and the cluster hosts.

        * For inbound traffic:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: Range of addresses to connect from.

            This rule allows VM connections over SSH.

        * For outbound traffic:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

            This rule permits all outbound traffic, allowing you to install any necessary certificates and tools on your VM.

{% endlist %}



### Security groups for {{ mtr-full-name }} {#sg-for-trino}

To connect to {{ mtr-name }}, the {{ GP }} connector uses the GPFDIST protocol:

* {{ mtr-name }} coordinators and workers send queries to the {{ GP }} master over TCP port {{ port-mgp }}.
* {{ GP }} segments forward data to {{ mtr-name }} workers over the GPFDIST TCP port, e.g., 31111.

To ensure a secure connection to {{ mtr-name }}, we recommend that you configure security groups in [{{ GP }}](#configuring-sg-greenplum) and, optionally, in [{{ mtr-name }}](#configuring-sg-trino).

If {{ GP }} interacts with other clusters or entities inside the user network, you need to separately configure security group rules for any such clusters or entities.

#### {{ GP }} side setup {#configuring-sg-greenplum}

{% list tabs group=traffic %}

- Incoming traffic {#incoming}

    * Rule for internal {{ GP }} cluster traffic:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.

    * Rule for connections from a {{ mtr-name }} cluster:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mgp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Specify the {{ mtr-name }} cluster security group.

- Outgoing traffic {#outgoing}

    * Rule for internal {{ GP }} cluster traffic:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.

    * Rule for connections to a {{ mtr-name }} cluster:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `30078-30085`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Specify the {{ mtr-name }} cluster security group.

{% endlist %}

#### {{ mtr-name }} side setup {#configuring-sg-trino}

To configure security group rules in {{ mtr-name }}, invert the {{ GP }} rule settings. Setting up rules for a {{ mtr-name }} cluster is optional, but this provides added security for your cluster.

{% list tabs group=traffic %}

- Incoming traffic {#incoming}

    Rule for receiving data from {{ GP }} segments:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `30078-30085`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Specify the {{ GP }} cluster security group.

- Outgoing traffic {#outgoing}

    Rule for connections to a {{ GP }} master:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mgp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Specify the {{ GP }} cluster security group.

{% endlist %}

## Obtaining an SSL certificate {#get-ssl-cert}

To use an SSL connection, get a certificate:

{% include [install-certificate](../../../_includes/mdb/mgp/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## What's next {#whats-next}

* [Get the FQDN of the host](fqdn.md) you want to connect to.
* [Connect](clients.md) to the cluster from a graphical IDE, {{ pgadmin }} or Docker container.
* [Integrate](code-examples.md) the cluster connection into your application code.

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
