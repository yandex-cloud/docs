{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![icon-federation](../../_assets/organization/icon-federation.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
  1. Select a [federation](../../organization/concepts/add-federation.md) from the federation list.
  1. Navigate to the **{{ ui-key.yacloud_org.form.federation.note.tab-domains }}** tab. 
  1. Click the [domain](../../organization/concepts/domains.md) name.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command for viewing information about a [domain](../../organization/concepts/domains.md) in a [federation](../../organization/concepts/add-federation.md):

     ```bash
     yc organization-manager federation saml get-domain --help
     ```

  1. Run this command:

      ```bash
      yc organization-manager federation saml get-domain <federation_name_or_ID> \
        --domain <domain>
      ```

      Where `--domain` is your domain.

- API {#api}

  Use the [Federation.GetDomain](../../organization/saml/api-ref/Federation/getDomain.md) REST API method for the [Federation](../../organization/saml/api-ref/Federation/index.md) resource or the [FederationService/GetDomain](../../organization/saml/api-ref/grpc/Federation/getDomain.md) gRPC API call.

{% endlist %}