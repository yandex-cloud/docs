{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command to associate a domain with a federation:

     ```bash
     yc organization-manager federation saml add-domain --help
     ```

  1. Run this command:

      ```bash
      yc organization-manager federation saml add-domain <federation_name_or_ID> \
        --domain <domain>
      ```

      Where `--domain` is your domain.

      For example, associate the `my-domain.ru` domain with a federation named `my-federation`:

      ```bash
      yc organization-manager federation saml add-domain my-federation \
        --domain my-domain.ru
      ```  

{% endlist %}