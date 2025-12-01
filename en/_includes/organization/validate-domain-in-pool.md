{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the [user pool](../../organization/concepts/user-pools.md).
  1. Select the domain you need to verify.
  1. In the section that opens, you will see the details you will need to pass the domain rights check.
  1. After completing the verification, click **{{ ui-key.yacloud_org.common.confirm }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}  

  1. Confirm that the domain belongs to you:

     1. Go to the DNS records management section on your domain's DNS provider's website:
     1. Add a TXT record with the following parameters:

        * **Host** or **Subdomain**: `_yandexcloud-challenge`.
        * **Text** or **Value**: The `value` field value you got after [associating the domain](../../organization/operations/user-pools/add-domain.md).

     1. Wait for the DNS records to update. The update may take up to 72 hours.

  1. See the description of the CLI command for validating your domain in a [user pool](../../organization/concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain validate --help
     ```

  1. Run this command:

      ```bash
      yc organization-manager idp userpool domain validate <pool_ID> <domain> \
        --name <domain>
      ```

      For example, validate `my-domain.ru` in `my-federation`:

      ```bash
      yc organization-manager federation saml validate-domain my-federation \
        --domain my-domain.ru
      ```

- API {#api}

  Use the [Userpool.ValidateDomain](../../organization/idp/api-ref/Userpool/validateDomain.md) REST API method for the [Userpool](../../organization/idp/api-ref/Userpool/index.md) resource or the [UserpoolService/ValidateDomain](../../organization/idp/api-ref/grpc/Userpool/validateDomain.md) gRPC API call.

{% endlist %}