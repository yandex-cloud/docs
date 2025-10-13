{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command for getting a list of [domains](../../organization/concepts/domains.md) in a [federation](../../organization/concepts/add-federation.md):

     ```bash
     yc organization-manager federation saml list-domain --help
     ```

  1. Run this command:

      ```bash
      yc organization-manager federation saml list-domain <federation_name_or_ID> \
        --domain <domain>
      ```

      Where `--domain` is your domain.

{% endlist %}