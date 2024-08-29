{% list tabs group=instructions %}

- Management console {#console}

   [Security groups](../../vpc/concepts/security-groups.md) act as a virtual firewall for incoming and outgoing traffic. See more about the default security group [here](../../vpc/concepts/security-groups.md#default-security-group).
   1. To enable OpenVPN Access Server to work, [add](../../vpc/operations/security-group-add-rule.md) the following rules to the default security group:

      | Traffic<br>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
      --- | --- | --- | --- | --- | ---
      | Incoming | `VPN Server` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | Incoming | `VPN Server` | `1194` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | Incoming | `Admin Web UI,`</br>`Client Web UI` | `943` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

      A VPN server can redirect traffic from the `HTTPS` port. If required, leave the only `TCP 443` port open. See also the settings in the **Configuration** → **Network Settings** tab of the server admin panel.

   1. If you have configured a security group of your own, make sure it allows traffic between the VPN server and the required resources. For example, they share the same security group and there is a [Self rule](../../vpc/concepts/security-groups.md#rules-types) for the whole group.

{% endlist %}