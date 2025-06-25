---
title: Создать политику резервного копирования
description: Из статьи вы узнаете, как создать политику резервного копирования в {{ backup-name }}.
---

# Создать политику резервного копирования


Создание [политики](../../concepts/policy.md) доступно после [активации](../../concepts/index.md#providers) сервиса {{ backup-name }}.

Создать или [изменить](update.md) политику можно с помощью консоли управления {{ yandex-cloud }}, {{ TF }}, а также задать по [спецификации](../../concepts/policy.md#specification) в формате [JSON](https://ru.wikipedia.org/wiki/JSON), с помощью [CLI](../../../cli/quickstart.md) {{ yandex-cloud }} или API.

{% note info %}

Политики резервного копирования с некоторыми дополнительными настройками нельзя создать в консоли управления {{ yandex-cloud }}. Для создания таких политик воспользуйтесь CLI, {{ TF }} или API.

{% endnote %}

{% include [default-policies](../../../_includes/backup/default-policies.md) %}

{% include [policy-execute-time](../../../_includes/backup/policy-execute-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать [политику резервного копирования](../../../backup/concepts/policy.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.backup.button_create-policy }}**.
  1. На странице создания политики резервного копирования:

      {% include [policy-options](../../../_includes/backup/policy-options.md) %}

        * (Опционально) Выберите **{{ ui-key.yacloud.backup.policy-overview.field_compression }}** данных в резервной копии. Чем выше уровень сжатия, тем больше времени занимает резервное копирование, при этом созданная копия занимает меньше места. Эффективность процесса зависит от типа копируемых данных: уже сжатые файлы, такие как JPG, PDF или MP3, плохо поддаются дополнительному сжатию, в отличие, например, от DOC или XLS. 

          {% note info %}

          Уровень сжатия можно выбрать только при создании политики. Для существующей политики изменить его нельзя.

          {% endnote %}

        {% include [policy-options-extra](../../../_includes/backup/policy-options-extra.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для создания [политики резервного копирования](../../../backup/concepts/policy.md):

     ```bash
     yc backup policy create --help
     ```

  1. Опишите конфигурацию создаваемой политики резервного копирования в виде схемы данных в формате [JSON](https://ru.wikipedia.org/wiki/JSON).

     {% cut "Пример файла конфигурации" %}

     {% include [json-example](../../../_includes/backup/operations/json-example.md) %}

     {% endcut %}

     {% note info %}

     Параметры `preserveFileSecuritySettings` и `quiesceSnapshottingEnabled` больше не поддерживаются.
     
     {% endnote %}

     Сохраните готовую конфигурацию в файл с расширением `.json`.

     В примере приведена конфигурация политики резервного копирования, которая будет создавать [инкрементальные](../../concepts/backup.md#types) [резервные копии](../../concepts/backup.md) [виртуальной машины](../../../compute/concepts/vm.md) или [сервера {{ baremetal-name }}](../../../baremetal/concepts/servers.md) каждый понедельник в 00:05 (UTC+0). При этом храниться будут только десять последних копий.

     См. [полную спецификацию](../../concepts/policy.md#specification) политики резервного копирования.

  1. Создайте политику резервного копирования:

     ```bash
     yc backup policy create \
       --name <имя_политики> \
       --settings-from-file <путь_к_файлу_конфигурации>
     ```

     Где:

     * `--name` — имя создаваемой политики резервного копирования.
     * `--settings-from-file` — путь к файлу с конфигурацией политики резервного копирования в формате JSON.

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

     Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы создать [политику резервного копирования](../../concepts/policy.md):
  1. Опишите в конфигурационном файле {{ TF }} параметры политики резервного копирования:

     ```hcl
     resource "yandex_backup_policy" "my_policy" {
         archive_name                      = "[Machine Name]-[Plan ID]-[Unique ID]a"
         cbt                               = "USE_IF_ENABLED"
         compression                       = "NORMAL"
         fast_backup_enabled               = true
         format                            = "AUTO"
         multi_volume_snapshotting_enabled = true
         name                              = "<имя_политики_резервного_копирования>"
         performance_window_enabled        = true
         sector_by_sector                  = true
         run_later                         = true
         validation_enabled                = true
         lvm_snapshotting_enabled          = true
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

     Где:

     * `archive_name` — имя сгенерированных архивов. Необязательный параметр. Переменные параметра:
       * `Machine Name` — имя [виртуальной машины](../../../compute/concepts/vm.md) или [сервера {{ baremetal-name }}](../../../baremetal/concepts/servers.md).
       * `Plan ID` — идентификатор плана.
       * `Unique ID` — уникальный идентификатор.

       Последний символ имени сгенерированных архивов не должен быть переменной.
     * `cbt` — конфигурация отслеживания содержимого [резервных копий](../../concepts/backup.md). Необязательный параметр. Принимает значения:
       * `CHANGED_BLOCK_TRACKING_UNSPECIFIED` — не задано.
       * `USE_IF_ENABLED` — использовать, если включено.
       * `ENABLE_AND_USE` — включить и использовать.
       * `DO_NOT_USE` — не использовать.

       Значение по умолчанию `DO_NOT_USE`.
     * `compression`— степень сжатия резервной копии. Необязательный параметр. Принимает значения:
       * `NORMAL` — стандартное сжатие.
       * `HIGH` — сильное сжатие.
       * `MAX` — максимальное сжатие.
       * `OFF` — отключено.

       Значение по умолчанию `NORMAL`.
     * `fast_backup_enabled` — быстрое резервное копирование для отслеживания изменений в файлах. Когда включено, наличие изменений в файле определяется по его размеру и временной метке. Когда выключено, для проверки наличия изменений содержимое файла сравнивается с содержимым, сохраненным в резервной копии. Принимает значения `true` или `false`.
     * `format` — формат резервной копии. Необязательный параметр. Принимает значения:
       * `VERSION_11` — устаревший формат, не рекомендуется его использовать.
       * `VERSION_12` — рекомендованный формат для быстрого резервного копирования и восстановления.
       * `AUTO` — автоматический выбор формата. По умолчанию используется `VERSION_12`. Исключение — создание [инкрементальных](../../concepts/backup.md#types) копий для образов, созданных в других версиях.
     * `multi_volume_snapshotting_enabled` — создание резервных копий нескольких томов одновременно. Необязательный параметр. Принимает значения `true` или `false`.
     * `name` — имя политики резервного копирования.
     * `performance_window_enabled` — временные окна для ограничения производительности резервного копирования. Необязательный параметр. Принимает значения `true` или `false`. Значение по умолчанию `false`.
     * `sector_by_sector` — посекторное резервное копирование. Создает резервную копию всех секторов диска или тома, включая пустые области и нераспределенное пространство. Если не выбран уровень сжатия, размер копии будет равен размеру диска. Для дисков с неподдерживаемыми файловыми системами режим применяется автоматически. Данные приложений из такой копии восстановить нельзя. Принимает значения `true` или `false`. Значение по умолчанию `false`.
     * `run_later` — если во время запланированного резервного копирования ВМ была в статусе `Stopped`, все пропущенные задания резервного копирования выполнятся после запуска ВМ. Принимает значения `true` или `false`. Значение по умолчанию `false`.
     * `validation_enabled` — проверка возможности восстановления данных из созданной резервной копии. При проверке для каждого доступного для восстановления блока вычисляется контрольная сумма. Проверка может занять длительное время, так как проверяются все восстанавливаемые данные. Принимает значения `true` или `false`. Значение по умолчанию `false`.
     * `lvm_snapshotting_enabled` — для создания моментального снимка тома будет использоваться LVM. Если создать снимок с помощью LVM не удастся, он будет создан с помощью агента {{ backup-name }}. Принимает значения `true` или `false`. Значение по умолчанию `false`.
     * `silent_mode_enabled` — режим тишины, предполагающий минимальное взаимодействие с пользователем. Необязательный параметр. Принимает значения `true` или `false`. Значение по умолчанию `true`.
     * `splitting_bytes` — параметр для определения размера для разделения резервных копий. Необязательный параметр. Значение по умолчанию `9223372036854775807`.
     * `vss_provider` — настройки VSS-службы. Необязательный параметр. Принимает значения `NATIVE` или `TARGET_SYSTEM_DEFINED`. Значение по умолчанию `NATIVE`.
     * `reattempts` — параметры повторения операций резервного копирования в случае сбоев:
       * `enabled` — повторять попытки создать резервную копию при возникновении некритических ошибок (например, при сбое подключения к целевому [диску](../../../compute/concepts/disk.md)). Необязательный параметр. Принимает значения `true` или `false`. Значение по умолчанию `true`.
       * `interval` — интервал повторных попыток. Необязательный параметр. Значение по умолчанию `5m`.
       * `max_attempts` — максимальное количество попыток. При достижении максимального количества повторных попыток операция будет считаться неуспешной. Необязательный параметр. Значение по умолчанию `5`.
     * `retention` — параметры хранения резервных копий:
       * `after_backup` — применять правила хранения резервных копий после завершения операции резервного копирования. Принимает значения `true` или `false`.
       * `rules` — правила хранения резервных копий:
          * `max_age` — удаление резервных копий, возраст которых превышает `max_age`.
          * `max_count` — удаление резервных копий, если их количество превышает `max_count`.
          * `repeat_period` — период применения правил.

          Атрибуты `max_age` и `max_count` — взаимоисключающие. Использование одного делает невозможным использование другого.
     * `scheduling` — параметры расписания резервного копирования:
       * `enabled` — включение планирования резервного копирования. Необязательный параметр. Принимает значения `true` или `false`. Значение по умолчанию `true`.
       * `max_parallel_backups` — максимальное количество процессов резервного копирования, которые могут выполняться параллельно. Необязательный параметр. Значение по умолчанию `0` — неограниченное количество процессов.
       * `random_max_delay` — настройка случайной задержки между выполнением параллельных задач. Необязательный параметр. Значение по умолчанию `30m`.
       * `scheme` — схема расписания резервного копирования. Необязательный параметр. Принимает значения:
         * `ALWAYS_INCREMENTAL` — всегда [инкрементальная](../../../glossary/backup.md#incremental-backup).
         * `ALWAYS_FULL` — всегда [полная](../../../glossary/backup.md#full-backup).
         * `WEEKLY_FULL_DAILY_INCREMENTAL` — еженедельно: полная, ежедневно: инкрементальная.
         * `WEEKLY_INCREMENTAL` — еженедельно: инкрементальная.

         Значение по умолчанию `ALWAYS_INCREMENTAL`.
       * `weekly_backup_day` — день недели, в который будут выполняться еженедельные операции копирования. Необязательный параметр. Значение по умолчанию `MONDAY`.
       * `backup_sets` — список расписаний с наборами резервных копий:
          * `execute_by_time` — настройки выполнения резервного копирования в определенное время:
            * `include_last_day_of_month` — выполнение резервного копирования в последний день месяца. Необязательный параметр. Принимает значения `true` или `false`. Значение по умолчанию `false`.
            * `monthdays` — список дней, когда применяется расписание. Необязательный параметр. Используется в формате `MONTHLY`.
            * `months` — список месяцев, когда применяется расписание. Необязательный параметр.
            * `repeat_at` — список значений времени в формате `ЧЧ:ММ` (24-часовой формат), когда применяется расписание. Необязательный параметр.
            * `repeat_every` — частоты повторения резервного копирования. Необязательный параметр.
            * `type` — тип расписания. Принимает значения: `HOURLY` (ежечасно), `DAILY` (ежедневно), `WEEKLY` (еженедельно), `MONTHLY` (ежемесячно).
            * `weekdays` — список дней недели, когда будет применена резервная копия. Используется в формате `WEEKLY`.
     * `vm_snapshot_reattempts` — параметры повторения операций создания резервных копий в случае сбоев:
       * `enabled` — повторение попыток создать резервную копию при возникновении ошибок. Необязательный параметр. Принимает значения `true` или `false`. Значение по умолчанию `true`.
       * `interval` — длительность интервала между повторениями попыток. Необязательный параметр. Значение по умолчанию `5m`.
       * `max_attempts` — максимальное количество попыток. При достижении максимального количества повторных попыток операция будет считаться неуспешной. Необязательный параметр. Значение по умолчанию `5`.

     {% note info %}

     Параметры `preserveFileSecuritySettings` и `quiesceSnapshottingEnabled` больше не поддерживаются.
     
     {% endnote %}


     Более подробную информацию о параметрах ресурса `yandex_backup_policy` см. в [документации провайдера]({{ tf-provider-resources-link }}/backup_policy).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc backup policy list
     ```

- API {#api}

  Чтобы создать [политику резервного копирования](../../concepts/policy.md), воспользуйтесь методом REST API [create](../../backup/api-ref/Policy/create.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Create](../../backup/api-ref/grpc/Policy/create.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](update.md).
* [{#T}](delete.md).