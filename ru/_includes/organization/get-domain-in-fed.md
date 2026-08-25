{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![icon-federation](../../_assets/organization/icon-federation.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
  1. В списке [федераций](../../organization/concepts/add-federation.md) выберите нужную федерацию.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.form.federation.note.tab-domains }}**. 
  1. Нажмите на название нужного [домена](../../organization/concepts/domains.md).

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра информации о [домене](../../organization/concepts/domains.md) в [федерации](../../organization/concepts/add-federation.md):

     ```bash
     yc organization-manager federation saml get-domain --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager federation saml get-domain <имя_или_идентификатор_федерации> \
        --domain <домен>
      ```

      Где `--domain` — ваш домен.

- API {#api}

  Воспользуйтесь методом REST API [Federation.GetDomain](../../organization/saml/api-ref/Federation/getDomain.md) для ресурса [Federation](../../organization/saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/GetDomain](../../organization/saml/api-ref/grpc/Federation/getDomain.md).

{% endlist %}