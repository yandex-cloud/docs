# Настройка прав доступа к бакету с помощью Identity and Access Management

В Object Storage реализовано несколько механизмов для управления доступом к ресурсам. Алгоритм взаимодействия этих механизмов смотрите в [Обзор способов управления доступом в Object Storage](../../security/overview.md).

Чтобы настроить доступ к [бакету](../../concepts/bucket.md) с помощью [Identity and Access Management](../../security/index.md), назначьте пользователю, группе пользователей или сервисному аккаунту [роль](../../security/index.md#roles-list) на бакет:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Нажмите на имя бакета, к которому вы хотите выдать доступ.
  1. В меню слева выберите **Безопасность**.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
  1. Нажмите кнопку **Добавить роль**.
  1. Выберите роль для пользователя.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения настроек бакета:

      ```bash
      yc storage bucket update --help
      ```

  1. Назначьте роль на бакет:

      ```bash
      yc storage bucket update \
        --name <имя_бакета> \
        --grants grantee-id=<идентификатор_аккаунта>,grant-type=<тип_субъекта>,permission=<разрешение>
      ```

      Где: 
      * `--name` — имя бакета.
      * `--grants` — параметры настройки прав доступа [ACL](../../concepts/acl.md):
        * `grantee-id` — идентификатор аккаунта, которому выдаются права. Используется при значении параметра `grant-type=grant-type-account`.
        * `grant-type` — тип субъекта, которому выдаются права. Возможные значения:
          * `grant-type-account` — пользовательский или сервисный аккаунт;
          * `grant-type-all-authenticated-users` — все аутентифицированные пользователи;
          * `grant-type-all-users` — все пользователи.
        * `permission` — выдаваемое разрешение. Возможные значения:
          * `permission-full-control` — полный доступ к бакету и объектам в нем;
          * `permission-write` — запись объектов в бакет;
          * `permission-write-acp` — изменение ACL бакета;
          * `permission-read` — чтение объектов в бакете;
          * `permission-read-acp` — чтение ACL бакета.
  
  При вызове команды `yc storage bucket update` назначенные роли ACL бакета перезаписываются, а не дополняются. Чтобы сохранить существующие настройки прав доступа, их необходимо перечислить заново в параметре `--grants`.

  Подробнее о команде `yc storage bucket update` в [Справочнике YC CLI](../../cli-ref/bucket/update.md).
  
  ## Пример {#example}

  Чтобы назначить сервисному аккаунту права для полного доступа к бакету с помощью CLI:

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```
 
      Результат:
 
      ```text
      +------------------+----------------------+----------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+----------+-----------------------+---------------------+
      | my-bucket        | b1gmit33ngp3******** | 10       | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Получите список сервисных аккаунтов в каталоге по умолчанию:

      ```bash
      yc iam service-account list
      ```
 
      Результат:
 
      ```text
      +----------------------+--------------+--------+---------------------+-----------------------+
      |          ID          |     NAME     | LABELS |     CREATED AT      | LAST AUTHENTICATED AT |
      +----------------------+--------------+--------+---------------------+-----------------------+
      | ajeg2b2et02f******** | my-robot     |        | 2024-09-08 18:59:45 | 2025-02-18 10:10:00   |
      | ajegtlf2q28a******** | account-name |        | 2023-06-27 16:18:18 | 2025-02-18 10:20:00   |
      +----------------------+--------------+--------+---------------------+-----------------------+
      ```

  1. Назначьте роль на бакет:

      ```bash
      yc storage bucket update \
        --name my-bucket \
        --grants grantee-id=ajeg2b2et02f********,grant-type=grant-type-account,permission=permission-full-control
      ```

  Результат:
      
  ```text
  name: my-bucket
  folder_id: b1g0ijbfaqsn********
  default_storage_class: STANDARD
  versioning: VERSIONING_DISABLED
  max_size: "53687091200"
  acl:
    grants:
      - permission: PERMISSION_FULL_CONTROL
        grant_type: GRANT_TYPE_ACCOUNT
        grantee_id: ajeg2b2et02f********
  created_at: "2026-04-30T09:48:38.836171Z"
  resource_id: e3ev6mif5rb1********
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы назначить роль на бакет с помощью Terraform:

  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_storage_bucket_iam_binding" "mybucket-viewers" {
        bucket  = "<имя_бакета>"
        role    = "<роль>"
        members = [
                    "<тип_субъекта>:<идентификатор_субъекта>",
                    "serviceAccount:<идентификатор_сервисного_аккаунта>",
                    "userAccount:<идентификатор_пользователя>"
                  ]
      }

      # Пример назначения роли storage.editor для сервисных аккаунтов
      resource "yandex_storage_bucket_iam_binding" "sa-editors" {
        bucket  = "<имя_бакета>"
        role    = "storage.editor"
        members = [
                    "serviceAccount:<идентификатор_сервисного_аккаунта_1>",
                    "serviceAccount:<идентификатор_сервисного_аккаунта_2>"
                  ]
      }

      # Пример назначения роли storage.admin для пользователей 
      resource "yandex_storage_bucket_iam_binding" "users-admins" {
        bucket  = "<имя_бакета>"
        role    = "storage.admin"
        members = [
                    "userAccount:<идентификатор_пользователя_1>",
                    "userAccount:<идентификатор_пользователя_2>"
                  ]
      }
      ```

      Где:

      * `bucket` — имя бакета.
      * `role` — назначаемая [роль](../../security/index.md#roles-list).

        {% note warning %}
        
        Ресурс [yandex_storage_bucket_iam_binding](../../../terraform/resources/storage_bucket_iam_binding.md) нельзя использовать для назначения [примитивных ролей](../../security/index.md#primitive-roles) (`viewer`, `editor` и `admin`) на бакет, если одновременно используется ресурс [yandex_storage_bucket_grant](../../../terraform/resources/storage_bucket_grant.md) или параметры `acl` и `grant` ресурса [yandex_storage_bucket](../../../terraform/resources/storage_bucket.md).
        
        {% endnote %}

      * `members` — список типов и идентификаторов [субъектов](../../../iam/concepts/access-control/index.md#subject), которым назначается роль. Указывается в формате `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      Подробнее о параметрах ресурса `yandex_storage_bucket_iam_binding` см. в [документации провайдера](../../../terraform/resources/storage_bucket_iam_binding.md).

  1. Если вы совместно с ресурсом [yandex_storage_bucket_iam_binding](../../../terraform/resources/storage_bucket_iam_binding.md) планируете использовать ресурс [yandex_storage_bucket_grant](../../../terraform/resources/storage_bucket_grant.md) для одного и того же бакета, рекомендуем выполнять создание ресурсов последовательно. Для этого добавьте в блок `yandex_storage_bucket_iam_binding` зависимость от наличия ресурса `yandex_storage_bucket_grant`:

      ```hcl
      resource "yandex_storage_bucket_iam_binding" "mybucket-viewers" {
        ...
      
        depends_on = [
          yandex_storage_bucket_grant.my_bucket_grant
        ]
      }
      ```

  1. Примените конфигурацию:

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

      Проверить изменения ресурсов можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Bucket/updateAccessBindings.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/UpdateAccessBindings](../../api-ref/grpc/Bucket/updateAccessBindings.md).

{% endlist %}

Также вы можете [назначить](../../../iam/operations/roles/grant.md) роль на бакет в сервисе Identity and Access Management.