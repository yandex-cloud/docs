[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Logging](../index.md) > [Пошаговые инструкции](index.md) > Управление правами доступа к лог-группе

# Управление правами доступа к лог-группе

Вы можете посмотреть, какие роли [назначены](#list) на лог-группу, [отозвать](#revoke) их или [назначить](#add-access) новые.

{% note info %}

[Лог-группа по умолчанию](../concepts/log-group.md) наследует [роли, назначенные на каталог](../../iam/operations/roles/get-assigned-roles.md), в котором она находится. Чтобы изменить права доступа к ней, [назначьте](../../iam/operations/roles/grant.md) или [отзовите](../../iam/operations/roles/revoke.md) роли на каталог.

{% endnote %}

## Посмотреть роли, назначенные на лог-группу {#list}

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
    
    Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы посмотреть [роли](../security/index.md), назначенные на [пользовательскую лог-группу](../concepts/log-group.md), выполните команду:

    ```
    yc logging group list-access-bindings --name=<имя_лог-группы>
    ```

    Результат:

    ```
    +---------+--------------+-----------------------+
    | ROLE ID | SUBJECT TYPE |      SUBJECT ID       |
    +---------+--------------+-----------------------+
    | editor  | system       | allAuthenticatedUsers |
    +---------+--------------+-----------------------+
    ```

- API {#api}

  Чтобы посмотреть роли, назначенные на пользовательскую лог-группу, воспользуйтесь методом REST API [listAccessBindings](../api-ref/LogGroup/listAccessBindings.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/ListAccessBindings](../api-ref/grpc/LogGroup/listAccessBindings.md).

{% endlist %}

## Назначить роли на лог-группу {#add-access}

{% list tabs group=instructions %}

- CLI {#cli}

    Выполните команду, чтобы назначить [роль](../security/index.md) на пользовательскую лог-группу:

    ```bash
    yc logging group add-access-binding \
      --name <имя_лог-группы> \
      --role <роль> \
      --subject <тип_субъекта>:<идентификатор_субъекта>
    ```

    Где:

    * `--role` — назначаемая [роль](../security/index.md#roles-list).
    * `--subject` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

        {% cut "Обозначения субъектов" %}

        Для обозначения субъекта используется параметр `--subject` со значением в формате `<тип_субъекта>:<идентификатор>`. Для некоторых типов субъектов в [Yandex Cloud CLI](../../cli/index.md) вместо `--subject` доступны отдельные параметры, в которых достаточно указать имя или идентификатор субъекта без типа. Возможные обозначения субъектов и соответствующие параметры CLI:
        
        #|
        || **Тип субъекта** | **Обозначение субъекта** | **Параметр Yandex Cloud CLI** ||
        || `userAccount`    | `userAccount:<идентификатор_пользователя>` | `--user-account-id` или `--user-yandex-login` ||
        || `serviceAccount` | `serviceAccount:<идентификатор_сервисного_аккаунта>` | `--service-account-id` или `--service-account-name` ||
        || `federatedUser`  | `federatedUser:<идентификатор_пользователя>` | `--user-account-id` ||
        || `group`          | `group:<идентификатор_группы>` | `--group-members` ||
        || `system`         | `system:allAuthenticatedUsers`
        
        (группа `All authenticated users`) | `--all-authenticated-users` ||
        || ^                | `system:allUsers`
        
        (группа `All users`) | — ||
        || ^                | `system:group:organization:<идентификатор_организации>:users`
        
        (группа `All users in organization X`) | `--organization-users` ||
        || ^                | `system:group:federation:<идентификатор_федерации>:users`
        
        (группа `All users in federation N`) | `--federation-users` ||
        || ^                | `system:group:userpool:<идентификатор_пула>:users`
        
        (группа `All users in userpool P`) | — ||
        |#

        {% endcut %}

- API {#api}

  Чтобы назначить роли на пользовательскую лог-группу, воспользуйтесь методом REST API [setAccessBindings](../api-ref/LogGroup/setAccessBindings.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/SetAccessBindings](../api-ref/grpc/LogGroup/setAccessBindings.md).

{% endlist %}

## Отозвать роли, назначенные на лог-группу {#revoke}

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду, чтобы отозвать [роль](../security/index.md) на пользовательскую лог-группу:

  ```bash
  yc logging group remove-access-binding \
    --name <имя_лог-группы> \
    --role <идентификатор_роли> \
    --subject <тип_субъекта>:<идентификатор_субъекта>
  ```

  Где:

  * `--role` — идентификатор роли, которую надо отозвать.
  * `--subject` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

      {% cut "Обозначения субъектов" %}

      Для обозначения субъекта используется параметр `--subject` со значением в формате `<тип_субъекта>:<идентификатор>`. Для некоторых типов субъектов в [Yandex Cloud CLI](../../cli/index.md) вместо `--subject` доступны отдельные параметры, в которых достаточно указать имя или идентификатор субъекта без типа. Возможные обозначения субъектов и соответствующие параметры CLI:
      
      #|
      || **Тип субъекта** | **Обозначение субъекта** | **Параметр Yandex Cloud CLI** ||
      || `userAccount`    | `userAccount:<идентификатор_пользователя>` | `--user-account-id` или `--user-yandex-login` ||
      || `serviceAccount` | `serviceAccount:<идентификатор_сервисного_аккаунта>` | `--service-account-id` или `--service-account-name` ||
      || `federatedUser`  | `federatedUser:<идентификатор_пользователя>` | `--user-account-id` ||
      || `group`          | `group:<идентификатор_группы>` | `--group-members` ||
      || `system`         | `system:allAuthenticatedUsers`
      
      (группа `All authenticated users`) | `--all-authenticated-users` ||
      || ^                | `system:allUsers`
      
      (группа `All users`) | — ||
      || ^                | `system:group:organization:<идентификатор_организации>:users`
      
      (группа `All users in organization X`) | `--organization-users` ||
      || ^                | `system:group:federation:<идентификатор_федерации>:users`
      
      (группа `All users in federation N`) | `--federation-users` ||
      || ^                | `system:group:userpool:<идентификатор_пула>:users`
      
      (группа `All users in userpool P`) | — ||
      |#

      {% endcut %}

- API {#api}

  Чтобы отозвать роли, назначенные на пользовательскую лог-группу, воспользуйтесь методом REST API [updateAccessBindings](../api-ref/LogGroup/updateAccessBindings.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/UpdateAccessBindings](../api-ref/grpc/LogGroup/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject).

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