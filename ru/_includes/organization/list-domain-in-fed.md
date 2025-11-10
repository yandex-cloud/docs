{% list tabs group=instructions %}

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