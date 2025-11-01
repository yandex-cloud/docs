# Access management in {{ org-full-name }}

Access management in {{ yandex-cloud }} leverages the [Role Based Access Control](https://en.wikipedia.org/wiki/Role-based_access_control) (RBAC) policy. To grant a user certain privileges or access to a resource, you must assign the user the appropriate roles.

Each role consists of a set of permissions that describe operations that can be performed with the resource. A user can assign a role with only those permissions which are available to themselves. For example, only a user with the organization [owner](#organization-manager-organizations-owner) role can assign this role: the administrator role is not sufficient to do this.

If a resource has child resources, all permissions from the parent resource will be inherited by the child resources. For example, if you assign the administrator role for the organization hosting the cloud, all the role's permissions will apply to the cloud and all its nested resources.

For more information on access management in {{ yandex-cloud }}, see the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/index.md).

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can assign a role for individual resources within the service using the [{{ cloud-center }} interface]({{ cloud-center-link }}), {{ yandex-cloud }} [CLI](../../cli/cli-ref/organization-manager/cli-ref/index.md), [API](../api-ref/authentication.md), or [{{ TF }}]({{ tf-provider-link }}):

{% include notitle [organization-resources](../../_includes/iam/resources-with-access-control/organization.md) %}

## What roles exist in this service {#roles-list}

### Service roles {#service-roles}

#### organization-manager.auditor {#organization-manager-auditor}

{% include [organizationmanager-auditor](../../_roles/organization-manager/auditor.md) %}

#### organization-manager.viewer {#organization-manager-viewer}

{% include [organizationmanager-viewer](../../_roles/organization-manager/viewer.md) %}

#### organization-manager.editor {#organization-manager-editor}

{% include [organizationmanager-editor](../../_roles/organization-manager/editor.md) %}

#### organization-manager.admin {#organization-manager-admin}

{% include [organizationmanager-admin](../../_roles/organization-manager/admin.md) %}

#### organization-manager.organizations.owner {#organization-manager-organizations-owner}

{% include [organizationmanager-organizations-owner](../../_roles/organization-manager/organizations/owner.md) %}

#### organization-manager.federations.extGroupsViewer {#organization-manager-federations-extGroupsViewer}

{% include [organization-manager.federations.extGroupsViewer](../../_roles/organization-manager/federations/extGroupsViewer.md) %}

#### organization-manager.federations.extGroupsManager {#organization-manager-federations-extGroupsManager}

{% include [organization-manager.federations.extGroupsManager](../../_roles/organization-manager/federations/extGroupsManager.md) %}

#### organization-manager.federations.extGroupsCleaner {#organization-manager-federations-extGroupsCleaner}

{% include [organization-manager.federations.extGroupsCleaner](../../_roles/organization-manager/federations/extGroupsCleaner.md) %}

#### organization-manager.federations.auditor {#organization-manager-federations-auditor}

{% include [organization-manager.federations.auditor](../../_roles/organization-manager/federations/auditor.md) %}

#### organization-manager.federations.viewer {#organization-manager-federations-viewer}

{% include [organization-manager.federations.viewer](../../_roles/organization-manager/federations/viewer.md) %}

#### organization-manager.federations.editor {#organization-manager-federations-editor}

{% include [organization-manager.federations.editor](../../_roles/organization-manager/federations/editor.md) %}

#### organization-manager.federations.userAdmin {#organization-manager-federations-userAdmin}

{% include [organization-manager.federations.userAdmin](../../_roles/organization-manager/federations/userAdmin.md) %}

#### organization-manager.federations.admin {#organization-manager-federations-admin}

{% include [organization-manager.federations.admin](../../_roles/organization-manager/federations/admin.md) %}

#### organization-manager.osLogins.viewer {#organization-manager-osLogins-viewer}

{% include [organizationmanager-oslogins-viewer](../../_roles/organization-manager/osLogins/viewer.md) %}

#### organization-manager.osLogins.admin {#organization-manager-osLogins-admin}

{% include [organizationmanager-oslogins-admin](../../_roles/organization-manager/osLogins/admin.md) %}

#### organization-manager.groups.externalCreator {#organization-manager-groups-externalCreator}

{% include [organization-manager-groups-externalCreator](../../_roles/organization-manager/groups/externalCreator.md) %}

#### organization-manager.groups.externalConverter {#organization-manager-groups-externalConverter}

{% include [organization-manager-groups-externalConverter](../../_roles/organization-manager/groups/externalConverter.md) %}

#### organization-manager.groups.externalManager {#organization-manager-groups-externalManager}

{% include [organization-manager.groups.externalManager](../../_roles/organization-manager/groups/externalManager.md) %}

#### organization-manager.groups.editor {#organization-manager-groups-editor}

{% include [organization-manager-groups-editor](../../_roles/organization-manager/groups/editor.md) %}

#### organization-manager.groups.memberAdmin {#organization-manager-groups-memberAdmin}

{% include [organizationmanager-groups-memberAdmin](../../_roles/organization-manager/groups/memberAdmin.md) %}

#### organization-manager.groups.admin {#organization-manager-groups-admin}

{% include [organization-manager-groups-admin](../../_roles/organization-manager/groups/admin.md) %}

#### organization-manager.users.viewer {#organization-manager-users-viewer}

{% include [organizationmanager-users-viewer](../../_roles/organization-manager/users/viewer.md) %}

#### organization-manager.passportUserAdmin {#organization-manager-passportUserAdmin}

{% include [organizationmanager-passportUserAdmin](../../_roles/organization-manager/passportUserAdmin.md) %}

#### organization-manager.oauthApplications.auditor {#organization-manager-oauthApplications-auditor}

{% include [organizationmanager-oauthApplications-auditor](../../_roles/organization-manager/oauthApplications/auditor.md) %}

#### organization-manager.oauthApplications.viewer {#organization-manager-oauthApplications-viewer}

{% include [organizationmanager-oauthApplications-viewer](../../_roles/organization-manager/oauthApplications/viewer.md) %}

#### organization-manager.oauthApplications.editor {#organization-manager-oauthApplications-editor}

{% include [organizationmanager-oauthApplications-editor](../../_roles/organization-manager/oauthApplications/editor.md) %}

#### organization-manager.oauthApplications.userAdmin {#organization-manager-oauthApplications-userAdmin}

{% include [organizationmanager-oauthApplications-userAdmin](../../_roles/organization-manager/oauthApplications/userAdmin.md) %}

#### organization-manager.oauthApplications.admin {#organization-manager-oauthApplications-admin}

{% include [organizationmanager-oauthApplications-admin](../../_roles/organization-manager/oauthApplications/admin.md) %}

#### organization-manager.samlApplications.auditor {#organization-manager-samlApplications-auditor}

{% include [organizationmanager-samlApplications-auditor](../../_roles/organization-manager/samlApplications/auditor.md) %}

#### organization-manager.samlApplications.viewer {#organization-manager-samlApplications-viewer}

{% include [organizationmanager-samlApplications-viewer](../../_roles/organization-manager/samlApplications/viewer.md) %}

#### organization-manager.samlApplications.editor {#organization-manager-samlApplications-editor}

{% include [organizationmanager-samlApplications-editor](../../_roles/organization-manager/samlApplications/editor.md) %}

#### organization-manager.samlApplications.userAdmin {#organization-manager-samlApplications-userAdmin}

{% include [organizationmanager-samlApplications-userAdmin](../../_roles/organization-manager/samlApplications/userAdmin.md) %}

#### organization-manager.samlApplications.admin {#organization-manager-samlApplications-admin}

{% include [organizationmanager-samlApplications-admin](../../_roles/organization-manager/samlApplications/admin.md) %}

#### organization-manager.userpools.extGroupsViewer {#organization-manager-userpools-extGroupsViewer}

{% include [organization-manager.userpools.extGroupsViewer](../../_roles/organization-manager/userpools/extGroupsViewer.md) %}

#### organization-manager.userpools.extGroupsManager {#organization-manager-userpools-extGroupsManager}

{% include [organization-manager.userpools.extGroupsManager](../../_roles/organization-manager/userpools/extGroupsManager.md) %}

#### organization-manager.userpools.extGroupsCleaner {#organization-manager-userpools-extGroupsCleaner}

{% include [organization-manager.userpools.extGroupsCleaner](../../_roles/organization-manager/userpools/extGroupsCleaner.md) %}

#### organization-manager.userpools.syncAgent {#organization-manager-userpools-syncAgent}

{% include [organizationmanager-userpools-syncAgent](../../_roles/organization-manager/userpools/syncAgent.md) %}

#### organization-manager.userpools.auditor {#organization-manager-userpools-auditor}

{% include [organizationmanager-userpools-auditor](../../_roles/organization-manager/userpools/auditor.md) %}

#### organization-manager.userpools.viewer {#organization-manager-userpools-viewer}

{% include [organizationmanager-userpools-viewer](../../_roles/organization-manager/userpools/viewer.md) %}

#### organization-manager.userpools.editor {#organization-manager-userpools-editor}

{% include [organizationmanager-userpools-editor](../../_roles/organization-manager/userpools/editor.md) %}

#### organization-manager.userpools.userAdmin {#organization-manager-userpools-userAdmin}

{% include [organizationmanager-userpools-userAdmin](../../_roles/organization-manager/userpools/userAdmin.md) %}

#### organization-manager.userpools.admin {#organization-manager-userpools-admin}

{% include [organizationmanager-userpools-admin](../../_roles/organization-manager/userpools/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

### Assigning a user as an organization administrator {#add-admin}

To grant a user permissions to manage an organization, [assign](#add-role) them the `organization-manager.admin` role.

### Assigning a role to a user {#add-role}

Organization administrators and owners can assign roles in {{ org-full-name }}. You can assign to users not just organization management roles but also roles for access to your organization's connected cloud resources.

For information about roles available in {{ yandex-cloud }} and their associated permissions, see the {{ iam-full-name }} documentation in the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md).

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [assign-role-to-user](../../_includes/organization/assign-role-to-user.md) %}

- CLI {#cli}

  1. Select the role you want to assign. You can find the description of the roles in the {{ iam-full-name }} documentation in the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md).

  1. [Get the user ID](../operations/users-get.md).

  1. To assign the role, run the following command:

      ```bash
      yc <service_name> <resource> add-access-binding <resource_name_or_ID> \
          --role <role_ID> \
          --subject <subject_type>:<subject_ID>
      ```

      * `<service_name>`: Name of the service for whose resource you are assigning the role, e.g., `organization-manager`.
      * `<resource>`: Resource category. For an organization, it is always `organization`.
      * `<resource_name_or_ID>`: Resource name or ID. For an organization, use its [technical name](../operations/org-profile.md).
      * `--role`: Role ID, e.g., `organization-manager.admin`.
      * `--subject`: Type and ID of the [subject](../../iam/concepts/access-control/index.md#subject) you are assigning the role to.

      For example, this command assigns the administrator role for the organization with the `bpf3crucp1v2********` ID:

      ```bash
      yc organization-manager organization add-access-binding bpf3crucp1v2******** \
          --role organization-manager.admin \
          --subject userAccount:aje6o61dvog2********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Describe the parameters of the roles you assign in the configuration file:

     * `organization_id`: [Organization ID](../operations/organization-get-id.md).
     * `role`: Role you want to assign. You can find the description of the roles in the {{ iam-full-name }} documentation in the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md). For each role, you can only use one `yandex_organization manager_organization_iam_binding` resource.
     * `members`: Array of the IDs of users to assign the role to:
       * `userAccount:{user_id}`: User Yandex account ID.
       * `serviceAccount:{service_account_id}`: Service account ID.
       * `federatedUser:{federated_user_id}`: Federated user ID.

     Here is an example of the configuration file structure:

     ```
     resource "yandex_organizationmanager_organization_iam_binding" "editor" {
       organization_id = "<organization_ID>"
       role = "editor"
       members = [
        "federatedUser:<user_ID>",
       ]
     }
     ```

     For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-link }}/).

  1. Make sure the configuration files are correct.
    
     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:
 
       ```
       terraform plan
       ```

      If the configuration is described correctly, the terminal will display a list of the assigned roles. If the configuration contains any errors, {{ TF }} will show them. 
 
  1. Assign roles.
  
     If the configuration does not contain any errors, run this command:

       ```
       terraform apply
       ```
     This assigns the roles in the specified organization.

- API {#api}

  Use the `updateAccessBindings` method for the appropriate resource.

  1. Select the role you want to assign. You can find the description of the roles in the {{ iam-full-name }} documentation in the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md).

  1. [Get the user ID](../operations/users-get.md).

  1. Create the request body, e.g., in the `body.json` file. In the `action` property, enter `ADD` and specify the `userAccount` type and user ID under `subject`.

      Example of the `body.json` file:

      ```json
      {
        "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
            "roleId": "organization-manager.admin",
            "subject": {
              "id": "gfei8n54hmfh********",
              "type": "userAccount"
            }
          }
        }]
      }
      ```

  1. Assign the role. For example, for an organization with the `bpf3crucp1v2********` ID:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v2********
      export IAM_TOKEN=CggaAT********
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

     For detailed instructions on assigning a role to a resource, please see the {{ iam-full-name }} and {{ resmgr-full-name }} documentation:
     * [{#T}](../../iam/operations/sa/set-access-bindings.md)
     * [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
     * [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)

{% endlist %}

In a similar way, you can [assign roles](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) for an organization to a service account.

### Revoking a user's role {#revoke}

If you want to deny a user access to a resource, revoke the relevant roles for this resource as well as for other resources access permissions can be inherited from. For more information on access management in {{ yandex-cloud }}, see the [{{ iam-full-name }}](../../iam/concepts/access-control/index.md) documentation.

The role can be revoked by a user with the `organization-manager.admin` or `organization-manager.organizations.owner` role. To learn how to grant a role to a user, see the [Roles](#add-role) section.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [revoke-role-from-user](../../_includes/organization/revoke-role-from-user.md) %}

- CLI {#cli}

  To revoke a role from a subject, delete access permissions for the appropriate resource:

  1. View the roles and assignees for the resource:

      ```bash
      yc <service_name> <resource> list-access-bindings <resource_name_or_ID>
      ```

      * `<service_name>`: Name of the service the resource belongs to, e.g., `organization-manager`.
      * `<resource>`: Resource category. For an organization, it is always `organization`.
      * `<resource_name_or_ID>`: Resource name or ID. For an organization, use its [technical name](../operations/org-profile.md).

      For example, view the roles and assignees in an organization with the `bpf3crucp1v2********` ID:

      ```bash
      yc organization-manager organization list-access-bindings bpf3crucp1v2********
      ```

      Result:

      ```bash
      +------------------------------------------+--------------+----------------------+
      |                 ROLE ID                  | SUBJECT TYPE |      SUBJECT ID      |
      +------------------------------------------+--------------+----------------------+
      | organization-manager.organizations.owner | userAccount  | aje3r40rsemj******** |
      | organization-manager.admin               | userAccount  | aje6o61dvog2******** |
      +------------------------------------------+--------------+----------------------+
      ```

  1. To delete access permissions, run this command:

      ```bash
      yc <service_name> <resource> remove-access-binding <resource_name_or_ID> \
          --role <role_ID> \
          --subject <subject_type>:<subject_ID>
      ```

      * `--role`: ID of the role to revoke, e.g., `organization-manager.admin`.
      * `--subject`: Type and ID of the [subject](../../iam/concepts/access-control/index.md#subject) to revoke the role from.

      For example, to revoke a role from a user with the `aje6o61dvog2********` ID:

      ```bash
      yc organization-manager organization remove-access-binding bpf3crucp1v2******** \
          --role organization-manager.admin \
          --subject userAccount:aje6o61dvog2********
      ```

- API {#api}

  To revoke a role from a subject, delete access permissions for the appropriate resource:

  1. View the roles and assignees for the resource using the `listAccessBindings` method. For example, to view the roles in the organization with the `bpf3crucp1v2********` ID:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v2********
      export IAM_TOKEN=CggaAT********
      curl \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:listAccessBindings"
      ```

      Result:

      ```bash
      {
      "accessBindings": [
      {
        "subject": {
        "id": "aje6o61dvog2********",
        "type": "userAccount"
        },
        "roleId": "organization-manager.admin"
      }
      ]
      }
      ```

  1. Create the request body, e.g., in the `body.json` file. In the request body, specify the access permissions to delete. For example, revoke the `organization-manager.admin` role from the `aje6o61dvog2********` user:

      Example of the `body.json` file:

      ```json
      {
        "accessBindingDeltas": [{
          "action": "REMOVE",
          "accessBinding": {
            "roleId": "organization-manager.admin",
            "subject": {
              "id": "aje6o61dvog2********",
              "type": "userAccount"
            }
          }
        }]
      }
      ```

  1. Revoke a role by deleting the specified permissions:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v2********
      export IAM_TOKEN=CggaAT********
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

{% endlist %}

### Assigning a role to a user group {#access-group-users}

Assign a role to a [user group](../../organization/operations/manage-groups.md) to grant access to a resource. To grant group access permissions to a [subject](../../iam/concepts/access-control/index.md#subject), see [{#T}](../../iam/operations/groups/access-binding-object.md).

In {{ org-full-name }}, you can assign a group a role for an organization, cloud, folder, another group, or service account.

#### Assigning a role for a cloud or folder {#access-binding-cloud}

{% include [accessbinding-group-as-object](../../_includes/organization/accessbinding-group-as-subject.md) %}

#### Assigning a role for an organization {#access-binding-organization}

{% include [accessbinding-group-as-subject-org](../../_includes/organization/accessbinding-group-as-subject-org.md) %}


## What roles are assigned in an organization {#list-access-bingings}

{% include [org-list-access-bingings](../../_includes/organization/org-list-access-bingings.md) %}
