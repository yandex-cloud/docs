{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![icon-federation](../../_assets/organization/icon-federation.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
  1. Select the [federation](../../organization/concepts/add-federation.md) you need from the list.
  1. Navigate to the **{{ ui-key.yacloud_org.form.federation.note.tab-domains }}** tab. You will see a list of all available domains.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command for getting a list of [domains](../../organization/concepts/domains.md) in a [federation](../../organization/concepts/add-federation.md):

     ```bash
     yc organization-manager federation saml list-domains --help
     ```

  1. Run this command:

      ```bash
      yc organization-manager federation saml list-domains <federation_name_or_ID>
      ```
      
- API {#api}

  Use the [Federation.ListDomains](../../organization/saml/api-ref/Federation/listDomains.md) REST API method for the [Federation](../../organization/saml/api-ref/Federation/index.md) resource or the [FederationService/ListDomains](../../organization/saml/api-ref/grpc/Federation/listDomains.md) gRPC API call.

{% endlist %}