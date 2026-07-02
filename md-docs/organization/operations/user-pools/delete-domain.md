[Документация Yandex Cloud](../../../index.md) > [Yandex Identity Hub](../../index.md) > [Пошаговые инструкции](../index.md) > Управление доменами > Удалить домен

# Удалить домен


Нельзя удалить [домен](../../concepts/domains.md) по умолчанию или домен, к которому привязаны пользователи.

## Удалить домен из пула пользователей {#userpool}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **Пулы пользователей** и выберите нужный [пул пользователей](../../concepts/user-pools.md).
  1. В блоке **Домены** рядом с необходимым доменом нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите удаление домена.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления домена из [пула пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain delete --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp userpool domain delete <идентификатор_пула> <домен>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.DeleteDomain](../../idp/api-ref/Userpool/deleteDomain.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/DeleteDomain](../../idp/api-ref/grpc/Userpool/deleteDomain.md).

{% endlist %}

## Удалить домен из федерации {#federation}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления домена из [федерации](../../concepts/add-federation.md):

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

  Воспользуйтесь методом REST API [Federation.DeleteDomain](../../saml/api-ref/Federation/deleteDomain.md) для ресурса [Federation](../../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/DeleteDomain](../../saml/api-ref/grpc/Federation/deleteDomain.md).

{% endlist %}