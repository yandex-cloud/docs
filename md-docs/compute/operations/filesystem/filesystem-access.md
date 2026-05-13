# Настроить права доступа к файловому хранилищу


Чтобы предоставить пользователю, группе или [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) доступ к [файловому хранилищу](../../concepts/filesystem.md), назначьте [роль](../../../iam/concepts/access-control/roles.md) на него.

## Назначить роль {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит файловое хранилище.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/nodes-right.svg) **Файловые хранилища**.
  1. Выберите файловое хранилище из списка.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к файловому хранилищу.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые [роли](../../security/index.md#roles-list).
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для назначения роли на файловое хранилище:

     ```bash
     yc compute filesystem add-access-binding --help
     ```

  1. Получите список файловых хранилищ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute filesystem list
     ```
     
     Результат:
     
     ```text
     +----------------------+-------------------+------------+---------------+--------+-------------+
     |          ID          |        NAME       |    SIZE    |     ZONE      | STATUS | DESCRIPTION |
     +----------------------+-------------------+------------+---------------+--------+-------------+
     | epdtcr9blled******** | first-filesystem  | 1073741824 | ru-central1-a | READY  |             |
     | epd3f4gv8bs4******** | second-filesystem | 1073741824 | ru-central1-a | READY  |             |
     +----------------------+-------------------+------------+---------------+--------+-------------+
     ```

  1. Посмотрите список ролей, которые уже назначены на ресурс:

     ```bash
     yc compute filesystem list-access-bindings <идентификатор_файлового_хранилища>
     ```

  1. Назначьте роль с помощью команды:

     * Пользователю:

       ```bash
       yc compute filesystem add-access-binding <идентификатор_файлового_хранилища> \
         --user-account-id <идентификатор_пользователя> \
         --role <роль>
       ```

       Где:

       * `--user-account-id` — [идентификатор пользователя](../../../organization/operations/users-get.md).
       * `--role` — назначаемая [роль](../../security/index.md#roles-list).

     * Сервисному аккаунту:

       ```bash
       yc compute filesystem add-access-binding <идентификатор_файлового_хранилища> \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --role <роль>
       ```

       Где:

       * `--service-account-id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md).
       * `--role` — назначаемая роль.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы назначить роль на доступ к файловому хранилищу с помощью Terraform:

  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_filesystem_iam_binding" "sa-access" {
        filesystem_id = "<идентификатор_файлового_хранилища>"
        role          = "<роль>"
        members       = ["<тип_субъекта>:<идентификатор_субъекта>","<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `filesystem_id` — идентификатор файлового хранилища.
      * `role` — назначаемая [роль](../../security/index.md#roles-list).
      * `members` — список типов и идентификаторов [субъектов](../../../iam/concepts/access-control/index.md#subject), которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      Более подробную информацию о параметрах ресурса `yandex_compute_filesystem_iam_binding` см. в [документации провайдера](../../../terraform/resources/compute_filesystem_iam_binding.md).

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
      yc compute filesystem list-access-bindings <идентификатор_файлового_хранилища>
      ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Filesystem/updateAccessBindings.md) для ресурса [Filesystem](../../api-ref/Filesystem/index.md) или вызовом gRPC API [FilesystemService/UpdateAccessBindings](../../api-ref/grpc/Filesystem/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}

## Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит файловое хранилище.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/nodes-right.svg) **Файловые хранилища**.
  1. Выберите файловое хранилище из списка.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к файловому хранилищу.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые [роли](../../security/index.md#roles-list).
  1. Добавьте еще роль через кнопку **Добавить роль**.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% note alert %}
  
  Команда `set-access-bindings` полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
  
  {% endnote %}

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

     ```bash
     yc compute filesystem list-access-bindings <идентификатор_файлового_хранилища>
     ```

  1. Посмотрите описание команды CLI для назначения ролей на файловое хранилище:

     ```bash
     yc compute filesystem set-access-bindings --help
     ```

  1. Назначьте роли:

     ```bash
     yc compute filesystem set-access-bindings <идентификатор_файлового_хранилища> \
       --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--access-binding` — назначаемая роль:

       * `role` — идентификатор назначаемой роли.
       * `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

     Например, назначьте роли нескольким пользователям и сервисному аккаунту:

     ```bash
     yc compute filesystem set-access-bindings my-filesystem \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
       --access-binding role=viewer,subject=userAccount:helj89sfj80a********
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы назначить несколько ролей на файловое хранилище с помощью Terraform:

  1. Опишите в конфигурационном файле Terraform необходимые права доступа:

      ```hcl
      resource "yandex_compute_filesystem_iam_binding" "role1" {
        filesystem_id = "<идентификатор_файлового_хранилища>"
        role          = "<роль_1>"
        members       = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      
      resource "yandex_compute_filesystem_iam_binding" "role2" {
        filesystem_id = "<идентификатор_файлового_хранилища>"
        role          = "<роль_2>"
        members       = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `filesystem_id` — идентификатор файлового хранилища.
      * `role` — назначаемая [роль](../../security/index.md#roles-list).
      * `members` — список типов и идентификаторов [субъектов](../../../iam/concepts/access-control/index.md#subject), которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      Более подробную информацию о параметрах ресурса `yandex_compute_filesystem_iam_binding` см. в [документации провайдера](../../../terraform/resources/compute_filesystem_iam_binding.md).

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
      yc compute filesystem list-access-bindings <идентификатор_файлового_хранилища>
      ```


- API {#api}

  Воспользуйтесь методом REST API [setAccessBindings](../../api-ref/Filesystem/setAccessBindings.md) для ресурса [Filesystem](../../api-ref/Filesystem/index.md) или вызовом gRPC API [FilesystemService/SetAccessBindings](../../api-ref/grpc/Filesystem/setAccessBindings.md).

{% endlist %}

## Отозвать роль {#revoke-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит файловое хранилище.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/nodes-right.svg) **Файловые хранилища**.
  1. Выберите файловое хранилище из списка.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **Права доступа**.
  1. В строке нужного пользователя нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите **Изменить роли**.
  1. Нажмите значок ![cross](../../../_assets/console-icons/xmark.svg) рядом с ролью, чтобы удалить ее.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для отзыва роли на файловое хранилище:

     ```bash
     yc compute filesystem remove-access-binding --help
     ```

  1. Посмотрите, кому и какие роли назначены на ресурс:

     ```bash
     yc compute filesystem list-access-bindings <идентификатор_файлового_хранилища>
     ```

  1. Чтобы отозвать права доступа, выполните команду:

     ```bash
     yc compute filesystem remove-access-binding <идентификатор_файлового_хранилища> \
       --role <идентификатор_роли> \
       --subject <тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--role` — идентификатор роли, которую надо отозвать.
     * `--subject` — [субъект](../../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

     Например, чтобы отозвать роль `viewer` у пользователя с идентификатором `ajel6l0jcb9s********` на файловое хранилище:

     ```bash
     yc compute filesystem remove-access-binding my-filesystem \
       --role viewer \
       --subject userAccount:ajel6l0jcb9s********
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы отозвать роль, назначенную на файловое хранилище  с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием роли:

      ```hcl
      resource "yandex_compute_filesystem_iam_binding" "role1" {
        filesystem_id = "<идентификатор_файлового_хранилища>"
        role          = "<роль>"
        members       = ["<тип_субъекта>:<идентификатор_субъекта>"]
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

      Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc compute filesystem list-access-bindings <идентификатор_файлового_хранилища>
      ```

- API {#api}

  Чтобы отозвать роли на файловое хранилище, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Filesystem/updateAccessBindings.md) для ресурса [Filesystem](../../api-ref/Filesystem/index.md) или вызовом gRPC API [FilesystemService/UpdateAccessBindings](../../api-ref/grpc/Filesystem/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}