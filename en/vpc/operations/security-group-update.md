# Changing the name and description

{% note info %}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

After creating a security group, you can change its name and description, and [add](security-group-add-rule.md) or [remove](security-group-delete-rule.md) rules.

{% list tabs %}

- Management console

   To change the name or description of a group:

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to change the security group.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
   1. Click ![image](../../_assets/options.svg) in the row next to the group to edit.
   1. In the menu that opens, click **{{ ui-key.yacloud.common.edit }}**.
   1. Edit the group name and description and click **{{ ui-key.yacloud.common.save }}**.

- CLI

   To update the security group, run this command:

   ```
   yc vpc security-group update <group ID> --new-name test-sg-renamed
   ```

- API

   To change the security group name or description, use the [update](../api-ref/SecurityGroup/update.md) REST API method for the [SecurityGroup](../api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Update](../api-ref/grpc/security_group_service.md#Update) gRPC API call.

- {{ TF }}

   For more information about {{ TF }}, [see our documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   1. Open the {{ TF }} configuration file and edit the `name` and `description` parameters in the security group description:

      ```hcl
      ...
      resource "yandex_vpc_security_group" "test-sg" {
        name        = "Test security group"
        description = "Description for security group"
        network_id  = "${yandex_vpc_network.lab-net.id}"
      }
      ...
      ```

      For more information about the `yandex_vpc_security_group` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_security_group).

      {% note info %}

      To manage the [default security group](../../vpc/concepts/security-groups#default-security-group), use the [vpc_default_security_group]({{ tf-provider-resources-link }}/vpc_default_security_group) resource.

      {% endnote %}

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

      You can verify the changes to the security group using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc vpc security-group get <security group name>
      ```

{% endlist %}
