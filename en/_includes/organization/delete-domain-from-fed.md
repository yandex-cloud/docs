{% list tabs group=instructions %}

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

{% endlist %}