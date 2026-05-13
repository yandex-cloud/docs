# Привязать домен


К [пулу пользователей](../../concepts/user-pools.md) или [федерации](../../concepts/add-federation.md) можно привязать [домен](../../concepts/domains.md), который дает возможность аутентифицироваться через систему [Login Discovery](../../concepts/domains.md#login-discovery). При аутентификации пользователь с вашим доменом будет перенаправлен в вашу федерацию или пул пользователей.

Чтобы использовать домен в пуле пользователей или федерации, нужно [подтвердить](validate-domain.md) право владения им через DNS-запись.

{% note warning %}

Домен может быть привязан только к одному пулу пользователей или к одной федерации.

{% endnote %}

## Привязать домен к пулу пользователей {#userpool}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **Пулы пользователей** и выберите нужный пул пользователей.
  1. В верхнем правом углу нажмите **Добавить домен**.
  1. Введите имя домена.
  1. Нажмите **Добавить**.

  Чтобы использовать домен для добавления новых пользователей, [подтвердите](validate-domain.md) его.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для привязки домена к пулу пользователей:

     ```bash
     yc organization-manager idp userpool domain add --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp userpool domain add <идентификатор_пула> <домен>
      ```

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

      Сохраните значение поля `value`, оно понадобится для [подтверждения домена](validate-domain.md).

- API {#api}

  Воспользуйтесь методом REST API [Userpool.AddDomain](../../idp/api-ref/Userpool/addDomain.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/AddDomain](../../idp/api-ref/grpc/Userpool/addDomain.md).

{% endlist %}

## Привязать домен к федерации {#federation}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

      Сохраните значение поля `value`, оно понадобится для [подтверждения домена](validate-domain.md).

- API {#api}

  Воспользуйтесь методом REST API [Federation.AddDomain](../../saml/api-ref/Federation/addDomain.md) для ресурса [Federation](../../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/AddDomain](../../saml/api-ref/grpc/Federation/addDomain.md).

{% endlist %}