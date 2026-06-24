---
title: Pre-configuring a {{ mgp-full-name }} cluster connection
description: In this tutorial, you will learn how to pre-configure a database connection in a {{ mgp-name }} cluster.
---

# Pre-configuring a {{ mgp-name }} cluster connection

A {{ mgp-name }} cluster can be used to deploy a {{ GP }} or {{ CB }} DBMS. Both DBMSs are based on {{ PG }}, so you need the same tools as for {{ PG }} to connect to them.

You can only connect to a {{ mgp-name }} cluster through the [primary master host](../../concepts/index.md). To identify host roles, get a [list of hosts in the cluster](../cluster-list.md#get-hosts).

You can connect to a cluster:

{% include [cluster-connect-note-monolithic](../../../_includes/mdb/cluster-connect-note-monolithic.md) %}


## Configuring security groups {#configuring-security-groups}

You can assign one or more security groups to a {{ mgp-name }} cluster. To connect to a cluster, security groups must include rules allowing traffic on port {{ port-mgp }} from certain IP addresses or other security groups.

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

{% include [trino-greenplum-security-groups](../../../_includes/managed-trino/greenplum-security-groups.md) %}


## Obtaining an SSL certificate {#get-ssl-cert}

To use an SSL connection, get a certificate:

{% include [install-certificate](../../../_includes/mdb/mgp/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## What's next {#whats-next}

* [Get the FQDN of the host](fqdn.md) you want to connect to.
* [Connect](clients.md) to the cluster from a graphical IDE, {{ pgadmin }} or Docker container.
* [Integrate](code-examples.md) the cluster connection into your application code.

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}

{% include [cloudberry-trademark](../../../_includes/mdb/mgp/trademark-cloudberry.md) %}
