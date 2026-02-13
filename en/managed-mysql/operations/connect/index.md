---
title: Pre-configuring a {{ MY }} cluster connection in {{ mmy-full-name }}
description: In this tutorial, you will learn how to pre-configure a database connection in a {{ MY }} cluster.
---

# Pre-configuring a {{ MY }} cluster connection

You can connect to {{ mmy-short-name }} cluster hosts:

{% include [cluster-connect-note](../../../_includes/mdb/mmy/cluster-connect-note.md) %}

{% note warning %}

If only some cluster hosts have public access, an [automatic master failover](../../concepts/replication.md#master-failover) can make the master host unreachable from the internet.

{% endnote %}

The maximum number of connections is defined by the [Max connections](../../concepts/settings-list.md#setting-max-connections) setting that [depends on the host class](../../concepts/settings-list.md#settings-instance-dependent).

For more information, see [{#T}](../../concepts/network.md).


## Configuring security groups {#configure-security-groups}

{% include [sg-rules](../../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the connection method you select:

{% list tabs group=connection_method %}

- Over the internet {#internet}

    [Configure all cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port {{ port-mmy }} from any IP address. To do this, create the following ingress rule:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mmy }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

- From a {{ yandex-cloud }} VM {#cloud}

    1. [Configure all cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port {{ port-mmy }} from the security group assigned to your VM. To do this, create the following ingress rule in these groups:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mmy }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
        * Security group: If your cluster and VM share the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). Otherwise, specify the VM security group.

    1. [Configure the VM security group](../../../vpc/operations/security-group-add-rule.md) to allow VM connections and traffic between the VM and cluster hosts.

        For example, you can set the following rules for your VM:

        * For incoming traffic:
           * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`.
           * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
           * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
           * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

            This rule allows inbound VM [connections](../../../compute/operations/vm-connect/ssh.md#vm-connect) over SSH.

        * For outgoing traffic:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

            This rule permits all outbound traffic, allowing you to connect to the cluster and install any necessary certificates and tools on your VM.

{% endlist %}

{% note info %}

You can specify more granular security group rules, such as allowing traffic only in specific subnets.

Make sure to configure the security groups correctly for all subnets where the cluster hosts will reside. With incomplete or incorrect security group settings, you may lose access to the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../../concepts/network.md#security-groups).


## Obtaining an SSL certificate {#get-ssl-cert}

Publicly accessible {{ MY }} hosts only support encrypted connections. To assess them, get an SSL certificate:

{% include [install-certificate](../../../_includes/mdb/mmy/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## What's next {#whats-next}

* [Get the FQDN of the host](fqdn.md) you want to connect to.
* [Connect](clients.md) to the cluster from a graphical IDE, Docker container, or CLI.
* [Integrate](code-examples.md) the cluster connection into your application code.
