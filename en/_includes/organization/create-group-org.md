{% list tabs %}

- Cloud Organization

   1. [Log in]({{ link-passport-login }}) to the organization's administrator account.

   1. Go to [{{ org-full-name }}]({{link-org-main}}).

   1. In the left panel, select **Groups** ![icon-services](../../_assets/organization/icon-groups.svg).

   1. In the top-right corner of the page, click **Create group** and enter a name and description.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the group parameters:

      ```hcl
      resource "yandex_organizationmanager_group" "my-group" {
         name            = "<group_name>"
         description     = "<group_description>"
         organization_id = "<organization_ID>"
      }
      ```

      Where:

      * `name`: Group name. The name format is as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * `description`: Group description. This is an optional parameter.
      * `organization_id`: ID of the organization to add the group to.

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can verify that the resources are there and their configuration is correct using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```bash
      yc organization-manager group list --organization-id=<organization_ID>
      ```

{% endlist %}