{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![icon-federation](../../_assets/organization/icon-federation.svg) **{{ ui-key.yacloud_org.pages.federations }}** and select the target [federation](../../organization/concepts/add-federation.md).
  1. Navigate to the **{{ ui-key.yacloud_org.form.federation.note.tab-domains }}** tab. 
  1. In the domain section, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command for deleting a domain from a [federation](../../organization/concepts/add-federation.md):

     ```bash
     yc organization-manager federation saml delete-domain --help
     ```

  1. Run this command:

      ```bash
      yc organization-manager federation saml delete-domain <federation_name_or_ID> \
        --domain <domain>
      ```

      Where `--domain` is your domain.

      For example, delete `my-domain.ru` from `my-federation`:

      ```bash
      yc organization-manager federation saml delete-domain my-federation \
        --domain my-domain.ru
      ```

- API {#api}

  Use the [Federation.DeleteDomain](../../organization/saml/api-ref/Federation/deleteDomain.md) REST API method for the [Federation](../../organization/saml/api-ref/Federation/index.md) resource or the [FederationService/DeleteDomain](../../organization/saml/api-ref/grpc/Federation/deleteDomain.md) gRPC API call.

{% endlist %}