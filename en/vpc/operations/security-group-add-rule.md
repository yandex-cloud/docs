# Add a new rule

{% include [Preview](../../_includes/vpc/preview.md) %}

You do not need to restart a VM when adding or deleting rules. The rules are applied to all the resources assigned to a group at the same time.

{% list tabs %}

- Management console

   To add a rule:

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to change the security group.

   1. In the list of services, select **{{ vpc-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **Security groups**.

   1. Select the group to update.

   1. Click ![image](../../_assets/options.svg) in the row of the group.

   1. In the menu that opens, click **Edit**.

   1. Under **Rules**, create traffic management rules:

      1. Select the **Outgoing traffic** or **Incoming traffic** tab.

      1. Click **Add rule**.

      1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.

      1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.

      1. In the **Purpose** or **Source** field, select the purpose of the rule:

         * **CIDR**: The rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.

         * **Security group**. Select one of the following:

            * **Current** (`Self`): The rule will apply to the VMs from the current group.
            * **From list**: The rule will apply to the VMs from the selected group. Make sure that source and destination IPs used for traffic exchange are from [private ranges](../concepts/network.md#subnet). For more information, see [Concepts](../concepts/security-groups.md#groups).

         * **Load balancer healthchecks**: A rule that allows checking the health of resources from [{{ network-load-balancer-name }}](../../network-load-balancer/concepts/health-check.md) or [{{ alb-name }}](../../application-load-balancer/concepts/backend-group.md#health-checks).

   1. Click **Save**.

   1. Click **Save** once again.

- CLI

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
      | enp9bmjge93bvnlb4061 | default-sg-enp509crtqufsuhm9kbr | Default security group for network | enp509crtqufsuhm9kbr |
      | enp9rs9u4h6juk9rq3k5 | sg-1                            |                                    | enp509crtqufsuhm9kbr |
      | enp9d8m73d1cgh2rm179 | sg-2                            |                                    | enp509crtqufsuhm9kbr |
      +----------------------+---------------------------------+------------------------------------+----------------------+
      ```

   1. Add a rule using the `update-rules` command and the `--add-rule` parameter:

      ```
      yc vpc security-group update-rules <group name or ID> --add-rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[10.0.0.0/24,10.10.0.0/24]"
      ```
      Result:
      ```
      done (12s)
      id: enp9rs9i4h9juk9rq3k5
      folder_id: b1gau98l79li5n96eabd
      created_at: "2022-06-24T15:46:31Z"
      name: sg-1
      network_id: enp559cr9q9fsuhm9kbr
      status: ACTIVE
      rules:
        - id: enp68o6cdi872ftdu4vp
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

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

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

      For more information about the `yandex_vpc_security_group` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/vpc_security_group).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes to the security group using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc vpc security-group get <security group name>
      ```

   ### Adding a new rule using the yandex_vpc_security_group_rule resource {#add-rule-with-yandex-vpc-security-group-rule}

   You can also add a new rule to an existing security group using the `yandex_vpc_security_group_rule` resource.

   {% note warning %}

   The two methods do the same but are incompatible: concurrent use of the `yandex_vpc_security_group_rule` and `yandex_vpc_security_group` resources will cause a configuration rule conflict.

   {% endnote %}

   1. In the configuration file, describe the following parameters:

      * `security_group_binding`: Security group ID.
      * `direction`: Incoming or outgoing traffic. Possible values: `ingress` or `egress`.
      * `description`: Description of the rule.
      * `v4_cidr_blocks`: List of CIDRs and masks of subnets that traffic will come from or to.
      * `port`: Port for traffic.
      * `from_port`: The first port in the range of ports for traffic.
      * `to_port`: The last port in the range of ports for traffic.
      * `protocol`: Traffic transfer protocol. Possible values: `TCP`, `UDP`, `ICMP`, or `ANY`.

      ```hcl
      ...
      resource "yandex_vpc_security_group_rule" "rule1" {
        security_group_binding = <security group ID>
        direction              = "ingress"
        description            = "<rule description>"
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

      For more information about the parameters of the `yandex_vpc_security_group_rule` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/resources/vpc_security_group_rule).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes to the security group using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc vpc security-group get <security group name>
      ```

{% endlist %}

