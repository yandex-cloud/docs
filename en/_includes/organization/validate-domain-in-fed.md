{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Confirm that the domain belongs to you:

     1. Go to the DNS records management section on your domain's DNS provider's website.
     1. Add a TXT record with the following parameters:

        * **Host** or **Subdomain**: `_yandexcloud-challenge`.
        * **Text** or **Value**: The `value` field value you got after [associating the domain](../../organization/operations/user-pools/add-domain.md).

     1. Wait for the DNS records to update. The update may take up to 72 hours.

  1. See the description of the CLI command for validating your domain in a [federation](../../organization/concepts/add-federation.md):

     ```bash
     yc organization-manager federation saml validate-domain --help
     ```

  1. Run this command:

     ```bash
     yc organization-manager federation saml validate-domain <federation_name_or_ID> \
       --domain <domain>
     ```

     Where `--domain` is your domain.

     For example, validate `my-domain.ru` in `my-federation`:

     ```bash
     yc organization-manager federation saml validate-domain my-federation \
       --domain my-domain.ru
     ```

{% endlist %}