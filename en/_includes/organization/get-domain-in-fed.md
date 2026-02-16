{% list tabs group=instructions %}

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