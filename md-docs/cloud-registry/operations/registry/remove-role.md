[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Управление реестром > Управление правами доступа к реестру > Отозвать роль

# Отозвать роль на реестр

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится реестр.
  1. [Перейдите](https://console.yandex.cloud/link/cloud-registry) в сервис **Cloud Registry**.
  1. Выберите реестр.
  1. Перейдите на вкладку **Права доступа**.
  1. Выберите пользователя в списке и нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) напротив имени пользователя.
  1. Нажмите кнопку **Изменить роли**.
  1. Нажмите значок ![image](../../../_assets/console-icons/xmark.svg) напротив роли, которую хотите отозвать.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Просмотрите назначенные роли:

     ```bash
     yc cloud-registry registry list-access-bindings <имя_или_идентификатор_реестра>
     ```

  1. Отзовите роль:

     ```bash
     yc cloud-registry registry remove-access-binding <имя_или_идентификатор_реестра> \
       --role <роль> \
       --subject <тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--role` — [роль](../../security/index.md#service-roles), которую необходимо отозвать.
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

    Чтобы отозвать все роли на реестр и сразу назначить новые, используйте команду `yc cloud-registry registry set-access-bindings`.
     
     **Пример**

     В примере ниже у пользователя отзывается роль `cloud-registry.admin` на реестр `my-first-registry`.
     
     ```bash
     yc cloud-registry registry remove-access-binding my-first-registry \
       --role cloud-registry.admin \
       --user-account-id ajeugsk5ubk6********
     ```

     Результат:

     ```text
     done (9s)
     ```

- API {#api}

  [Просмотрите](list-role.md#api) роли, назначенные на реестр.
  
  Чтобы отозвать роли, назначенные на реестр, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/UpdateAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

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

Подробнее об отзыве ролей читайте в [документации](../../../iam/operations/roles/revoke.md) Yandex Identity and Access Management.