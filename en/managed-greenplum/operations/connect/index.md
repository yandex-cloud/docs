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

Rule settings depend on the chosen connection method:

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



## Obtaining an SSL certificate {#get-ssl-cert}

To use an SSL connection, get a certificate:

{% include [install-certificate](../../../_includes/mdb/mgp/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## What's next {#whats-next}

* [Get the FQDN of the host](fqdn.md) you want to connect to.
* [Connect](clients.md) to the cluster from a graphical IDE, {{ pgadmin }} or Docker container.
* [Integrate](code-examples.md) the cluster connection into your application code.

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
