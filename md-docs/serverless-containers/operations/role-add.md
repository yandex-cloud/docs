[Документация Yandex Cloud](../../index.md) > [Yandex Serverless Containers](../index.md) > [Пошаговые инструкции](index.md) > Управление правами доступа к контейнеру > Назначить роли на контейнер

# Назначить роли на контейнер

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду, чтобы назначить [роль](../security/index.md) на контейнер:

  ```bash
  yc serverless container add-access-binding \
    --name <имя_контейнера> \
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

  Чтобы назначить роли на контейнер, воспользуйтесь методом REST API [setAccessBindings](../containers/api-ref/Container/setAccessBindings.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/SetAccessBindings](../containers/api-ref/grpc/Container/setAccessBindings.md). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject).

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