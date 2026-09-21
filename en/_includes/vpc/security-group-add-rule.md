Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**, and in the window that opens:

  1. Select **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}**.
  1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field, specify a single port or a range of ports open for inbound or outbound traffic.
  1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the appropriate protocol or leave `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` to allow traffic transmission over any protocol.
  1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** field, select the rule purpose:
    * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`: Rule will apply to the range of IP addresses.
    * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`: Select one of the following:
      * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`: Rule will apply to the VMs from the current group.
      * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-list }}`: Rule will apply to the VMs from the selected group. Make sure that source and destination IP addresses used for traffic exchange are from [private ranges](../../vpc/concepts/network.md#subnet). For more information, see [Concepts](../../vpc/concepts/security-groups.md#groups).
      * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`: Rule that allows checking the health of resources from [{{ network-load-balancer-name }}](../../network-load-balancer/concepts/health-check.md) or [{{ alb-name }}](../../application-load-balancer/concepts/backend-group.md#health-checks).
  1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, specify the CIDRs and masks of subnets traffic will move to/from. To add multiple CIDRs, click **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-cidr }}**.
  1. Optionally, add a description.
  1. Click **{{ ui-key.yacloud.common.save }}**.