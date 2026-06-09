# Настроить права доступа к секрету

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите на имя нужного секрета.
  1. На панели слева выберите раздел ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. В открывшемся окне нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.select-subject }}**.
  1. Выберите группу, пользователя или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которым нужно предоставить доступ к секрету.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые [роли](../security/index.md#roles-list).
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  1. Чтобы назначить роль на секрет:

      * Пользователю:

        ```bash
        yc lockbox secret add-access-binding \
          --id <идентификатор_секрета> \
          --user-account-id <идентификатор_пользователя> \
          --role <роль>
        ```

        Где:
        * `--id` — идентификатор секрета.
        * `--user-account-id` — [идентификатор пользователя](../../organization/operations/users-get.md).
        * `--role` — назначаемая [роль](../security/index.md#roles-list).

      * [Сервисному аккаунту](../../iam/concepts/users/service-accounts.md):

        ```bash
        yc lockbox secret add-access-binding \
          --id <идентификатор_секрета> \
          --service-account-id <идентификатор_сервисного_аккаунта> \
          --role <роль>
        ```

        Где:
        * `--id` — идентификатор секрета.
        * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md).
        * `--role` — назначаемая [роль](../security/index.md#roles-list).

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите права доступа к секрету в конфигурационном файле {{ TF }}:

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
      * `member` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль. Указывается в формате `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      Более подробную информацию о параметрах ресурса `yandex_lockbox_secret_iam_member` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/lockbox_secret_iam_member).

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc lockbox secret list-access-binding <идентификатор_секрета>
      ```

- API {#api}

  Чтобы настроить права доступа к секрету, воспользуйтесь методом REST API [setAccessBindings](../api-ref/Secret/setAccessBindings.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/SetAccessBindings](../api-ref/grpc/Secret/setAccessBindings.md).

{% endlist %}

{% note warning %}

Если вы [назначите](../../iam/operations/roles/grant.md) группе, пользователю или сервисному аккаунту роль на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) или [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), в которых находится секрет, все разрешения этой роли будут действовать и для секрета.

Подробнее об этом читайте в разделе [Как устроено управление доступом](../../iam/concepts/access-control/index.md#inheritance).

{% endnote %}

## См. также {#see-also}

* [{#T}](../concepts/secret.md)
* [{#T}](../../iam/concepts/access-control/index.md)
* [{#T}](../security/index.md)