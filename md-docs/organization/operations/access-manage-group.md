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

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

    1. Получите [идентификатор пользователя](users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, которым назначаете роль.
    1. С помощью команды `yc organization-manager group add-access-binding` назначьте роль:

        ```bash
        yc organization-manager group add-access-binding \
          --id <идентификатор_группы> \
          --role <роль> \
          --user-account-id <идентификатор_пользователя> \
          --federation-users <идентификатор_пользователя> \
          --service-account-id <идентификатор_сервисного_аккаунта> \
          --subject group:<идентификатор_группы>
        ```

        Где:

        * `--id` — идентификатор группы пользователей.
        * `--role` — идентификатор роли.

        Идентификатор объекта, которому назначается роль:

        * `--user-account-id` — идентификатор аккаунта на Яндексе.
        * `--federation-users` — идентификатор федеративного пользователя.
        * `--service-account-id` — идентификатор сервисного аккаунта.
        * `--subject group` — идентификатор группы.

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры назначаемых ролей:

      ```hcl
      resource "yandex_organizationmanager_group_iam_binding" "editor" {
        group_id = "<идентификатор_группы>"
        role     = "<идентификатор_роли>"
        members  = [
          "userAccount:<идентификатор_пользователя>",
        ]
      }
      ```

      Где:

      * `group_id` — [идентификатор группы пользователей](group-get-id.md).
      * `role` — роль, которую хотите назначить. Для каждой роли можно использовать только один `yandex_organizationmanager_group_iam_binding`.
      * `members` — массив идентификаторов пользователей, которым будет назначена роль:

        * `userAccount:<идентификатор_пользователя>` — идентификатор аккаунта пользователя на Яндексе или локального пользователя.
        * `federatedUser:<идентификатор_пользователя>` — идентификатор федеративного пользователя.
        * `serviceAccount:<идентификатор_сервисного_аккаунта>` — идентификатор сервисного аккаунта.
        * `group:<идентификатор_группы>` — идентификатор группы пользователей.

      Подробнее о ресурсах, которые вы можете создать с помощью Terraform, читайте в [документации провайдера](../../terraform/index.md).

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
   
  После этого указанным пользователям будут назначены роли на группу пользователей. Проверить появление роли можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization).

