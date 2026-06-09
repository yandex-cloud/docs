# Изменить политику резервного копирования


{% note info %}

Резервные копии создаются по локальному времени ВМ или сервера {{ baremetal-full-name }}. Возможно небольшое отставание от расписания в зависимости от текущей нагрузки на сервис.

{% endnote %}

## Изменить основные параметры {#update-basic-parameters}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  {% note warning %}
  
  Политики копирования с некоторыми дополнительными настройками нельзя изменить в консоли управления {{ yandex-cloud }}. Чтобы изменить настройки таких политик, воспользуйтесь CLI {{ yandex-cloud }}, {{ TF }} или API.

  Если изменения настроек политики резервного копирования не применились на ВМ или сервере {{ baremetal-name }}, к которым ранее была привязана политика, то [отвяжите](detach-vm.md) политику от ВМ и [привяжите](attach-and-detach-vm.md) ее заново.

  {% endnote %}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно изменить [политику резервного копирования](../../concepts/policy.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Напротив политики резервного копирования, которую нужно изменить, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры политики резервного копирования:

      * Введите имя. Требования к имени:

        * длина — от 3 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.

      * В блоке **{{ ui-key.yacloud.backup.policy-form.title_schedule-section }}** в зависимости от выбранного при создании типа расписания запуска:

          * `{{ ui-key.yacloud.backup.policy-form.value_schedule-type-fixed }}` — укажите частоту создания копий:
          
              *  `{{ ui-key.yacloud.backup.policy-form.value_periodicity-daily }}`. Настройте создание резервной копии либо один раз в день в указанное время, либо несколько раз в день с заданной периодичностью в указанном временном интервале.
              * `{{ ui-key.yacloud.backup.policy-form.value_periodicity-weekly }}`. Выберите дни недели и время, в которое в эти дни будет выполняться резервное копирование.
              * `{{ ui-key.yacloud.backup.policy-form.value_periodicity-monthly }}`. Укажите месяцы, день месяца и время, в которые будет выполняться резервное копирование.
          
              Для инкрементальных копий вы можете включить опцию **{{ ui-key.yacloud.backup.policy-form.value_weekly-full-copy }}** и выбрать день недели, в который будет создаваться полная копия. В выбранный день вместо инкрементальной копии будет создана полная резервная копия.
          
          * `{{ ui-key.yacloud.backup.policy-form.value_schedule-type-interval }}` — укажите интервал в часах или днях между завершением предыдущего копирования и началом нового.
          
          Резервные копии создаются по локальному времени ВМ или сервера {{ baremetal-name }}. Возможно небольшое отставание от расписания в зависимости от текущей нагрузки на сервис.

      * В блоке **{{ ui-key.yacloud.backup.policy-form.title_retention-section }}** задайте политику [хранения копий](../../concepts/policy.md#retention):
      
        * `{{ ui-key.yacloud.backup.policy-form.value_retention-variant-save-all }}` — будут храниться все копии, созданные по этой политике резервного копирования.
        * `{{ ui-key.yacloud.backup.policy-form.value_retention-variant-save-last-f }}` — укажите количество последних копий, которые нужно хранить, или количество дней, недель или месяцев, копии за которые нужно хранить. Остальные копии будут удаляться автоматически.
      
            {% note info %}
      
            При создании политики с помощью консоли управления последующие изменения настроек хранения резервных копий применяются только после создания очередной резервной копии. Если изменения не вступили в силу, то [отвяжите](detach-vm.md) политику от ВМ или сервера {{ baremetal-name }} и после [привяжите](attach-and-detach-vm.md) ее заново.
      
            {% endnote %}

      * В блоке **{{ ui-key.yacloud.backup.policy-form.title_additional-section }}**:

          * (Опционально) Включите опцию **{{ ui-key.yacloud.backup.policy-form.field_run-later }}**, чтобы выполнить все пропущенные задания резервного копирования после запуска ВМ, если во время запланированного резервного копирования ВМ была в статусе `Stopped`. Доступно только для инкрементальных копий.
          * (Опционально) Включите опцию **{{ ui-key.yacloud.backup.policy-overview.field_fast-copy }}**, чтобы ускорить создание инкрементальных копий. Наличие изменений в файле будет определяться по размеру, дате и времени последнего изменения. Если опция отключена, {{ backup-name }} будет сравнивать содержимое всех файлов с содержимым резервной копии. Опция не работает для томов с файловыми системами JFS, ReiserFS3, ReiserFS4, ReFS или XFS.
          * (Опционально) Включите опцию **{{ ui-key.yacloud.backup.policy-form.field_sector-by-sector }}** для создания точной копии диска или тома на физическом уровне. Создает резервную копию всех секторов диска или тома, включая пустые области и нераспределенное пространство. Если не выбран уровень сжатия, размер копии будет равен размеру диска. Для дисков с неподдерживаемыми файловыми системами режим применяется автоматически. Данные приложений из такой копии восстановить нельзя.
          * (Опционально) Включите опцию **{{ ui-key.yacloud.backup.policy-form.field_validation-enabled }}**, чтобы убедиться в возможности восстановления данных из созданной резервной копии. При проверке для каждого доступного для восстановления блока вычисляется контрольная сумма. Проверка может занять длительное время, так как проверяются все восстанавливаемые данные.

          * (Опционально) Включите опцию **{{ ui-key.yacloud.backup.policy-overview.field_multivolume-snapshot }}** для создания синхронизированных по времени резервных копий данных, расположенных на нескольких томах. Параметр определяет, будут ли создаваться снимки нескольких томов одновременно или последовательно. Выберите приоритетный способ создания снимков:
          
              * `{{ ui-key.yacloud.backup.policy-form.field_lvm-snapshotting-disabled }}` — снимки томов будут создаваться под управлением LVM с помощью агента {{ backup-name }}.
              * `{{ ui-key.yacloud.backup.policy-form.field_lvm-snapshotting-enabled }}` — снимки томов будут создаваться встроенными средствами LVM. Если создать снимок с помощью LVM не удастся, он будет создан с помощью агента {{ backup-name }}.
          
          * (Опционально) В блоке **{{ ui-key.yacloud.backup.policy-form.field_pre-post-commands }}** задайте действия, которые {{ backup-name }} будет выполнять перед началом резервного копирования и после его завершения. Для этого включите опцию **{{ ui-key.yacloud.backup.policy-form.field_pre-command-enabled }}** и/или **{{ ui-key.yacloud.backup.policy-form.field_post-command-enabled }}** и задайте настройки:
          
              * **{{ ui-key.yacloud.backup.policy-form.field_pre-post-commands-cmd }}** — команда или путь к исполняемому файлу, которые требуется выполнить (запустить). Например: `/usr/bin/myapp`.
              * **{{ ui-key.yacloud.backup.policy-form.field_pre-post-commands-workdir }}** — рабочая директория выполнения команды (запуска файла). Например: `/etc/myapp/`.
              * **{{ ui-key.yacloud.backup.policy-form.field_pre-post-commands-args }}** — параметры командной строки, которые будут применяться при выполнении команды (запуске файла). Например: `-d -rw`.
              * Включите опцию **{{ ui-key.yacloud.backup.policy-form.field_pre-post-commands-stop-on-error }}**, чтобы создание резервной копии останавливалось при возникновении ошибки выполнения команды (запуска файла).
          
              {% note info %}
          
              В каждую политику можно добавить не более одной команды, выполняемой до резервного копирования, и не более одной — выполняемой после.
          
              {% endnote %}
          
          * (Опционально) В блоке **{{ ui-key.yacloud.backup.PolicyForm.PrePostDataCommandCardBlock.field_pre-post-data-command_mmRTZ }}** задайте действия, которые {{ backup-name }} будет выполнять непосредственно до и после захвата данных (создания снимка). Для этого включите опцию **{{ ui-key.yacloud.backup.PolicyForm.PrePostDataCommandCardBlock.field_pre-data-command-enabled_sZ45C }}** и/или **{{ ui-key.yacloud.backup.PolicyForm.PrePostDataCommandCardBlock.field_post-data-command-enabled_rXvwj }}** и задайте настройки:
          
              * **{{ ui-key.yacloud.backup.policy-form.field_pre-post-commands-cmd }}** — команда или путь к исполняемому файлу, которые требуется выполнить (запустить). Например: `/usr/bin/pg_start_backup.sh`.
              * **{{ ui-key.yacloud.backup.policy-form.field_pre-post-commands-workdir }}** — рабочая директория выполнения команды (запуска файла). Например: `/var/lib/postgresql/`.
              * **{{ ui-key.yacloud.backup.policy-form.field_pre-post-commands-args }}** — параметры командной строки, которые будут применяться при выполнении команды (запуске файла). Например: `--flush-all`.
              * Включите опцию **{{ ui-key.yacloud.backup.policy-form.field_pre-post-commands-stop-on-error }}**, чтобы создание резервной копии останавливалось при возникновении ошибки выполнения команды (запуска файла).
          
              {% note info %}
          
              Команды выполняются максимально близко к моменту создания снимка — непосредственно перед и сразу после захвата данных.
              В каждую политику можно добавить не более одной команды каждого типа.
          
              {% endnote %}
          
          * (Опционально) В блоке **{{ ui-key.yacloud.backup.policy-form.field_action-on-task-failure }}** укажите настройки резервного копирования в случае сбоя копирования:
          
              * **{{ ui-key.yacloud.backup.policy-form.field_attempts-qty }}** — максимальное количество попыток. При достижении максимального количества повторных попыток операция будет считаться неуспешной. Попытки будут прекращены, как только операция будет успешно выполнена или по достижении указанного количества попыток, в зависимости от того, что наступит раньше.
                  Не действует, если резервное копирование запущено вручную.
              * **{{ ui-key.yacloud.backup.policy-form.field_interval-between-attempts }}** — длительность интервала между повторениями попыток.
          
          * (Опционально) В блоке **{{ ui-key.yacloud.backup.policy-overview.field_error-handling }}** настройте поведение {{ backup-name }} при возникновении ошибок:
          
              *  **{{ ui-key.yacloud.backup.policy-form.field_action-on-task-failure }}** — настройки повторных попыток при ошибках копирования:
          
                  * **{{ ui-key.yacloud.backup.policy-form.field_attempts-qty }}** — максимальное количество попыток.
                  * **{{ ui-key.yacloud.backup.policy-form.field_interval-between-attempts }}** — длительность интервала между повторениями попыток.
          
              * **{{ ui-key.yacloud.backup.policy-form.field_snapshot-reattempt }}** — настройки повторных попыток при ошибках создания снимка:
          
                  *  **{{ ui-key.yacloud.backup.policy-form.field_attempts-qty }}** — максимальное количество попыток.
                  *  **{{ ui-key.yacloud.backup.policy-form.field_interval-between-attempts }}** — длительность интервала между повторениями попыток.
          
          * (Опционально) В блоке **{{ ui-key.yacloud.backup.policy-overview.field_files-filters }}** вы можете с помощью фильтров исключить из резервных копий определенные файлы и папки или, наоборот, делать резервные копии только конкретных элементов файловой системы:
          
              * **{{ ui-key.yacloud.backup.policy-overview.field_exclusion-masks }}**.
              * **{{ ui-key.yacloud.backup.policy-overview.field_inclusion-masks }}**.
          
              Исключающий фильтр имеет преимущество над включающим.
          
              Чтобы включить или исключить файлы, добавьте критерии, которым они должны соответствовать, например, имена файлов, пути или маски. Поддерживаются подстановочные символы `*` и `?`. Каждый критерий указывается с новой строки. В критериях не учитывается регистр.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для изменения [политики резервного копирования](../../concepts/policy.md):

      ```bash
      yc backup policy update --help
      ```

  1. Опишите конфигурацию политики резервного копирования в формате [JSON](https://ru.wikipedia.org/wiki/JSON).

      {% cut "Пример файла конфигурации" %}

      ```json
      {
        "compression": "NORMAL",
        "format": "AUTO",
        "multiVolumeSnapshottingEnabled": true,
        "preserveFileSecuritySettings": true,
        "reattempts": {
          "enabled": true,
          "interval": {
            "type": "SECONDS",
            "count": "30"
          },
          "maxAttempts": "30"
        },
        "silentModeEnabled": true,
        "splitting": {
          "size": "1099511627776"
        },
        "vmSnapshotReattempts": {
          "enabled": true,
          "interval": {
            "type": "MINUTES",
            "count": "5"
          },
          "maxAttempts": "3"
        },
        "vss": {
          "enabled": true,
          "provider": "TARGET_SYSTEM_DEFINED"
        },
        "archive": {
          "name": "'[Machine Name]-[Plan ID]-[Unique ID]A'"
        },
        "performanceWindow": {
        },
        "retention": {
          "rules": [
            {
              "maxCount": "10"
            }
          ],
          "beforeBackup": true
        },
        "scheduling": {
          "backupSets": [
            {
              "time": {
                "weekdays": [
                  "MONDAY"
                ],
                "repeatAt": [
                  {
                    "minute": "5"
                  }
                ],
                "type": "WEEKLY"
              }
            }
          ],
          "enabled": true,
          "maxParallelBackups": "2",
          "randMaxDelay": {
            "type": "MINUTES",
            "count": "30"
          },
          "scheme": "ALWAYS_INCREMENTAL",
          "weeklyBackupDay": "MONDAY"
        },
        "cbt": "ENABLE_AND_USE",
        "fastBackupEnabled": true,
        "quiesceSnapshottingEnabled": true,
        "prePostCommands": [
          {
            "cmd": "/usr/bin/myapp",
            "args": "-d -rw",
            "enabled": true,
            "stopOnError": true,
            "type": "PRE_COMMAND",
            "wait": true,
            "workdir": "/etc/myapp/"
          }
        ]
      }
      ```

      {% endcut %}

      В примере приведена конфигурация политики резервного копирования, которая будет создавать [инкрементальные](../../concepts/backup.md#types) [резервные копии](../../concepts/backup.md) [виртуальной машины](../../../compute/concepts/vm.md) или [сервера {{ baremetal-name }}](../../../baremetal/concepts/servers.md) каждый понедельник в 00:05 (UTC+0). При этом храниться будут только десять последних копий.

      См. [полную спецификацию](../../concepts/policy.md#specification) политики резервного копирования.
  1. Узнайте идентификатор политики резервного копирования, которую нужно изменить:

      ```bash
      yc backup policy list
      ```
      
      Результат:
      
      ```text
      +----------------------+----------------------+---------+---------+---------------------+---------------------+
      |          ID          |      FOLDER ID       |  NAME   | ENABLED |     CREATED AT      |     UPDATED AT      |
      +----------------------+----------------------+---------+---------+---------------------+---------------------+
      | abc7n3wln123******** | ghi681qpe789******** | policy1 | true    | 2023-07-03 09:12:02 | 2023-07-03 09:12:43 |
      | deflqbiwc456******** | ghi681qpe789******** | policy2 | true    | 2023-07-07 14:58:23 | 2023-07-07 14:58:23 |
      +----------------------+----------------------+---------+---------+---------------------+---------------------+
      ```

  1. Измените политику резервного копирования, указав ее идентификатор:

      ```bash
      yc backup policy update <идентификатор_политики_резервного_копирования> \
        --settings-from-file <путь_к_файлу_конфигурации>
      ```

      Где `--settings-from-file` — путь к файлу с конфигурацией политики резервного копирования в формате JSON.

      Результат:

      ```text
      id: cdgkoivuvtey********
      name: sample-backup-policy
      created_at: "2025-10-06T19:09:31Z"
      updated_at: "2025-10-06T19:09:31Z"
      enabled: true
      settings:
        compression: NORMAL
        format: AUTO
        multi_volume_snapshotting_enabled: true
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
              type: TYPE_AUTO
          enabled: true
          max_parallel_backups: "2"
          rand_max_delay:
            type: MINUTES
            count: "30"
          scheme: ALWAYS_INCREMENTAL
          weekly_backup_day: MONDAY
        cbt: ENABLE_AND_USE
        fast_backup_enabled: true
        file_filters: {}
        pre_post_commands:
          - cmd: /usr/bin/myapp
            args: -d -rw
            enabled: true
            stop_on_error: true
            type: PRE_COMMAND
            wait: true
            workdir: /etc/myapp/
      folder_id: b1gt6g8ht345********
      ```

      Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/update.md).

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить основные параметры в [политике резервного копирования](../../concepts/policy.md):
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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/index.md):

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
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
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

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Узнайте идентификатор политики резервного копирования, в которой нужно изменить список ВМ или серверов {{ baremetal-name }}:

     ```bash
     yc backup policy list
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------+---------+---------+---------------------+---------------------+
     |          ID          |      FOLDER ID       |  NAME   | ENABLED |     CREATED AT      |     UPDATED AT      |
     +----------------------+----------------------+---------+---------+---------------------+---------------------+
     | abc7n3wln123******** | ghi681qpe789******** | policy1 | true    | 2023-07-03 09:12:02 | 2023-07-03 09:12:43 |
     | deflqbiwc456******** | ghi681qpe789******** | policy2 | true    | 2023-07-07 14:58:23 | 2023-07-07 14:58:23 |
     +----------------------+----------------------+---------+---------+---------------------+---------------------+
     ```

  1. Узнайте идентификаторы виртуальных машин, которые нужно добавить или удалить:

     ```bash
     yc compute instance list
     ```
     
     Результат:
     
     ```text
     +----------------------+---------+---------------+---------+--------------+-------------+
     |          ID          |  NAME   |    ZONE ID    | STATUS  | EXTERNAL IP  | INTERNAL IP |
     +----------------------+---------+---------------+---------+--------------+-------------+
     | jklp0o9i8012******** | my-vm-1 | {{ region-id }}-b | RUNNING | 51.250.**.** | 192.168.*.* |
     | mnoa5s6d8345******** | my-vm-2 | {{ region-id }}-b | RUNNING | 84.201.**.** | 192.168.*.* |
     +----------------------+---------+---------------+---------+--------------+-------------+
     ```

     Чтобы узнать идентификаторы серверов {{ baremetal-name }}, в [консоли управления]({{ link-console-main }}) в списке сервисов нужного [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**. Идентификаторы указаны в списке серверов в поле **{{ ui-key.yacloud.common.id }}**.

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