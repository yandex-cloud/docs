### Добавьте федеративных пользователей {#add-user-sso}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    {% include [add-users-to-fed](./add-users-to-fed.md) %}

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    1. Посмотрите описание команды добавления пользователей:

        ```bash
        yc organization-manager federation saml add-user-accounts --help
        ```

    1. Добавьте пользователей, перечислив их Name ID через запятую:

        ```bash
        yc organization-manager federation saml add-user-accounts \
           --name <имя_федерации> \
           --name-ids <список_Name_ID_пользователей>
        ```

- API {#api}

    Воспользуйтесь методом REST API [addUserAccounts](../../iam/api-ref/Federation/addUserAccounts.md) для ресурса [Federation](../../iam/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/AddUserAccounts](../../iam/api-ref/grpc/federation_service.md#AddUserAccounts) и передайте в запросе:

    * Идентификатор федерации в параметре `federationId`.
    * Список Name ID пользователей в параметре `nameIds`.

{% endlist %}
