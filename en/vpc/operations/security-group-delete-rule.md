---
title: Deleting a rule from a security group
description: Follow this guide to delete a rule from a security group.
---

# Deleting a rule from a security group

{% list tabs group=instructions %}

- Management console {#console}

  To delete a [rule](../concepts/security-groups.md#security-groups-structure) from a [security group](../concepts/security-groups.md):

  1. In the [management console]({{ link-console-main }}), select the folder containing the security group you want to update.
  1. [Navigate]({{ link-console-main }}/link/vpc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row of the security group you need to delete a rule from and select **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.vpc.network.security-groups.label_rules-ingress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_rules-egress }}**, click ![image](../../_assets/console-icons/ellipsis.svg) next to the rule you need to delete.
  1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  To delete a [rule](../concepts/security-groups.md#security-groups-structure) from a [group](../concepts/security-groups.md):

  1. Get the name or ID of the group to edit:

     ```bash
     yc vpc security-groups list
     ```

     Result:

     ```text
     +----------------------+---------------------------------+------------------------------------+----------------------+
     |          ID          |              NAME               |          DESCRIPTION               |      NETWORK-ID      |
     +----------------------+---------------------------------+------------------------------------+----------------------+
     | enp9bmjge93b******** | default-sg-enp509crtquf******** | Default security group for network | enp509crtquf******** |
     | enp9rs9u4h6j******** | sg-1                            |                                    | enp509crtquf******** |
     | enp9d8m73d1c******** | sg-2                            |                                    | enp509crtquf******** |
     +----------------------+---------------------------------+------------------------------------+----------------------+
     ```
  1. Get a list of security group rules by specifying the group name or ID:

     ```bash
     yc vpc security-groups get <group_name_or_ID>
     ```

     Result:

     ```text
     id: enp8rs9i4h6j********
     folder_id: b1gaus8l79li********
     created_at: "2022-06-24T15:46:31Z"
     name: sg-1
     network_id: enp559cr9quf********
     status: ACTIVE
     rules:
       - id: enpbbmv8ici********
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

     ```bash
     yc vpc security-group update-rules <group_name_or_ID> --delete-rule-id <rule_ID>
     ```

     Result:

     ```text
     done (12s)
     id: enp8rs9i4h6j********
     folder_id: b1gaus8l79li********
     created_at: "2022-06-24T15:46:31Z"
     name: sg-1
     network_id: enp559cr9quf********
     status: ACTIVE
     rules:
     ...
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete a [rule](../concepts/security-groups.md#security-groups-structure) created with {{ TF }} from a [security group](../concepts/security-groups.md):

  1. Open the {{ TF }} configuration file and delete the `ingress` or `egress` section from the security group description:

     {% cut "Example of a description of a security group with rules in the {{ TF }} configuration" %}

     ```hcl
     ...
     resource "yandex_vpc_security_group" "test-sg" {
       name        = "Test security group"
       description = "Description for security group"
       network_id  = yandex_vpc_network.lab-net.id

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
     }
     ...
     ```

     {% endcut %}

  1. Apply the configuration:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the security group update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc vpc security-group get <security_group_name>
     ```

- API {#api}

  To delete a [rule](../concepts/security-groups.md#security-groups-structure) from a [security group](../concepts/security-groups.md), use the [updateRules](../api-ref/SecurityGroup/updateRules.md) REST API method for the [SecurityGroup](../api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/UpdateRules](../api-ref/grpc/SecurityGroup/updateRules.md) gRPC API call, and provide the following in the request:

  * ID of the security group to delete the rules from, in the `securityGroupId` parameter.
  * IDs of the rules to delete, in the `deletionRuleIds[]` array.

  {% include [get-security-group-id](../../_includes/vpc/get-security-group-id.md) %}

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

