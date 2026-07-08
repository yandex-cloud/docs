---
title: Изменить политику резервного копирования в {{ backup-full-name }}
description: Из статьи вы узнаете, как изменить политику резервного копирования в {{ backup-full-name }}.
---

# Изменить политику резервного копирования


{% include [policy-execute-time](../../../_includes/backup/policy-execute-time.md) %}

## Изменить основные параметры {#update-basic-parameters}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  {% note warning %}
  
  Политики копирования с некоторыми дополнительными настройками нельзя изменить в консоли управления {{ yandex-cloud }}. Чтобы изменить настройки таких политик, воспользуйтесь CLI {{ yandex-cloud }}, {{ TF }} или API.

  Если изменения настроек политики резервного копирования не применились на [защищаемом ресурсе](../../concepts/index.md#protected-resources), к которому ранее была привязана политика, то [отвяжите](detach-vm.md) политику от ресурса и [привяжите](attach-and-detach-vm.md) ее заново.

  {% endnote %}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно изменить [политику резервного копирования](../../../backup/concepts/policy.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Напротив политики резервного копирования, которую нужно изменить, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры политики резервного копирования:

      * Введите имя. Требования к имени:

        {% include [name-format](../../../_includes/name-format.md) %}

      * В блоке **{{ ui-key.yacloud.backup.policy-form.title_schedule-section }}** в зависимости от выбранного при создании типа расписания запуска:

          {% include [policy-options-schedule-type](../../../_includes/backup/policy-options-schedule-type.md) %}

      {% include [policy-options-retention](../../../_includes/backup/policy-options-retention.md) %}

      * В блоке **{{ ui-key.yacloud.backup.policy-form.title_additional-section }}**:

          {% include [policy-options-additional](../../../_includes/backup/policy-options-additional.md) %}

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

      В примере приведена конфигурация политики резервного копирования, которая будет создавать [инкрементальные](../../concepts/backup.md#types) [резервные копии](../../concepts/backup.md) для [защищаемого ресурса](../../concepts/index.md#protected-resources) каждый понедельник в 00:05 (UTC+0). При этом храниться будут только десять последних копий.

      Полная спецификация описана в разделе [{#T}](../../concepts/policy.md#specification).
 
     
  1. Узнайте идентификатор политики резервного копирования, которую нужно изменить:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Измените политику резервного копирования, указав ее идентификатор:

      ```bash
      yc backup policy update <идентификатор_политики_резервного_копирования> \
        --settings-from-file <путь_к_файлу_конфигурации>
      ```

      Где `--settings-from-file` — путь к файлу с конфигурацией политики резервного копирования в формате JSON.

      Результат:

      {% include [json-output-cli](../../../_includes/backup/operations/json-output-cli.md) %}

      Подробнее о команде в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/update.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы изменить основные параметры в [политике резервного копирования](../../../backup/concepts/policy.md):
  1. Откройте файл конфигурации {{ TF }} и измените необходимые параметры во фрагменте с описанием ресурса `yandex_backup_policy`:

     {% cut "Пример описания ресурса `yandex_backup_policy` в конфигурации {{ TF }}" %}

     ```hcl
     resource "yandex_backup_policy" "my_policy" {
         archive_name                      = "[<имя_защищаемого_ресурса>]-[<идентификатор_плана>]-[<уникальный_идентификатор>]"
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

     Подробнее о параметрах ресурса `yandex_backup_policy` в [документации провайдера]({{ tf-provider-resources-link }}/backup_policy).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc backup policy get <идентификатор_политики_резервного_копирования>
     ```

- API {#api}

  Чтобы изменить основные параметры [политики резервного копирования](../../concepts/policy.md), воспользуйтесь методом REST API [update](../../backup/api-ref/Policy/update.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Update](../../backup/api-ref/grpc/Policy/update.md).

{% endlist %}

## Изменить список защищаемых ресурсов {#update-vm-list}

{% include [external-no-console-notice](../../../_includes/backup/external-no-console-notice.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится политика резервного копирования.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Выберите политику резервного копирования, в которой нужно изменить список [защищаемых ресурсов](../../concepts/index.md#protected-resources).
  1. Измените список привязанных ресурсов:
     * Чтобы привязать новую ВМ или сервер, нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}** и в открывшемся окне:

        * В зависимости от того, какой ресурс вы хотите привязать к политике, выберите вкладку **{{ ui-key.yacloud.backup.value_vm-recourses }}** или **{{ ui-key.yacloud.backup.value_bms-recourses }}** и в списке выберите нужные ВМ или сервер.

           Если ВМ или сервера, которые вы хотите привязать к политике, нет в списке, убедитесь, что они подключены к {{ backup-name }}.
        * Нажмите кнопку **{{ ui-key.yacloud_billing.backup.button_attach-instance-submit }}**.
     * Чтобы отвязать ВМ или сервер от политики:

        * В зависимости от того, какой ресурс вы хотите отвязать от политики резервного копирования, выберите вкладку **{{ ui-key.yacloud.backup.value_vm-recourses }}** или **{{ ui-key.yacloud.backup.value_bms-recourses }}**.
        * В строке с ВМ или сервером, которые нужно отвязать от политики, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите соответственно **{{ ui-key.yacloud.backup.action_detach-vm-instance }}** или **{{ ui-key.yacloud.backup.action_detach-baremetal-instance }}**.
        * В открывшемся окне подтвердите это действие.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Узнайте идентификатор политики резервного копирования, в которой нужно изменить список [защищаемых ресурсов](../../concepts/index.md#protected-resources):

     {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Узнайте идентификаторы защищаемых ресурсов, подключенных к {{ backup-name }}, которые нужно добавить или удалить:

     {% include [get-resource-ids](../../../_includes/backup/operations/get-resource-ids.md) %}

  1. Измените список защищаемых ресурсов в политике резервного копирования.
     * Чтобы привязать ресурс к политике резервного копирования:

       Посмотрите описание команды CLI:

       ```bash
       yc backup policy apply --help
       ```

       Привяжите ресурсы к политике резервного копирования, указав ее идентификатор:

       ```bash
       yc backup policy apply <идентификатор_политики_резервного_копирования> \
         --instance-ids <идентификаторы_защищаемых_ресурсов>
       ```

       Где `--instance-ids` — идентификаторы подключенных к {{ backup-name }} [виртуальных машин {{ compute-name }}](../../concepts/vm-connection/compute.md), [серверов {{ baremetal-name }}](../../concepts/vm-connection/baremetal.md) или [внешних ресурсов](../../concepts/vm-connection/external-resources.md), которые нужно привязать к политике резервного копирования. Несколько идентификаторов указываются через запятую.

       Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/apply.md).
     * Чтобы отвязать защищаемые ресурсы от политики резервного копирования:

       Посмотрите описание команды CLI:

       ```bash
       yc backup policy revoke --help
       ```

       Отвяжите ресурсы от политики резервного копирования, указав ее идентификатор:

       ```bash
       yc backup policy revoke <идентификатор_политики_резервного_копирования> \
         --instance-ids <идентификаторы_защищаемых_ресурсов>
       ```

       Где `--instance-ids` — идентификаторы [виртуальных машин {{ compute-name }}](../../concepts/vm-connection/compute.md), [серверов {{ baremetal-name }}](../../concepts/vm-connection/baremetal.md) или [внешних ресурсов](../../concepts/vm-connection/external-resources.md), которые нужно отвязать от политики резервного копирования. Несколько идентификаторов указываются через запятую.

       Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/revoke.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы изменить список [защищаемых ресурсов](../../concepts/index.md#protected-resources), привязанных к политике резервного копирования:

  1. Опишите в конфигурационном файле {{ TF }} отдельными блоками параметры привязки к политике для каждого защищаемого ресурса:

      ```hcl
      resource "yandex_backup_policy_bindings" "test_backup_binding_1" {
        instance_id = "<идентификатор_защищаемого_ресурса_1>"
        policy_id   = "<идентификатор_политики>"
      }

      resource "yandex_backup_policy_bindings" "test_backup_binding_2" {
        instance_id = "<идентификатор_защищаемого_ресурса_2>"
        policy_id   = "<идентификатор_политики>"
      }
      ```

      Где:

      * `instance_id` — идентификаторы защищаемых ресурсов, которые должны быть привязаны к политике.

          Получить список идентификаторов, привязанных к сервису {{ backup-name }} ресурсов в каталоге по умолчанию, вы можете с помощью команды {{ yandex-cloud }} CLI `yc backup vm list`.
      * `policy_id` — [идентификатор](./get-info.md) политики резервного копирования, к которой должны быть привязаны защищаемые ресурсы.

     Более подробную информацию о параметрах ресурса `yandex_backup_policy_bindings` см. в [документации провайдера]({{ tf-provider-resources-link }}/backup_policy_bindings).
  1. Создайте ресурсы {{ TF }}:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
      yc backup policy list-applications
     ```

- API {#api}

  Чтобы изменить список [защищаемых ресурсов](../../concepts/index.md#protected-resources), копии которых создаются согласно [политике резервного копирования](../../concepts/policy.md), воспользуйтесь методом REST API [update](../../backup/api-ref/Policy/update.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Update](../../backup/api-ref/grpc/Policy/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](delete.md).
