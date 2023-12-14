# Access management in {{ org-full-name }}

Access management in {{ yandex-cloud }} leverages the [Role Based Access Control](https://en.wikipedia.org/wiki/Role-based_access_control) (RBAC) policy. To grant a user certain privileges or access to a resource, you must assign the user the appropriate roles.

Each role consists of a set of permissions that describe operations that can be performed with the resource. A user can assign a role with only those permissions which are available to themselves. For example, only a user with the organization [owner](#admin) role can assign this role: the administrator role is not sufficient to do this.

If a resource has child resources, all permissions from the parent resource will be inherited by the child resources. For instance, if you assign a user the administrator role for the organization hosting the cloud, all the role's permissions will apply to the cloud and all the cloud's nested resources.

For more information about access control in {{ yandex-cloud }}, see the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/index.md).

## Which roles exist in the service {#roles-list}

### Service roles {#service-roles}

* `organization-manager.admin`: Organization administrator role.

   The role allows you to edit organization settings, create identity federations, add and remove users, and assign other administrators.

* `organization-manager.organizations.owner`: The organization owner role.

   The role allows you to appoint organization owners as well as use all the administrator privileges.

   By default, the user who creates an organization is the organization owner.

* `organization-manager.viewer`: This role allows you to view an organization's settings without editing them.

* `organization-manager.groups.memberAdmin`: This role allows you to view information about a group and add and remove group members.

* `organization-manager.osLogins.admin`: This role allows you to edit OS Login profiles, SSH keys, and create certificates for the organization users.

* `organization-manager.osLogins.viewer`: This role allows you to view OS Login profiles and SSH keys of the organization users.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

### Appointing a user the organization administrator {#admin}

To grant a user organization management access, [assign](#add-role) the user one of the following roles:

* `organization-manager.admin`.
* `organization-manager.organizations.owner`.

### Assigning a role to a user {#add-role}

An organization's administrators and owners can assign roles in {{ org-full-name }}. You can assign users both roles for managing an organization and roles for your organization's connected cloud resources.

For information about roles available in {{ yandex-cloud }} and their associated permissions, see the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md).

{% list tabs %}

- {{ org-name }}

   1. [Log in]({{ link-passport }}) as the organization administrator or owner.

   1. Go to [{{ org-full-name }}]({{ link-org-main }}).

   1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.acl }}]({{ link-org-acl }}) ![icon-acl](../../_assets/console-icons/shield.svg).

   1. If the respective user has at least one role, select it from the list or use the search bar at the top of the page. In the line with the user name, click ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

      If the user is not on the list, click **{{ ui-key.yacloud_org.entity.user.action.acl }}** in the top-right corner. In the window that opens, click **{{ ui-key.yacloud.component.acl.update-dialog.button_select-subject }}** and select the appropriate user from the list or use the search bar.

   1. Click **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** and enter the role name or select one from the list.

      You can find a description of the available roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md).

   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

   1. Select the role you wish to assign. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md).

   1. [Get the user ID](../operations/users-get.md).

   1. Assign the role using the command:

      ```bash
      yc <SERVICE-NAME> <RESOURCE> add-access-binding <RESOURCE-NAME>|<RESOURCE-ID> \
          --role <ROLE-ID> \
          --subject userAccount:<USER-ACCOUNT-ID>
      ```
      * `<SERVICE-NAME>`: Name of the service to whose resource a role, e.g., `organization-manager`, is assigned.
      * `<RESOURCE>`: Resource category. For an organization, `organization` is the category of importance.
      * `<RESOURCE-NAME>`: Resource name. Refer to an organization by its [technical name](../operations/org-profile.md).
      * `<RESOURCE-ID>`: Resource ID.
      * `<ROLE-ID>`: Role ID, e.g., `organization-manager.admin`.
      * `<USER-ACCOUNT-ID>`: ID of the user account to which the role is assigned.

      For example, assign the administrator role for the organization with the ID `bpf3crucp1v28b74p3rk`:

      ```bash
      yc organization-manager organization add-access-binding bpf3crucp1v28b74p3rk \
          --role organization-manager.admin \
          --subject userAccount:aje6o61dvog2h6g9a33s
      ```
