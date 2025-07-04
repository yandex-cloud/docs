---
title: Изменить политику резервного копирования в {{ backup-full-name }}
description: Из статьи вы узнаете, как изменить политику резервного копирования в {{ backup-name }}.
---

# Изменить политику резервного копирования


{% include [policy-execute-time](../../../_includes/backup/policy-execute-time.md) %}

## Изменить основные параметры {#update-basic-parameters}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  {% note warning %}
  
  Политики копирования с некоторыми дополнительными настройками нельзя изменить в консоли управления {{ yandex-cloud }}. Чтобы изменить настройки таких политик, воспользуйтесь CLI {{ yandex-cloud }}, {{ TF }} или API.

  Если изменения настроек политики резервного копирования не применились на ВМ или сервере {{ baremetal-name }}, к которым ранее была привязана политика, то [отвяжите](detach-vm.md) политику от ВМ и [привяжите](attach-and-detach-vm.md) ее заново.

  {% endnote %}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно изменить [политику резервного копирования](../../../backup/concepts/policy.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Напротив политики резервного копирования, которую нужно изменить, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры политики резервного копирования:

     {% include [policy-options](../../../_includes/backup/policy-options.md) %}

       {% include [policy-options-extra](../../../_includes/backup/policy-options-extra.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для изменения [политики резервного копирования](../../../backup/concepts/policy.md):

     ```bash
     yc backup policy update --help
     ```

  1. Опишите конфигурацию политики резервного копирования в формате [JSON](https://ru.wikipedia.org/wiki/JSON).

     {% cut "Пример файла конфигурации" %}

     {% include [json-example](../../../_includes/backup/operations/json-example.md) %}

     {% endcut %}

     В примере приведена конфигурация политики резервного копирования, которая будет создавать [инкрементальные](../../concepts/backup.md#types) [резервные копии](../../concepts/backup.md) [виртуальной машины](../../../compute/concepts/vm.md) или [сервера {{ baremetal-name }}](../../../baremetal/concepts/servers.md) каждый понедельник в 00:05 (UTC+0). При этом храниться будут только десять последних копий.

     См. [полную спецификацию](../../concepts/policy.md#specification) политики резервного копирования.
  1. Узнайте идентификатор политики резервного копирования, которую нужно изменить:

     {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Измените политику резервного копирования, указав ее идентификатор:

     ```bash
     yc backup policy update <идентификатор_политики_резервного_копирования> \
       --settings-from-file <путь_к_файлу_конфигурации>
     ```

     Где `--settings-from-file` — путь к файлу с конфигурацией политики резервного копирования в формате JSON.

     Результат:

     ```text
     id: cbq5rwepukxn********
     name: test2
     created_at: "2023-07-03T08:24:16.735555276Z"
     updated_at: "2023-07-03T08:24:16.746377738Z"
     enabled: true
     settings:
       compression: NORMAL
       format: AUTO
       multi_volume_snapshotting_enabled: true
       preserve_file_security_settings: true
       reattempts:
         enabled: true
         interval:
           type: SECONDS
           count: "30"
         max_attempts: "30"
       silent_mode_enabled: true
       splitting:
         size: "1099511627776"
       vm_snapshot_reattempts:
         enabled: true
         interval:
           type: MINUTES
           count: "5"
         max_attempts: "3"
       vss:
         enabled: true
         provider: TARGET_SYSTEM_DEFINED
       archive:
         name: '''[Machine Name]-[Plan ID]-[Unique ID]A'''
       performance_window: {}
       retention:
         rules:
           - max_count: "10"
         before_backup: true
       scheduling:
         backup_sets:
           - time:
               weekdays:
                 - MONDAY
               repeat_at:
                 - minute: "5"
               type: WEEKLY
         enabled: true
         max_parallel_backups: "2"
         rand_max_delay:
           type: MINUTES
           count: "30"
         scheme: ALWAYS_INCREMENTAL
         weekly_backup_day: MONDAY
       cbt: ENABLE_AND_USE
       fast_backup_enabled: true
       quiesce_snapshotting_enabled: true
     folder_id: d2q792qpemb4********
     ```

     Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/update.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы изменить основные параметры в [политике резервного копирования](../../../backup/concepts/policy.md):
  1. Откройте файл конфигурации {{ TF }} и измените необходимые параметры во фрагменте с описанием ресурса `yandex_backup_policy`:

     {% cut "Пример описания ресурса `yandex_backup_policy` в конфигурации {{ TF }}" %}

     ```hcl
     resource "yandex_backup_policy" "my_policy" {
         archive_name                      = "[<имя_ВМ_или_сервера_{{ baremetal-name }}>]-[<идентификатор_плана>]-[<уникальный_идентификатор>]a"
         cbt                               = "USE_IF_ENABLED"
         compression                       = "NORMAL"
         fast_backup_enabled               = true
         format                            = "AUTO"
         multi_volume_snapshotting_enabled = true
         name                              = "<имя_политики_резервного_копирования>"
         performance_window_enabled        = true
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

             backup_sets {
                 execute_by_time {
                     type                      = "MONTHLY"
                     include_last_day_of_month = true
                     monthdays                 = []
                     months                    = [1,2,3,4,5,6,7,8,9,10,11,12]
                     repeat_at                 = ["04:10"]
                     repeat_every              = "30m"
                     weekdays                  = []
                 }
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
     yc backup policy get <идентификатор_политики_резервного_копирования>
     ```

- API {#api}

  Чтобы изменить основные параметры [политики резервного копирования](../../concepts/policy.md), воспользуйтесь методом REST API [update](../../backup/api-ref/Policy/update.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Update](../../backup/api-ref/grpc/Policy/update.md).

{% endlist %}

## Изменить список виртуальных машин и серверов {{ baremetal-full-name }} {#update-vm-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится политика резервного копирования.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Выберите политику резервного копирования, в которой нужно изменить список [виртуальных машин](../../../compute/concepts/vm.md) или [серверов](../../../baremetal/concepts/servers.md) {{ baremetal-name }}.
  1. Измените список привязанных ресурсов:
     * Чтобы привязать новую ВМ или сервер {{ baremetal-name }}, нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}** и в открывшемся окне:

        * В зависимости от того, какой ресурс вы хотите привязать к политике, выберите вкладку **{{ ui-key.yacloud.backup.value_vm-recourses }}** или **{{ ui-key.yacloud.backup.value_bms-recourses }}** и в списке выберите нужные ВМ или сервер.

           Если ВМ или сервера {{ baremetal-name }}, которые вы хотите привязать к политике, нет в списке, убедитесь, что они подключены к {{ backup-name }}.
        * Нажмите кнопку **{{ ui-key.yacloud_billing.backup.button_attach-instance-submit }}**.
     * Чтобы отвязать ВМ или сервер {{ baremetal-name }}:

        * В зависимости от того, какой ресурс вы хотите отвязать от политики резервного копирования, выберите вкладку **{{ ui-key.yacloud.backup.value_vm-recourses }}** или **{{ ui-key.yacloud.backup.value_bms-recourses }}**.
        * В строке с ВМ или сервером {{ baremetal-name }}, которые нужно отвязать от политики, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите соответственно **{{ ui-key.yacloud.backup.action_detach-vm-instance }}** или **{{ ui-key.yacloud.backup.action_detach-baremetal-instance }}**.
        * В открывшемся окне подтвердите это действие.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Узнайте идентификатор политики резервного копирования, в которой нужно изменить список ВМ или серверов {{ baremetal-name }}:

     {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Узнайте идентификаторы виртуальных машин, которые нужно добавить или удалить:

     {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

     {% include [get-bms-ids](../../../_includes/backup/operations/get-bms-ids.md) %}

  1. Измените список ВМ и серверов {{ baremetal-name }} в политике резервного копирования.
     * Чтобы привязать ВМ или сервер {{ baremetal-name }} к политике резервного копирования:

       Посмотрите описание команды CLI:

       ```bash
       yc backup policy apply --help
       ```

       Привяжите ВМ или серверы {{ baremetal-name }} к политике резервного копирования, указав ее идентификатор:

       ```bash
       yc backup policy apply <идентификатор_политики_резервного_копирования> \
         --instance-ids <идентификаторы_ВМ_или_серверов_{{ baremetal-name }}>
       ```

       Где `--instance-ids` — идентификаторы подключенных к {{ backup-name }} виртуальных машин и серверов {{ baremetal-name }}, которые нужно привязать к политике резервного копирования. Несколько идентификаторов указываются через запятую.

       Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/apply.md).
     * Чтобы отвязать ВМ или серверы {{ baremetal-name }} от политики резервного копирования:

       Посмотрите описание команды CLI:

       ```bash
       yc backup policy revoke --help
       ```

       Отвяжите ВМ или серверы {{ baremetal-name }} от политики резервного копирования, указав ее идентификатор:

       ```bash
       yc backup policy revoke <идентификатор_политики_резервного_копирования> \
         --instance-ids <идентификаторы_ВМ_или_серверов_{{ baremetal-name }}>
       ```

       Где `--instance-ids` — идентификаторы ВМ или серверов {{ baremetal-name }}, которые нужно отвязать от политики резервного копирования. Несколько идентификаторов указываются через запятую.

       Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/revoke.md).

- API {#api}

  Чтобы изменить список ВМ или серверов {{ baremetal-name }}, копии которых создаются согласно [политике резервного копирования](../../concepts/policy.md), воспользуйтесь методом REST API [update](../../backup/api-ref/Policy/update.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Update](../../backup/api-ref/grpc/Policy/update.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](delete.md).
