---
title: "Adding a new rule to a {{ vpc-full-name }} security group"
description: "You can add rules using the management console, CLI, and {{ vpc-name }} API. You do not need to restart a VM when adding or deleting rules. The rules are applied to all the resources assigned to a group at the same time."
---

# Adding a new rule to a security group

You do not need to restart a VM when adding or deleting rules. The rules are applied to all the resources assigned to a group at the same time.

{% list tabs group=instructions %}

- Management console {#console}

   To add a rule:

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to change the security group.

   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.

   1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.

   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the security group you need to add a rule to and select **{{ ui-key.yacloud.common.edit }}**.

   1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create traffic management rules:

     1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.

     1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.

     1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.

      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the appropriate protocol or leave `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` to allow traffic transmission over any protocol.

      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select the purpose of the rule:

        * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`: Rule will apply to the range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_add-cidr }}**.

        * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`. Select one of the following:

            * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`: The rule will apply to the VMs from the current group.
            * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-list }}`: The rule will apply to the VMs from the selected group. Make sure that source and destination IPs used for traffic exchange are from [private ranges](../concepts/network.md#subnet). For more information, see [Concepts](../concepts/security-groups.md#groups).

         * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`: A rule that allows checking the health of resources from [{{ network-load-balancer-name }}](../../network-load-balancer/concepts/health-check.md) or [{{ alb-name }}](../../application-load-balancer/concepts/backend-group.md#health-checks).

   1. Click **{{ ui-key.yacloud.common.save }}**.

   1. Click **{{ ui-key.yacloud.common.save }}** once again.

- CLI {#cli}

   To add a rule to an existing group:

   1. Get the name or ID of the group to edit:

      ```
      yc vpc security-groups list
      ```
      Result:
      ```
      +----------------------+---------------------------------+------------------------------------+----------------------+
      |          ID          |              NAME               |          DESCRIPTION               |      NETWORK-ID      |
      +----------------------+---------------------------------+------------------------------------+----------------------+
      | enp9bmjge93b******** | default-sg-enp509crtquf******** | Default security group for network | enp509crtquf******** |
      | enp9rs9u4h6j******** | sg-1                            |                                    | enp509crtquf******** |
      | enp9d8m73d1c******** | sg-2                            |                                    | enp509crtquf******** |
      +----------------------+---------------------------------+------------------------------------+----------------------+
      ```

   1. Add a rule using the `update-rules` command and the `--add-rule` parameter:

      ```
      yc vpc security-group update-rules <group_name_or_ID> --add-rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[10.0.0.0/24,10.10.0.0/24]"
      ```
      Result:
      ```
      done (12s)
      id: enp9rs9i4h9j********
      folder_id: b1gau98l79li********
      created_at: "2022-06-24T15:46:31Z"
      name: sg-1
      network_id: enp559cr9q9f********
      status: ACTIVE
      rules:
        - id: enp68o6cdi87********
          direction: INGRESS
          ports:
            from_port: "443"
            to_port: "443"
          protocol_name: TCP
          protocol_number: "6"
          cidr_blocks:
            v4_cidr_blocks:
              - 10.0.0.0/24
              - 10.10.0.0/24
           ...
      ```

      {% note info %}

      You can use `predefined=self_security_group` to apply the rule to the VMs inside the security group being updated.

      For more information about the `Self` rule, see the [types of security group rules](../concepts/security-groups.md#rules-types).

      {% endnote %}

      To get help about the `--add-rule` parameter, run `yc vpc security-group update-rules --help`.

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   1. Open the {{ TF }} configuration file and add the `ingress` or `egress` section to the security group description:

      ```hcl
      ...
      resource "yandex_vpc_security_group" "test-sg" {
        name        = "Test security group"
        description = "Description for security group"
        network_id  = "${yandex_vpc_network.lab-net.id}"

        ingress {
          protocol       = "TCP"
          description    = "Rule description 1"
          v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
          port           = 8080
        }

        egress {
          protocol       = "ANY"
          description    = "Rule description 2"
          v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
          from_port      = 8090
          to_port        = 8099
        }

        egress {
          protocol       = "UDP"
          description    = "rule3 description"
          v4_cidr_blocks = ["10.0.1.0/24"]
          from_port      = 8090
          to_port        = 8099
        }
      }
      ...
      ```

      For more information about the `yandex_vpc_security_group` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_security_group).

   1. Check the configuration using this command:

      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes to the security group using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc vpc security-group get <security_group_name>
      ```

   ### Adding a new rule using the yandex_vpc_security_group_rule resource {#add-rule-with-yandex-vpc-security-group-rule}

   You can also add a new rule to an existing security group using the `yandex_vpc_security_group_rule` resource.

   {% note warning %}

   The two methods do the same but are incompatible: concurrent use of the `yandex_vpc_security_group_rule` and `yandex_vpc_security_group` resources will cause a configuration rule conflict.

   {% endnote %}

   1. In the configuration file, describe the following parameters:

      * `security_group_binding`: Security group ID.
      * `direction`: Incoming or outgoing traffic. The possible values are `ingress` or `egress`.
      * `description`: Description of the rule.
      * `v4_cidr_blocks`: List of CIDRs and masks of subnets to deal with outgoing and incoming traffic.
      * `port`: Port for traffic.
      * `from_port`: First port in the traffic ports range.
      * `to_port`: Last port in the traffic ports range.
      * `protocol`: Traffic transfer protocol. The possible values are `TCP`, `UDP`, `ICMP`, or `ANY`.

      ```hcl
      ...
      resource "yandex_vpc_security_group_rule" "rule1" {
        security_group_binding = <security_group_ID>
        direction              = "ingress"
        description            = "<rule_description>"
        v4_cidr_blocks         = ["10.0.1.0/24", "10.0.2.0/24"]
        port                   = 8080
        protocol               = "TCP"
      }

      resource "yandex_vpc_security_group_rule" "rule2" {
        security_group_binding = yandex_vpc_security_group.group1.id
        direction              = "egress"
        description            = "rule2 description"
        v4_cidr_blocks         = ["10.0.1.0/24"]
        from_port              = 8090
        to_port                = 8099
        protocol               = "UDP"
      }
      ...
      ```

      For more information about the parameters of the `yandex_vpc_security_group_rule` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/resources/vpc_security_group_rule).

   1. Check the configuration using this command:

      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes to the security group using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc vpc security-group get <security_group_name>
      ```

- API {#api}

   To add a rule, use the [updateRules](../api-ref/SecurityGroup/updateRules.md) REST API method for the [SecurityGroup](../api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/UpdateRules](../api-ref/grpc/security_group_service.md#UpdateRules) gRPC API call, and provide the following in the request:

   * ID of the security group you want to add rules to, in the `securityGroupId` parameter.

      {% include [get-security-group-id](../../_includes/vpc/get-security-group-id.md) %}

      {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

   * New security group rules, in the `additionRuleSpecs[]` array.

      * Traffic direction for which the rule is created, in the `additionRuleSpecs[].direction` parameter. The possible values include:

         * `ingress`: Incoming traffic
         * `egress`: Outgoing traffic

      * Name of the traffic transmission protocol, in the `additionRuleSpecs[].protocolName` parameter. The possible values are `tcp`, `udp`, `icmp`, `esp`, `ah`, or `any`.
      * List of CIDRs and masks of subnets to deal with outgoing and incoming traffic, in the `additionRuleSpecs[].cidrBlocks.v4CidrBlocks[]` parameter. If the rule is configured for transmitting traffic to a security group, provide the security group ID in the `additionRuleSpecs[].securityGroupId` parameter instead.
      * First port in the traffic ports range, in the `additionRuleSpecs[].ports.fromPort` parameter. The possible values are from `0` to `65535`.
      * Last port in the traffic ports range, in the `additionRuleSpecs[].ports.toPort` parameter. The possible values are from `0` to `65535`.

{% endlist %}
