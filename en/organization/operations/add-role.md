# Assigning a role to a user

[Organization administrators and owners](add-org-admin.md) can assign roles in {{ org-full-name }}. You can assign to users not just organization management roles but also roles for access to your organization's connected cloud resources.

For information about roles available in {{ yandex-cloud }} and their associated permissions, see the {{ iam-full-name }} documentation, [{#T}](../../iam/roles-reference.md).

{% list tabs group=instructions %}

- {{ org-name }} interface {#cloud-org}

   1. [Log in]({{ link-passport }}) as the organization administrator or owner.

   1. Go to [{{ org-full-name }}]({{ link-org-main }}).

   1. In the left-hand panel, select ![persons-lock](../../_assets/console-icons/persons-lock.svg) [{{ ui-key.yacloud_org.pages.acl }}]({{ link-org-acl }}).

   1. At the top right, click **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

   1. Select a user from the list or use the search bar.

   1. Click **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** and enter the role name or select one from the list. You can choose more than one role.

   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   1. Select the role you want to assign.

   1. [Get the user ID](../operations/users-get.md).

   1. Assign the role using the command:

      ```bash
      yc <service_name> <resource> add-access-binding <resource_name_or_ID> \
        --role <role_ID> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `<service_name>`: Name of the service to whose resource the role is assigned, e.g., `organization-manager`.
      * `<resource>`: Resource category. For an organization, `organization` is the category of importance.
      * `<resource_name_or_ID>`: Name or ID of the resource. Refer to an organization by its [technical name](../operations/org-profile.md).
      * `--role`: Role ID.
      * `--subject`: Type and ID of the [subject](../../iam/concepts/access-control/index.md#subject) getting the role.

      For example, assign to a user the administrator role for a directory with the `b1gmit33ngp3********` ID:

      ```bash
      yc recource-manager folder add-access-binding b1gmit33ngp3******** \
        --role resource-manager.admin \
        --subject userAccount:aje6o61dvog2********
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. Describe the properties of the roles to be assigned in the configuration file:

      ```hcl
      resource "yandex_organizationmanager_organization_iam_binding" "editor" {
        organization_id = "<organization_ID>"
        role = "<role_ID>"
        members = [
          "federatedUser:<user_ID>",
        ]
      }
      ```

      Where:

      * `organization_id`: Organization ID.
      * `role`: Role you want to assign. For each role, you can only use one `yandex_organization manager_organization_iam_binding`.
      * `members`: Array of the IDs of users to assign a role to:

         * `userAccount:<user_ID>`: User's Yandex account ID.
         * `federatedUser:<user_ID>`: Federated user ID.

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   The specified user will then get roles in the organization. You can check the new role in the [management console]({{ link-console-main }}).

- API {#api}

   To assign a role, use the `updateAccessBindings` REST API method for the appropriate resource:

   1. Select the role you want to assign.

   1. [Get the user ID](../operations/users-get.md).

   1. Create the request body, e.g., in the `body.json` file. In the `action` property, specify `ADD`, and in the `subject` property, specify the `userAccount` or `federatedUser` type and the user ID:

      ```json
      {
        "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
            "roleId": "<role_ID>",
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
      export IAM_TOKEN=<IAM-token>
      curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \	"https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

{% endlist %}

In a similar way, you can [assign roles](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) for an organization to a service account.

#### See also {#see-also}

* [{#T}](../../iam/operations/sa/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)
