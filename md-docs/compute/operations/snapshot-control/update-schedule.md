# Изменить расписание, по которому создаются снимки дисков


## Изменить основные параметры {#update-basic-parameters}

Чтобы изменить основные параметры [расписания](../../concepts/snapshot-schedule.md) [снимков дисков](../../concepts/snapshot.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится расписание.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **Снимки дисков**.
  1. Перейдите на вкладку **Расписания снимков**.
  1. Напротив расписания, которое нужно изменить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. Измените параметры расписания снимков [диска](../../concepts/disk.md):
     * **Имя**. Требования к имени:

       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

     * **Описание**.
     * В поле **Создавать снимки** выберите периодичность создания снимков диска: `По часам`, `По дням`, `По неделям` [или `По cron-выражению`](../../concepts/snapshot-schedule.md#cron). Время создания снимка диска указывается в часовом поясе [UTC±00:00](https://ru.wikipedia.org/wiki/UTC±00:00).
     * В поле **Начиная с** укажите дату, начиная с которой будет работать расписание.
     * Выберите политику хранения снимков диска:
       * **Хранить все снимки** — будут храниться все снимки диска, созданные по этому расписанию. 
       * **Только последние** — укажите количество последних снимков диска, которые нужно хранить, или количество дней, снимки за которые нужно хранить. Остальные снимки диска, созданные по этому расписанию, будут удаляться автоматически.

       {% note info %}

       На количество и суммарный объем снимков диска в облаке действуют [квоты](../../concepts/limits.md#compute-quotas).

       {% endnote %}

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команд [CLI](../../../cli/index.md) для работы с расписаниями:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule update --help
     ```

  1. Получите список расписаний в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute snapshot-schedule list --format yaml
     ```

     Результат:

     ```text
     - id: fc852cvb1ipd5********
       folder_id: e1ea8s8l71li********
       created_at: "2022-09-28T13:25:02Z"
     ...
         expression: 10 19 ? * *
       snapshot_count: "7"
       snapshot_spec: {}
     ```

  1. Измените параметры выбранного расписания:

     ```bash
     yc compute snapshot-schedule update <имя_или_идентификатор_расписания> \
       --new-name <новое_имя_расписания> \
       --description <описание> \
       --expression <cron-выражение> \
       --retention-period <срок_хранения_снимков_диска> \
       --snapshot-count <количество_снимков_диска> \
       --start-at <дата_и_время_начала> \
       --labels <метки>
      ```

     Где:
     * `--new-name` — новое имя расписания.
     * `--description` — описание.
     * `--expression` — [cron-выражение](../../concepts/snapshot-schedule.md#cron).
     * `--retention-period` — длительность хранения снимков [диска](../../concepts/disk.md), указанная в секундах (`s`), минутах (`m`) или часах (`h`).
     * `--snapshot-count` — количество хранимых снимков диска. Используйте либо параметр `--snapshot-count`, либо `--retention-period`. См. подробнее о политике [хранения снимков диска](../../concepts/snapshot-schedule.md#retention).
     * `--start-at` — дата и время начала. Также можно указать промежуток времени относительно текущего момента. Например: `"2022-12-31T16:39:00+05:00"`, `"2h"`.
     * `--labels` — метки, указанные в формате `ключ=значение`.

     Подробнее о команде `yc compute snapshot-schedule update` см. в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/snapshot-schedule/update.md).

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

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием расписания:

     {% cut "Пример описания расписания в конфигурации Terraform" %}

     ```hcl
     resource "yandex_compute_snapshot_schedule" "default" {
       name = "my-name"

       schedule_policy {
         expression = "0 0 * * *"
       }

       snapshot_count = 1

       snapshot_spec {
         description = "snapshot-description"
         labels = {
           snapshot-label = "my-snapshot-label-value"
         }
       }

       disk_ids = ["test_disk_id", "another_test_disk_id"]
     }
     ```

     {% endcut %}

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Проверить изменение расписания и его настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

  ```bash
  yc compute snapshot-schedule get <имя_расписания>
  ```

- API {#api}

  1. Получите список расписаний с помощью метода REST API [list](../../api-ref/SnapshotSchedule/list.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызова gRPC API [SnapshotScheduleService/List](../../api-ref/grpc/SnapshotSchedule/list.md).

     Создавать можно снимки сетевых [дисков](../../concepts/disk.md#disks_types) HDD, SSD и нереплицируемых SSD, а также сверхбыстрых сетевых хранилищ с тремя репликами (SSD).
     
     Для нереплицируемых SSD и сверхбыстрых сетевых хранилищ с тремя репликами (SSD) момент времени, когда фиксируется содержимое диска, не детерминирован.
     
     Для снимков с локальных дисков на [выделенных хостах](../../concepts/dedicated-host.md) используйте сервис [Yandex Cloud Backup](../../../backup/index.md) (поддерживает ОС Ubuntu, CentOS, CentOS Stream и Windows Server).

  1. Измените расписание снимков [диска](../../concepts/disk.md) с помощью метода REST API [update](../../api-ref/SnapshotSchedule/update.md) для ресурса `SnapshotSchedule` или вызова gRPC API [SnapshotScheduleService/Update](../../api-ref/grpc/SnapshotSchedule/update.md).

{% endlist %}

## Изменить список дисков {#update-disk-list}

Чтобы изменить список дисков, снимки диска которых создаются по расписанию:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится расписание.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **Снимки дисков**.
  1. На вкладке **Расписания снимков** выберите расписание, в котором нужно изменить список дисков.
  1. Измените список дисков:
     * Чтобы добавить новый диск, в блоке **Диски** нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить диск**. В открывшемся окне выберите диск, который нужно добавить к расписанию, и нажмите кнопку **Сохранить**.

       Создавать можно снимки сетевых [дисков](../../concepts/disk.md#disks_types) HDD, SSD и нереплицируемых SSD, а также сверхбыстрых сетевых хранилищ с тремя репликами (SSD).
       
       Для нереплицируемых SSD и сверхбыстрых сетевых хранилищ с тремя репликами (SSD) момент времени, когда фиксируется содержимое диска, не детерминирован.
       
       Для снимков с локальных дисков на [выделенных хостах](../../concepts/dedicated-host.md) используйте сервис [Yandex Cloud Backup](../../../backup/index.md) (поддерживает ОС Ubuntu, CentOS, CentOS Stream и Windows Server).

     * Чтобы удалить диск, в блоке **Диски** напротив диска, который нужно удалить из расписания, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Удалить из расписания**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Добавьте или [удалите](#remove) диски с помощью команд `add-disks` и `remove-disks`.

  Чтобы добавить диски:
  1. Посмотрите описание команд CLI для работы с расписаниями:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule add-disks --help
     ```

  1. Получите список расписаний в каталоге по умолчанию:

     ```bash
     yc compute snapshot-schedule list --format yaml
     ```

     Результат:

     ```text
     - id: fc852cvb1ipd5********
       folder_id: e1ea8s8l71li********
       created_at: "2022-09-28T13:25:02Z"
     ...
         expression: 10 19 ? * *
       snapshot_count: "7"
       snapshot_spec: {}
     ```

  1. Получите идентификаторы дисков, чтобы добавить их в расписание:

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

  Чтобы удалить диски: {#remove}
  1. Посмотрите описание команд CLI для работы с расписаниями:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule remove-disks --help
     ```

  1. Получите список расписаний в каталоге по умолчанию:

     ```bash
     yc compute snapshot-schedule list --format yaml
     ```

     Результат:

     ```text
     - id: fc852cvb1ipd5********
       folder_id: e1ea8s8l71li********
       created_at: "2022-09-28T13:25:02Z"
     ...
         expression: 10 19 ? * *
       snapshot_count: "7"
       snapshot_spec: {}
     ```

  1. Получите список дисков в выбранном расписании:

     ```bash
     yc compute snapshot-schedule list-disks <имя_или_идентификатор_расписания> \
       --format yaml
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

  1. Удалите диски из расписания:

     ```bash
     yc compute snapshot-schedule remove-disks <имя_или_идентификатор_расписания> \
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

- API {#api}

  1. Получите список расписаний с помощью метода REST API [list](../../api-ref/SnapshotSchedule/list.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызова gRPC API [SnapshotScheduleService/List](../../api-ref/grpc/SnapshotSchedule/list.md).
  1. Получите список дисков с помощью метода REST API [list](../../api-ref/Disk/list.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызова gRPC API [DiskService/List](../../api-ref/grpc/Disk/list.md).
  1. Измените список дисков в расписании с помощью метода REST API [updateDisks](../../api-ref/SnapshotSchedule/updateDisks.md) для ресурса `SnapshotSchedule` или вызова gRPC API [SnapshotScheduleService/UpdateDisks](../../api-ref/grpc/SnapshotSchedule/updateDisks.md).

{% endlist %}

## Примеры {#examples}

### Изменить имя расписания {#change-name}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Получите список расписаний в каталоге по умолчанию:

     ```bash
     yc compute snapshot-schedule list --format yaml
     ```

     Результат:

     ```text
     - id: fc852cvb1ipd5********
       folder_id: e1ea8s8l71li********
       created_at: "2022-09-28T13:25:02Z"
     ...
         expression: 10 19 ? * *
       snapshot_count: "7"
       snapshot_spec: {}
     ```

  1. Измените имя выбранного расписания:

     ```bash
     yc compute snapshot-schedule update sched-1 \
       --new-name "my-schedule"
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

{% endlist %}

#### Что дальше {#what-is-next}

* [Остановить и запустить расписание, по которому создаются снимки дисков](stop-and-start-schedule.md).
* [Удалить расписание, по которому создаются снимки дисков](delete-schedule.md).