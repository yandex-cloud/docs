[Документация Yandex Cloud](../../../index.md) > [Yandex Identity Hub](../../index.md) > [Пошаговые инструкции](../index.md) > Управление приложениями (SSO) > OIDC-приложения > Настроить доступ к приложению

# Настроить доступ к OIDC-приложению в Yandex Identity Hub


Чтобы предоставить доступ к [OIDC-приложению](../../concepts/applications/oidc.md), назначьте [роли](../../../iam/concepts/access-control/roles.md) субъектам. [Узнайте](../../security/index.md#roles-list), какие роли действуют в сервисе, чтобы назначить нужные.

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева нажмите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное приложение.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к приложению.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль. При необходимости добавьте другие роли.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  {% note alert %}
  
  Команда `set-access-bindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
  
  {% endnote %}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   1. Посмотрите описание команды CLI для назначения ролей на OIDC-приложение:

      ```bash
      yc organization-manager idp application oauth application set-access-bindings --help
      ```

   1. Получите список OIDC-приложений и их идентификаторы:

      ```bash
      yc organization-manager idp application oauth application list --organization-id <идентификатор_организации>
      ```

      Где `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно получить список OIDC-приложений.

   1. Получите идентификатор [пользователя](../users-get.md), [сервисного аккаунта](../../../iam/operations/sa/get-id.md) или группы, которым нужно предоставить доступ к OIDC-приложению.

   1. С помощью команды `yc organization-manager idp application oauth application set-access-bindings` назначьте роли:

      ```bash
      yc organization-manager idp application oauth application set-access-bindings \
        --id <идентификатор_приложения> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--id` — идентификатор OIDC-приложения, к которому нужно предоставить доступ.
      * `role` — идентификатор роли, которую нужно назначить.
      * `subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          Для обозначения субъекта используется комбинация типа и уникального идентификатора — `<тип_субъекта>:<идентификатор>`. Возможные обозначения субъектов:
          
          #|
          || **Тип субъекта** | **Обозначение субъекта** ||
          || `userAccount`    | `userAccount:<идентификатор_пользователя>` ||
          || `serviceAccount` | `serviceAccount:<идентификатор_сервисного_аккаунта>` ||
          || `federatedUser`  | `federatedUser:<идентификатор_пользователя>` ||
          || `group`          | `group:<идентификатор_группы>` ||
          || `system`         | `system:allAuthenticatedUsers`
          
          (группа `All authenticated users`) ||
          || ^                | `system:allUsers`
          
          (группа `All users`) ||
          || ^                | `system:group:organization:<идентификатор_организации>:users`
          
          (группа `All users in organization X`) ||
          || ^                | `system:group:federation:<идентификатор_федерации>:users`
          
          (группа `All users in federation N`) ||
          || ^                | `system:group:userpool:<идентификатор_пула>:users`
          
          (группа `All users in userpool P`) ||
          |#

          {% endcut %}

      Для каждой роли передайте отдельный параметр `--access-binding`. Пример:

      ```bash
      yc organization-manager idp application oauth application set-access-bindings \
        --id <идентификатор_приложения> \
        --access-binding role=<роль1>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль2>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль3>,service-account-id=<идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  {% note alert %}
  
  Метод `setAccessBindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
  
  {% endnote %}

  Воспользуйтесь методом REST API [Application.SetAccessBindings](../../idp/application/oauth/api-ref/Application/setAccessBindings.md) для ресурса [Application](../../idp/application/oauth/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/SetAccessBindings](../../idp/application/oauth/api-ref/grpc/Application/setAccessBindings.md).

  Передайте в запросе:

  * Роль в параметре `accessBindings[].roleId`.
  * Идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль на OIDC-приложение, в параметре `accessBindings[].subject.id`.
  * Тип субъекта, которому назначается роль на OIDC-приложение, в параметре `accessBindings[].subject.type`.

      {% cut "Обозначения субъектов" %}

      Для обозначения субъекта используется комбинация типа и уникального идентификатора в полях запроса `subject.type` и `subject.id`. Возможные комбинации:
      
      #|
      || **subject.type** | **subject.id** ||
      || `userAccount`    | `<идентификатор_пользователя>` ||
      || `serviceAccount` | `<идентификатор_сервисного_аккаунта>` ||
      || `federatedUser`  | `<идентификатор_пользователя>` ||
      || `group`          | `<идентификатор_группы>` ||
      || `system`         | `allAuthenticatedUsers`
      
      (группа `All authenticated users`) ||
      || ^                | `allUsers`
      
      (группа `All users`) ||
      || ^                | `group:organization:<идентификатор_организации>:users`
      
      (группа `All users in organization X`) ||
      || ^                | `group:federation:<идентификатор_федерации>:users`
      
      (группа `All users in federation N`) ||
      || ^                | `group:userpool:<идентификатор_пула>:users`
      
      (группа `All users in userpool P`) ||
      |#

      {% endcut %}

{% endlist %}