# Изменить расписание, по которому создаются снимки дисков

## Изменить основные параметры {#update-basic-parameters}

Чтобы изменить основные параметры расписания снимков:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится расписание.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/snapshots.svg) **Снимки дисков**.
  1. Перейдите на вкладку **Расписания снимков**.
  1. Напротив расписания, которое нужно изменить, нажмите ![image](../../../_assets/options.svg) и выберите **Редактировать**.
  1. Измените параметры расписания снимков:
      * **Имя**:

        {% include [name-format](../../../_includes/name-format.md) %}

      * **Описание**.
      * В поле **Создавать снимки** выберите периодичность создания снимков: **По часам**, **По дням**, **По неделям** или [**По cron-выражению**](../../concepts/snapshot-schedule.md#cron). Время создания снимка указывается в часовом поясе [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00).
      * В поле **Начиная с** укажите дату, начиная с которой будет работать расписание.
      * Выберите политику хранения снимков:
        * **Хранить все снимки** — будут храниться все снимки, созданные по этому расписанию. 
        * **Только последние** — укажите количество последних снимков, которые нужно хранить, или количество дней, снимки за которые нужно хранить. Остальные снимки будут удаляться автоматически.

        {% note info %}

        На количество и суммарный объем снимков в облаке действуют [квоты](../../concepts/limits.md#compute-quotas).

        {% endnote %}

  1. Нажмите кнопку **Сохранить**.

- API

  1. Получите список расписаний с помощью метода [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API или метода [list](../../api-ref/SnapshotSchedule/list.md) для ресурса `SnapshotSchedule` REST API.
  1. Измените расписание снимков с помощью метода [SnapshotScheduleService/Update](../../api-ref/grpc/snapshot_schedule_service.md#Update) gRPC API или метода [update](../../api-ref/SnapshotSchedule/update.md) для ресурса `SnapshotSchedule` REST API.

{% endlist %}

## Изменить список дисков {#update-disk-list}

Чтобы изменить список дисков, снимки которых создаются по расписанию:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится расписание.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/snapshots.svg) **Снимки дисков**.
  1. На вкладке **Расписания снимков** выберите расписание, в котором нужно изменить список дисков.
  1. Измените список дисков:
      * Чтобы добавить новый диск, в блоке **Диски** нажмите кнопку ![image](../../../_assets/plus-sign.svg) **Добавить диск**. В открывшемся окне выберите диск, который нужно добавить к расписанию, и нажмите кнопку **Сохранить**.
      * Чтобы удалить диск, в блоке **Диски** напротив диска, который нужно удалить из расписания, нажмите ![image](../../../_assets/options.svg) и выберите **Удалить из расписания**.

- API

  1. Получите список расписаний с помощью метода [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API или метода [list](../../api-ref/SnapshotSchedule/list.md) для ресурса `SnapshotSchedule` REST API.
  1. Получите список дисков с помощью метода [DiskService/List](../../api-ref/grpc/disk_service.md#List) gRPC API или метода [list](../../api-ref/Disk/list.md) для ресурса `Disk` REST API.
  1. Измените список дисков в расписании с помощью метода [SnapshotScheduleService/UpdateDisks](../../api-ref/grpc/snapshot_schedule_service.md#UpdateDisks) gRPC API или метода [updateDisks](../../api-ref/SnapshotSchedule/updateDisks.md) для ресурса `SnapshotSchedule` REST API.

{% endlist %}

#### Что дальше {#what-is-next}

* [{#T}](stop-and-start-schedule.md)
* [{#T}](delete-schedule.md)
