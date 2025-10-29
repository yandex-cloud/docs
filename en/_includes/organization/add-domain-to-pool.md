{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the user pool.
  1. In the top-right corner, click **{{ ui-key.yacloud_org.organization.userpools.action.add_domain }}**.
  1. Enter the domain name.
  1. Click **{{ ui-key.yacloud.common.add }}**.

  To use the domain to add new users, have it [verified](../../organization/operations/user-pools/validate-domain.md).

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command to associate a domain with a user pool:

     ```bash
     yc organization-manager idp userpool domain add --help
     ```

  1. Run this command:

      ```bash
      yc organization-manager idp userpool domain add <pool_ID> <domain>
      ```

      Result:

      ```text
      done (1s)
      domain: example. com
      status: NEED_TO_VALIDATE
      status_code: organization/domain-diagnostics#need-to-validate
      created_at: "2025-10-09T06:40:18.704791371Z"
      validated_at: "1970-01-01T00:00:00Z"
      challenges:
      - created_at: "2025-10-09T06:40:18.704791371Z"
      updated_at: "2025-10-09T06:40:18.704791371Z"
      type: DNS_TXT
      status: PENDING
      dns_challenge:
      name: _yandexcloud-challenge. example. com
      type: TXT
      value: TlHc5HKJDeQIgPqaoiiSXxgy3CWFD+MLMJJP********
      ```

      Save the `value` as you will need it to [validate the domain](../../organization/operations/user-pools/validate-domain.md).

{% endlist %}