{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для привязки домена к федерации:

     ```bash
     yc organization-manager federation saml add-domain --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager federation saml add-domain <имя_или_идентификатор_федерации> \
        --domain <домен>
      ```

      Где `--domain` — ваш домен.

      Например, привяжите домен `my-domain.ru` к федерации `my-federation`:

      ```bash
      yc organization-manager federation saml add-domain my-federation \
        --domain my-domain.ru
      ```  

{% endlist %}