{% list tabs %}

- Cloud Organization

   1. [Log in]({{ link-passport-login }}) to the organization administrator account.

   1. Go to [{{ org-full-name }}]({{link-org-main}}).

   1. In the left-hand panel, select **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../../_assets/console-icons/persons.svg).

   1. In the top-right corner, click **{{ ui-key.yacloud_org.entity.group.action_create }}** and enter a group name and description.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

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

      {{ TF }} will create all the required resources. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc organization-manager group list --organization-id=<organization_ID>
      ```

{% endlist %}