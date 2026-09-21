---
title: How to delete a security group
description: Follow this guide to delete a security group.
---

# Deleting a security group

{% note warning %}

You cannot delete a security group created by default in the network.

{% endnote %}

To delete a [security group](../concepts/security-groups.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you need to delete a security group.
  1. [Navigate]({{ link-console-main }}/link/vpc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row of the security group you need to delete.
  1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for deleting security groups:

      ```bash
      yc vpc security-group delete --help
      ```

  1. Get a list of all security groups in the default folder:

      ```bash
      yc vpc security-group list
      ```

      Result:

      ```text
      +----------------------+-------------+-------------+----------------------+
      |          ID          |    NAME     | DESCRIPTION |      NETWORK-ID      |
      +----------------------+-------------+-------------+----------------------+
      | enpkf7dbjonf******** | test-sg-cli |             | enpgkbe17td8******** |
      +----------------------+-------------+-------------+----------------------+
      ```

  1. Select `ID` or `NAME` of the security group in question.
  1. Delete the security group:

      ```bash
      yc vpc security-group delete test-sg-cli
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete a security group created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the fragment with the security group description.
     
     {% cut "Example of a security group description in the {{ TF }} configuration" %}

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

     You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc vpc security-group list
     ```

- API {#api}

  Use the [delete](../api-ref/SecurityGroup/delete.md) REST API method for the [SecurityGroup](../api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Delete](../api-ref/grpc/SecurityGroup/delete.md) gRPC API call and provide the ID of the security group being deleted in the `securityGroupId` request parameter.

  {% include [get-security-group-id](../../_includes/vpc/get-security-group-id.md) %}

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

