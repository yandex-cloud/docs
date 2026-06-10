# Назначить роль на реестр

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится реестр.
  1. Перейдите в сервис **Cloud Registry**.
  1. Выберите реестр.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В открывшемся окне выберите группу, пользователя или [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md).
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль из списка.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду, чтобы назначить роль на реестр:

  * пользователю:

    ```bash
    yc cloud-registry registry add-access-binding <имя_или_идентификатор_реестра> \
      --role <роль> \
      --user-account-id <идентификатор_пользователя>
    ```

  * [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md):

    ```bash
    yc cloud-registry registry add-access-binding <имя_или_идентификатор_реестра> \
      --role <роль> \
      --service-account-id <идентификатор_сервисного_аккаунта>
    ```

  * всем авторизованным пользователям ([публичная группа](../../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers) `All authenticated users`):

    ```bash
    yc cloud-registry registry add-access-binding <имя_или_идентификатор_реестра> \
      --role <роль> \
      --allAuthenticatedUsers
    ```

  * всем пользователям ([публичная группа](../../../iam/concepts/access-control/public-group.md#allUsers) `All users`):

    ```bash
    yc cloud-registry registry add-access-binding <имя_или_идентификатор_реестра> \
      --role <роль> \
      --subject system:allUsers
    ```

    Где `<роль>` — [роль](../../security/index.md#service-roles), которую необходимо назначить.

  Чтобы отозвать все роли на реестр и сразу назначить новые, используйте команду `yc cloud-registry registry set-access-bindings`.
  
  **Пример**

  В примере ниже пользователю назначается роль `cloud-registry.admin` на реестр `my-first-registry`.

  ```bash
  yc cloud-registry registry add-access-binding my-first-registry \
    --role cloud-registry.admin \
    --user-account-id ajeugsk5ubk6********
  ```

  Результат:

  ```text
  done (4s)
  ```
- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/UpdateAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md).

{% endlist %}

Подробнее о назначении ролей читайте в [документации](../../../iam/operations/roles/grant.md) Yandex Identity and Access Management.