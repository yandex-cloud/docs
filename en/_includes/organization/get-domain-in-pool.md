{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. Select the required pool from the [user pool](../../organization/concepts/user-pools.md) list.
  1. Under **{{ ui-key.yacloud_org.organization.userpools.caption_domains }}**, click the [domain](../../organization/concepts/domains.md) name.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command for viewing information about a [domain](../../organization/concepts/domains.md) in a [user pool](../../organization/concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain get --help
     ```

  1. Run this command:

      ```bash
      yc organization-manager idp userpool domain get <pool_ID> <domain>
      ```

{% endlist %}