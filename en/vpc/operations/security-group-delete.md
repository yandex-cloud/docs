# Delete a security group

Security groups are at the [Preview stage](../../overview/concepts/launch-stages.md). If they are unavailable on your network, all incoming and outgoing traffic will be allowed for the resources. No additional setup is required.

To enable security groups, request access to this feature from the [support team]({{ link-console-support }}/create-ticket).

{% note warning %}

You can't delete security group created by default in the network.

{% endnote %}

To delete a security group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to delete the security group.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **Security groups**.
   1. Click ![image](../../_assets/options.svg) in the line of the group to delete.
   1. In the menu that opens, click **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

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
      | enpkf7dbjonf45gda6cd | test-sg-cli |             | enpgkbe17td89r34satu |
      +----------------------+-------------+-------------+----------------------+
      ```

   1. Select the `ID` or `NAME` of the network you need.
   1. Delete the network:

      ```
      yc vpc security-group delete test-sg-cli
      ```

- API

   Use the [delete](../api-ref/SecurityGroup/delete.md) REST API method for the [SecurityGroup](../api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Delete](../api-ref/grpc/security_group_service.md#Delete) gRPC API call.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc vpc security-group list
      ```

{% endlist %}
