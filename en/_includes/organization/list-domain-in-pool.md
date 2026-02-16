{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. Select the pool from the [user pool](../../organization/concepts/user-pools.md) list.
  1. Under **{{ ui-key.yacloud_org.organization.userpools.caption_domains }}**, you will see a list of all available domains.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command for getting a list of [domains](../../organization/concepts/domains.md) in a [user pool](../../organization/concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain list --help
     ```

  1. Run this command:

      ```bash
      yc organization-manager idp userpool domain list <pool_ID>
      ```

- API {#api}

  Use the [Userpool.ListDomains](../../organization/idp/api-ref/Userpool/listDomains.md) REST API method for the [Userpool](../../organization/idp/api-ref/Userpool/index.md) resource or the [UserpoolService/ListDomains](../../organization/idp/api-ref/grpc/Userpool/listDomains.md) gRPC API call.

{% endlist %}