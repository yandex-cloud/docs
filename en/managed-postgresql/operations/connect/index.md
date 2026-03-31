---
title: Pre-configuring a {{ PG }} cluster connection in {{ mpg-full-name }}
description: Follow this guide to pre-configure a connection to hosts in an {{ PG }} cluster.
---

# Pre-configuring a {{ PG }} cluster connection

You can connect to {{ mpg-short-name }} cluster hosts:

{% include [cluster-connect-note](../../../_includes/mdb/mpg/cluster-connect-note.md) %}

{% note warning %}

If only some cluster hosts have public access, an [automatic master failover](../../concepts/replication.md#replication-auto) can make the master host unreachable from the internet.

{% endnote %}


## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the chosen connection method:

{% list tabs group=connection_method %}

- Over the internet {#internet}

  [Configure all cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port 6432 from any IP address. To do this, create the following inbound rule:

  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `6432`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

- From a {{ yandex-cloud }} VM {#cloud}

  1. [Configure all cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port 6432 from the target VM’s security group. To do this, create the following ingress rule in these groups:

     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `6432`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM share the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`. Otherwise, specify the VM security group.

  1. [Configure the VM’s security group](../../../vpc/operations/security-group-add-rule.md) to enable connections to the VM and traffic between the VM and the cluster hosts.

     VM rule examples:

     * For incoming traffic:
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

       This rule allows inbound VM [connections](../../../compute/operations/vm-connect/ssh.md#vm-connect) over SSH.

     * For outgoing traffic:
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

       This rule permits all outbound traffic, allowing you to install any necessary certificates and tools on your VM.

{% endlist %}

{% note info %}

You can specify more granular security group rules, such as allowing traffic only in specific subnets.

Make sure to properly configure security groups for all subnets where the cluster hosts will reside. With incomplete or incorrect security group settings, you may lose access to the cluster if a [manual](../hosts.md#update) or [automatic](../../concepts/replication.md#replication-auto) master failover occurs.

{% endnote %}

For more information about security groups, see [{#T}](../../concepts/network.md#security-groups).


## Obtaining an SSL certificate {#get-ssl-cert}

Publicly accessible {{ PG }} hosts support only encrypted connections. To use them, get an SSL certificate:

{% include [install-certificate](../../../_includes/mdb/mpg/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## What's next {#whats-next}

* [Get the FQDN of the host](./fqdn.md) you want to connect to.
* [Connect](./clients.md) to the cluster using the command-line tools, graphical IDEs, {{ websql-full-name }}, {{ pgadmin }}, {{ google-looker }}, and a Docker container.
* [Integrate](./code-examples.md) the cluster connection into your application code.