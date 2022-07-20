# Granting permissions

Access management in {{ yandex-cloud }} leverages the [Role Based Access Control](https://en.wikipedia.org/wiki/Role-based_access_control) (RBAC) policy. To grant a user certain privileges or access to a resource, you must assign the user the appropriate roles.

Each role consists of a set of permissions that describe operations that can be performed with the resource. A user can assign a role with only those permissions which are available to themselves. For example, only a user with the organization [owner](#admin) role can assign this role: the administrator role is not sufficient to do this.

If a resource has child resources, all permissions from the parent resource will be inherited by the child resources. For instance, if you assign a user the administrator role for the organization hosting the cloud, all the role's permissions will apply to the cloud and all the cloud's nested resources.

For more information about access control in {{ yandex-cloud }}, see the {{ iam-full-name }} documentation, [{#T}](../iam/concepts/access-control/index.md).

## Service roles {#service-roles}

* `organization-manager.admin`: The organization administrator role.

   The role is able to edit organization settings, create identity federations, add and remove users, create other administrators, and manage the resources of an organization's clouds.

* `organization-manager.organizations.owner`: The organization owner role.

   The role is able to appoint organization owners as well as use all the administrator privileges.

   By default, the user who creates an organization is the organization owner.

* `organization-manager.viewer`: This role is able to view, but not edit, an organization's settings.

### Appointing a user the organization administrator {#admin}

To grant a user organization management access, [assign](#add-role) the user one of the following roles:

* `organization-manager.admin`;
* `organization-manager.organizations.owner`.

### Assigning a role to a user {#add-role}

An organization's administrators and owners can assign roles in {{ org-full-name }}. You can assign users both roles for managing an organization and roles for your organization's connected cloud resources.

For information about roles available in {{ yandex-cloud }} and their associated permissions, see the {{ iam-full-name }} documentation, [{#T}](../iam/concepts/access-control/roles.md).

{% list tabs %}

- {{ org-name }} interface

   1. [Log in]({{link-passport}}) to the organization's administrator account.

   1. Go to [{{org-full-name}}]({{link-org-main}}).

   1. In the left panel, select [Users]({{link-org-users}}) ![icon-users](../_assets/organization/icon-users.png).

   1. Select a user from the list or use the search bar at the top of the page.

   1. In the right-hand column, click ![icon-context-menu](../_assets/organization/icon-context-menu.png) and select **Configure access**.

   1. In the **Configure access rights** window, click **Add role** and enter the name of the role or select from list.

      You can find a description of the available roles in the {{ iam-full-name }} documentation, [{#T}](../iam/concepts/access-control/roles.md).

   1. Click **Save**.

- CLI

   1. Select the role you wish to assign. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../iam/concepts/access-control/roles.md).

   1. [Get the user ID](users-get.md).

   1. Assign the role using the command:

      ```bash
      yc <SERVICE-NAME> <RESOURCE> add-access-binding <RESOURCE-NAME>|<RESOURCE-ID> \
          --role <ROLE-ID> \
          --subject userAccount:<USER-ACCOUNT-ID>
      ```
      * `<SERVICE-NAME>` is the name of the service whose resource the role, such as `organization-manager`, is assigned to.
      * `<RESOURCE>` is the resource category. For an organization, `organization` is the category of importance.
      * `<RESOURCE-NAME>` is the name of the resource. Refer to an organization by its [technical name](#org-profile.md).
      * `<RESOURCE-ID>` is the resource ID.
      * `<ROLE-ID>` is the role ID, such as `organization-manager.admin`.
      * `<USER-ACCOUNT-ID>` is the ID of the user account assigned the role.

      For example, assign the administrator role for the organization with the ID `bpf3crucp1v28b74p3rk`:

      ```bash
      yc organization-manager organization add-access-binding bpf3crucp1v28b74p3rk \
          --role organization-manager.admin \
          --subject userAccount:aje6o61dvog2h6g9a33s
      ```
- API

   Use the `updateAccessBindings` method for the corresponding resource.

   1. Select the role you wish to assign. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../iam/concepts/access-control/roles.md).

   1. [Get the user ID](users-get.md).

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

   1. Assign the role. For example, for an organization with the ID `bpf3crucp1v28b74p3rk`:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v28b74p3rk
      export IAM_TOKEN=CggaATEVAgA...
      curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \	"https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

   For detailed instructions on assigning a role to a resource, please see the {{ iam-full-name }} and {{ resmgr-full-name }} documentation:
   * [{#T}](../iam/operations/sa/set-access-bindings.md)
   * [{#T}](../resource-manager/operations/cloud/set-access-bindings.md)
   * [{#T}](../resource-manager/operations/folder/set-access-bindings.md)

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Describe the properties of the roles to be assigned in the configuration file:

      * `organization_id`: Organization ID.
      * `role`: Role to assign. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../iam/concepts/access-control/roles.md). For each role, you can only use one `yandex_organization manager_organization_iam_binding`.
      * `members`: An array of the IDs of users to assign the role to:
                  * `userAccount:{user_id}`: User's  Yandex account ID.
         * `serviceAccount:{service_account_id}`: Service account ID.
         * `federatedUser:{federated_user_id}`: Federated user ID.

      Example configuration file structure:

      ```
      resource "yandex_organizationmanager_organization_iam_binding" "editor" {
        organization_id = "<organization ID>"
        role = "editor"
        members = [
         "federatedUser:<user ID>",
        ]
      }
      ```

      For more information about resources that you can create with {{ TF }}, please see the [provider documentation]({{ tf-provider-link }}/).

   2. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      2. Run the check using the command:

      ```
      $ terraform plan
      ```

      If the configuration is described correctly, the terminal displays a list of the roles assigned. If there are errors in the configuration, {{ TF }} points them out.

   3. Assign roles.

      If the configuration doesn't contain any errors, run the command:

      ```
      $ terraform apply
      ```
      This assigns the roles in the specified organization.

{% endlist %}

### Revoking a user's role {#revoke}

If you wish to deny a user access to a resource, revoke the relevant roles for this resource and for resources that grant inherited access rights. For more information on access control in {{ yandex-cloud }}, please see the [{{ iam-full-name }}](../iam/concepts/access-control/index.md) documentation.

{% list tabs %}

- {{ org-name }} interface

   1. [Log in]({{link-passport}}) to the organization's administrator account.

   1. Go to [{{org-full-name}}]({{link-org-main}}).

   1. In the left panel, select [Users]({{link-org-users}}) ![icon-users](../_assets/organization/icon-users.png).

   1. Select a user from the list or use the search bar at the top of the page.

   1. In the right-hand column, click ![icon-context-menu](../_assets/organization/icon-context-menu.png) and select **Configure access**.

   1. Click ![cross](../_assets/cross.svg) next to a role to delete it.

   1. Click **Save**.

- CLI

   To revoke a role from a subject, delete the corresponding access binding for the appropriate resource:

   1. View roles and their assignees:

      ```bash
      yc <SERVICE-NAME> <RESOURCE> list-access-bindings <RESOURCE-NAME>|<RESOURCE-ID>
      ```

      * `<SERVICE-NAME>` is the name of the service that the resource belongs to, such as `organization-manager`.
      * `<RESOURCE>` is the resource category. For an organization, `organization` is the category of importance.
      * `<RESOURCE-NAME>` is the name of the resource. Refer to an organization by its [technical name](#org-profile.md).
      * `<RESOURCE-ID>` is the resource ID.

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
   * `<SUBJECT-TYPE>` is the [subject](../iam/concepts/access-control/index.md#subject) type to revoke a role from.
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

   1. Create a request body, for example, in a `body.json` file. In the request body, specify which access binding to delete. For example, revoke the `organization-manager.admin` role from user `aje6o61dvog2h6g9a33s`:

      Example `body.json` file:

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
