## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../sg-rules-connect.md) %}

Settings of access policies depend on the connection method you select:

{% list tabs group=connection_method %}

- Over the internet {#internet}

   [Configure all the cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on ports {{ port-https }} (`Dashboards`) and {{ port-mos }} ({{ OS }}) from any IP address. To do this, create the following rules for incoming traffic:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}` and `{{ port-mos }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

   Create a separate rule for each port.

- From a {{ yandex-cloud }} VM {#cloud}

   1. [Configure all the cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on ports {{ port-https }} (`Dashboards`) and {{ port-mos }} ({{ OS }}) from your VM’s security group. To do this, create the following rules for incoming traffic in these security groups:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}` and `{{ port-mos }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM share the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). Otherwise, specify the VM security group.

      Create a separate rule for each port.

   1. [Configure all the security groups](../../../vpc/operations/security-group-add-rule.md) assigned to your VM to allow connections to the VM and traffic between the VM and cluster hosts.

      For example, you can set the following rules for your VM:

      * For incoming traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`, `{{ port-https }}`, `{{ port-mos }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         Create a separate rule for each port.

      * For outgoing traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         This rule allows all outgoing traffic, thus enabling you not only to connect to the cluster but also to install the certificates and utilities your VM needs for connection.

{% endlist %}

{% note info %}

You can specify more granular rules for your security groups, e.g., to allow traffic only in specific subnets.

Make sure to configure the security groups correctly for all subnets where the cluster hosts will reside. With incomplete or incorrect security group settings, you may lose access to the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../../../managed-opensearch/concepts/network.md#security-groups).
