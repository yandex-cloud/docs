{% list tabs %}

- Cloud Organization

   1. Go to [{{ org-full-name }}]({{link-org-main}}).

   1. In the left panel, select **Groups** ![icon-services](../../_assets/organization/icon-groups.svg) and click the line with the group name.

   1. Go to the **Members** tab.

   1. Click **Add member**.

   1. In the **Add members** window, select users from the list or perform a search by user. You can also add [service accounts](../../iam/concepts/users/service-accounts.md) to a group.

   1. Click **Save**.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
      * `members`: [IDs](../../organization/users-get.md) of the members to be added to the group.

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can verify that the resources are there and their configuration is correct using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```bash
      yc organization-manager group --name=<group_name> list-members --organization-id=<organization_ID>
      ```

{% endlist %}