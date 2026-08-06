[Документация Yandex Cloud](../../../index.md) > [Yandex Identity and Access Management](../../index.md) > [Пошаговые инструкции](../index.md) > [Роли](index.md) > Назначение роли

# Назначение роли

Чтобы предоставить доступ к ресурсу, назначьте на него [роль](../../concepts/access-control/roles.md). Ее могут получить:

* [пользователи с аккаунтом на Яндексе](../../concepts/users/accounts.md#passport);
* [локальные пользователи](../../concepts/users/accounts.md#local);
* [федеративные пользователи](../../concepts/users/accounts.md#saml-federation);
* [сервисные аккаунты](../../concepts/users/service-accounts.md);
* [группы пользователей](../../../organization/concepts/groups.md).

Роль можно назначить не только на сам ресурс, но и на его родительский ресурс, так как от него наследуются права доступа. Например, если сервисному аккаунту назначить роль на облако, этот сервисный аккаунт получит разрешения на все ресурсы во всех каталогах этого облака. Подробнее читайте в разделе [Как устроено управление доступом в Yandex Cloud](../../concepts/access-control/index.md).

Чтобы назначить роль на ресурс, нужна роль `admin` или `service-name.admin`, где `service-name`— название сервиса, на ресурс которого назначается роль.

[Узнайте](../../concepts/access-control/resources-with-access-control.md), на какие ресурсы можно назначать роли.

Чтобы выбрать роли, обратитесь к [их справочнику](../../roles-reference.md).

{% note info %}

Даже если [операция](../../../api-design-guide/concepts/about-async.md) с ресурсами [сервисов](../../../overview/concepts/services.md) Yandex Cloud разрешена [ролью](../../concepts/access-control/roles.md), ее выполнение может быть заблокировано, если для [организации](../../../organization/concepts/organization.md), [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) создана [политика авторизации](../../concepts/access-control/access-policies.md), запрещающая эту операцию.

{% endnote %}

## Назначить роль на каталог или облако {#cloud-or-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите облако или каталог.
   1. Перейдите на вкладку **Права доступа**.
   1. Нажмите кнопку **Настроить доступ**.
   1. Выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к облаку или каталогу.
   1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые роли.
   1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
   
   Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   Чтобы назначить роль на облако или каталог:

   1. Посмотрите описание команды CLI для назначения роли:

      ```bash
      yc resource-manager <cloud_или_folder> add-access-binding --help
      ```

      Укажите `cloud` для облака и `folder` для каталога.

   1. Получите список доступных облаков или каталогов вместе с их идентификаторами:

      ```bash
      yc resource-manager <cloud_или_folder> list
      ```

   1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md), [сервисного аккаунта](../sa/get-id.md), группы пользователей, организации или федерации удостоверений, которым или пользователем которых вы назначаете роль.
   1. Чтобы назначить роль, выполните команду:

      ```bash
      yc resource-manager <cloud_или_folder> add-access-binding \
        --id <идентификатор_облака_или_каталога> \
        --role <идентификатор_роли> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--id` — идентификатор ресурса, на который назначается роль.
      * `--role` — идентификатор роли, которую нужно назначить, например `resource-manager.clouds.owner`.
      * `--subject` — обозначение [субъекта](../../concepts/access-control/index.md#subject), которому назначается роль.

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

      Например, чтобы назначить сервисному аккаунту роль `viewer` на каталог:

      ```bash
      yc resource-manager folder add-access-binding \
        --id b1g672qpemb4******** \
        --role viewer \
        --subject serviceAccount:aje8m5luj4qf********
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры назначаемых ролей.

      Пример структуры конфигурационного файла:

      ```hcl
      // Назначение роли на облако
      resource "yandex_resourcemanager_cloud_iam_member" "cloud_member" {
        cloud_id = "<идентификатор_облака>"
        role     = "<роль>"
        member   = "<субъект>"
      }

      // Назначение роли на каталог
      resource "yandex_resourcemanager_folder_iam_member" "folder_member" {
        folder_id = "<идентификатор_каталога>"
        role      = "<роль>"
        member    = "<субъект>"
      }
      ```

      Где:

      * `cloud_id` — идентификатор облака. Получить список доступных облаков можно с помощью команды [CLI](../../../cli/quickstart.md): `yc resource-manager cloud list`. Обязательный параметр.
      * `folder_id` — идентификатор каталога. Получить список доступных каталогов можно с помощью команды [CLI](../../../cli/quickstart.md): `yc resource-manager cloud list`. Обязательный параметр.
      * `role` — роль, которую нужно назначить. Перечень ролей можно получить с помощью команды [CLI](../../../cli/quickstart.md): `yc iam role list`. В одном ресурсе можно назначить только одну роль. Обязательный параметр.
      * `member` — обозначение [субъекта](../../concepts/access-control/index.md#subject), которому назначается роль. Обязательный параметр.

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

      Подробнее о параметрах ресурсов в Terraform читайте в [документации провайдера](../../../terraform/tf-ref/overview.md).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
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

      После этого в организации будут созданы нужные ресурсы.

- API {#api}

   Чтобы назначить роль на облако, воспользуйтесь методом REST API [updateAccessBindings](../../../resource-manager/api-ref/Cloud/updateAccessBindings.md) для ресурса [Cloud](../../../resource-manager/api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/UpdateAccessBindings](../../../resource-manager/api-ref/grpc/Cloud/updateAccessBindings.md).

   Чтобы назначить роль на каталог, воспользуйтесь методом REST API [updateAccessBindings](../../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md).

   Передайте в запросе:

   * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор [субъекта](../../concepts/access-control/index.md#subject), которму назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, которому назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

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

## Назначить роль на организацию {#organization}

Чтобы выдать права доступа на организацию, вам нужна роль не ниже `organization-manager.admin`. Подробнее о последовательности ролей читайте в [документе Yandex Identity Hub](../../../organization/security/index.md#roles-list).

Чтобы назначить роль на организацию:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![persons-lock](../../../_assets/console-icons/persons-lock.svg) **Права доступа**.

  1. Если у нужного пользователя, сервисного аккаунта или группы пользователей уже есть хотя бы одна роль, в строке с этим пользователем, сервисным аккаунтом или группой нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите **Назначить роли**.

      Если нужного пользователя, сервисного аккаунта или группы пользователей нет в списке, в правом верхнем углу страницы нажмите кнопку **Назначить роли**. В открывшемся окне выберите нужного пользователя, сервисный аккаунт или группу из списка. При необходимости воспользуйтесь строкой поиска.

  1. Нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../concepts/access-control/roles.md), которую хотите назначить. Вы можете назначить несколько ролей.

      Описание доступных ролей можно найти в [справочнике ролей Yandex Cloud](../../roles-reference.md).

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
   
   Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   Чтобы назначить роль на организацию:

   1. Посмотрите описание команды CLI для назначения роли:

      ```bash
      yc organization-manager organization add-access-binding --help
      ```

   1. Получите список доступных организаций вместе с их идентификаторами:

      ```bash
      yc organization-manager organization list
      ```

   1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md), [сервисного аккаунта](../sa/get-id.md), группы пользователей, организации или федерации удостоверений, которым или пользователем которых вы назначаете роль.
   1. Чтобы назначить роль, выполните команду:

      ```bash
      yc organization-manager organization add-access-binding \
        --id <идентификатор_организации> \
        --role <идентификатор_роли> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--id` — идентификатор ресурса, на который назначается роль.
      * `--role` — идентификатор роли, которую нужно назначить, например `resource-manager.clouds.owner`.
      * `--subject` — обозначение [субъекта](../../concepts/access-control/index.md#subject), которому назначается роль.

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

      Например, чтобы назначить сервисному аккаунту роль `viewer` на организацию:

      ```bash
      yc organization-manager organization add-access-binding \
        --id org672qpemb4******** \
        --role viewer \
        --subject serviceAccount:aje8m5luj4qf********
      ```

- Terraform {#tf}

   Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   
   
   Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

   Чтобы назначить роль на организацию:

   1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md), [сервисного аккаунта](../sa/get-id.md) или группы пользователей, которым назначаете роль.
   1. Опишите в конфигурационном файле ресурс с ролью на организацию.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_organizationmanager_organization_iam_binding" "<название_ресурса>" {
        organization_id = "<идентификатор_организации>"
        role            = "<роль>"
        member          = "<субъект>"
      }
      ```

      Где:

      * `organization_id` — [идентификатор](../../../organization/operations/organization-get-id.md) организации. Обязательный параметр.
      * `role` — назначаемая роль. Для каждой роли можно использовать только один ресурс `yandex_organizationmanager_organization_iam_binding`. Обязательный параметр.
      * `member` — обозначение [субъекта](../../concepts/access-control/index.md#subject), которому назначается роль. Обязательный параметр.

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

      Подробнее читайте в [документации провайдера](../../../terraform/index.md).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
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

      После этого в организации будут созданы нужные ресурсы. Проверить их создание можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

      ```bash
      yc organization-manager organization list-access-bindings <имя_или_идентификатор_организации>
      ```

- API {#api}

   Чтобы назначить роль на организацию, воспользуйтесь методом REST API [updateAccessBindings](../../../organization/api-ref/Organization/updateAccessBindings.md) для ресурса [Organization](../../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UpdateAccessBindings](../../../organization/api-ref/grpc/Organization/updateAccessBindings.md) и передайте в запросе:

   * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор [субъекта](../../concepts/access-control/index.md#subject), которому назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, которому назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

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

## Назначить роль на ресурс {#resource}

Вы можете назначить роль не только на организацию, облако или каталог, но и на их дочерние ресурсы. Они перечислены в разделе [Ресурсы, на которые можно назначать роли](../../concepts/access-control/resources-with-access-control.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы назначить роль на ресурс:

   1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите каталог, в котором находится ресурс.
   1. Откройте его страницу.
   1. Перейдите в раздел ![image](../../../_assets/console-icons/persons.svg) **Права доступа** и нажмите кнопку **Назначить роли**.
   1. Выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к ресурсу.
   1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые роли.
   1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
   
   Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   Чтобы назначить роль на ресурс:

   1. Посмотрите описание команды CLI для назначения роли:

      ```bash
      yc <имя_сервиса> <ресурс> add-access-binding --help
      ```

      Пример для [виртуальной машины Yandex Compute Cloud](../../../compute/concepts/vm.md):

      ```bash
      yc compute instance add-access-binding --help
      ```

   1. Получите список ресурсов вместе с их идентификаторами:

      ```bash
      yc <имя_сервиса> <ресурс> list
      ```

   1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md), [сервисного аккаунта](../sa/get-id.md), группы пользователей, организации или федерации удостоверений, которым или пользователем которых вы назначаете роль.
   1. Чтобы назначить роль, выполните команду:

      ```bash
      yc <имя_сервиса> <ресурс> add-access-binding \
        --id <идентификатор_ресурса> \
        --role <идентификатор_роли> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--id` — идентификатор ресурса, на который назначается роль.
      * `--role` — идентификатор роли, которую нужно назначить, например `resource-manager.clouds.owner`.
      * `--subject` — обозначение [субъекта](../../concepts/access-control/index.md#subject), которому назначается роль.

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

      Например, чтобы назначить сервисному аккаунту роль `viewer` на виртуальную машину:

      ```bash
      yc compute instance add-access-binding \
        --id ins672qpemb4******** \
        --role viewer \
        --subject serviceAccount:aje8m5luj4qf********
      ```

- Terraform {#tf}

   Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   
   
   Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

   Чтобы назначить роль на организацию:

   1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md), [сервисного аккаунта](../sa/get-id.md) или группы пользователей, которым назначаете роль.
   1. Опишите в конфигурационном файле ресурс с ролью на организацию.

      Пример структуры конфигурационного файла для назначения роли на каталог:

      ```hcl
      resource "yandex_resourcemanager_folder_iam_member" "admin-account-iam" {
        folder_id   = "<идентификатор_каталога>"
        role        = "<роль>"
        member      = "<субъект>"
      }
      ```

      Где:

      * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md). Обязательный параметр.
      * `role` — назначаемая роль. Для каждой роли можно использовать только один ресурс `yandex_organizationmanager_organization_iam_binding`. Обязательный параметр.
      * `member` — обозначение [субъекта](../../concepts/access-control/index.md#subject), которому назначается роль. Обязательный параметр.

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

      Подробнее читайте в [документации провайдера](../../../terraform/index.md).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
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

      После этого в организации будут созданы нужные ресурсы. Проверить их создание можно в [консоли управления](https://console.yandex.cloud) или с помощью команд CLI.

- API {#api}

   Чтобы назначить роль на ресурс, воспользуйтесь методом REST API или вызовом gRPC API `updateAccessBindings` для нужного ресурса и передайте в запросе:

   * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор [субъекта](../../concepts/access-control/index.md#subject), которому назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, которому назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

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

## Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится ресурс.
   1. Откройте его страницу.
   1. Перейдите в раздел ![image](../../../_assets/console-icons/persons.svg) **Права доступа** и нажмите кнопку **Назначить роли**.
   1. Выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к ресурсу.
   1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые роли.
   1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

   {% note alert %}
   
   Команда `set-access-bindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
   
   {% endnote %}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
   
   Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   Чтобы назначить несколько ролей на ресурс:

   1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

      ```bash
      yc <имя_сервиса> <ресурс> list-access-bindings \
         --id <идентификатор_ресурса>
      ```

      Пример для [виртуальной машины Yandex Compute Cloud](../../../compute/concepts/vm.md):

      ```bash
      yc compute instance list-access-bindings \
         --id <идентификатор_ВМ>
      ```

   1. Посмотрите описание команды CLI для назначения ролей:

      ```bash
      yc <имя_сервиса> <ресурс> set-access-bindings --help
      ```

   1. Получите список ресурсов вместе с их идентификаторами:

      ```bash
      yc <имя_сервиса> <ресурс> list
      ```

   1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md), [сервисного аккаунта](../sa/get-id.md), группы пользователей, организации или федерации удостоверений, которым или пользователем которых вы назначаете роль.

   1. Чтобы назначить роль, выполните команду:

      ```bash
      yc <имя_сервиса> <ресурс> set-access-bindings \
        --id <идентификатор_ресурса> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--id` — идентификатор ресурса, на который назначается роль.
      * `role` — идентификатор роли, которую нужно назначить, например `resource-manager.clouds.owner`.
      * `subject` — обозначение [субъекта](../../concepts/access-control/index.md#subject), которому назначается роль.

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

      Для каждой роли передайте отдельный параметр `--access-binding`. Наример, чтобы назначить несколько ролей сервисному аккаунту на виртуальную машину:

      ```bash
      yc compute instance set-access-bindings \
         --id ins672qpemb4******** \
         --access-binding role=compute.disks.user,subject=<тип_субъекта>:aje8m5luj4qf******** \
         --access-binding role=compute.images.user,subject=<тип_субъекта>:aje8m5luj4qf******** \
         --access-binding role=compute.operator,subject=<тип_субъекта>:aje8m5luj4qf********
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры назначаемых ролей.

      Пример структуры конфигурационного файла для назначения нескольких ролей на облако:

      ```hcl
      resource "yandex_resourcemanager_cloud_iam_member" "cloud_member_1" {
        cloud_id = "<идентификатор_облака>"
        role     = "<роль_1>"
        members  = ["<субъект_1>","<субъект_2>,...,<субъект_n>"]
      }

      resource "yandex_resourcemanager_cloud_iam_member" "cloud_member_2" {
        cloud_id  = "<идентификатор_облака>"
        role      = "<роль_2>"
        members   = ["<субъект_1>","<субъект_2>,...,<субъект_n>"]
      }
      ```

      Где:

      * `cloud_id` — идентификатор облака. Получить список доступных облаков можно с помощью команды [CLI](../../../cli/quickstart.md): `yc resource-manager cloud list`. Обязательный параметр.
      * `role` — роль, которую нужно назначить. Перечень ролей можно получить с помощью команды [CLI](../../../cli/quickstart.md): `yc iam role list`. В одном ресурсе `yandex_resourcemanager_cloud_iam_member` можно назначить только одну роль. Обязательный параметр.
      * `members` — обозначения [субъектов](../../concepts/access-control/index.md#subject), которым назначается роль. Обязательный параметр.

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

      Подробнее о параметрах ресурсов в Terraform читайте в [документации провайдера](../../../terraform/tf-ref/overview.md).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
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

      После этого в организации будут созданы нужные ресурсы.

- API {#api}

   {% note alert %}
   
   Метод `setAccessBindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
   
   {% endnote %}

   Чтобы назначить несколько ролей на ресурс, воспользуйтесь методом REST API или вызовом gRPC API `setAccessBindings` для нужного ресурса. Передайте в запросе массив из объектов, каждый из которых соответствует отдельной роли и содержит следующие данные:

   * Роль в параметре `accessBindings[].roleId`.
   * Идентификатор [субъекта](../../concepts/access-control/index.md#subject), на кого назначаются роли, в параметре `accessBindings[].subject.id`.
   * Тип субъекта, на кого назначаются роли, в параметре `accessBindings[].subject.type`.

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