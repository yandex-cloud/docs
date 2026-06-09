# Настроить домен в федерации удостоверений


[Домен](../concepts/domains.md) дает возможность аутентифицироваться через систему [Login Discovery](../concepts/domains.md#login-discovery). При аутентификации пользователь с вашим доменом будет перенаправлен в вашу [федерацию удостоверений](../concepts/add-federation.md).

## Привязать домен {#add}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

      Результат:

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

      Сохраните значение поля `value`, оно понадобится для [подтверждения домена](user-pools/validate-domain.md).

- API {#api}

  Воспользуйтесь методом REST API [Federation.AddDomain](../saml/api-ref/Federation/addDomain.md) для ресурса [Federation](../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/AddDomain](../saml/api-ref/grpc/Federation/addDomain.md).

{% endlist %}


## Получить список доменов {#list}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения списка [доменов](../concepts/domains.md) в [федерации](../concepts/add-federation.md):

     ```bash
     yc organization-manager federation saml list-domains --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager federation saml list-domains <имя_или_идентификатор_федерации>
      ```
      
- API {#api}

  Воспользуйтесь методом REST API [Federation.ListDomains](../saml/api-ref/Federation/listDomains.md) для ресурса [Federation](../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/ListDomains](../saml/api-ref/grpc/Federation/listDomains.md).

{% endlist %}

## Посмотреть информацию о домене {#get}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра информации о [домене](../concepts/domains.md) в [федерации](../concepts/add-federation.md):

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

  Воспользуйтесь методом REST API [Federation.GetDomain](../saml/api-ref/Federation/getDomain.md) для ресурса [Federation](../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/GetDomain](../saml/api-ref/grpc/Federation/getDomain.md).

{% endlist %}

## Удалить домен {#delete}

Нельзя удалить домен по умолчанию или домен, к которому привязаны пользователи.

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления домена из [федерации](../concepts/add-federation.md):

     ```bash
     yc organization-manager federation saml delete-domain --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager federation saml delete-domain <имя_или_идентификатор_федерации> \
        --domain <домен>
      ```

      Где `--domain` — ваш домен.

      Например, удалите домен `my-domain.ru` из федерации `my-federation`:

      ```bash
      yc organization-manager federation saml delete-domain my-federation \
        --domain my-domain.ru
      ```

- API {#api}

  Воспользуйтесь методом REST API [Federation.DeleteDomain](../saml/api-ref/Federation/deleteDomain.md) для ресурса [Federation](../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/DeleteDomain](../saml/api-ref/grpc/Federation/deleteDomain.md).

{% endlist %}