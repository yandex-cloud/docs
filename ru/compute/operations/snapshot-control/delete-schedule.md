# Удалить расписание, по которому создаются снимки дисков

Чтобы удалить расписание снимков дисков:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится расписание.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/snapshots.svg) **Снимки дисков**.
  1. Перейдите на вкладку **Расписания снимков**.
  1. Напротив расписания, которое нужно удалить, нажмите ![image](../../../_assets/options.svg) и выберите **Удалить**.
  1. Подтвердите удаление расписания.

- API

  1. Получите список расписаний с помощью метода [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API или метода [list](../../api-ref/SnapshotSchedule/list.md) для ресурса `SnapshotSchedule` REST API.
  1. Удалите расписание снимков с помощью метода [SnapshotScheduleService/Delete](../../api-ref/grpc/snapshot_schedule_service.md#Delete) gRPC API или метода [delete](../../api-ref/SnapshotSchedule/delete.md) для ресурса `SnapshotSchedule` REST API.

{% endlist %}

Все операции по созданию и удалению снимков, начатые до удаления расписания, будут доведены до конца.
