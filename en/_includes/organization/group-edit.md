To change the name or description of a group:

{% list tabs %}

- Cloud Organization

   1. [Log in]({{ link-passport-login }}) to the organization's administrator account.

   1. Go to [{{org-full-name}}]({{ link-org-main }}).

   1. In the left panel, select **Groups** ![icon-services](../../_assets/organization/icon-groups.svg).

   1. Select a group from the list and click ![image](../../_assets/options.svg) next to the group name.

   1. Click **Edit** and enter a new group name or description.

   1. Click **Save**.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, edit the group parameters:

      ```hcl
      resource "yandex_organizationmanager_group" "my-group" {
         name            = "new-group-name"
         description     = "My first group"
         organization_id = "<organization_ID>"
      }
      ```

      Where:

      * `name`: New group name. The name format is as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * `description`: New group description.
      * `organization_id`: ID of the organization the group belongs to.

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can verify that the resources are there and their configuration is correct using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```bash
      yc organization-manager group get --name=<group_name> --organization-id=<organization_ID>
      ```

{% endlist %}