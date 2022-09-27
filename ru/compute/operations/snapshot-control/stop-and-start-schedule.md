# Остановить и запустить расписание, по которому создаются снимки дисков

## Остановить расписание {#stop-schedule}

Чтобы остановить автоматическое создание [снимков дисков](../../concepts/snapshot.md) по [расписанию](../../concepts/snapshot-schedule.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится расписание.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/snapshots.svg) **Снимки дисков**.
  1. Перейдите на вкладку **Расписания снимков**.
  1. Напротив расписания, которое нужно остановить, нажмите ![image](../../../_assets/options.svg) и выберите **Остановить**.
  1. Подтвердите остановку расписания.

- API

  1. Получите список расписаний с помощью метода [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API или метода [list](../../api-ref/SnapshotSchedule/list.md) для ресурса `SnapshotSchedule` REST API.
  1. Остановите расписание снимков с помощью метода [SnapshotScheduleService/Disable](../../api-ref/grpc/snapshot_schedule_service.md#Disable) gRPC API или метода [disable](../../api-ref/SnapshotSchedule/disable.md) для ресурса `SnapshotSchedule` REST API.

{% endlist %}

Расписание перейдет в [статус](../../concepts/snapshot-schedule.md#statuses) `INACTIVE` — снимки дисков не создаются и не удаляются. 

Все операции по созданию и удалению снимков, начатые до остановки расписания, будут доведены до конца.

## Запустить расписание {#start-schedule}

Чтобы запустить автоматическое создание снимков дисков по расписанию:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится расписание.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/snapshots.svg) **Снимки дисков**.
  1. Перейдите на вкладку **Расписания снимков**.
  1. Напротив расписания, которое нужно запустить, нажмите ![image](../../../_assets/options.svg) и выберите **Запустить**.

- API

  1. Получите список расписаний с помощью метода [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API или метода [list](../../api-ref/SnapshotSchedule/list.md) для ресурса `SnapshotSchedule` REST API.
  1. Запустите расписание снимков с помощью метода [SnapshotScheduleService/Enable](../../api-ref/grpc/snapshot_schedule_service.md#Enable) gRPC API или метода [enable](../../api-ref/SnapshotSchedule/enable.md) для ресурса `SnapshotSchedule` REST API.

{% endlist %}

Расписание перейдет в статус `ACTIVE` — создаются новые снимки дисков и удаляются старые (если выбрана соответствующая опция в настройках [хранения снимков](../../concepts/snapshot-schedule.md#retention)). 

#### Что дальше {#what-is-next}

* [{#T}](update-schedule.md)
* [{#T}](delete-schedule.md) 
