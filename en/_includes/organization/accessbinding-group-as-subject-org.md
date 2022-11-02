1. {% include [cli-install](../cli-install.md) %}

1. Assign a [role](../../iam/concepts/access-control/roles.md) for the group:

   ```bash
   yc organization-manager organization add-access-binding \
   --subject=group:<group_ID> \
   --role=<role_ID> \
   <organization_ID>
   ```

1. Make sure the requested rights are granted:

   ```bash
   yc organization-manager organization list-access-bindings <organization_ID>
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