# Overview of database connection methods

Available connection methods depend on whether [sharding](../../concepts/sharding.md):

* [Connecting to a non-sharded cluster](./non-sharded.md).
* [Connecting to a sharded cluster](./sharded.md).

## Accessing cluster hosts {#connect}

You can connect to {{ mmg-short-name }} cluster hosts:

{% include [cluster-connect-note](../../../_includes/mdb/mmg/cluster-connect-note.md) %}

To connect to cluster hosts, use port:

* `{{ port-mmg }}` for a non-sharded cluster.
* `{{ port-mmg-sharded }}` for a sharded cluster.

Write requests will be automatically routed to the primary cluster replica.

{% note info %}

If public access is only configured for certain hosts, [automatic primary replica change](../../concepts/replication.md) may make the cluster unavailable over the internet.

{% endnote %}


## Getting an SSL certificate {#get-ssl-cert}

To connect to {{ MG }} hosts with public access, get an SSL certificate:

{% include [install-certificate](../../../_includes/mdb/mmg/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}


## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the connection method you select:

{% list tabs %}

- Over the internet

   [Configure all security groups](../../../vpc/operations/security-group-add-rule.md) in your cluster to allow incoming traffic from any IP on port `{{ port-mmg }}` for an unsharded cluster or on port `{{ port-mmg-sharded }}` for a [sharded](../shards.md) one. To do this, create the following rule for incoming traffic:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**:
      * `{{ port-mmg }}` for a non-sharded cluster.
      * `{{ port-mmg-sharded }}` for a sharded cluster.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

- With a VM in Yandex.Cloud

   1. [Configure all security group](../../../vpc/operations/security-group-add-rule.md) in your cluster to allow incoming traffic from the security group where your VM is located on port `{{ port-mmg }}` for an unsharded cluster and on port `{{ port-mmg-sharded }}` for a [sharded](../shards.md) one. To do this, create the following rule for incoming traffic in these groups:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**:
         * `{{ port-mmg }}` for a non-sharded cluster.
         * `{{ port-mmg-sharded }}` for a sharded cluster.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Security group assigned to the VM. If it is the same as the group being configured, specify `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).

   1. [Configure the security group](../../../vpc/operations/security-group-add-rule.md) where the VM is located to enable connections to the VM and traffic between the VM and the cluster hosts.

      For example, you can set the following rules for a VM:

      * For incoming traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

         This rule allows you to connect to the VM over SSH.

      * For outgoing traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

         This rule allows all outgoing traffic, which enables you to both connect to the cluster and install the certificates and utilities the VMs need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If security group settings are incomplete or incorrect, you may lose access to the cluster if the [primary replica fails over automatically](../../concepts/replication.md).

{% endnote %}

For more information, see [{#T}](../../concepts/network.md#security-groups).


## Connection limits {#connection-limits}

{% include [mmg-conn-limits](../../../_includes/mdb/mmg/conn-limits.md) %}

A host's RAM amount depends on its class. All available options are listed in [{#T}](../../concepts/instance-types.md).
