# Создать расписание, по которому будут создаваться снимки дисков


## Настроить автоматическое создание снимков дисков по расписанию {#set-schedule}

Чтобы настроить автоматическое создание [снимков дисков](../../concepts/snapshot.md) по [расписанию](../../concepts/snapshot-schedule.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [диск](../../concepts/disk.md).
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **Снимки дисков**.
  1. На вкладке **Расписания снимков** нажмите кнопку **Создать**.
  1. Задайте параметры расписания снимков:
     * Введите имя расписания в формате:

       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

     * Если требуется, укажите произвольное текстовое описание расписания.
     * Выберите диски, снимки которых нужно создавать по расписанию. В одно расписание можно добавить несколько дисков, а один диск можно добавить в несколько расписаний в пределах [лимитов](../../concepts/limits.md#compute-limits-snapshot-schedule).

       Создавать можно снимки сетевых [дисков](../../concepts/disk.md#disks_types) HDD, SSD и нереплицируемых SSD, а также сверхбыстрых сетевых хранилищ с тремя репликами (SSD).
       
       Для нереплицируемых SSD и сверхбыстрых сетевых хранилищ с тремя репликами (SSD) момент времени, когда фиксируется содержимое диска, не детерминирован.
       
       Для снимков с локальных дисков на [выделенных хостах](../../concepts/dedicated-host.md) используйте сервис [Yandex Cloud Backup](../../../backup/index.md) (поддерживает ОС Ubuntu, CentOS, CentOS Stream и Windows Server).

     * В поле **Создавать снимки** выберите периодичность создания снимков: `По часам`, `По дням`, `По неделям` [или `По cron-выражению`](../../concepts/snapshot-schedule.md#cron). Время создания снимка указывается в часовом поясе [UTC±00:00](https://ru.wikipedia.org/wiki/UTC±00:00).
     * В поле **Начиная с** укажите дату, начиная с которой будет работать расписание.
     * Выберите политику хранения снимков:
       * **Хранить все снимки** — будут храниться все снимки, созданные по этому расписанию.
       * **Только последние** — укажите количество последних снимков, которые нужно хранить, или количество дней, снимки за которые нужно хранить. Остальные снимки, созданные по этому расписанию, будут удаляться автоматически.

       {% note info %}

       На количество и суммарный объем снимков в облаке действуют [квоты](../../concepts/limits.md#compute-quotas).

       {% endnote %}

  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команд [CLI](../../../cli/index.md) для работы с расписаниями:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule create --help
     ```

  1. Создайте расписание с помощью [cron-выражения](../../concepts/snapshot-schedule.md#cron):

     ```bash
     yc compute snapshot-schedule create <имя_расписания> \
       --expression <cron-выражение>
     ```

     {% note info %}

     Время создания снимка указывается в часовом поясе [UTC±00:00](https://ru.wikipedia.org/wiki/UTC±00:00).

     {% endnote %}

     Если необходимо задать политику [хранения снимков](../../concepts/snapshot-schedule.md#retention), добавьте параметр `--snapshot-count` или `--retention-period`. Например:
     * `--snapshot-count 5` — хранение последних 5 снимков.
     * `--retention-period 72h` — хранение снимков за последние 3 дня.

     Чтобы установить дату начала для расписания, используйте параметр `--start-at`. Например:
     * `--start-at "2022-12-31T16:39:00+05:00"` — начало 31 декабря 2022 г. в 16:39 UTC+5.
     * `--start-at "2h"` — начало два часа назад от текущего момента.

     Подробнее о команде `yc compute snapshot-schedule create` см. в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/snapshot-schedule/create.md).
  1. Получите идентификаторы [дисков](../../concepts/disk.md), чтобы добавить их в расписание:

     ```bash
     yc compute disk list --format yaml
     ```

     Результат:

     ```text
     - id: epdcq9g3co9s********
       folder_id: e1ea8s8l71li********
       created_at: "2022-10-13T14:37:44Z"
     ...
       instance_ids:
         - fhm1c7u23aiq********
       disk_placement_policy: {}
     ```

  1. Добавьте диски в расписание:

     ```bash
     yc compute snapshot-schedule add-disks <имя_или_идентификатор_расписания> \
       --disk-id <идентификатор_диска_1>,<идентификатор_диска_2>
     ```

     Результат:

     ```text
     done (3s)
     id: fc8e52mvchb2********
     folder_id: e1ea8s8l71li********
     ...
       expression: 36 14 */1 * *
     snapshot_count: "3"
     snapshot_spec: {}
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле Terraform параметры ресурса, который необходимо создать:

     ```hcl
     resource "yandex_compute_snapshot_schedule" "default" {
       name = "<название_расписания>"

       schedule_policy {
         expression = "<cron-выражение>"
       }

       snapshot_count = <количество_снимков_для_каждого_диска>

       snapshot_spec {
         description = "<описание_снимка>"
         labels = {
           <ключ_метки_снимка> = "<значение_метки_снимка>"
         }
       }

       disk_ids = ["<идентификатор_диска_1>", "<идентификатор_диска_2>"]
     }
     ```

     Где:
     * `name` — название расписания. Обязательный параметр.
     * `schedule_policy` — блок с параметрами расписания. Содержит поле `expression` с [cron-выражением](../../concepts/snapshot-schedule.md#cron). Обязательный параметр.
     * `snapshot_count` — максимальное количество снимков для каждого [диска](../../concepts/disk.md). Необязательный параметр.
     * `snapshot_spec` — блок с дополнительными параметрами снимка. Необязательный параметр. Может содержать поля:
       * `description` — описание снимка.
       * `labels` — [метка](../../../overview/concepts/services.md#labels) снимка в формате `<ключ> = "<значение>"`.
     * `disk_ids`— идентификаторы дисков, для которых будут создаваться снимки. Обязательный параметр.

     Более подробную информацию о параметрах ресурса `yandex_compute_snapshot_schedule` в Terraform, см. в [документации провайдера](../../../terraform/resources/compute_snapshot_schedule.md).
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

  После этого в указанном каталоге будет создано расписание. Проверить появление расписания и его настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

  ```bash
  yc compute snapshot-schedule get <имя_расписания>
  ```

- API {#api}

  1. Получите список дисков с помощью метода REST API [list](../../api-ref/Disk/list.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызова gRPC API [DiskService/List](../../api-ref/grpc/Disk/list.md).

     Создавать можно снимки сетевых [дисков](../../concepts/disk.md#disks_types) HDD, SSD и нереплицируемых SSD, а также сверхбыстрых сетевых хранилищ с тремя репликами (SSD).
     
     Для нереплицируемых SSD и сверхбыстрых сетевых хранилищ с тремя репликами (SSD) момент времени, когда фиксируется содержимое диска, не детерминирован.
     
     Для снимков с локальных дисков на [выделенных хостах](../../concepts/dedicated-host.md) используйте сервис [Yandex Cloud Backup](../../../backup/index.md) (поддерживает ОС Ubuntu, CentOS, CentOS Stream и Windows Server).

  1. Создайте расписание снимков с помощью метода REST API [create](../../api-ref/SnapshotSchedule/create.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызова gRPC API [SnapshotScheduleService/Create](../../api-ref/grpc/SnapshotSchedule/create.md).

{% endlist %}

Снимки будут автоматически создаваться и удаляться, только пока расписание работает ([статус](../../concepts/snapshot-schedule.md#statuses) `ACTIVE`).

## Примеры {#examples}

### Снимки создаются каждый день {#daily}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы настроить ежедневное создание снимков:
  1. Создайте расписание с помощью [cron-выражения](../../concepts/snapshot-schedule.md#cron):

     ```bash
     yc compute snapshot-schedule create sched-1 \
       --description "Ежедневное" \
       --expression "10 16 ? * *" \
       --start-at "2022-12-31T19:04:05+03:00" \
       --snapshot-count 7 \
       --labels "machine=file-server"
     ```

     В результате будет создано расписание:
     * С именем `sched-1` и описанием `Ежедневное`.
     * С созданием снимков каждый день в 19:10 по МСК.
     * С датой начала 31 декабря 2022 г. 19:04 по МСК.
     * С сохранением последних семи снимков.
     * С меткой `machine` и значением метки `file-server`.
  1. Получите идентификаторы дисков, чтобы добавить их в расписание:

     ```bash
     yc compute disk list --format yaml
     ```

     Результат:

     ```text
     - id: epdcq9g3co9s********
       folder_id: e1ea8s8l71li********
       created_at: "2022-10-13T14:37:44Z"
       name: disk-2
       type_id: network-hdd
       zone_id: ru-central1-a
       size: "21474836480"
       block_size: "4096"
       product_ids:
         - f2euv1kekdgv********
       status: READY
       source_image_id: fd88d14a6790********
       instance_ids:
         - ephothb6lppn********
       disk_placement_policy: {}
     - id: fhm7mip40dqh********
       folder_id: e1ea8s8l71li********
       created_at: "2022-10-10T05:00:04Z"
       name: disk-1
       type_id: network-hdd
       zone_id: ru-central1-a
       size: "21474836480"
       block_size: "4096"
       product_ids:
         - f2euv1kekdgv********
       status: READY
       source_image_id: fd88d14a6790********
       instance_ids:
         - fhm1c7u23aiq********
       disk_placement_policy: {}
      ```

  1. Добавьте диски в расписание:

     ```bash
     yc compute snapshot-schedule add-disks sched-1 \
       --disk-id epdcq9g3co9s********,fhm7mip40dqh********
     ```

     Результат:

     ```text
     done (3s)
     id: fc8bplhqmh2b********
     folder_id: e1ea8s8l71li********
     created_at: "2022-10-03T13:28:01Z"
     name: sched-1
     description: Ежедневное
     labels:
       machine: file-server
     status: ACTIVE
     schedule_policy:
       start_at: "2022-12-31T16:04:05Z"
       expression: 10 16 ? * *
     snapshot_count: "7"
     snapshot_spec: {}
     ```

{% endlist %}

#### См. также {#see-also}

* [Остановить и запустить расписание, по которому создаются снимки дисков](stop-and-start-schedule.md).
* [Изменить расписание, по которому создаются снимки дисков](update-schedule.md).
* [Удалить расписание, по которому создаются снимки дисков](delete-schedule.md).
* [Создать снимок диска вручную](../disk-control/create-snapshot.md).