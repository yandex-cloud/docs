# Настройка прав доступа к асимметричной ключевой паре шифрования

Вы можете предоставить пользователю, сервисному аккаунту или группе пользователей доступ к [асимметричной ключевой паре шифрования](../concepts/asymmetric-encryption-key.md). Для этого назначьте [роли](../../iam/concepts/access-control/roles.md) на ключевую пару. Чтобы выбрать нужные, [узнайте](../security/index.md#roles-list), какие роли действуют в сервисе.

## Назначить роль {#add-access-binding}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится асимметричная ключевая пара шифрования.
   1. Перейдите в сервис **Key Management Service**.
   1. На панели слева выберите ![image](../../_assets/kms/asymmetric-key.svg) **Асимметричные ключи**.
   1. На вкладке **Шифрование** нажмите на имя нужной ключевой пары.
   1. Перейдите в раздел ![image](../../_assets/console-icons/persons.svg) **Права доступа** и нажмите кнопку **Назначить роли**.
   1. Выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к ключевой паре.
   1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые роли.
   1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   Чтобы назначить роль на асимметричную ключевую пару шифрования:

   1. Посмотрите описание команды CLI для назначения роли:

      ```bash
      yc kms asymmetric-encryption-key add-access-binding --help
      ```

   1. Получите список асимметричных ключевых пар вместе с их идентификаторами:

      ```bash
      yc kms asymmetric-encryption-key list
      ```

   1. Получите [идентификатор пользователя](../../organization/operations/users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, которым назначаете роль.
   1. С помощью одной из команд ниже назначьте роль:

      * Пользователю:

         ```bash
         yc kms asymmetric-encryption-key add-access-binding \
           --id <идентификатор_ключевой_пары> \
           --role <роль> \
           --user-account-id <идентификатор_пользователя>
         ```

      * Федеративному пользователю:

         ```bash
         yc kms asymmetric-encryption-key add-access-binding \
           --id <идентификатор_ключевой_пары> \
           --role <роль> \
           --subject federatedUser:<идентификатор_пользователя>
         ```

      * Сервисному аккаунту:

         ```bash
         yc kms asymmetric-encryption-key add-access-binding \
           --id <идентификатор_ключевой_пары> \
           --role <роль> \
           --service-account-id <идентификатор_сервисного_аккаунта>
         ```

      * Группе пользователей:

         ```bash
         yc kms asymmetric-encryption-key add-access-binding \
           --id <идентификатор_ключевой_пары> \
           --role <роль> \
           --subject group:<идентификатор_группы>
         ```

- Terraform {#tf}

   [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
   
   Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
   
   Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

   Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   
   
   Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

   Чтобы назначить роль на асимметричную ключевую пару шифрования с помощью Terraform:

   1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

       ```hcl
       resource "yandex_kms_asymmetric_encryption_key_iam_member" "key-viewers" {
         asymmetric_encryption_key_id = "<идентификатор_ключевой_пары>"

         role   = "<роль_1>"
         member = "<тип_субъекта>:<идентификатор_субъекта>"
       }
       ```

       Где:

       * `asymmetric_encryption_key_id` — идентификатор ассиметричной ключевой пары шифрования.
       * `role` — назначаемая [роль](../security/index.md#roles-list).
       * `member` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль. Указывается в формате `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

       Подробнее о параметрах ресурса `yandex_kms_asymmetric_encryption_key_iam_member` см. в [документации провайдера](../../terraform/resources/kms_asymmetric_encryption_key_iam_member.md).

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
       yc kms asymmetric-key list-access-bindings <идентификатор_ключа>
       ```

- API {#api}

   Воспользуйтесь методом [UpdateAccessBindings](../asymmetricencryption/api-ref/AsymmetricEncryptionKey/updateAccessBindings.md) для ресурса [AsymmetricEncryptionKey](../asymmetricencryption/api-ref/AsymmetricEncryptionKey/index.md) или вызовом gRPC API [AsymmetricEncryptionKeyService/UpdateAccessBindings](../asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/updateAccessBindings.md) и передайте в запросе:

   * Значение `ADD` в параметре `access_binding_deltas[].action`, чтобы добавить роль.
   * Роль в параметре `access_binding_deltas[].access_binding.role_id`.
   * Идентификатор субъекта, на кого назначается роль, в параметре `access_binding_deltas[].access_binding.subject.id`.
   * Тип субъекта, на кого назначается роль, в параметре `access_binding_deltas[].access_binding.subject.type`.

{% endlist %}

## Назначить несколько ролей {#set-access-bindings}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится асимметричная ключевая пара шифрования.
   1. Перейдите в сервис **Key Management Service**.
   1. На панели слева выберите ![image](../../_assets/kms/asymmetric-key.svg) **Асимметричные ключи**.
   1. На вкладке **Шифрование** нажмите на имя нужной ключевой пары.
   1. Перейдите в раздел ![image](../../_assets/console-icons/persons.svg) **Права доступа** и нажмите кнопку **Назначить роли**.
   1. Выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к ключевой паре.
   1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые роли.
   1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

   {% note alert %}
   
   Команда `set-access-bindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
   
   {% endnote %}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   Чтобы назначить несколько ролей на асимметричную ключевую пару шифрования:

   1. Убедитесь, что на ключевую пару не назначены роли, которые вы не хотите потерять:

      ```bash
      yc kms asymmetric-encryption-key list-access-bindings \
        --id <идентификатор_ключевой_пары>
      ```

   1. Посмотрите описание команды CLI для назначения ролей:

      ```bash
      yc kms asymmetric-encryption-key set-access-bindings --help
      ```

   1. Получите список асимметричных ключевых пар вместе с их идентификаторами:

      ```bash
      yc kms asymmetric-encryption-key list
      ```

   1. Получите [идентификатор пользователя](../../organization/operations/users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, которым назначаете роли.
   1. С помощью одной из команд ниже назначьте роли:

      * Пользователю с аккаунтом на Яндексе или локальному пользователю:

         ```bash
         yc kms asymmetric-encryption-key set-access-bindings \
           --id <идентификатор_ключевой_пары> \
           --access-binding role=<роль>,user-account-id=<идентификатор_пользователя>
         ```

      * Федеративному пользователю:

         ```bash
         yc kms asymmetric-encryption-key set-access-bindings \
           --id <идентификатор_ключевой_пары> \
           --access-binding role=<роль>,subject=federatedUser:<идентификатор_пользователя>
         ```

      * Сервисному аккаунту:

         ```bash
         yc kms asymmetric-encryption-key set-access-bindings \
           --id <идентификатор_ключевой_пары> \
           --access-binding role=<роль>,service-account-id=<идентификатор_сервисного_аккаунта>
         ```

      * Группе пользователей:

         ```bash
         yc kms asymmetric-encryption-key set-access-bindings \
           --id <идентификатор_ключевой_пары> \
           --access-binding role=<роль>,subject=group:<идентификатор_группы>
         ```

      Для каждой роли передайте отдельный параметр `--access-binding`. Пример:

      ```bash
      yc kms asymmetric-encryption-key set-access-bindings \
        --id <идентификатор_ключевой_пары> \
        --access-binding role=<роль1>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль2>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль3>,service-account-id=<идентификатор_сервисного_аккаунта>
      ```

- Terraform {#tf}

   [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
   
   Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
   
   Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

   Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   
   
   Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

   Чтобы назначить несколько ролей на асимметричную ключевую пару шифрования с помощью Terraform:

   1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

       ```hcl
       # Роль 1
       resource "yandex_kms_asymmetric_encryption_key_iam_member" "key-viewers" {
         asymmetric_encryption_key_id = "<идентификатор_ключевой_пары>"

         role   = "<роль_1>"
         member = "<тип_субъекта>:<идентификатор_субъекта>"
       }

       # Роль 2
       resource "yandex_kms_asymmetric_encryption_key_iam_member" "key-editors" {
         asymmetric_encryption_key_id = "<идентификатор_ключевой_пары>"

         role   = "<роль_2>"
         member = "<тип_субъекта>:<идентификатор_субъекта>"
       }
       ```

       Где:

       * `asymmetric_encryption_key_id` — идентификатор ассиметричной ключевой пары шифрования.
       * `role` — назначаемая [роль](../security/index.md#roles-list).
       * `member` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль. Указывается в формате `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

       Подробнее о параметрах ресурса `yandex_kms_asymmetric_encryption_key_iam_member` см. в [документации провайдера](../../terraform/resources/kms_asymmetric_encryption_key_iam_member.md).

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
       yc kms asymmetric-key list-access-bindings <идентификатор_ключа>
       ```

- API {#api}

   {% note alert %}
   
   Метод `setAccessBindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
   
   {% endnote %}

   Воспользуйтесь методом [SetAccessBindings](../asymmetricencryption/api-ref/AsymmetricEncryptionKey/setAccessBindings.md) для ресурса [AsymmetricEncryptionKey](../asymmetricencryption/api-ref/AsymmetricEncryptionKey/index.md) или вызовом gRPC API [AsymmetricEncryptionKeyService/SetAccessBindings](../asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/setAccessBindings.md). Передайте в запросе массив из объектов, каждый из которых соответствует отдельной роли и содержит следующие данные:

   * Роль в параметре `access_bindings[].role_id`.
   * Идентификатор субъекта, на кого назначаются роли, в параметре `access_bindings[].subject.id`.
   * Тип субъекта, на кого назначаются роли, в параметре `access_bindings[].subject.type`.

{% endlist %}