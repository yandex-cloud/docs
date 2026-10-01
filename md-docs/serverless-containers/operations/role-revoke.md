[Документация Yandex Cloud](../../index.md) > [Yandex Serverless Containers](../index.md) > [Пошаговые инструкции](index.md) > Управление правами доступа к контейнеру > Отозвать роли, назначенные на контейнер

# Отозвать роли, назначенные на контейнер

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду, чтобы отозвать [роль](../security/index.md) на контейнер:

  ```bash
  yc serverless container remove-access-binding \
    --name <имя_контейнера> \
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

  Чтобы отозвать роли, назначенные на контейнер, воспользуйтесь методом REST API [updateAccessBindings](../containers/api-ref/Container/updateAccessBindings.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/UpdateAccessBindings](../containers/api-ref/grpc/Container/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject).

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