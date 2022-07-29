# Managing user groups

For organizations with a lot of employees, multiple users may need to be granted the same access rights to {{ yandex-cloud }} resources. In this case, it's more convenient to grant roles and permissions to a group rather than individually.

You can group users by any criteria: for example, by their duties or department.

{% note info %}

Groups may only have a one-level structure.

The following limits apply to groups by default:
* The number of groups per organization: 100.
* The number of members per group: 1000.
* The number of groups a user may belong to: 1000.

To increase the quotas, contact [support]({{ link-console-support }}).

{% endnote %}

## Creating a group {#create-group}

1. [Log in]({{link-passport}}) to the organization's administrator account.

1. Go to [{{org-full-name}}]({{link-org-main}}).

1. In the left panel, select [Groups]({{link-org-groups}}) ![icon-services](../_assets/organization/icon-groups.svg).

1. In the top-right corner of the page, click **Create group** and enter a name and description.

## Editing a group {#edit-group}

To edit a group:

1. [Log in]({{link-passport}}) to the organization's administrator account.

1. Go to [{{org-full-name}}]({{link-org-main}}).

1. In the left panel, select [Groups]({{link-org-groups}}) ![icon-services](../_assets/organization/icon-groups.svg) and open the desired group from the list.

1. To rename the group and update its description, go to the **Overview** tab and click **Edit** in the top-right corner.

1. To add new group members, go to the **Members** tab, click **Add member**, and select a name from the list.

   {% note info %}

   You can't add [service accounts](../iam/concepts/users/service-accounts.md) to a group.

   {% endnote %}

1. To remove a group member, go to the **Members** tab, click ![](../_assets/horizontal-ellipsis.svg) next to the appropriate username, and select **Remove from group**.

## Setting up permissions to manage a group {#access-manage-group}

You can grant rights to edit a group to any user from your organization.

To set up permissions to manage a group:

1. [Log in]({{link-passport}}) to the organization's administrator account.

1. Go to [{{org-full-name}}]({{link-org-main}}).

1. In the left panel, select [Groups]({{link-org-groups}}) ![icon-services](../_assets/organization/icon-groups.svg) and open the desired group from the list.

1. Open the **Group access rights** tab and click **Assign roles**.

1. Click **Select user** and specify the account or group to grant the group edit permissions to.

1. Click **Add role** and select a role from the list:

   * `organization-manager.admin` to allow editing the group and changing its members.

   * `organization-manager.groups.memberAdmin` to allow managing the list of group members.

1. Click **Save**.

1. To edit or revoke access rights, click ![](../_assets/horizontal-ellipsis.svg) next to a username and select an option from the list.

{% note tip %}

To open the list of users who are allowed to manage a group at the level of [organization roles](./roles.md) (such as admin or organization owner), enable the **Inherited roles** option.

{% endnote %}

## Setting up a group's access to use {{ yandex-cloud }}{#access}

To enable group members to work with {{ yandex-cloud }} services, assign the appropriate [roles](../iam/concepts/access-control/roles.md) to the group.

### Resource-level access {#access-services}

