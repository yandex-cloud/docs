### Добавьте федеративных пользователей {#add-user-sso}

{% list tabs %}

- Консоль управления

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.
    1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
    1. На панели слева выберите раздел [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) ![icon-users](../../_assets/console-icons/person.svg).
    1. В правом верхнем углу нажмите ![icon-users](../../_assets/console-icons/chevron-down.svg) → **{{ ui-key.yacloud_org.page.users.action.add-federated-users }}**.
    1. Выберите федерацию, из которой необходимо добавить пользователей.
    1. Перечислите Name ID пользователей, разделяя их переносами строк.
    1. Нажмите **Добавить**. Пользователи будут подключены к организации.

- CLI

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

- API

    Воспользуйтесь методом REST API [addUserAccounts](../../iam/api-ref/Federation/addUserAccounts.md) для ресурса [Federation](../../iam/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/AddUserAccounts](../../iam/api-ref/grpc/federation_service.md#AddUserAccounts) и передайте в запросе:

    * Идентификатор федерации в параметре `federationId`.
    * Список Name ID пользователей в параметре `nameIds`.

{% endlist %}
