---
title: Настройка прав доступа к бакету {{ objstorage-full-name }} с помощью {{ iam-name }}
description: Следуя данной инструкции, вы сможете назначить роль на бакет.
---

# Настройка прав доступа к бакету с помощью {{ iam-name }}

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

Чтобы настроить доступ к [бакету](../../concepts/bucket.md) с помощью [{{ iam-name }}](../../security/index.md), назначьте пользователю, группе пользователей или сервисному аккаунту [роль](../../security/index.md#roles-list) на бакет:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите на имя бакета, к которому вы хотите выдать доступ.
  1. В меню слева выберите **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.button.add-role }}**.
  1. Выберите роль для пользователя.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы назначить роль на бакет с помощью {{ TF }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

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

        {% include [tf-iam-binding-warning](../../../_includes/storage/tf-iam-binding-warning.md) %}

      * `members` — список типов и идентификаторов [субъектов](../../../iam/concepts/access-control/index.md#subject), которым назначается роль. Указывается в формате `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      Подробнее о параметрах ресурса `yandex_storage_bucket_iam_binding` читайте в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket_iam_binding).

  1. Если вы совместно с ресурсом [yandex_storage_bucket_iam_binding]({{ tf-provider-resources-link }}/storage_bucket_iam_binding) планируете использовать ресурс [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/storage_bucket_grant) для одного и того же бакета, рекомендуем выполнять создание ресурсов последовательно. Для этого добавьте в блок `yandex_storage_bucket_iam_binding` зависимость от наличия ресурса `yandex_storage_bucket_grant`:

      ```hcl
      resource "yandex_storage_bucket_iam_binding" "mybucket-viewers" {
        ...
      
        depends_on = [
          yandex_storage_bucket_grant.my_bucket_grant
        ]
      }
      ```

  1. Примените конфигурацию:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Проверить изменения ресурсов можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../../storage/api-ref/Bucket/updateAccessBindings.md) для ресурса [Bucket](../../../storage/api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/UpdateAccessBindings](../../../storage/api-ref/grpc/Bucket/updateAccessBindings.md).

{% endlist %}

Также вы можете [назначить](../../../iam/operations/roles/grant.md) роль на бакет в сервисе {{ iam-name }}.
