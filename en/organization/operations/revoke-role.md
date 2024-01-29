# Revoking a role from a user

If you want to deny a user access to a resource, revoke the relevant roles for this resource and for resources that grant inherited access rights. For more information on access control in {{ yandex-cloud }}, please see the [{{ iam-full-name }}](../../iam/concepts/access-control/index.md) documentation.

The role can be revoked by a [user with the organization administrator role](add-org-admin.md) (`organization-manager.admin`) or organization owner role (`organization-manager.organizations.owner`).

{% list tabs group=instructions %}

- {{ org-name }} {#cloud-org}

   1. [Log in]({{ link-passport }}) as the organization administrator or owner.

   1. Go to [{{ org-full-name }}]({{ link-org-main }}).

   1. In the left-hand panel, select ![persons-lock](../../_assets/console-icons/persons-lock.svg) [{{ ui-key.yacloud_org.pages.acl }}]({{ link-org-acl }}).

   1. Select a user from the list or use the search bar at the top of the page.

   1. In the right-hand column, click ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

   1. Click ![cross](../../_assets/console-icons/xmark.svg) next to a role to delete it.

   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   1. View the roles and assignees for a resource:

      ```bash
      yc <service_name> <resource> list-access-bindings <resource_name_or_ID>
      ```

      Where:

      * `<service_name>`: Name of the service the resource belongs to, e.g., `organization-manager`.
      * `<resource>`: Resource category. For an organization, `organization` is the category of importance.
      * `<resource_name_or_ID>`: Name or ID of the resource. You can specify the resource name or ID. Refer to an organization by its [technical name](../operations/org-profile.md).

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

   1. To delete an access binding, run:

      ```bash
      yc <service_name> <resource> remove-access-binding <resource_name_or_ID> \
        --role <role_ID> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `--role`: ID of the role to be revoked, e.g., `organization-manager.admin`.
      * `<subject-type>`: [Subject](../../iam/concepts/access-control/index.md#subject) type to revoke a role from.
      * `<subject_ID>`: Subject ID.

      For example, to revoke a role from a user with the `aje6o61dvog2********` ID:

      ```bash
      yc organization-manager organization remove-access-binding bpf3crucp1v2******** \
        --role organization-manager.admin \
        --subject userAccount:aje6o61dvog2********
      ```

- API {#api}

   1. View the roles and assignees for a resource using the `listAccessBindings` method. For example, to view an organization's roles with the `bpf3crucp1v2********` ID:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v2********
      export IAM_TOKEN=<IAM-token>
      curl -H "Authorization: Bearer ${IAM_TOKEN}" "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:listAccessBindings"
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

   1. Create the request body, e.g., in the `body.json` file. In the request body, specify which access binding to delete. For example, revoke the `organization-manager.admin` role from the `aje6o61dvog2********` user:

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

   1. Revoke the role by deleting the specified access binding:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v2********
      export IAM_TOKEN=<IAM-token>
      curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \	"https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

{% endlist %}

#### See also {#see-also}

[{#T}](add-role.md)
