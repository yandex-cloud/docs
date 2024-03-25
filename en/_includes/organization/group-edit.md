To change the name or description of a [group](../../organization/concepts/groups.md):

{% list tabs group=instructions %}

- {{ org-name }} interface {#cloud-org}

   1. [Log in]({{ link-passport-login }}) as the organization administrator.
   1. Go to [{{org-full-name}}]({{ link-org-main }}).
   1. In the left-hand panel, select **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../../_assets/console-icons/persons.svg).
   1. Select a group from the list and click ![image](../../_assets/console-icons/ellipsis.svg) next to the group name.
   1. Click **{{ ui-key.yacloud_org.entity.group.action_edit }}** and enter a new group name or description.
   1. Click **{{ ui-key.yacloud_org.actions.save-changes }}**.

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

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

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

      ```bash
      yc organization-manager group get --name=<group_name> --organization-id=<organization_ID>
      ```

{% endlist %}