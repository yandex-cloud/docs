---
title: "How to delete a security group"
description: "Follow this guide to delete a security group."
---

# Delete a security group

{% note warning %}

You cannot delete security group created by default in the network.

{% endnote %}

To delete a security group:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to delete the security group.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the line of the group to delete.
   1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI command for deleting security groups:

      ```
      yc vpc security-group delete --help
      ```

   1. Get a list of all security groups in the default folder:

      ```
      yc vpc security-group list
      ```

      Result:
      ```
      +----------------------+-------------+-------------+----------------------+
      |          ID          |    NAME     | DESCRIPTION |      NETWORK-ID      |
      +----------------------+-------------+-------------+----------------------+
      | enpkf7dbjonf******** | test-sg-cli |             | enpgkbe17td8******** |
      +----------------------+-------------+-------------+----------------------+
      ```

   1. Select the `ID` or `NAME` of the network you need.
   1. Delete the network:

      ```
      yc vpc security-group delete test-sg-cli
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To delete a security group created with {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the fragment with the security group description.

      {% cut "Example security group description in a {{ TF }} configuration" %}

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

      You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```
      yc vpc security-group list
      ```

- API {#api}

   Use the [delete](../api-ref/SecurityGroup/delete.md) REST API method for the [SecurityGroup](../api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Delete](../api-ref/grpc/security_group_service.md#Delete) gRPC API call, and provide the ID of the security group you want to to delete in the `securityGroupId` request parameter.

   {% include [get-security-group-id](../../_includes/vpc/get-security-group-id.md) %}

   {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}
