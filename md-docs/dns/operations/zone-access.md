# Настроить права доступа к зоне DNS

Чтобы предоставить пользователю, группе или [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) доступ к [зоне DNS](../concepts/dns-zone.md), назначьте на нее [роль](../../iam/concepts/access-control/roles.md).

## Назначить роль {#add-access}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для назначения роли на зону DNS:

      ```bash
      yc dns zone add-access-binding --help
      ```

  1. Получите список зон DNS в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      ```bash
      yc dns zone list
      ```

  1. Посмотрите список ролей, которые уже назначены на ресурс:

      ```bash
      yc dns zone list-access-bindings <идентификатор_зоны>
      ```

  1. Назначьте роль с помощью команды:

      * Пользователю:

        ```bash
        yc dns zone add-access-binding <идентификатор_зоны> \
          --user-account-id <идентификатор_пользователя> \
          --role <роль>
        ```

        Где:

        * `--user-account-id` — [идентификатор пользователя](../../organization/operations/users-get.md). Чтобы назначить роль для всех аутентифицированных пользователей, воспользуйтесь флагом `--all-authenticated-users`.
        * `--role` — назначаемая [роль](../security/index.md#roles-list).

      * Сервисному аккаунту:

        ```bash
        yc dns zone add-access-binding <идентификатор_зоны> \
          --service-account-id <идентификатор_сервисного_аккаунта> \
          --role <роль>
        ```

        Где:

        * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md).
        * `--role` — назначаемая [роль](../security/index.md#roles-list).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы назначить роль на зону DNS с помощью Terraform:

  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_dns_zone_iam_binding" "zone-viewers" {
        dns_zone_id = "<идентификатор_зоны>"
        role        = "<роль>"
        members     = ["<тип_субъекта>:<идентификатор_субъекта>","<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `dns_zone_id` — идентификатор зоны DNS.
      * `role` — назначаемая [роль](../security/index.md#roles-list).
      * `members` — список типов и идентификаторов [субъектов](../../iam/concepts/access-control/index.md#subject), которым назначается роль. Указывается в формате `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

       Подробнее о параметрах ресурса `yandex_dns_zone_iam_binding` в [документации провайдера](../../terraform/resources/dns_zone_iam_binding.md).

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

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно с помощью команды [CLI](../../cli/index.md):

      ```bash
      yc dns zone list-access-bindings <идентификатор_зоны>
      ```

- API {#api}

  Чтобы назначить роль, воспользуйтесь методом REST API [updateAccessBindings](../api-ref/DnsZone/updateAccessBindings.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateAccessBindings](../api-ref/grpc/DnsZone/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}

## Назначить несколько ролей {#set-access}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% note alert %}

  Команда `set-access-binding` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

  {% endnote %}

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

      ```bash
      yc dns zone list-access-bindings <идентификатор_зоны>
      ```

  1. Посмотрите описание команды CLI для назначения ролей на зону DNS:

     ```bash
     yc dns zone set-access-bindings --help
     ```

  1. Назначьте роли:

     ```bash
     yc dns zone set-access-bindings <идентификатор_зоны> \
       --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта> \
       --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--access-binding` — параметры для установки прав доступа:
         * `role` — назначаемая [роль](../security/index.md#roles-list).
         * `subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

     Например, назначьте роли `dns.editor` нескольким пользователям и сервисному аккаунту:

     ```bash
     yc dns zone set-access-bindings my-disk-group \
       --access-binding role=dns.editor,subject=userAccount:gfei8n54hmfh********
       --access-binding role=dns.editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы назначить несколько ролей на зону DNS с помощью Terraform:

  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_dns_zone_iam_binding" "role1" {
        dns_zone_id = "<идентификатор_зоны>"
        role        = "<роль_1>"
        members     = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }

      resource "yandex_dns_zone_iam_binding" "role2" {
        dns_zone_id = "<идентификатор_зоны>"
        role        = "<роль_2>"
        members     = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `dns_zone_id` — идентификатор зоны DNS.
      * `role` — назначаемая [роль](../security/index.md#roles-list).
      * `members` — список типов и идентификаторов [субъектов](../../iam/concepts/access-control/index.md#subject), которым назначается роль. Указывается в формате `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      Подробнее о параметрах ресурса `yandex_dns_zone_iam_binding` в [документации провайдера](../../terraform/resources/dns_zone_iam_binding.md).

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

      Проверить изменения можно с помощью команды [CLI](../../cli/index.md):

      ```bash
      yc dns zone list-access-bindings <идентификатор_зоны>
      ```

- API {#api}

  Чтобы назначить роли на ресурс, воспользуйтесь методом REST API [setAccessBindings](../api-ref/DnsZone/setAccessBindings.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/SetAccessBindings](../api-ref/grpc/DnsZone/setAccessBindings.md).

  {% note alert %}

  Метод `setAccessBindings` и вызов `DnsZoneService/SetAccessBindings` полностью перезаписывают права доступа к ресурсу. Все текущие роли на ресурс будут удалены.

  {% endnote %}

{% endlist %}

## Отозвать роль {#revoke-role}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для отзыва роли на зону DNS:

      ```bash
      yc dns zone add-access-binding --help
      ```

  1. Посмотрите список ролей, которые уже назначены на ресурс:

      ```bash
      yc dns zone list-access-bindings <идентификатор_зоны>
      ```

  1. Чтобы отозвать права доступа, выполните команду:

     ```bash
     yc dns zone remove-access-binding <идентификатор_зоны> \
       --role=<роль> \
       --subject=<тип_субъекта>:<идентификатор_субъекта> \
     ```

     Где:

     * `--role` — идентификатор роли, которую надо отозвать.
     * `--subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

     Например, чтобы отозвать роль `dns.editor` у пользователя с идентификатором `ajel6l0jcb9s********` на DNS зону:

     ```bash
     yc dns zone remove-access-binding my-dns-zone \
       --role dns.editor \
       --subject userAccount:ajel6l0jcb9s********
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы отозвать роль, назначенную на зону DNS:

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием роли:

      ```hcl
      resource "yandex_dns_zone_iam_binding" "sa-role" {
        dns_zone_id = "<идентификатор_зоны>"
        role        = "<роль>"
        members     = ["<тип_субъекта>:<идентификатор_субъекта>"]
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

      Проверить изменения можно с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc dns zone list-access-bindings <идентификатор_зоны>
      ```

- API {#api}

  Чтобы отозвать роль, воспользуйтесь методом REST API [updateAccessBindings](../api-ref/DnsZone/updateAccessBindings.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateAccessBindings](../api-ref/grpc/DnsZone/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}