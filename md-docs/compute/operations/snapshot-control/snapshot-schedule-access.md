[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Снимки > Настроить права доступа к расписанию снимков

# Настроить права доступа к расписанию снимков диска

Чтобы предоставить пользователю, группе или [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) доступ к [расписанию снимков диска](../../concepts/snapshot-schedule.md), назначьте на него [роль](../../../iam/concepts/access-control/roles.md).

## Назначить роль {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит расписание.
  1. [Перейдите](https://console.yandex.cloud/link/compute) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **Снимки дисков**.
  1. Перейдите на вкладку **Расписания снимков**.
  1. Выберите расписание из списка.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к расписанию.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые [роли](../../security/index.md#roles-list).
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для назначения роли на расписание снимков диска:

     ```bash
     yc compute snapshot-schedule add-access-binding --help
     ```

  1. Получите список расписаний в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute snapshot-schedule list
     ```
     
     Результат:
     
     ```text
     +----------------------+-----------------+--------+-------------+
     |          ID          |      NAME       | STATUS | DESCRIPTION |
     +----------------------+-----------------+--------+-------------+
     | fd85vvoeea6u******** | first-schedule  | ACTIVE |             |
     | fd14ogykea8j******** | second-schedule | ACTIVE |             |
     +----------------------+-----------------+--------+-------------+
     ```

  1. Посмотрите список ролей, которые уже назначены на ресурс:

     ```bash
     yc compute snapshot-schedule list-access-bindings <идентификатор_расписания>
     ```

  1. Назначьте роль с помощью команды:

     ```bash
     yc compute snapshot-schedule add-access-binding <идентификатор_расписания> \
       --role <роль>
       --subject <тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--role` — назначаемая [роль](../../security/index.md#roles-list).
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

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы назначить роль на расписание с помощью Terraform:

  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_snapshot_schedule_iam_binding" "sa-access" {
        snapshot_schedule_id = "<идентификатор_расписания>"
        role                 = "<роль>"
        members              = ["<тип_субъекта>:<идентификатор_субъекта>","<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `snapshot_schedule_id` — идентификатор расписания.
      * `role` — назначаемая [роль](../../security/index.md#roles-list).
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

      Более подробную информацию о параметрах ресурса `yandex_compute_snapshot_schedule_iam_binding` читайте в [документации провайдера](../../../terraform/resources/compute_snapshot_schedule_iam_binding.md).

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

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud) и с помощью команды [CLI](../../../cli/index.md):

      ```bash
      yc compute snapshot-schedule list-access-bindings <идентификатор_расписания>
      ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/SnapshotSchedule/updateAccessBindings.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызовом gRPC API [SnapshotSchedule/UpdateAccessBindings](../../api-ref/grpc/SnapshotSchedule/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

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

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит расписание.
  1. [Перейдите](https://console.yandex.cloud/link/compute) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **Снимки дисков**.
  1. Перейдите на вкладку **Расписания снимков**.
  1. Выберите расписание из списка.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к расписанию.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые [роли](../../security/index.md#roles-list).
  1. Добавьте еще роль через кнопку **Добавить роль**.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% note alert %}
  
  Команда `set-access-bindings` полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
  
  {% endnote %}

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

     ```bash
     yc compute snapshot-schedule list-access-bindings <идентификатор_расписания>
     ```

  1. Посмотрите описание команды CLI для назначения ролей на расписание снимков диска:

     ```bash
     yc compute snapshot-schedule set-access-bindings --help
     ```

  1. Назначьте роли:

     ```bash
     yc compute snapshot-schedule set-access-bindings <идентификатор_расписания> \
       --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
     ```

     Где `--access-binding` — назначаемая роль:

     * `role` — идентификатор назначаемой роли.
     * `subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

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

     Например, назначьте роли нескольким пользователям и сервисному аккаунту:

     ```bash
     yc compute snapshot-schedule set-access-bindings my-schedule \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh******** \
       --access-binding role=viewer,subject=userAccount:helj89sfj80a******** \
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы назначить несколько ролей на расписание с помощью Terraform:

  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_snapshot_schedule_iam_binding" "role-1" {
        snapshot_schedule_id = "<идентификатор_расписания>"
        role                 = "<роль_1>"
        members              = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }

      resource "yandex_compute_snapshot_schedule_iam_binding" "role-2" {
        snapshot_schedule_id = "<идентификатор_расписания>"
        role                 = "<роль_2>"
        members              = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `snapshot_schedule_id` — идентификатор расписания.
      * `role` — назначаемая [роль](../../security/index.md#roles-list).
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

      Более подробную информацию о параметрах ресурса `yandex_compute_snapshot_schedule_iam_binding` читайте в [документации провайдера](../../../terraform/resources/compute_snapshot_schedule_iam_binding.md).

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

      Проверить изменения можно в [консоли управления](https://console.yandex.cloud) и с помощью команды [CLI](../../../cli/index.md):

      ```bash
      yc compute snapshot-schedule list-access-bindings <идентификатор_расписания>
      ```

- API {#api}

  Воспользуйтесь методом REST API [setAccessBindings](../../api-ref/SnapshotSchedule/setAccessBindings.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызовом gRPC API [SnapshotSchedule/SetAccessBindings](../../api-ref/grpc/SnapshotSchedule/setAccessBindings.md). В теле запроса в свойстве `subject` укажите тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

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

## Отозвать роль {#revoke-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит расписание.
  1. [Перейдите](https://console.yandex.cloud/link/compute) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **Снимки дисков**.
  1. Перейдите на вкладку **Расписания снимков**.
  1. Выберите расписание из списка.
  1. Перейдите на вкладку **Права доступа**.
  1. В строке нужного пользователя нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите **Изменить роли**.
  1. Нажмите значок ![cross](../../../_assets/console-icons/xmark.svg) рядом с ролью, чтобы удалить ее.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для отзыва роли на расписание снимков диска:

     ```bash
     yc compute snapshot-schedule remove-access-binding --help
     ```

  1. Посмотрите, кому и какие роли назначены на ресурс:

     ```bash
     yc compute snapshot-schedule list-access-bindings <идентификатор_расписания>
     ```

  1. Чтобы отозвать права доступа, выполните команду:

      ```bash
      yc compute snapshot-schedule remove-access-binding <идентификатор_расписания> \
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

      Например, чтобы отозвать роль `viewer` у пользователя с идентификатором `ajel6l0jcb9s********` на расписание:

      ```bash
      yc compute snapshot-schedule remove-access-binding my-schedule \
        --role viewer \
        --subject userAccount:ajel6l0jcb9s********
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы отозвать роль, назначенную на расписание снимков диска с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием роли:

      ```hcl
      ...
      resource "yandex_compute_snapshot_schedule_iam_binding" "sa-access" {
        snapshot_schedule_id = "<идентификатор_расписания>"
        role                 = "<роль>"
        members              = ["<тип_субъекта>:<идентификатор_субъекта>"]
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

      Проверить изменения можно в [консоли управления](https://console.yandex.cloud) и с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc compute snapshot-schedule list-access-bindings <идентификатор_расписания>
      ```

- API {#api}

  Чтобы отозвать роли на расписание снимков диска, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/SnapshotSchedule/updateAccessBindings.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызовом gRPC API [SnapshotScheduleService/UpdateAccessBindings](../../api-ref/grpc/SnapshotSchedule/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

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