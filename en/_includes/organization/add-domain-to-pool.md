{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the user pool.
  1. In the top-right corner, click **{{ ui-key.yacloud_org.organization.userpools.action.add_domain }}**.
  1. Enter the domain name. The domain must not be linked to another user pool or federation.
  1. Click **{{ ui-key.yacloud.common.add }}**.

  To use the domain to add new users, have it [verified](../../organization/operations/user-pools/validate-domain.md).

{% endlist %}