- API

   Use the `updateAccessBindings` method for the corresponding resource.

   1. Select the role you wish to assign. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md).

   1. [Get the user ID](../operations/users-get.md).

   1. Create a request body, for example, in a `body.json` file. Set the `action` property to `ADD` and specify the `userAccount` type and user ID in the `subject` property:

      Example `body.json` file:

      ```json
      {
        "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
            "roleId": "organization-manager.admin",
            "subject": {
              "id": "gfei8n54hmfhuk5nogse",
              "type": "userAccount"
            }
          }
        }]
      }
      ```

  1. Assign the role. For example, for an organization with the `bpf3crucp1v28b74p3rk` ID:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v28b74p3rk
      export IAM_TOKEN=CggaATEVAgA...
      curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \	"https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

     For detailed instructions on assigning a role to a resource, please see the {{ iam-full-name }} and {{ resmgr-full-name }} documentation:
     * [{#T}](../../iam/operations/sa/set-access-bindings.md)
     * [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
     * [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)

- {{ TF }}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. Describe the properties of the roles to be assigned in the configuration file:

      * `organization_id`: Organization ID.
      * `role`: Role to assign. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md). For each role, you can only use one `yandex_organization manager_organization_iam_binding`.
      * `members`: An array of the IDs of users to assign the role to:
         * `userAccount:{user_id}`: User's Yandex account ID.
         * `serviceAccount:{service_account_id}`: Service account ID.
         * `federatedUser:{federated_user_id}`: Federated user ID.

      Here is an example of the configuration file structure:

      ```
      resource "yandex_organizationmanager_organization_iam_binding" "editor" {
        organization_id = "<organization ID>"
        role = "editor"
        members = [
         "federatedUser:<user ID>",
        ]
      }
      ```

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      2. Run a check using this command:

        ```
        terraform plan
        ```

      If the configuration is described correctly, the terminal displays a list of the roles assigned. If the configuration contains any errors, {{ TF }} will point them out.

   1. Assign roles.

      If the configuration does not contain any errors, run this command:

        ```
        terraform apply
        ```
      This assigns the roles in the specified organization.

{% endlist %}

In a similar way, you can [assign roles](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) for an organization to a service account.

### Revoking a user's role {#revoke}

If you wish to deny a user access to a resource, revoke the relevant roles for this resource and for resources that grant inherited access rights. For more information on access control in {{ yandex-cloud }}, please see the [{{ iam-full-name }}](../../iam/concepts/access-control/index.md) documentation.

The role can be revoked by a user with the `organization-manager.admin` or `organization-manager.organizations.owner` role. To learn how to grant roles to a user, see [Roles](#admin).

{% list tabs %}

- {{ org-name }}

   1. [Log in]({{ link-passport }}) as the organization administrator or owner.

   1. Go to [{{ org-full-name }}]({{ link-org-main }}).

   1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.acl }}]({{ link-org-acl }}) ![icon-users](../../_assets/console-icons/person.svg).

   1. Select a user from the list or use the search bar at the top of the page.

   1. In the right-hand column, click ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

   1. Click ![cross](../../_assets/console-icons/xmark.svg) next to a role to delete it.

   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

   To revoke a role from a subject, delete the corresponding access binding for the appropriate resource:

   1. View roles and their assignees:

      ```bash
      yc <SERVICE-NAME> <RESOURCE> list-access-bindings <RESOURCE-NAME>|<RESOURCE-ID>
      ```

      * `<SERVICE-NAME>`: Name of the service the resource belongs to, e.g., `organization-manager`.
      * `<RESOURCE>`: Resource category. For an organization, `organization` is the category of importance.
      * `<RESOURCE-NAME>`: Name of the resource. Refer to an organization by its [technical name](../operations/org-profile.md).
      * `<RESOURCE-ID>`: Resource ID.

      For example, see to whom and which roles the organization with the ID `bpf3crucp1v28b74p3rk` has been assigned:

      ```bash
      yc organization-manager organization list-access-bindings bpf3crucp1v28b74p3rk
      ```

      Result:

      ```bash
      +------------------------------------------+--------------+----------------------+
      |                 ROLE ID                  | SUBJECT TYPE |      SUBJECT ID      |
      +------------------------------------------+--------------+----------------------+
      | organization-manager.organizations.owner | userAccount  | aje3r40rsemj2f5b5jkk |
      | organization-manager.admin               | userAccount  | aje6o61dvog2h6g9a33s |
      +------------------------------------------+--------------+----------------------+
      ```


