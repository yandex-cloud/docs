# Посмотреть информацию о домене


## Посмотреть информацию о домене в пуле пользователей {#userpool}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. В списке [пулов пользователей](../../concepts/user-pools.md) выберите нужный пул.
  1. В блоке **{{ ui-key.yacloud_org.organization.userpools.caption_domains }}** нажмите на название нужного [домена](../../concepts/domains.md).

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра информации о [домене](../../concepts/domains.md) в [пуле пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain get --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp userpool domain get <идентификатор_пула> <домен>
      ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.GetDomain](../../idp/api-ref/Userpool/getDomain.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/GetDomain](../../idp/api-ref/grpc/Userpool/getDomain.md).

{% endlist %}

## Посмотреть информацию о домене в федерации {#federation}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра информации о [домене](../../concepts/domains.md) в [федерации](../../concepts/add-federation.md):

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

  Воспользуйтесь методом REST API [Federation.GetDomain](../../saml/api-ref/Federation/getDomain.md) для ресурса [Federation](../../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/GetDomain](../../saml/api-ref/grpc/Federation/getDomain.md).

{% endlist %}