With resource-level access permissions, group members can use {{ yandex-cloud }} services as per the role that the group is granted for a resource. [{#T}](../iam/concepts/access-control/resources-with-access-control.md).

To grant a group access to a resource:

{% list tabs %}

- Management console

   In the management console, you can only assign a role for a cloud or folder:

   1. Select the desired cloud or folder.

   1. Go to the **Access bindings** tab.

   1. In the top-right corner, activate **Inherited roles** so that the list shows users added to an organization.

   1. Select a group from the list and click ![image](../_assets/options.svg) next to the group name.

   1. Click **Edit roles**.

   1. In the cloud's **Configure access rights** window, click **Add role**.

   1. Choose the role.

   1. Click **Save**.

- CLI

   {% include [cli-install](../_includes/cli-install.md) %}

   1. Choose a role from the list in [Roles](../iam/concepts/access-control/roles.md).

   1. Assign the role using the command:

      ```bash
      yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
        --role <role-id> \
        --subject group:<group-id>
      ```

      Where:

      * `<service-name>`: The name of the service whose resource a role is assigned for (for example, `resource-manager`).
      * `<resource>`: The resource category, for example, `cloud`.
      * `<resource-name>`: The name of the resource. You can specify a resource by its name or ID.
      * `<resource-id>`: The resource ID.
      * `<role-id>`: The role ID, for example, `{{ roles-cloud-owner }}`.
      * `<group-id>`: The ID of the group that the role is assigned to.

      For example, assign the `viewer` role for the `mycloud` [cloud](../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager cloud add-access-binding mycloud \
        --role viewer \
        --subject group:aje6o61dvog2h6g9a33s
      ```

- API

   Use the `updateAccessBindings` method for the corresponding resource.

   1. Choose a role from the list in [Roles](../iam/concepts/access-control/roles.md).

   1. Create a request body, for example, in a `body.json` file. Set the `action` property to `ADD` and specify the `group` type and group ID in the `subject` property:

      **body.json:**
      ```json
      {
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "<group-id>",
                      "type": "group"
                      }
                  }
              }
          ]
      }
      ```

   1. {% include [grant-role-folder-via-curl-step](../_includes/iam/grant-role-folder-via-curl-step.md) %}

   For detailed instructions on how to assign a role for the corresponding resource, see:
   * [{#T}](../iam/operations/sa/set-access-bindings.md)
   * [{#T}](../resource-manager/operations/cloud/set-access-bindings.md)
   * [{#T}](../resource-manager/operations/folder/set-access-bindings.md)

- Terraform

   If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Add the resource parameters to the configuration file, specify the required role and a list of groups:

      * `cloud_id`: Cloud ID. You can also assign a role in an individual folder. To do this, specify `folder_id`instead of `cloud_id` and the required folder ID in the resource parameters.
      * `role`: The [role](../iam/concepts/access-control/roles.md) assigned. Required parameter.
      * `members`: The list of groups that the role is assigned to. Specified in `group:<group ID>` format. Required parameter.

      ```
      resource "yandex_resourcemanager_cloud_iam_binding" "admin" {
        cloud_id    = "<cloud-id>"
        role        = "<role-id>"
        members     = ["group:<group-id>"]
      }
      ```

      For more information about the parameters of the `yandex_resourcemanager_cloud_iam_binding` resource, see the [provider documentation]({{ tf-provider-link }}/iam_service_account_iam_binding).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      Afterwards, all the necessary resources are created in the specified folder. You can verify that the resource has been created in the [management console]({{ link-console-main }}) or with the following [CLI](../cli/quickstart.md) command:

      ```
      yc resource-manager folder list-access-bindings <folder-name>|<folder-id>
      ```

{% endlist %}

### Organization-level access {#access-organization}

With organization-level access permissions, organization employees can manage any {{ yandex-cloud }} resources activated for the organization as per the granted role.

To grant a group access to resources at the organization level, use the {{ yandex-cloud }} CLI:

1. {% include [cli-install](../_includes/cli-install.md) %}

1. Assign a [role](../iam/concepts/access-control/roles.md) for the group:

   ```bash
   yc organization-manager organization add-access-binding \
   --subject=group:<group-id> \
   --role=<role-id> \
   <organization-id>
   ```

1. Make sure the requested rights are granted:

   ```bash
   yc organization-manager organization list-access-bindings <organization ID>
   ```

   A response contains a list of all roles assigned to users and groups in the organization:

   ```
   +------------------------------------------+--------------+----------------------+
   |                 ROLE ID                  | SUBJECT TYPE |      SUBJECT ID      |
   +------------------------------------------+--------------+----------------------+
   | organization-manager.admin               | userAccount  | ajev1p2345lj67u89adi |
   | organization-manager.organizations.owner | userAccount  | ajev1p2345lj67u89adi |
   | editor                                   | group        | ajeq123cmuotesu4e567 |
   | viewer                                   | group        | ajeq123cmuotesu4e567 |
   +------------------------------------------+--------------+----------------------+
   ```
