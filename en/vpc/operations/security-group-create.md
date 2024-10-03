---
title: How to create a security group
description: Follow this guide to create a security group.
---

# Creating a security group

{% include [sg-rules](../../_includes/vpc/sg-rules.md) %}

To create a new [security group](../concepts/security-groups.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a security group.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
   1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
   1. Enter a name for the security group.
   1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select the network to assign the security group to.
   1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create traffic management rules:
      1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.
      1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the appropriate protocol or leave `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` to allow traffic transmission over any protocol.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select the purpose of the rule:
         1. `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`: Rule will apply to the range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-cidr }}**.
         1. `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` field alternative. Select:
            * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`: To allow networking between the resources within the current security group.
            * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-list }}`: To allow networking with the resources of the selected group.
         1. `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`​.
   1. Click **{{ ui-key.yacloud.common.save }}**. Add other rules, if required.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   To create a group with an IPv4 CIDR rule, run the command:

   ```bash
   yc vpc security-group create \
     --name test-sg-cli \
     --rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[10.0.0.0/24]" \
     --network-id c645mh47vscb********
   ```

   Where:

   * `name`: Security group name.
   * `rule`: Rule description:
      * `direction`: Traffic direction. `ingress`: Incoming traffic; `egress`: Outgoing traffic.
      * `port`: Port for receiving or transmitting traffic. You can also specify a range of ports using the `from-port` and `to-port` parameters.
      * `protocol`: Data transfer protocol. The possible values are `tcp`, `udp`, `icmp`, `esp`, `ah`, or `any`.
      * `v4-cidrs`: List of IPv4 CIDRs and masks of subnets to deal with outgoing and incoming traffic.
      * `network-id`: ID of the network the security group will be connected to.

   To create a group with a rule that allows traffic from all resources of a different security group, run this command:

   ```bash
   yc vpc security-group create \
     --name allow-connection-from-app \
     --rule "direction=ingress,port=5642,protocol=tcp,security-group-id=enp099cqehlfvabec36d" \
     --network-name infra2
   ```

   Where:

   * `name`: Security group name.
   * `rule`: Rule description:
      * `direction`: Traffic direction. `ingress`: Incoming traffic; `egress`: Outgoing traffic.
      * `port`: Port for receiving or transmitting traffic. You can also specify a range of ports using the `from-port` and `to-port` parameters.
      * `protocol`: Data transfer protocol. The possible values are `tcp`, `udp`, `icmp`, `esp`, `ah`, or `any`.
      * `security-group-id`: ID of the security group for which traffic is allowed to the new security group through port 443.
   * `network-name`: Name of the network the security group will be connected to.

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To create a security group with multiple rules:

   1. In the configuration file, describe the parameters of the resources you want to create:

      * `name`: Security group name.
      * `description`: Optional description of the security group.
      * `network_id`: ID of the network that the security group will be assigned to.
      * `ingress` and `egress`: Rule parameters for incoming and outgoing traffic:
         * `protocol`: Traffic transfer protocol. The possible values are `tcp`, `udp`, `icmp`, `esp`, `ah`, or `any`.
         * `description`: Optional description of the rule.
         * `v4_cidr_blocks`: List of CIDRs and masks of subnets to deal with outgoing and incoming traffic.
         * `port`: Port for traffic.
         * `from-port`: First port in the traffic ports range.
         * `to-port`: Last port in the traffic ports range.

      Here is an example of the configuration file structure:


      ```
      provider "yandex" {
        token     = "<OAuth_or_service_account_static_key>"
        folder_id = "<folder_ID>"
        zone      = "{{ region-id }}-a"
      }

      resource "yandex_vpc_security_group" "test-sg" {
        name        = "Test security group"
        description = "Description for security group"
        network_id  = "<network_ID>"

        ingress {
          protocol       = "TCP"
          description    = "Rule description 1"
          v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
          port           = 8080
        }

        ingress {
          protocol          = "ANY"
          description       = "Allows networking between resources within the current security group"
          predefined_target = "self_security_group"
          from_port         = 0
          to_port           = 65535
        }

        ingress {
          protocol           = "TCP"
          description        = "Allows connections for the sg-frontend security group resources over port 27017"
          security_group_id  = yandex_vpc_security_group.sg-frontend.id
          port               = 27017
        }

        egress {
          protocol       = "ANY"
          description    = "Rule description 2"
          v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
          from_port      = 8090
          to_port        = 8099
        }
      }
      ```



      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure the configuration files are correct.

      1. In the command line, go to the folder where you created the configuration file.
      1. Run a check using this command:
         ```
         terraform plan
         ```
      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:
         ```
         terraform apply
         ```
      1. Confirm that you want to create the resources.

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API {#api}

   Use the [create](../api-ref/SecurityGroup/create.md) REST API method for the [SecurityGroup](../api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Create](../api-ref/grpc/security_group_service.md#Create) gRPC API call, and provide the following in the request:

   * ID of the folder where the security group will be placed, in the `folderId` parameter.
   * ID of the network where the security group will be placed, in the `networkId` parameter.
   * Settings for the security group rules, in the `ruleSpecs[]` array.

      * Traffic direction for which the rule is created, in the `ruleSpecs[].direction` parameter. The possible values are:

         * `ingress`: Incoming traffic
         * `egress`: Outgoing traffic

      * Name of the traffic transmission protocol, in the `ruleSpecs[].protocolName` parameter. The possible values are `tcp`, `udp`, `icmp`, `esp`, `ah`, or `any`.
      * List of CIDRs and masks of subnets to deal with outgoing and incoming traffic, in the `ruleSpecs[].cidrBlocks.v4CidrBlocks[]` parameter. If the rule is configured for transmitting traffic to a security group, then transmit the security group ID in the `ruleSpecs[].securityGroupId` parameter instead.
      * First port in the traffic ports range, in the `ruleSpecs[].ports.fromPort` parameter. The possible values are from `0` to `65535`.
      * Last port in the traffic ports range, in the `ruleSpecs[].ports.toPort` parameter. The possible values are from `0` to `65535`.

{% endlist %}