- API {#api}

   Воспользуйтесь методом [updateAccessBindings](../api-ref/Group/updateAccessBindings.md) для ресурса [Group](../api-ref/Group/index.md) или вызовом gRPC API [GroupService/UpdateAccessBindings](../api-ref/grpc/Group/updateAccessBindings.md) и передайте в запросе:

   * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор субъекта, на кого назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, на кого назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

{% endlist %}

## Назначить несколько ролей {#set-access-bindings}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **Группы** и нажмите строку с названием [группы](../concepts/groups.md).
  
  1. Перейдите на вкладку **Права доступа к группе**.

  1. Нажмите кнопку **Назначить роли**.
  
  1. Выберите пользователя или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которому нужно предоставить доступ к группе. При необходимости воспользуйтесь поиском.
  
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роли, которые нужно назначить на группу.

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

   {% note alert %}
   
   Команда `set-access-bindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
   
   {% endnote %}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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
   1. Получите [идентификатор пользователя](users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или [группы пользователей](group-get-id.md), которым назначаете роли.

   1. С помощью команды `yc organization-manager group set-access-bindings` назначьте роли:

      * Пользователю с аккаунтом на Яндексе или локальному пользователю:

         ```bash
         yc organization-manager group set-access-bindings \
           --id <идентификатор_группы> \
           --access-binding role=<роль>,user-account-id=<идентификатор_пользователя>
         ```

      * Федеративному пользователю:

         ```bash
         yc organization-manager group set-access-bindings \
           --id <идентификатор_группы> \
           --access-binding role=<роль>,subject=federatedUser:<идентификатор_пользователя>
         ```

      * Сервисному аккаунту:

         ```bash
         yc organization-manager group set-access-bindings \
           --id <идентификатор_группы> \
           --access-binding role=<роль>,service-account-id=<идентификатор_сервисного_аккаунта>
         ```

      * Группе пользователей:

         ```bash
         yc organization-manager group set-access-bindings \
           --id <идентификатор_группы> \
           --access-binding role=<роль>,subject=group:<идентификатор_группы>
         ```

      Для каждой роли передайте отдельный параметр `--access-binding`. Пример:

      ```bash
      yc organization-manager group set-access-bindings \
        --id <идентификатор_группы> \
        --access-binding role=<роль1>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль2>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль3>,service-account-id=<идентификатор_сервисного_аккаунта>
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы назначить несколько ролей на группу пользователей:

  1. Опишите в конфигурационном файле параметры назначаемых ролей:

      ```hcl
      resource "yandex_organizationmanager_group_iam_binding" "role1" {
        group_id = "<идентификатор_группы>"
        role     = "<роль1>"
        members  = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }

      resource "yandex_organizationmanager_group_iam_binding" "role2" {
        group_id = "<идентификатор_группы>"
        role     = "<роль2>"
        members  = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }

      resource "yandex_organizationmanager_group_iam_binding" "role3" {
        group_id = "<идентификатор_группы>"
        role     = "<роль3>"
        members  = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `group_id` — [идентификатор группы пользователей](group-get-id.md).
      * `role` — роль, которую хотите назначить. Для каждой роли можно использовать только один `yandex_organizationmanager_group_iam_binding`.
      * `members` — массив идентификаторов пользователей, которым будет назначена роль:

        * `userAccount:<идентификатор_пользователя>` — идентификатор аккаунта пользователя на Яндексе или локального пользователя.
        * `federatedUser:<идентификатор_пользователя>` — идентификатор федеративного пользователя.
        * `serviceAccount:<идентификатор_сервисного_аккаунта>` — идентификатор сервисного аккаунта.
        * `group:<идентификатор_группы>` — идентификатор группы пользователей.

      Подробнее о ресурсах, которые вы можете создать с помощью Terraform, читайте в [документации провайдера](../../terraform/index.md).

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
   
  После этого указанному пользователю будут назначены несколько ролей на группу пользователей. Проверить появление ролей можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization).

- API {#api}

   {% note alert %}
   
   Метод `setAccessBindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
   
   {% endnote %}

   Воспользуйтесь методом [setAccessBindings](../api-ref/Group/setAccessBindings.md) для ресурса [Group](../api-ref/Group/index.md) или вызовом gRPC API [GroupService/SetAccessBindings](../api-ref/grpc/Group/setAccessBindings.md). Передайте в запросе массив из объектов, каждый из которых соответствует отдельной роли и содержит следующие данные:

   * Роль в параметре `accessBindings[].roleId`.
   * Идентификатор субъекта, на кого назначаются роли, в параметре `accessBindings[].subject.id`.
   * Тип субъекта, на кого назначаются роли, в параметре `accessBindings[].subject.type`.

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

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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
   1. С помощью команды `yc organization-manager group remove-access-binding` отзовите роль у объекта:

         ```bash
         yc organization-manager group remove-access-binding \
           --id <идентификатор_группы> \
           --role <роль> \
           --user-account-id <идентификатор_пользователя> \
           --federation-users <идентификатор_пользователя> \
           --service-account-id <идентификатор_сервисного_аккаунта> \
           --subject group:<идентификатор_группы>
         ```

         Где:

         * `--id` — идентификатор группы пользователей.
         * `--role` — идентификатор роли.
         
         Идентификатор объекта, у которого отзывается роль:
         
         * `--user-account-id` — идентификатор аккаунта на Яндексе.
         * `--federation-users` — идентификатор федеративного пользователя.
         * `--service-account-id` — идентификатор сервисного аккаунта.
         * `--subject group` — идентификатор группы.

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы отозвать роль у пользователя, сервисного аккаунта или группы пользователей:

  1. Откройте конфигурационный файл Terraform и удалите фрагмент с ресурсом `yandex_organizationmanager_group_iam_binding`, соответствующим роли, которую хотите отозвать.

      ```hcl
      resource "yandex_organizationmanager_group_iam_binding" "editor" {
        group_id = "<идентификатор_группы>"
        role     = "<идентификатор_роли>"
        members  = [
          "<тип_субъекта>:<идентификатор_субъекта>",
        ]
      }
      ```

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

   Воспользуйтесь методом [updateAccessBindings](../api-ref/Group/updateAccessBindings.md) для ресурса [Group](../api-ref/Group/index.md) или вызовом gRPC API [GroupService/UpdateAccessBindings](../api-ref/grpc/Group/updateAccessBindings.md) и передайте в запросе:

   * Значение `REMOVE` в параметре `accessBindingDeltas[].action`, чтобы отозвать роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор субъекта, у кого отзывается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, у которого отзывается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

{% endlist %}