[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Диски > Управление > Настроить права доступа к диску

# Настроить права доступа к диску

Чтобы предоставить пользователю, группе или [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) доступ к [диску](../../concepts/disk.md), назначьте на него [роль](../../../iam/concepts/access-control/roles.md).

## Назначить роль {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит диск.
  1. [Перейдите](https://console.yandex.cloud/link/compute) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **Диски и хранилища**.
  1. Выберите диск из списка.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к диску.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые [роли](../../security/index.md#roles-list).
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для назначения роли на диск:

     ```bash
     yc compute disk add-access-binding --help
     ```

  1. Получите список дисков в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute disk list
     ```
     
     Результат:
     
     ```text
     +----------------------+-------------+-------------+-------------------+--------+----------------------+-----------------+-------------+
     |          ID          |     NAME    |    SIZE     |       ZONE        | STATUS |     INSTANCE IDS     | PLACEMENT GROUP | DESCRIPTION |
     +----------------------+-------------+-------------+-------------------+--------+----------------------+-----------------+-------------+
     | epd557pch3uk******** | first-disk  | 68719476736 | ru-central1-a | READY  | epd5ieqbii7l******** |                 |             |
     | epdusilqgq3m******** | second-disk | 68719476736 | ru-central1-a | READY  | epd37ebcdf36******** |                 |             |
     +----------------------+-------------+-------------+-------------------+--------+----------------------+-----------------+-------------+
     ```

  1. Посмотрите список ролей, которые уже назначены на ресурс:

     ```bash
     yc compute disk list-access-bindings <идентификатор_диска>
     ```

  1. Назначьте роль с помощью команды:

     ```bash
     yc compute disk add-access-binding <идентификатор_диска> \
       --role <роль> \
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

  Чтобы назначить роль на диск с помощью Terraform:

  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_disk_iam_binding" "sa-access" {
        disk_id = "<идентификатор_диска>"
        role    = "<роль>"
        members = ["<тип_субъекта>:<идентификатор_субъекта>","<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `disk_id` — идентификатор диска.
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

      Более подробную информацию о параметрах ресурса `yandex_compute_disk_iam_binding` читайте в [документации провайдера](../../../terraform/resources/compute_disk_iam_binding.md).

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

      Terraform создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

      ```bash
      yc compute disk list-access-bindings <идентификатор_диска>
      ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Disk/updateAccessBindings.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/UpdateAccessBindings](../../api-ref/grpc/Disk/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

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

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит диск.
  1. [Перейдите](https://console.yandex.cloud/link/compute) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **Диски и хранилища**.
  1. Выберите диск из списка.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к диску.
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
     yc compute disk list-access-bindings <идентификатор_диска>
     ```

  1. Посмотрите описание команды CLI для назначения ролей на диск:

     ```bash
     yc compute disk set-access-bindings --help
     ```

  1. Назначьте роли:

     ```bash
     yc compute disk set-access-bindings <идентификатор_диска> \
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
     yc compute disk set-access-bindings my-disk \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh******** \
       --access-binding role=viewer,subject=userAccount:helj89sfj80a******** \
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы назначить несколько ролей на диск с помощью Terraform:

  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_disk_iam_binding" "role1" {
        disk_id = "<идентификатор_диска>"
        role    = "<роль_1>"
        members = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }

      resource "yandex_compute_disk_iam_binding" "role2" {
        disk_id = "<идентификатор_диска>"
        role    = "<роль_2>"
        members = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `disk_id` — идентификатор диска.
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

      Более подробную информацию о параметрах ресурса `yandex_compute_disk_iam_binding` читайте в [документации провайдера](../../../terraform/resources/compute_disk_iam_binding.md).

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

      Terraform создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

      ```bash
      yc compute disk list-access-bindings <идентификатор_диска>
      ```

- API {#api}

  Воспользуйтесь методом REST API [setAccessBindings](../../api-ref/Disk/setAccessBindings.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/SetAccessBindings](../../api-ref/grpc/Disk/setAccessBindings.md). В теле запроса в свойстве `subject` укажите тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

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

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит диск.
  1. [Перейдите](https://console.yandex.cloud/link/compute) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **Диски и хранилища**.
  1. Выберите диск из списка.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В строке нужного пользователя нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите **Изменить роли**.
  1. Нажмите значок ![cross](../../../_assets/console-icons/xmark.svg) рядом с ролью, чтобы удалить ее.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для отзыва роли на диск:

     ```bash
     yc compute disk remove-access-binding --help
     ```

  1. Посмотрите, кому и какие роли назначены на ресурс:

     ```bash
     yc compute disk list-access-bindings <идентификатор_диска>
     ```

  1. Чтобы отозвать права доступа, выполните команду:

     ```bash
     yc compute disk remove-access-binding <идентификатор_диска> \
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

     Например, чтобы отозвать роль `viewer` у пользователя с идентификатором `ajel6l0jcb9s********` на диск:

     ```bash
     yc compute disk remove-access-binding my-disk \
       --role viewer \
       --subject userAccount:ajel6l0jcb9s********
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы отозвать роль, назначенную на диск с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием роли:

      ```hcl
      resource "yandex_compute_disk_iam_binding" "sa-access" {
        disk_id = "<идентификатор_диска>"
        role    = "<роль>"
        members = ["<тип_субъекта>:<идентификатор_субъекта>"]
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

      Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

      ```bash
      yc compute disk list-access-bindings <идентификатор_диска>
      ```

- API {#api}

  Чтобы отозвать роли на диск, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Disk/updateAccessBindings.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/UpdateAccessBindings](../../api-ref/grpc/Disk/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

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