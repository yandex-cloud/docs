# Assigning a role to a user

[Organization administrators and owners](add-org-admin.md) can assign roles in {{ org-full-name }}. You can assign to users not just organization management roles but also roles for access to your organization's connected cloud resources.

For information on roles available in {{ yandex-cloud }} and their associated permissions, please review the {{ iam-full-name }} documentation, [{#T}](../../iam/roles-reference.md).

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [assign-role-to-user](../../_includes/organization/assign-role-to-user.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Select the [role](../../iam/concepts/access-control/roles.md) you want to assign.
  1. [Get](users-get.md) the user ID.
  1. Assign a role using this command:

      ```bash
      yc organization-manager organization add-access-binding <organization_name_or_ID> \
        --role <role_ID> \
        --user-account-id <user_ID>
      ```

      Where:

      * `--role`: Role ID.
      * `--user-account-id`: User ID. You can also use the `--user-yandex-login` parameter and specify the username instead of the ID.

      For example, assign a user the administrator role for an organization with the `b1gmit33ngp3********` ID:

      ```bash
      yc organization-manager organization add-access-binding b1gmit33ngp3******** \
        --role resource-manager.admin \
        --user-account-id aje6o61dvog2********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Select the [role](../../iam/concepts/access-control/roles.md) you want to assign.
  1. [Get](users-get.md) the user ID.
  1. Describe the roles you are assigning in the configuration file:

      Example of configuration file structure for assigning a role for an organization:

      ```hcl
      resource "yandex_organizationmanager_organization_iam_binding" "editor" {
        organization_id = "<organization_ID>"
        role            = "<role_ID>"
        member          = "userAccount:<user_ID>"
      }
      ```

      Where:

      * `organization_id`: [Organization ID](./organization-get-id.md).
      * `role`: Role you want to assign. For each role, you can only use one `yandex_organizationmanager_organization_iam_binding` resource.
      * `member`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      For more on the properties of the `yandex_organizationmanager_organization_iam_binding` resource, see [this provider guide]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_binding).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  The specified user will then get roles in the organization. You can check the role assignment using the [{{ cloud-center }} UI]({{ link-org-cloud-center }}).

- API {#api}

  To assign the user a role for the organization, use the [updateAccessBindings](../api-ref/Organization/updateAccessBindings.md) REST API method for the [Organization](../api-ref/Organization/index.md) resource or the [OrganizationService/UpdateAccessBindings](../api-ref/grpc/Organization/updateAccessBindings.md) gRPC API call.

  1. Select the [role](../../iam/concepts/access-control/roles.md) you want to assign.
  1. [Get](users-get.md) the user ID.
  1. Create the request body, e.g., in the `body.json` file. In the `action` property, enter `ADD` and specify the `userAccount` or `federatedUser` type and user ID under `subject`.

      **body.json:**

      ```json
      {
        "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
            "roleId": "<role_ID>",
            "subject": {
              "id": "<user_ID>",
              "type": "userAccount"
            }
          }
        }]
      }
      ```

      Where:

      * `ADD` in the `accessBindingDeltas[].action` parameter indicates you need to add a role.
      * `accessBindingDeltas[].accessBinding.roleId`: ID of the role you need to assign.
      * `accessBindingDeltas[].accessBinding.subject.id`: ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.
      * `accessBindingDeltas[].accessBinding.subject.type`: Type of subject the role is assigned to.

          {% cut "Subject designations" %}

          {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

          {% endcut %}

  1. Assign the role. For example, for an organization with the `bpf3crucp1v2********` ID:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v2********
      export IAM_TOKEN=<IAM_token>
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

{% endlist %}

In a similar way, you can [assign roles](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) for an organization to a service account.

#### Useful links {#see-also}

* [{#T}](../../iam/operations/sa/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)
