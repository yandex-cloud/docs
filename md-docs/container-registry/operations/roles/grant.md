[Документация Yandex Cloud](../../../index.md) > [Yandex Container Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Работа с ролями > Назначить роль

# Назначить роль на ресурс

Чтобы предоставить доступ к [ресурсу](../../../iam/concepts/access-control/resources-with-access-control.md), назначьте субъекту [роль](../../../iam/concepts/access-control/roles.md) на сам ресурс или на ресурс, от которого наследуются права доступа, например на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) или [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud). Актуальный список ресурсов, на которые можно назначать роли, доступен в разделе [На какие ресурсы можно назначить роль](../../security/index.md#resources).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно назначить роль на ресурс.
  1. [Перейдите](https://console.yandex.cloud/link/container-registry) в сервис **Container Registry**.
  1. Выберите [реестр](../../concepts/registry.md) или [репозиторий](../../concepts/repository.md) в нем.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В открывшемся окне выберите группу, пользователя или [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md).
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль из списка.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду, чтобы назначить роль на ресурс:

  ```bash
  yc container <ресурс> add-access-binding <имя_или_идентификатор_ресурса> \
    --role <роль> \
    --subject <тип_субъекта>:<идентификатор_субъекта>
  ```

  Где:

  * `<ресурс>` — тип ресурса `registry` (реестр) или `repository` (репозиторий);
  * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса, на который назначается роль;
  * `--role` — [роль](../../security/index.md#service-roles), которую необходимо назначить;
  * `--subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

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

  В примере ниже пользователю назначается роль `container-registry.admin` на реестр `my-first-registry`.

  ```bash
  yc container registry add-access-binding my-first-registry \
    --role container-registry.admin \
    --subject userAccount:ajeugsk5ubk6********
  ```

  Результат:

  ```text
  done (4s)
  ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле:
     * Параметры ресурса `yandex_container_registry_iam_binding`, чтобы назначить роль на [реестр](../../concepts/registry.md):

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
       * `registry_id` — идентификатор реестра, на который назначается роль. Чтобы узнать идентификатор реестра, [получите список реестров в каталоге](../registry/registry-list.md#registry-list).
       * `role` — [роль](../../security/index.md#service-roles), которую необходимо назначить.
       * `members` — список обозначений [субъектов](../../../iam/concepts/access-control/index.md#subject), которым назначается роль.

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
     
     * Параметры ресурса `yandex_container_repository_iam_binding`, чтобы назначить роль на [репозиторий](../../concepts/repository.md):

       ```
       resource "yandex_container_repository_iam_binding" "имя_репозитория" {
         repository_id = "<идентификатор_репозитория>"
         role          = "<роль>"
       
         members = [
           "<тип_субъекта>:<идентификатор_субъекта>",
         ]
       }
       ```

       Где:
       * `repository_id` — идентификатор репозитория, на который назначается роль. Чтобы узнать идентификатор репозитория, [получите список репозиториев в каталоге](../repository/repository-list.md#repository-list).
       * `role` — роль, которую необходимо назначить.
       * `members` — список обозначений субъектов, которым назначается роль.

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

     Подробнее о параметрах ресурса `yandex_container_repository_iam_binding` в [документации провайдера](../../../terraform/resources/container_repository_iam_binding.md).
  
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

  Проверить назначение роли можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

     * Для реестра:

       ```bash
       yc container registry list-access-bindings <имя_или_идентификатор_реестра>
       ```

     * Для репозитория:

       ```bash
       yc container repository list-access-bindings <имя_или_идентификатор_репозитория>
       ```

- API {#api}

  Чтобы назначить роль на реестр, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/UpdateAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md).

  Чтобы назначить роль на репозиторий, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Repository/updateAccessBindings.md) для ресурса [Repository](../../api-ref/Repository/index.md) или вызовом gRPC API [RepositoryService/UpdateAccessBindings](../../api-ref/grpc/Repository/updateAccessBindings.md).

  В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

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