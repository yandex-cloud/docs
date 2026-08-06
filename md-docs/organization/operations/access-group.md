[Документация Yandex Cloud](../../index.md) > [Yandex Identity Hub](../index.md) > [Пошаговые инструкции](index.md) > Управление группами пользователей > Назначить права доступа группе

# Назначить роль на всю организацию

Чтобы участники группы могли работать с ресурсами Yandex Cloud в организации, назначьте группе соответствующие [роли](../../iam/concepts/access-control/roles.md).

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **Права доступа**.
  1. Справа сверху нажмите кнопку **Назначить роли**.
  1. Перейдите на вкладку **Группы** и выберите [группу](../concepts/groups.md) или воспользуйтесь поиском по названию группы.

      Вы также можете назначить роль одной из [системных](../../iam/concepts/access-control/system-group.md) групп:

      * `All users in organization X` — в группу входят все пользователи организации `X`.
      * `All users in federation N` — в группу входят все пользователи федерации `N`.

  1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../iam/concepts/access-control/roles.md), которую хотите назначить группе на организацию. Вы можете назначить несколько ролей.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Назначьте [роль](../../iam/concepts/access-control/roles.md) [группе](../concepts/groups.md) на организацию:

      ```bash
      yc organization-manager organization add-access-binding \
        --id <идентификатор_организации> \
        --role <идентификатор_роли> \
        --subject group:<идентификатор_группы>
      ```

      Где:

      * `--id` — идентификатор организации, на которую назначается роль.
      * `--role` — идентификатор роли, которую нужно назначить.
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

  1. Проверьте, что запрошенные права были выданы:

      ```bash
      yc organization-manager organization list-access-bindings <идентификатор_организации>
      ```

      Ответ содержит список всех ролей, выданных пользователям и группам в организации:

      ```text
      +------------------------------------------+--------------+----------------------+
      |                 ROLE ID                  | SUBJECT TYPE |      SUBJECT ID      |
      +------------------------------------------+--------------+----------------------+
      | organization-manager.admin               | userAccount  | ajev1p2345lj******** |
      | organization-manager.organizations.owner | userAccount  | ajev1p2345lj******** |
      | editor                                   | group        | ajev1p2345lj******** |
      | viewer                                   | group        | ajev1p2345lj******** |
      +------------------------------------------+--------------+----------------------+
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Добавьте в конфигурационный файл параметры ресурса, укажите нужную [роль](../../iam/concepts/access-control/roles.md) и [группу](../concepts/groups.md):

     ```hcl
     resource "yandex_organizationmanager_organization_iam_member" "users-editors" {
       organization_id = "<идентификатор_организации>"
       role            = "<идентификатор_роли>"
       member          = "group:<идентификатор_группы>"
     }
     ```

     Где:
     
     * `organization_id` — [идентификатор организации](organization-get-id.md). Обязательный параметр.
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

     Подробнее о параметрах ресурса `yandex_organizationmanager_organization_iam_member` читайте в [документации провайдера](../../terraform/resources/organizationmanager_organization_iam_member.md).

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

     После этого будут назначены указанные права доступа. Проверить назначение роли можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     yc organization-manager organization list-access-bindings <идентификатор_организации>
     ```

- API {#api}

  Чтобы назначить роль группе пользователей на организацию, воспользуйтесь методом REST API [updateAccessBindings](../api-ref/Organization/updateAccessBindings.md) для ресурса [Organization](../api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UpdateAccessBindings](../api-ref/grpc/Organization/updateAccessBindings.md) и передайте в запросе:

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