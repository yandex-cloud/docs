---
title: Настройка прав доступа к бакету {{ objstorage-full-name }} с помощью {{ iam-name }}
description: Следуя данной инструкции, вы сможете назначить роль на бакет.
---

# Настройка прав доступа к бакету с помощью {{ iam-name }}

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

Чтобы настроить доступ к [бакету](../../concepts/bucket.md) с помощью [{{ iam-name }}](../../security/index.md), назначьте пользователю, группе пользователей или сервисному аккаунту [роль](../../security/index.md#roles-list) на бакет:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите на имя бакета, к которому вы хотите выдать доступ.
  1. В меню слева выберите **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.button.add-role }}**.
  1. Выберите роль для пользователя.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

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

      Подробнее о параметрах ресурса `yandex_storage_bucket_iam_binding` см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket_iam_binding).

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
