# Access management in {{ org-full-name }}

Access management in {{ yandex-cloud }} leverages the [Role Based Access Control](https://en.wikipedia.org/wiki/Role-based_access_control) (RBAC) policy. To grant a user certain privileges or access to a resource, you must assign the user the appropriate roles.

Each role consists of a set of permissions that describe operations that can be performed with the resource. A user can assign a role with only those permissions which are available to themselves. For example, only a user with the organization [owner](#admin) role can assign this role: the administrator role is not sufficient to do this.

If a resource has child resources, all permissions from the parent resource will be inherited by the child resources. For example, if you assign the administrator role for the organization hosting the cloud, all the role's permissions will apply to the cloud and all its nested resources.

For more information on access management in {{ yandex-cloud }}, see the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/index.md).

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can assign a role via the [{{ cloud-center }} interface]({{ cloud-center-link }}), [YC CLI](../../cli/quickstart.md) or [API {{ yandex-cloud }}](../../api-design-guide/index.yaml) for individual resources within the service:

{% include notitle [organization-resources](../../_includes/iam/resources-with-access-control/organization.md) %}

## Which roles exist in the service {#roles-list}

### Service roles {#service-roles}

#### organization-manager.viewer {#organization-manager-viewer}

{% include [organizationmanager-viewer](../../_roles/organization-manager/viewer.md) %}

#### organization-manager.admin {#organization-manager-admin}

{% include [organizationmanager-admin](../../_roles/organization-manager/admin.md) %}

#### organization-manager.organizations.owner {#organization-manager-organizations-owner}

{% include [organizationmanager-organizations-owner](../../_roles/organization-manager/organizations/owner.md) %}

#### organization-manager.federations.viewer {#organization-manager-federations-viewer}

{% include [organization-manager.federations.viewer](../../_roles/organization-manager/federations/viewer.md) %}

#### organization-manager.federations.userAdmin {#organization-manager-federations-userAdmin}

{% include [organization-manager.federations.userAdmin](../../_roles/organization-manager/federations/userAdmin.md) %}

#### organization-manager.federations.admin {#organization-manager-federations-admin}

{% include [organization-manager.federations.admin](../../_roles/organization-manager/federations/admin.md) %}

#### organization-manager.osLogins.viewer {#organization-manager-osLogins-viewer}

{% include [organizationmanager-oslogins-viewer](../../_roles/organization-manager/osLogins/viewer.md) %}

#### organization-manager.osLogins.admin {#organization-manager-osLogins-admin}

{% include [organizationmanager-oslogins-admin](../../_roles/organization-manager/osLogins/admin.md) %}

#### organization-manager.groups.memberAdmin {#organization-manager-groups-memberAdmin}

{% include [organizationmanager-groups-memberAdmin](../../_roles/organization-manager/groups/memberAdmin.md) %}

#### organization-manager.users.viewer {#organization-manager-users-viewer}

{% include [organizationmanager-users-viewer](../../_roles/organization-manager/users/viewer.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

### Appointing a user the organization administrator {#admin}

To grant a user organization management access, [assign](#add-role) the user one of the following roles:

* `organization-manager.admin`
* `organization-manager.organizations.owner`

### Assigning a role to a user {#add-role}

Organization administrators and owners can assign roles in {{ org-full-name }}. You can assign to users not just organization management roles but also roles for access to your organization's connected cloud resources.

For information about roles available in {{ yandex-cloud }} and their associated permissions, see the {{ iam-full-name }} documentation in the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md).

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  {% include [assign-role-to-user](../../_includes/organization/assign-role-to-user.md) %}

- CLI {#cli}

  1. Select the role you want to assign. You can find the description of the roles in the {{ iam-full-name }} documentation in the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md).

  1. [Get the user ID](../operations/users-get.md).

  1. Assign the role using the command:

      ```bash
      yc <service_name> <resource> add-access-binding <resource_name_or_ID> \
          --role <role_ID> \
          --subject <subject_type>:<subject_ID>
      ```
      * `<service_name>`: Name of the service for whose resource you are assigning the role, e.g., `organization-manager`.
      * `<resource>`: Resource category. For an organization, it is always `organization`.
      * `<resource_name_or_ID>`: Resource name or ID. For an organization, use its [technical name](../operations/org-profile.md).
      * `--role`: Role ID, e.g., `organization-manager.admin`.
      * `--subject`: Type and ID of the [subject](../../iam/concepts/access-control/index.md#subject) getting the role.

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
       * `userAccount:{user_id}`: ID of the user Yandex account.
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

     For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

  1. Make sure the configuration files are correct.
    
     1. In the command line, go to the folder where you created the configuration file.
     1. Run a check using this command:
 
       ```
       terraform plan
       ```

      If the configuration is described correctly, the terminal will display a list of the assigned roles. If the configuration contains any errors, {{ TF }} will point them out. 
 
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

If you want to deny a user access to a resource, revoke the relevant roles for this resource and for resources that grant inherited access rights. For more information on access management in {{ yandex-cloud }}, see the [{{ iam-full-name }}](../../iam/concepts/access-control/index.md) documentation.

The role can be revoked by a user with the `organization-manager.admin` or `organization-manager.organizations.owner` role. To learn how to grant roles to a user, see [Roles](#admin).

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

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
