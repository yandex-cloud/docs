{% list tabs group=instructions %}

- {{ org-name }} interface {#cloud-org}

   1. Go to [{{ org-full-name }}]({{link-org-main}}).

   1. In the left-hand panel, select **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../../_assets/console-icons/persons.svg) and click the line with the group name.

   1. Go to the **{{ ui-key.yacloud_org.entity.group.title_tab-members }}** tab.

   1. Click **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.

   1. In the **{{ ui-key.yacloud_org.component.subject-select-dialog.title_dialog }}** window, select users from the list or search by user. You can also add [service accounts](../../iam/concepts/users/service-accounts.md) to a group.

   1. Click **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the new group members:

      ```hcl
      resource "yandex_organizationmanager_group_membership" "group-members" {
         group_id = "<group_ID>"
         members  = [
           "<member_1_ID>",
           "<member_2_ID>"
         ]
      }
      ```

      Where:

      * `organization_id`: ID of the group to add the members to.
      * `members`: [IDs](../../organization/operations/users-get.md) of the members to be added to the group.

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc organization-manager group --name=<group_name> list-members --organization-id=<organization_ID>
      ```

{% endlist %}