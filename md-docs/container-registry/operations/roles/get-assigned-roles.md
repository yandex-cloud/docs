[Документация Yandex Cloud](../../../index.md) > [Yandex Container Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Работа с ролями > Просмотреть назначенные роли

# Просмотреть роли на ресурс

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно просмотреть [роли](../../../iam/concepts/access-control/roles.md), назначенные на ресурс.
  1. Перейдите в сервис **Container Registry**.
  1. Выберите [реестр](../../concepts/registry.md) или [репозиторий](../../concepts/repository.md) в нем.
  1. Перейдите на вкладку **Права доступа**.
  1. Найдите в списке нужного пользователя, группу или [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md). Назначенные роли указаны в столбце **Роли**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду:

  ```bash
  yc container <ресурс> list-access-bindings <имя_или_идентификатор_ресурса>
  ```

  Где:
  * `<ресурс>` — тип ресурса `registry` (реестр) или `repository` (репозиторий);
  * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса, роли, назначенные на который, вы хотите посмотреть.

  **Пример**
  
  ```bash
  yc container registry list-access-bindings my-first-registry
  ```

  Результат:
  
  ```bash
  +--------------------------+---------------+----------------------+
  |         ROLE ID          | SUBJECT TYPE  |      SUBJECT ID      |
  +--------------------------+---------------+----------------------+
  | container-registry.admin | federatedUser | ajekv7lpqpgu******** |
  +--------------------------+---------------+----------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API [listAccessBindings](../../api-ref/Registry/listAccessBindings.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/listAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md).

  Воспользуйтесь методом REST API [listAccessBindings](../../api-ref/Repository/listAccessBindings.md) для ресурса [Repository](../../api-ref/Repository/index.md) или вызовом gRPC API [RepositoryService/listAccessBindings](../../api-ref/grpc/Repository/updateAccessBindings.md).

{% endlist %}

Подробнее об управлении ролями читайте в [документации](../../../iam/concepts/index.md) Yandex Identity and Access Management.