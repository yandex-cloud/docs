# Просмотреть роли, назначенные на реестр

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится реестр.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Выберите реестр.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Найдите в списке нужного пользователя, группу или [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md). Назначенные роли будут указаны в столбце **{{ ui-key.yacloud_components.acl.resource-acl.label_bindings }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

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

Подробнее о просмотре назначенных ролей читайте в [документации](../../../iam/operations/roles/get-assigned-roles.md) {{ iam-full-name }}.