## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../sg-rules-connect.md) %}

Settings of access policies depend on the connection method you select:

{% list tabs group=connection_method %}

- Over the internet {#internet}

   [Configure all security groups](../../../vpc/operations/security-group-add-rule.md) in the cluster to allow incoming traffic on any IP addresses to the ports {{ port-https }} (Dashboards) and {{ port-mos }} ({{ OS }}). To do this, create the following rules for incoming traffic:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`, `{{ port-mos }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

   A separate rule is created for each port.

- From a VM in {{ yandex-cloud }} {#cloud}

   1. [Configure all security groups](../../../vpc/operations/security-group-add-rule.md) in your cluster to allow incoming traffic on ports {{ port-https }} (Dashboards) and {{ port-mos }} ({{ OS }}) from the security group where the VM is located. To do this, create the following rules for incoming traffic in these security groups:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`, `{{ port-mos }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM are in the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`) as the value. Otherwise, specify the VM security group.

      A separate rule is created for each port.

   1. [Configure all security groups](../../../vpc/operations/security-group-add-rule.md) that include your VM to allow connections to the VM and traffic between the VM and cluster hosts.

      For example, you can set the following rules for a VM:

      * For incoming traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`, `{{ port-https }}`, `{{ port-mos }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         A separate rule is created for each port.

      * For outgoing traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         This rule allows all outgoing traffic, which enables you to both connect to the cluster and install the certificates and utilities the VMs need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If the security group settings are incomplete or incorrect, you might lose access the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../../../managed-opensearch/concepts/network.md#security-groups).
