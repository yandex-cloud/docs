---
title: "Deleting a rule from a security group"
description: "Follow this guide to delete a rule from a security group."
---

# Deleting a rule from a security group

{% list tabs %}

- Management console

   To delete a rule from a security group:

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to change the security group.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
   1. Click ![image](../../_assets/options.svg) next to the security group for which you need to delete a rule and select **{{ ui-key.yacloud.common.edit }}**.
   1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, click ![image](../../_assets/options.svg) in the row of the rule to delete.
   1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI

   To delete a rule from a group:

   1. Get the name or ID of the group to edit:

      ```
      yc vpc security-groups list
      ```
      Result:
      ```
      +----------------------+---------------------------------+------------------------------------+----------------------+
      |          ID          |              NAME               |          DESCRIPTION               |      NETWORK-ID      |
      +----------------------+---------------------------------+------------------------------------+----------------------+
      | enp9bmjge93bvnlb4061 | default-sg-enp509crtqufsu9m9kbr | Default security group for network | enp509crtqufsuhm9kbr |
      | enp9rs9u4h6juk9rq3k5 | sg-1                            |                                    | enp509crtqufsuhm9kbr |
      | enp9d8m73d1cgh2rm179 | sg-2                            |                                    | enp509crtqufsuhm9kbr |
      +----------------------+---------------------------------+------------------------------------+----------------------+
      ```
   1. Get a list of security group rules by specifying the group name or ID:

      ```
      yc vpc security-groups get <group name or ID>
      ```
      Result:
      ```
      id: enp8rs9i4h6juk9rl3k5
      folder_id: b1gaus8l79li5979eabd
      created_at: "2022-06-24T15:46:31Z"
      name: sg-1
      network_id: enp559cr9qufsuhm9kbr
      status: ACTIVE
      rules:
        - id: enpbbmv8icie959gcm84
          description: SSH
          direction: INGRESS
          ports:
            from_port: "22"
            to_port: "22"
          protocol_name: TCP
          protocol_number: "6"
          cidr_blocks:
            v4_cidr_blocks:
              - 0.0.0.0/0
      ...
      ```

   1. To delete a rule, specify its ID in the command:

      ```
      yc vpc security-group update-rules <group name or ID> --delete-rule-id <rule ID>
      ```
      Result:
      ```
      done (12s)
      id: enp8rs9i4h6juk9rq3k5
      folder_id: b1gaus8l79li5n96eabd
      created_at: "2022-06-24T15:46:31Z"
      name: sg-1
      network_id: enp559cr9qufsuhm9kbr
      status: ACTIVE
      rules:
      ...
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To delete a rule created with {{ TF }} from a security group:

   1. Open the {{ TF }} configuration file and delete the `ingress` or `egress` section from the security group description:

      {% cut "Sample description of a security group with rules in a {{ TF }} configuration" %}

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
      }
      ...
      ```

      {% endcut %}

   1. In the command line, go to the directory with the {{ TF }} configuration file.

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
      yc vpc security-group get <security group name>
      ```

- API

   To delete a rule from a security group, use the [updateRules](../api-ref/SecurityGroup/updateRules.md) REST API method for the [SecurityGroup](../api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/UpdateRules](../api-ref/grpc/security_group_service.md#UpdateRules) gRPC API call, and provide the following in the request:

   * ID of the security group you want to delete rules from, in the `securityGroupId` parameter.
   * IDs of the rules to be deleted, in the `deletionRuleIds[]` array.

   {% include [get-security-group-id](../../_includes/vpc/get-security-group-id.md) %}

   {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}
