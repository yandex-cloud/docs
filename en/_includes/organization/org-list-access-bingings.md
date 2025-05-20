You can view all [roles](../../organization/security/index.md) assigned to subjects in an organization:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

  1. In the left-hand panel, select ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.

  1. The **{{ ui-key.yacloud_org.pages.acl }}** page will display information about users and roles assigned to them.

     {% include [switch-org-note](switch-org-note.md) %}

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. {% include [get-federation-id-cli](../../_includes/organization/get-federation-id-cli.md) %}

  1. See the description of the CLI command to get a list of roles assigned in an organization:

     ```bash
     yc organization-manager organization list-access-bindings --help
     ```

  1. Get a list of roles assigned in an organization by specifying its name or ID:

     ```bash
     yc organization-manager organization list-access-bindings <organization_ID>
     ```

     Result:

     ```text
     +------------------------------------------+----------------+----------------------+
     |                 ROLE ID                  |  SUBJECT TYPE  |      SUBJECT ID      |
     +------------------------------------------+----------------+----------------------+
     | auditor                                  | serviceAccount | ajefbjkmgjt1******** |
     | admin                                    | userAccount    | asefbskmgjt1******** |
     | organization-manager.organizations.owner | userAccount    | ajcfabjkmgjt******** |
     +------------------------------------------+----------------+----------------------+
     ```

- API {#api}

  Use the [ListAccessBindings](../../organization/api-ref/Organization/listAccessBindings.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/ListAccessBindings](../../organization/api-ref/grpc/Organization/listAccessBindings.md) gRPC API call.

{% endlist %}
