---
title: Configuring security groups in {{ dataproc-full-name }}
description: Follow this guide to configure security groups in {{ dataproc-name }}.
---

# Configuring security groups

Cluster access depends on the security group configuration. Make sure the rules allow the required traffic.

{% note alert %}

When setting up security groups, do not change the [rules for control plane traffic](cluster-create.md#change-security-groups). This may cause the cluster to fail.

{% endnote %}

Rule settings depends on the connection method you select:

{% list tabs %}

- SSH

    * To connect to subcluster hosts with public access from cloud networks and the internet, [configure cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow inbound traffic from any IP address on port `{{ port-ssh }}`. To do this, create the following inbound rule:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

    * To connect to a cluster from a jump host VM:

      1. [Configure](../../vpc/operations/security-group-add-rule.md) the VM security group to allow connections to the VM and traffic between the VM and subcluster hosts. To do this, create the following rules:

          * For inbound traffic:

              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

          * For outbound traffic:

              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: Address range of the subnet where the cluster hosts reside. If subclusters are in different subnets, create this rule for each subnet.

      1. [Configure the cluster security](../../vpc/operations/security-group-add-rule.md) groups to allow inbound traffic from the VM security group on port `{{ port-ssh }}`. To do this, create the following rule for inbound traffic:

          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`.
          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: VM security group.

- UI Proxy

    To use [**UI Proxy**](../concepts/interfaces.md), [add](../../vpc/operations/security-group-add-rule.md) rules to the subcluster host's security group to allow inbound traffic on port `{{ port-https }}`:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

    If the connection is established via a jump host VM, [add](../../vpc/operations/security-group-add-rule.md) rules to the subcluster host's security group that allow connections via this VM:

    * For inbound traffic:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

    * For outbound traffic:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: Address range of the subnet where the subcluster host resides.

- Connecting with port forwarding

    If using [port forwarding](../operations/connect-interfaces.md#routing), [add](../../vpc/operations/security-group-add-rule.md) rules to the jump host VM security group that allow inbound and outbound traffic on the ports of the required components:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `<component_port>`.

        Port numbers for the {{ dataproc-name }} components are shown in the table:

        {% include [ports-table](../../_includes/data-processing/ports-table.md) %}

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

{% endlist %}

{% note info %}

You can specify more granular rules for your security groups, such as allowing traffic only within specific subnets.

Make sure to properly configure security groups for all subnets where the subclusters will reside.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).