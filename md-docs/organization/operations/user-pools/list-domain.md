# Получить список доменов


## Получить список доменов в пуле пользователей {#userpool}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **Пулы пользователей**.
  1. В списке [пулов пользователей](../../concepts/user-pools.md) выберите нужный пул.
  1. В блоке **Домены** отобразится список всех доступных доменов.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения списка [доменов](../../concepts/domains.md) в [пуле пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain list --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp userpool domain list <идентификатор_пула>
      ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.ListDomains](../../idp/api-ref/Userpool/listDomains.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/ListDomains](../../idp/api-ref/grpc/Userpool/listDomains.md).

{% endlist %}

## Получить список доменов в федерации {#federation}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения списка [доменов](../../concepts/domains.md) в [федерации](../../concepts/add-federation.md):

     ```bash
     yc organization-manager federation saml list-domains --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager federation saml list-domains <имя_или_идентификатор_федерации>
      ```
      
- API {#api}

  Воспользуйтесь методом REST API [Federation.ListDomains](../../saml/api-ref/Federation/listDomains.md) для ресурса [Federation](../../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/ListDomains](../../saml/api-ref/grpc/Federation/listDomains.md).

{% endlist %}