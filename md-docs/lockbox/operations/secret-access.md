[Документация Yandex Cloud](../../index.md) > [Yandex Lockbox](../index.md) > [Пошаговые инструкции](index.md) > Настроить права доступа к секрету

# Настроить права доступа к секрету

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит секрет.
  1. [Перейдите](https://console.yandex.cloud/link/lockbox) в сервис **Lockbox**.
  1. Нажмите на имя нужного секрета.
  1. Перейдите на вкладку **Права доступа** и нажмите кнопку **Назначить роли**.
  1. В открывшемся окне в поле **Кому выдать доступ** выберите группу, пользователя или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которым нужно предоставить доступ к секрету.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые [роли](../security/index.md#roles-list).
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите идентификатор секрета (столбец `ID` в выводе команды):
     
        ```bash
        yc lockbox secret list
        ```
     
        Результат:
     
        ```text
        +----------------------+-------------+------------+---------------------+----------------------+--------+
        |          ID          |    NAME     | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
        +----------------------+-------------+------------+---------------------+----------------------+--------+
        | e6qetpqfe8vvag9h7jkr | test-secret |            | 2023-12-06 15:12:13 | e6qdnt9t2qsdggusve4g | ACTIVE |
        +----------------------+-------------+------------+---------------------+----------------------+--------+
        ```

  1. Чтобы назначить роль на секрет, выполните команду:

      ```bash
      yc lockbox secret add-access-binding \
        --id <идентификатор_секрета> \
        --role <роль> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--id` — идентификатор секрета.
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

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите права доступа к секрету в конфигурационном файле Terraform:

      ```hcl
      resource "yandex_lockbox_secret_iam_member" "secret-viewer" {
        secret_id = "<идентификатор_секрета>"
        role      = "<роль>"
        member    = "<тип_субъекта>:<идентификатор_субъекта>"
      }
      ```

      Где:

      * `secret_id` — идентификатор секрета.
      * `role` — назначаемая [роль](../security/index.md#roles-list).
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

      Подробнее о параметрах ресурса `yandex_lockbox_secret_iam_member` в [документации провайдера](../../terraform/resources/lockbox_secret_iam_member.md).

  1. Создайте ресурсы

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
      
      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc lockbox secret list-access-binding <идентификатор_секрета>
      ```

- API {#api}

  Чтобы настроить права доступа к секрету, воспользуйтесь методом REST API [setAccessBindings](../api-ref/Secret/setAccessBindings.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/SetAccessBindings](../api-ref/grpc/Secret/setAccessBindings.md). В теле запроса в свойстве `subject` укажите тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject).

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

{% note warning %}

Если вы [назначите](../../iam/operations/roles/grant.md) группе, пользователю или сервисному аккаунту роль на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) или [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), в которых находится секрет, все разрешения этой роли будут действовать и для секрета.

Подробнее об этом читайте в разделе [Как устроено управление доступом](../../iam/concepts/access-control/index.md#inheritance).

{% endnote %}

#### Полезные ссылки {#see-also}

* [Секреты в Yandex Lockbox](../concepts/secret.md)
* [Как устроено управление доступом в Yandex Cloud](../../iam/concepts/access-control/index.md)
* [Управление доступом в Yandex Lockbox](../security/index.md)