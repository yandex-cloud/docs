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