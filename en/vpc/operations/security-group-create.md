---
title: How to create a security group
description: Follow this guide to create a security group.
---

# Creating a security group

{% include [sg-rules](../../_includes/vpc/sg-rules.md) %}

To create a new [security group](../concepts/security-groups.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you need to create a security group.
  1. [Navigate]({{ link-console-main }}/link/vpc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**. 
  1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. Enter a name for the security group.
  1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select the network to assign the security group to.
  1. {% include [security-group-add-rule](../../_includes/vpc/security-group-add-rule.md) %}
  1. Click **{{ ui-key.yacloud.common.save }}** once again.

- CLI {#cli}
  
  To create a group with an IPv4 CIDR rule, run this command:

  ```bash
  yc vpc security-group create \
    --name test-sg-cli \
    --description "My security group" \
    --rule "description=Allow HTTPS,direction=ingress,port=443,protocol=tcp,v4-cidrs=[10.0.0.0/24]" \
    --network-id c645mh47vscb********
  ```

  Where:

  * `--name`: Security group name.
  * `--description`: Security group description.
  * `--labels`: Security group labels in `key=value` format.
  * `--rule`: Security group rule:
    * `description`: Rule description.
    * `direction`: Traffic direction, with `ingress` for incoming traffic and `egress` for outgoing traffic.
    * `port`: Port for receiving or transmitting traffic. You can also specify a range of ports using the `from-port` and `to-port` parameters.
    * `protocol`: Data transfer protocol. The possible values are `any`, `tcp`, `udp`, `icmp`, or [IANA IP protocol number](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).
    * `v4-cidrs`: List of IPv4 CIDRs and masks of subnets the traffic will come to or from.
  * `--network-id`: ID of the network the security group will be connected to.

  To create a group with a rule that allows traffic from all resources of a different security group, run this command:

  ```bash
  yc vpc security-group create \
    --name allow-connection-from-app \
    --rule "direction=ingress,port=443,protocol=tcp,security-group-id=enp099cqehlf********" \
    --network-name infra2
  ```

  Where:

  * `--name`: Security group name.
  * `--rule`: Security group rule:
    * `direction`: Traffic direction, with `ingress` for incoming traffic and `egress` for outgoing traffic.
    * `port`: Port for receiving or transmitting traffic. You can also specify a range of ports using the `from-port` and `to-port` parameters.
    * `protocol`: Data transfer protocol. The possible values are `any`, `tcp`, `udp`, `icmp`, or [IANA IP protocol number](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).
    * `security-group-id`: ID of the security group that is allowed to send traffic to the new security group through port 443. Instead of the ID, you can specify the security group name under `security-group-name`.
    * `predefined`: Predefined rule target. Specify it instead of `security-group-id`, `security-group-name`, or `v4-cidrs`. The possible values are:
      * `self_security_group`: Resources the new security group applies to. Learn more about the Self rule [here](../concepts/security-groups.md#self-rule).
      * `loadbalancer_healthchecks`: Load balancer health check nodes.
  * `--network-name`: Name of the network the security group will be connected to.

  For example, use `predefined=self_security_group` to allow inbound traffic on port `443` from the new security group resources:

  ```bash
  yc vpc security-group create \
    --name allow-connection-from-self \
    --rule "direction=ingress,port=443,protocol=tcp,predefined=self_security_group" \
    --network-name infra2
  ```

  The command also supports the `--async` parameter to output information on the current operation without waiting for its completion.

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a security group with multiple rules: 
    
  1. In the configuration file, specify the properties of the resources you want to create:

     * `name`: Security group name.
     * `description`: Optional description of the security group.
     * `network_id`: ID of the network the security group will be assigned to.
     * `ingress` and `egress`: Incoming and outgoing traffic rule parameters:
       * `protocol`: Traffic transmission protocol. The possible values are `tcp`, `udp`, `icmp`, `esp`, `ah`, or `any`.
       * `description`: Optional description of the rule.
       * `v4_cidr_blocks`: List of CIDRs and masks of subnets the traffic will come to or from.
       * `port`: Traffic port.
       * `from-port`: First port in the traffic port range.
       * `to-port`: Last port in the traffic port range.

     Here is an example of the configuration file structure:

     ```hcl
     resource "yandex_vpc_security_group" "test-sg" {
       name        = "Test security group"
       description = "Description for security group"
       network_id  = "<network_ID>"

       egress {
         protocol       = "ANY"
         description    = "Rule description 2"
         v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
         from_port      = 8090
         to_port        = 8099
       }

       ingress {
         protocol       = "TCP"
         description    = "Rule description 1"
         v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
         port           = 8080
       }

       ingress {
         protocol          = "ANY"
         description       = "Enables communication between resources in the current security group"
         predefined_target = "self_security_group"
         from_port         = 0
         to_port           = 65535
       }

       ingress {
         protocol           = "TCP"
         description        = "Enables connections on port 27017 from resources in the `sg-frontend` security group"
         security_group_id  = yandex_vpc_security_group.sg-frontend.id
         port               = 27017
       }
     }
     ```

     For more information about the resources you can create with {{ TF }}, see [this provider guide]({{ tf-provider-link }}).
     
  1. Apply the configuration:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
     
     This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [create](../api-ref/SecurityGroup/create.md) REST API method for the [SecurityGroup](../api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Create](../api-ref/grpc/SecurityGroup/create.md) gRPC API call, and provide the following in the request:

  * ID of the folder the security group will reside in, in the `folderId` parameter.
  * Security group name, in the `name` parameter.
  * Security group description, in the `description` parameter.
  * Security group labels as `key:value` pairs, in the `labels` parameter.
  * ID of the network the security group will reside in, in the `networkId` parameter.
  * Settings for the security group rules, in the `ruleSpecs[]` array:

    * Rule description, in the `ruleSpecs[].description` parameter.
    * Rule labels as `key:value` pairs, in the `ruleSpecs[].labels` parameter.
    * Traffic direction for which the rule is created, in the `ruleSpecs[].direction` parameter. The possible values are:

      * `ingress`: Incoming traffic
      * `egress`: Outgoing traffic

    * Name of the traffic transmission protocol, in the `ruleSpecs[].protocolName` parameter, or the protocol number as per the [IANA registry](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml), in the `ruleSpecs[].protocolNumber` parameter. You can only provide one of these parameters at a time.
    * Rule’s target resources. Provide only one of these parameters:

      * List of IPv4 CIDRs and masks of subnets the traffic will come to or from, in the `ruleSpecs[].cidrBlocks.v4CidrBlocks[]` parameter.
      * ID of the security group whose resources the rule applies to, in the `ruleSpecs[].securityGroupId` parameter.
      * Predefined rule target, in the `ruleSpecs[].predefinedTarget` parameter. The possible values are:
        * `self_security_group`: Resources the new security group applies to. Learn more about the Self rule [here](../concepts/security-groups.md#self-rule).
        * `loadbalancer_healthchecks`: Load balancer health check nodes.

    * First port in the traffic port range, in the `ruleSpecs[].ports.fromPort` parameter. The values range from `0` to `65535`.
    * Last port in the traffic port range, in the `ruleSpecs[].ports.toPort` parameter. The possible values range from `0` to `65535`.

{% endlist %}
