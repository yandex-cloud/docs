[Документация Yandex Cloud](../../../index.md) > [Yandex Container Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Работа с ролями > Отозвать роль

# Отозвать роль на ресурс

Вы можете запретить [субъекту](../../../iam/concepts/access-control/index.md#subject) доступ к ресурсу, для этого необходимо отозвать у него соответствующие [роли](../../../iam/concepts/access-control/roles.md) на этот ресурс и на ресурсы, от которых наследуются права доступа. Подробнее читайте в разделе [Как устроено управление доступом в Yandex Cloud](../../../iam/concepts/access-control/index.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно отозвать роль на ресурс.
  1. [Перейдите](https://console.yandex.cloud/link/container-registry) в сервис **Container Registry**.
  1. Выберите [реестр](../../concepts/registry.md) или [репозиторий](../../concepts/repository.md) в нем.
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
     yc container <ресурс> list-access-bindings <имя_или_идентификатор_ресурса>
     ```

     Где:
     * `<ресурс>` — тип ресурса `registry` (реестр) или `repository` (репозиторий);
     * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса, на который назначена роль.

  1. Отзовите роль:

     ```bash
     yc container <ресурс> remove-access-binding <имя_или_идентификатор_ресурса> \
       --role <роль> \
       --subject <тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `<ресурс>` — тип ресурса `registry` (реестр) или `repository` (репозиторий);
     * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса, на который отзывается роль;
     * `<идентификатор_роли>` — [роль](../../security/index.md#service-roles), которую необходимо отозвать;
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
     
     **Пример**

     В примере ниже у пользователя отзывается роль `container-registry.admin` на реестр `my-first-registry`.
     
     ```bash
     yc container registry remove-access-binding my-first-registry \
       --role container-registry.admin \
       --subject userAccount:ajeugsk5ubk6********
     ```

     Результат:

     ```text
     done (9s)
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием назначения ролей.

     Пример описания назначения роли в конфигурации Terraform:

       ```
       resource "yandex_container_registry_iam_binding" "имя_реестра" {
         registry_id = "<идентификатор_реестра>"
         role        = "<роль>"
       
         members = [
           "<тип_субъекта>:<идентификатор_субъекта>",
         ]
       }
       ```

       Где:

       * `registry_id` — идентификатор реестра, на который назначена роль.
       * `role` — [роль](../../security/index.md#service-roles), которую необходимо отозвать.
       * `members` — список обозначений [субъектов](../../../iam/concepts/access-control/index.md#subject), у которых отзывается роль.

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

       Подробнее о параметрах ресурса `yandex_container_registry_iam_binding` в [документации провайдера](../../../terraform/resources/container_registry_iam_binding.md).
  
  1. 1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Проверить отзыв роли можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

     * Для реестра:

       ```bash
       yc container registry list-access-bindings <имя_или_идентификатор_реестра>
       ```

     * Для репозитория:

       ```bash
       yc container repository list-access-bindings <имя_или_идентификатор_репозитория>
       ```

- API {#api}

  [Просмотрите](get-assigned-roles.md#cli) роли, назначенные на ресурсы.
  
  Чтобы отозвать роли, назначенные на реестр, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/UpdateAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md).

  Чтобы отозвать роли, назначенные на репозиторий, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Repository/updateAccessBindings.md) для ресурса [Repository](../../api-ref/Repository/index.md) или вызовом gRPC API [RepositoryService/UpdateAccessBindings](../../api-ref/grpc/Repository/updateAccessBindings.md).

  В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

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

Подробнее об управлении ролями читайте в [документации](../../../iam/concepts/index.md) Yandex Identity and Access Management.