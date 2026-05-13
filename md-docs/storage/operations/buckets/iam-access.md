# Настройка прав доступа к бакету с помощью Identity and Access Management

В Object Storage реализовано несколько механизмов для управления доступом к ресурсам. Алгоритм взаимодействия этих механизмов см. в [Обзор способов управления доступом в Object Storage](../../security/overview.md).

Чтобы настроить доступ к [бакету](../../concepts/bucket.md) с помощью [Identity and Access Management](../../security/index.md), назначьте пользователю, группе пользователей или сервисному аккаунту [роль](../../security/index.md#roles-list) на бакет:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Нажмите на имя бакета, к которому вы хотите выдать доступ.
  1. В меню слева выберите **Безопасность**.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
  1. Нажмите кнопку **Добавить роль**.
  1. Выберите роль для пользователя.
  1. Нажмите кнопку **Сохранить**.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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