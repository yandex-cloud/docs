{% list tabs group=instructions %}

- Management console {#console}

   1. [Create a network](../../vpc/operations/network-create.md) named `network-1`. When creating your network, disable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option.
   1. In `network-1`, [create](../../vpc/operations/subnet-create.md) two [subnets](../../vpc/concepts/network.md#subnet) in different [availability zones](../../overview/concepts/geo-scope.md) with the following parameters:
      1. Subnet in the `{{ region-id }}-a` availability zone:
         * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `subnet-a`
         * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-a`
         * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `192.168.0.0/24`
      1. Subnet in the `{{ region-id }}-b` availability zone:
         * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `subnet-b`
         * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-b`
         * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `192.168.1.0/24`
   1. In `network-1`, [create security groups](../../vpc/operations/security-group-create.md):
      1. Named `bitrix-sg-vm` for your VM in the cloud. [Set rules](../../vpc/operations/security-group-add-rule.md) for the [security group](../../vpc/concepts/security-groups.md) based on the following table:

         | Traffic<br>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
         --- | --- | --- | --- | --- | ---
         | Outgoing | `ANY` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0` |
         | Incoming | `HTTP` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0` |
         | Incoming | `EXT-HTTPS` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0` |
         | Incoming | `SSH` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0` |

      1. Named `bitrix-sg` for a {{ MY }} database cluster. [Set rules](../../vpc/operations/security-group-add-rule.md) for the security group based on the following table:

         | Traffic<br>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
         --- | --- | --- | --- | --- | ---
         | Outgoing | `ANY` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0` |
         | Incoming | `EXT-HTTPS` | `3306` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0` |

{% endlist %}