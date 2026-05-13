# Просмотреть роли, назначенные на реестр

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится реестр.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud Registry**.
  1. Выберите реестр.
  1. Перейдите на вкладку **Права доступа**.
  1. Найдите в списке нужного пользователя, группу или [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md). Назначенные роли будут указаны в столбце **Роли**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду:

  ```bash
  yc cloud-registry registry list-access-bindings <имя_или_идентификатор_реестра>
  ```

  **Пример**
  
  ```bash
  yc cloud-registry registry list-access-bindings my-first-registry
  ```

  Результат:
  
  ```bash
  +----------------------+---------------+----------------------+
  |       ROLE ID        | SUBJECT TYPE  |      SUBJECT ID      |
  +----------------------+---------------+----------------------+
  | cloud-registry.admin | federatedUser | ajekv7lpqpgu******** |
  +----------------------+---------------+----------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API [listAccessBindings](../../api-ref/Registry/listAccessBindings.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/ListAccessBindings](../../api-ref/grpc/Registry/listAccessBindings.md).

{% endlist %}

Подробнее о просмотре назначенных ролей читайте в [документации](../../../iam/operations/roles/get-assigned-roles.md) Yandex Identity and Access Management.