---
title: Удалить политику резервного копирования
description: Из статьи вы узнаете, как удалить политику резервного копирования в **{{ backup-name }}**.
---

# Удалить политику резервного копирования

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно удалить [политику резервного копирования](../../../backup/concepts/policy.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Напротив политики резервного копирования, которую нужно удалить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**. 
  1. Подтвердите удаление политики резервного копирования.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для удаления [политики резервного копирования](../../../backup/concepts/policy.md):

     ```bash
     yc backup policy delete --help
     ```

  1. Узнайте идентификатор политики резервного копирования, которую нужно удалить:

     {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Удалите политику резервного копирования, указав ее идентификатор:

     ```bash
     yc backup policy delete <идентификатор_политики_резервного_копирования>
     ```

     Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/policy/delete.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы удалить [политику резервного копирования](../../../backup/concepts/policy.md), созданную с помощью {{ TF }}:
  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием ресурса `yandex_backup_policy`:

     {% cut "Пример описания ресурса `yandex_backup_policy` в конфигурации {{ TF }}" %}

     ```hcl
     resource "yandex_backup_policy" "my_policy" {
         archive_name                      = "[<имя_ВМ>]-[<идентификатор_плана>]-[<уникальный_идентификатор>]a"
         cbt                               = "USE_IF_ENABLED"
         compression                       = "NORMAL"
         fast_backup_enabled               = true
         format                            = "AUTO"
         multi_volume_snapshotting_enabled = true
         name                              = "<имя_политики_резервного_копирования>"
         performance_window_enabled        = true
         preserve_file_security_settings   = true
         quiesce_snapshotting_enabled      = true
         silent_mode_enabled               = true
         splitting_bytes                   = "9223372036854775807"
         vss_provider                      = "NATIVE"

         reattempts {
             enabled      = true
             interval     = "1m"
             max_attempts = 10
         }

         retention {
             after_backup = false

             rules {
                 max_age       = "365d"
                 repeat_period = []
             }
         }

         scheduling {
             enabled              = false
             max_parallel_backups = 0
             random_max_delay     = "30m"
             scheme               = "ALWAYS_INCREMENTAL"
             weekly_backup_day    = "MONDAY"

             execute_by_time {
                 include_last_day_of_month = true
                 monthdays                 = []
                 months                    = [1,2,3,4,5,6,7,8,9,10,11,12]
                 repeat_at                 = ["04:10"]
                 repeat_every              = "30m"
                 type                      = "MONTHLY"
                 weekdays                  = []
             }
         }

         vm_snapshot_reattempts {
             enabled      = true
             interval     = "1m"
             max_attempts = 10
         }
     } 
     ```

     {% endcut %}

     Более подробную информацию о параметрах ресурса `yandex_backup_policy` см. в [документации провайдера]({{ tf-provider-resources-link }}/backup_policy).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc backup policy list
     ```

- API {#api}

  Чтобы удалить [политику резервного копирования](../../concepts/policy.md), воспользуйтесь методом REST API [delete](../../backup/api-ref/Policy/delete.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Delete](../../backup/api-ref/grpc/Policy/delete.md).

{% endlist %}