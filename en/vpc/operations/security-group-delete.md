# Delete a security group

The feature is at the [Preview stage](../../overview/concepts/launch-stages.md).

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

- Terraform

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more on Terraform, [review the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   If you created a security group using Terraform, you can delete it:

   1. In the command line, go to the directory with the Terraform configuration file.
   2. Delete resources using the command:
      ```
      terraform destroy
      ```

      {% note alert %}

      Terraform deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and VMs.

      {% endnote %}

   3. Confirm the deletion of resources.

{% endlist %}
