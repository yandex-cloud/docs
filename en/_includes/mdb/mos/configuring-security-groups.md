## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../sg-rules-connect.md) %}

Settings of access policies depend on the connection method you select:

{% list tabs %}

- Over the internet

   [Configure all security groups](../../../vpc/operations/security-group-add-rule.md) in the cluster to allow incoming traffic on any IP addreses to the ports {{ port-https }} (Dashboards) and {{ port-mos }} ({{ OS }}). To do this, create the following rules for incoming traffic:

   * Port range: `{{ port-https }}`, `{{ port-mos }}`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

   A separate rule is created for each port.

- From a VM in {{ yandex-cloud }}

   1. [Configure all security groups](../../../vpc/operations/security-group-add-rule.md) in your cluster to allow incoming traffic on ports {{ port-https }} (Dashboards) and {{ port-mos }} ({{ OS }}) from the security group where the VM is located. To do this, create the following rules for incoming traffic in these security groups:

      * Protocol: `TCP`.
      * Port range: `{{ port-https }}`, `{{ port-mos }}`.
      * Source: `Security group`.
      * Security group: If a cluster and a VM are in the same security group, select `Self` (`Self`) as the value. Otherwise, specify the VM security group.

      A separate rule is created for each port.

   1. [Configure all security groups](../../../vpc/operations/security-group-add-rule.md) that include your VM to allow connections to the VM and traffic between the VM and cluster hosts.

      Example of rules for a VM:

      * For incoming traffic:

         * Port range: `{{ port-ssh }}`, `{{ port-https }}`, `{{ port-mos }}`.
         * Protocol: `TCP`.
         * Source: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

         A separate rule is created for each port.

      * For outgoing traffic:

         * Port range: `{{ port-any }}`.
         * Protocol: ``Any``.
         * Source type: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

         This rule allows all outgoing traffic, which lets you both connect to the cluster and install the certificates and utilities that the VMs need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If the security group settings are incomplete or incorrect, you might lose access the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../../../managed-opensearch/concepts/network.md#security-groups).
