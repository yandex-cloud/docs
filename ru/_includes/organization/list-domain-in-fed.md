{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![icon-federation](../../_assets/organization/icon-federation.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
  1. В списке [федераций](../../organization/concepts/add-federation.md) выберите нужную федерацию.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.form.federation.note.tab-domains }}**. Отобразится список всех доступных доменов.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения списка [доменов](../../organization/concepts/domains.md) в [федерации](../../organization/concepts/add-federation.md):

     ```bash
     yc organization-manager federation saml list-domains --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager federation saml list-domains <имя_или_идентификатор_федерации>
      ```
      
- API {#api}

  Воспользуйтесь методом REST API [Federation.ListDomains](../../organization/saml/api-ref/Federation/listDomains.md) для ресурса [Federation](../../organization/saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/ListDomains](../../organization/saml/api-ref/grpc/Federation/listDomains.md).

{% endlist %}