1. To delete an access binding, run:

   ```bash
   yc <SERVICE-NAME> <RESOURCE> remove-access-binding <RESOURCE-NAME>|<RESOURCE-ID> \
       --role <ROLE-ID> \
       --subject <SUBJECT-TYPE>:<SUBJECT-ID>
   ```

   * `<ROLE-ID>` is the ID of the role to revoke, such as `organization-manager.admin`.
   * `<SUBJECT-TYPE>` is the [subject](../../iam/concepts/access-control/index.md#subject) type to revoke a role from.
   * `<SUBJECT-ID>` is the subject ID.

   For example, to take a role away from a user with the ID `aje6o61dvog2h6g9a33s`:

   ```bash
   yc organization-manager organization remove-access-binding bpf3crucp1v28b74p3rk \
       --role organization-manager.admin \
       --subject userAccount:aje6o61dvog2h6g9a33s
   ```

- API

   To revoke a resource role from a subject, delete the corresponding access binding:

   1. View what roles were assigned for resources and to whom using the `listAccessBindings` method. For example, to view the roles in an organization with the ID `bpf3crucp1v28b74p3rk`:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v28b74p3rk
      export IAM_TOKEN=CggaATEVAgA...
      curl -H "Authorization: Bearer ${IAM_TOKEN}" "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:listAccessBindings"
      ```

      Result:

      ```bash
      {
      "accessBindings": [
      {
        "subject": {
        "id": "aje6o61dvog2h6g9a33s",
        "type": "userAccount"
        },
        "roleId": "organization-manager.admin"
      }
      ]
      }
      ```

  1. Create a request body, for example, in a `body.json` file. In the request body, specify which access binding to delete. The example below shows how to revoke the `organization-manager.admin` role from user `aje6o61dvog2h6g9a33s`.

   Example of `body.json` file:

   ```json
   {
     "accessBindingDeltas": [{
       "action": "REMOVE",
       "accessBinding": {
         "roleId": "organization-manager.admin",
         "subject": {
           "id": "aje6o61dvog2h6g9a33s",
           "type": "userAccount"
         }
       }
     }]
   }
   ```

1. Revoke the role by deleting the specified access binding:

   ```bash
   export ORGANIZATION_ID=bpf3crucp1v28b74p3rk
   export IAM_TOKEN=CggaATEVAgA...
   curl -X POST \
       -H "Content-Type: application/json" \
       -H "Authorization: Bearer ${IAM_TOKEN}" \
       -d '@body.json' \	"https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
   ```

{% endlist %}

### Assigning a role to a user group {#access-group-users}

Assign a role to a [user group](../../organization/operations/manage-groups.md) to grant access to a resource. To grant group access permissions to a [subject](../../iam/operations/groups/access-binding-object.md), see [{#T}](../../iam/concepts/access-control/index.md#subject).

In the management console, you can assign a group a role for a cloud, folder, or service account. In the {{ org-full-name }} service, a group can only be granted a role for another group. To assign a group a role for an organization, use the CLI.

#### Assigning a role for a cloud or folder {#access-binding-cloud}

{% include [accessbinding-group-as-object](../../_includes/organization/accessbinding-group-as-subject.md) %}

#### Assigning a role for an organization {#access-binding-organization}

{% include [accessbinding-group-as-subject-org](../../_includes/organization/accessbinding-group-as-subject-org.md) %}
