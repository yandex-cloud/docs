[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Functions](../../index.md) > [Пошаговые инструкции](../index.md) > Управление правами доступа к функции > Отозвать роли, назначенные на функцию

# Отозвать роли, назначенные на функцию

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
    
    Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Выполните команду, чтобы отозвать [роль](../../security/index.md#roles-list) на функцию:

    ```bash
    yc serverless function remove-access-binding \
      --id <идентификатор_функции> \
      --role <идентификатор_роли> \
      --subject <тип_субъекта>:<идентификатор_субъекта>
    ```

    Где:

    * `--role` — идентификатор роли, которую надо отозвать.
    * `--subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

        {% cut "Обозначения субъектов" %}

        Для обозначения субъекта используется параметр `--subject` со значением в формате `<тип_субъекта>:<идентификатор>`. Для некоторых типов субъектов в [Yandex Cloud CLI](../../../cli/index.md) вместо `--subject` доступны отдельные параметры, в которых достаточно указать имя или идентификатор субъекта без типа. Возможные обозначения субъектов и соответствующие параметры CLI:
        
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

  Чтобы отозвать роли на функцию, воспользуйтесь методом REST API [updateAccessBindings](../../functions/api-ref/Function/updateAccessBindings.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/UpdateAccessBindings](../../functions/api-ref/grpc/Function/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

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