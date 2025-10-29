{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the [user pool](../../organization/concepts/user-pools.md).
  1. Under **{{ ui-key.yacloud_org.organization.userpools.caption_domains }}**, click ![image](../../_assets/console-icons/ellipsis.svg) next to the domain and select ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.organization.userpool.action_delete-domain }}**.
  1. In the window that opens, confirm deleting the domain.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command for deleting a domain from a [user pool](../../organization/concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain delete --help
     ```

  1. Run this command:

     ```bash
     yc organization-manager idp userpool domain delete <pool_ID> <domain>
     ```

{% endlist %}