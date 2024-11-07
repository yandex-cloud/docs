# Revoking a user's role 

If you want to deny a user access to a resource, revoke the relevant roles for this resource and for resources that grant inherited access rights. For more information on access management in {{ yandex-cloud }}, see the [{{ iam-full-name }}](../../iam/concepts/access-control/index.md) documentation.

The role can be revoked by a user with the [`organization-manager.admin`](add-org-admin.md) or `organization-manager.organizations.owner` role.

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  {% include [revoke-role-from-user](../../_includes/organization/revoke-role-from-user.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. View the roles and assignees for the resource:

      ```bash
      yc <service_name> <resource> list-access-bindings <resource_name_or_ID>
      ```

      Where:

      * `<service_name>`: Name of the service the resource belongs to, e.g., `organization-manager`.
      * `<resource>`: Resource category. For an organization, it is always `organization`.
      * `<resource_name_or_ID>`: Resource name or ID. You can specify the resource name or ID. For an organization, use its [technical name](../operations/org-profile.md).

      For example, view the roles and assignees in an organization with the `bpf3crucp1v2********` ID:

      ```bash
      yc organization-manager organization list-access-bindings bpf3crucp1v2********
      ```

      Result:

      ```text
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

      Where:

      * `--role`: ID of the role to revoke, e.g., `organization-manager.admin`.
      * `<subject_type>`: [Subject](../../iam/concepts/access-control/index.md#subject) type to revoke a role from.
      * `<subject_ID>`: Subject ID.

      For example, to revoke a role from a user with the `aje6o61dvog2********` ID:

      ```bash
      yc organization-manager organization remove-access-binding bpf3crucp1v2******** \
        --role organization-manager.admin \
        --subject userAccount:aje6o61dvog2********
      ```

- API {#api}

  1. View the roles and assignees for the resource using the `listAccessBindings` method. For example, to view the roles in the organization with the `bpf3crucp1v2********` ID:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v2********
      export IAM_TOKEN=<IAM_token>
      curl \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:listAccessBindings"
      ```

      Result:

      ```text
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

  1. Create the request body, e.g., in the `body.json` file. In the request body, specify access permissions to delete. For example, revoke the `organization-manager.admin` role from the `aje6o61dvog2********` user:

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
      export IAM_TOKEN=<IAM_token>
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

{% endlist %}

#### See also {#see-also}

[{#T}](add-role.md)
