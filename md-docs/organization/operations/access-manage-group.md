[Документация Yandex Cloud](../../index.md) > [Yandex Identity Hub](../index.md) > [Пошаговые инструкции](index.md) > Управление группами пользователей > Настроить доступ к управлению группой

# Настроить доступ к управлению группой

Вы можете предоставить доступ к группе пользователей:

* [пользователям с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport);
* [федеративным пользователям](../../iam/concepts/users/accounts.md#saml-federation);
* [локальным пользователям](../../iam/concepts/users/accounts.md#local);
* [сервисным аккаунтам](../../iam/concepts/users/service-accounts.md);
* другим [группам пользователей](../concepts/groups.md).

Для этого назначьте [роли](../../iam/concepts/access-control/roles.md) на группу. Чтобы выбрать нужные, [узнайте](../security/index.md#roles-list), какие роли действуют в сервисе.

## Назначить роль {#add-access-binding}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **Группы** и нажмите строку с названием нужной [группы](../concepts/groups.md).
  1. Перейдите на вкладку **Права доступа к группе**.
  1. Нажмите кнопку **Назначить роли**.
  1. Выберите группу, пользователя или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которым нужно предоставить доступ к группе. При необходимости воспользуйтесь поиском.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роли, которые нужно назначить на группу.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
    
    Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы выдать права доступа на группу пользователей:

    1. Посмотрите описание команды CLI для назначения роли:

        ```bash
        yc organization-manager group add-access-binding --help
        ```

    1. Получите список групп пользователей вместе с идентификаторами этих групп:

        ```bash
        yc organization-manager group list \
          --organization-id <идентификатор_организации>
        ```

    1. Получите [идентификатор пользователя](users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, которым нужно предоставить доступ к группе.
    1. С помощью команды `yc organization-manager group add-access-binding` назначьте роль:

        ```bash
        yc organization-manager group add-access-binding \
          --id <идентификатор_группы> \
          --role <роль> \
          --subject <тип_субъекта>:<идентификатор_субъекта>
        ```

        Где:

        * `--id` — идентификатор группы пользователей, к которой нужно предоставить доступ.
        * `--role` — идентификатор роли.
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

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Получите [идентификатор пользователя](users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, которым нужно предоставить доступ к группе.
  1. Опишите в конфигурационном файле параметры назначаемых ролей:

      ```hcl
      resource "yandex_organizationmanager_group_iam_member" "editor" {
        group_id = "<идентификатор_группы>"
        role     = "<идентификатор_роли>"
        member   = "<субъект>"
      }
      ```

      Где:

      * `group_id` — [идентификатор группы пользователей](group-get-id.md).
      * `role` — назначаемая роль. Обязательный параметр.
      * `member` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль. Обязательный параметр.

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

      Подробнее о параметрах ресурса `yandex_organizationmanager_group_iam_member` читайте в [документации провайдера](../../terraform/resources/organizationmanager_group_iam_member.md).

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

  После этого указанным субъектам будут назначены роли на группу пользователей. Проверить назначение роли можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization).

- API {#api}

   Чтобы назначить роль субъекту на группу пользователей, воспользуйтесь методом REST API [updateAccessBindings](../api-ref/Group/updateAccessBindings.md) для ресурса [Group](../api-ref/Group/index.md) или вызовом gRPC API [GroupService/UpdateAccessBindings](../api-ref/grpc/Group/updateAccessBindings.md) и передайте в запросе:

   * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
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

## Назначить несколько ролей {#set-access-bindings}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **Группы** и нажмите строку с названием [группы](../concepts/groups.md).
  1. Перейдите на вкладку **Права доступа к группе**.
  1. Нажмите кнопку **Назначить роли**.
  1. Выберите пользователя, группу или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которым нужно предоставить доступ к группе. При необходимости воспользуйтесь поиском.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роли, которые нужно назначить на группу.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  {% note alert %}
  
  Команда `set-access-bindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
  
  {% endnote %}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы назначить несколько ролей на группу пользователей:

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

      ```bash
      yc organization-manager group list-access-bindings \
        --id <идентификатор_группы>
      ```

  1. Посмотрите описание команды CLI для назначения ролей:

      ```bash
      yc organization-manager group set-access-bindings --help
      ```

  1. Получите список групп пользователей вместе с идентификаторами этих групп:

      ```bash
      yc organization-manager group list
      ```

  1. Получите [идентификатор пользователя](users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или [группы пользователей](group-get-id.md), которым нужно предоставить доступ к группе.
  1. С помощью команды `yc organization-manager group set-access-bindings` назначьте роли:

      ```bash
      yc organization-manager group set-access-bindings \
        --id <идентификатор_группы> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--id` — идентификатор группы пользователей, к которой нужно предоставить доступ.
      * `role` — идентификатор роли, которую нужно назначить.
      * `subject` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

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
      yc organization-manager group set-access-bindings \
        --id ins672qpemb4******** \
        --access-binding role=<роль1>,subject=serviceAccount:<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль2>,subject=serviceAccount:<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль3>,subject=serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы назначить несколько ролей на группу пользователей:

  1. Опишите в конфигурационном файле параметры назначаемых ролей:

      ```hcl
      resource "yandex_organizationmanager_group_iam_member" "role1" {
        group_id = "<идентификатор_группы>"
        role     = "<роль1>"
        member   = "<тип_субъекта>:<идентификатор_субъекта>"
      }

      resource "yandex_organizationmanager_group_iam_member" "role2" {
        group_id = "<идентификатор_группы>"
        role     = "<роль2>"
        member   = "<тип_субъекта>:<идентификатор_субъекта>"
      }

      resource "yandex_organizationmanager_group_iam_member" "role3" {
        group_id = "<идентификатор_группы>"
        role     = "<роль3>"
        member   = "<тип_субъекта>:<идентификатор_субъекта>"
      }
      ```

      Где:

      * `group_id` — [идентификатор группы пользователей](group-get-id.md).
      * `role` — роль, которую хотите назначить.
      * `member` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

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

      Подробнее о параметрах ресурса `yandex_organizationmanager_group_iam_member` читайте в [документации провайдера](../../terraform/resources/organizationmanager_group_iam_member.md).

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

  После этого указанному субъекту будут назначены несколько ролей на группу пользователей. Проверить назначение ролей можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization).

- API {#api}

  {% note alert %}
  
  Метод `setAccessBindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
  
  {% endnote %}

  Чтобы назначить несколько ролей субъекту на группу пользователей, воспользуйтесь методом REST API [setAccessBindings](../api-ref/Group/setAccessBindings.md) для ресурса [Group](../api-ref/Group/index.md) или вызовом gRPC API [GroupService/SetAccessBindings](../api-ref/grpc/Group/setAccessBindings.md). Передайте в запросе массив из объектов, каждый из которых соответствует отдельной роли и содержит следующие данные:

  * Роль в параметре `accessBindings[].roleId`.
  * Идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначаются роли, в параметре `accessBindings[].subject.id`.
  * Тип субъекта, которому назначаются роли, в параметре `accessBindings[].subject.type`.

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

## Отозвать роль {#remove-access-binding}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **Группы** и нажмите строку с названием [группы](../concepts/groups.md).
  1. Перейдите на вкладку **Права доступа к группе**.
  1. Чтобы отозвать определенные роли:

      1. В строке с нужным пользователем, сервисным аккаунтом или группой нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Настроить доступ**.
      1. Нажмите ![image](../../_assets/console-icons/xmark.svg) напротив ролей, которые вы хотите отозвать.
      1. Нажмите **Сохранить**.

  1. Чтобы отозвать все роли, в строке с нужным пользователем, сервисным аккаунтом или группой нажмите ![image](../../_assets/console-icons/ellipsis.svg), выберите ![TrashBin](../../_assets/console-icons/trash-bin.svg) **Отозвать доступ** и подтвердите действие.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для отзыва роли:

      ```bash
      yc organization-manager group remove-access-binding --help
      ```

  1. Получите список групп пользователей вместе с идентификаторами этих групп:

      ```bash
      yc organization-manager group list \
        --organization-id <идентификатор_организации>
      ```

  1. Получите [идентификатор пользователя](users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, у которых отзываете роль.
  1. С помощью команды `yc organization-manager group remove-access-binding` отзовите роль у субъекта:

      ```bash
      yc organization-manager group remove-access-binding \
        --id <идентификатор_группы> \
        --role <роль> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--id` — идентификатор группы пользователей, к которой был предоставлен доступ.
      * `--role` — идентификатор роли, которую нужно отозвать.
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

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы отозвать роль у пользователя, сервисного аккаунта или группы пользователей:

  1. Откройте конфигурационный файл Terraform и удалите фрагмент с ресурсом `yandex_organizationmanager_group_iam_member`, соответствующим роли, которую хотите отозвать.

      ```hcl
      resource "yandex_organizationmanager_group_iam_member" "editor" {
        group_id = "<идентификатор_группы>"
        role     = "<идентификатор_роли>"
        member   = "<тип_субъекта>:<идентификатор_субъекта>"
      }
      ```

      Где:

      * `group_id` — [идентификатор группы пользователей](group-get-id.md).
      * `role` — отзываемая роль. Обязательный параметр.
      * `member` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль. Обязательный параметр.

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

  1. Примените изменения:

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

  После этого роль будет отозвана у указанного субъекта. Проверить отсутствие роли можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization).

- API {#api}

   Чтобы отозвать роль у субъекта на группу пользователей, воспользуйтесь методом REST API [updateAccessBindings](../api-ref/Group/updateAccessBindings.md) для ресурса [Group](../api-ref/Group/index.md) или вызовом gRPC API [GroupService/UpdateAccessBindings](../api-ref/grpc/Group/updateAccessBindings.md) и передайте в запросе:

   * Значение `REMOVE` в параметре `accessBindingDeltas[].action`, чтобы отозвать роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, у которого отзывается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

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