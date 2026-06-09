# Справочник аудитных логов {{ at-full-name }}


В {{ at-name }} для {{ compute-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.compute.<имя_события>
```

Подробная JSON-структура записи события приведена в справочнике аудитных логов. События в нем отсортированы по алфавиту без разделения на уровни и содержат все возможные поля. В реальных логах набор полей зависит от параметров события и конкретного объекта.

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`AddInstanceOneToOneNat` | Добавление публичного IP-адреса виртуальной машине
`AttachInstanceDisk` | Подключение диска к ВМ
`AttachInstanceFilesystem` | Подключение файловой системы к ВМ
`AttachInstanceNetworkInterface` | Подключение сетевого интерфейса
`ChangeDiskStatus` | Изменение статуса нереплицируемого диска
`CrashInstance` | Аварийное отключение ВМ
`CreateDisk` | Создание диска
`CreateDiskPlacementGroup` | Создание группы размещения диска
`CreateFilesystem` | Создание файловой системы
`CreateGpuCluster` | Создание кластера GPU
`CreateHostGroup` | Создание группы выделенных хостов
`CreateImage` | Создание образа диска
`CreateInstance` | Создание ВМ
`CreatePlacementGroup` | Создание группы размещения
`CreateReservedInstancePool` | Создание пула резервов ВМ
`CreateSnapshot` | Создание снимка диска
`CreateSnapshotSchedule` | Создание расписания снимков диска
`DecommissionHost` | Вывод выделенного хоста в [обслуживание](concepts/dedicated-host.md#maintenance)
`DeleteDisk` | Удаление диска
`DeleteDiskPlacementGroup` | Удаление группы размещения диска
`DeleteFilesystem` | Удаление файловой системы
`DeleteGpuCluster` | Удаление кластера GPU
`DeleteHostGroup` | Удаление группы выделенных хостов
`DeleteImage` | Удаление образа диска
`DeleteInstance` | Удаление ВМ
`DeletePlacementGroup` | Удаление группы размещения
`DeleteReservedInstancePool` | Удаление пула резервов ВМ
`DeleteSnapshot` | Удаление снимка диска
`DeleteSnapshotSchedule` | Удаление расписания снимков диска
`DetachInstanceDisk` | Отключение диска от ВМ
`DetachInstanceFilesystem` | Отключение файловой системы от ВМ
`DetachInstanceNetworkInterface` | Отключение сетевого интерфейса
`DisableSnapshotSchedule` | Отключение расписания снимков диска
`EnableSnapshotSchedule` | Включение расписания снимков диска
`GuestStopInstance` | Остановка ВМ по команде из этой ВМ
`PreemptInstance` | Прерывание работы ВМ
`RemoveInstanceOneToOneNat` | Удаление публичного IP-адреса ВМ
`RestartInstance` | Перезагрузка ВМ
`StartInstance` | Запуск ВМ
`StopInstance` | Остановка ВМ
`UpdateDisk` | Изменение диска
`UpdateDiskPlacementGroup` | Изменение группы размещения диска
`UpdateFilesystem` | Изменение файловой системы
`UpdateGpuCluster` | Изменение кластера GPU
`UpdateHost` | Обновление [даты автоматического освобождения](concepts/dedicated-host.md#maintenance) выделенного хоста
`UpdateHostGroup` | Изменение группы выделенных хостов
`UpdateImage` | Изменение образа диска
`UpdateInstance` | Изменение ВМ
`UpdateInstanceMetadata` | Изменение метаданных ВМ
`UpdateInstanceNetworkInterface` | Изменение сетевых настроек ВМ
`UpdatePlacementGroup` | Изменение группы размещения
`UpdateReservedInstancePool` | Изменение пула резервов ВМ
`UpdateSnapshot` | Изменение снимка диска
`UpdateSnapshotSchedule` | Изменение параметров расписания снимков диска
`UpdateSnapshotScheduleDisks` | Изменение параметров расписания снимков дисков
`instancegroup` | Управление группой ВМ
`instancegroup.CreateInstanceGroup` | Создание группы ВМ
`instancegroup.DeleteInstanceGroup` | Удаление группы ВМ
`instancegroup.DeleteInstanceGroupInstances` | Удаление ВМ из группы
`instancegroup.DisableZones` | [Временное отключение](concepts/instance-groups/disable-enable-zone.md) зон доступности
`instancegroup.EnableZones` | Включение зон доступности
`instancegroup.PauseInstanceGroup` | Приостановка процессов управления группой ВМ
`instancegroup.ResumeInstanceGroup` | Возобновление процессов управления группой ВМ
`instancegroup.RollingRestartInstanceGroupInstances` | Поочередная перезагрузка ВМ из группы
`instancegroup.SetInstanceGroupAccessBindings` | Назначение ролей на группу ВМ
`instancegroup.StartInstanceGroup` | Запуск группы ВМ
`instancegroup.StopInstanceGroup` | Остановка группы ВМ
`instancegroup.StopInstanceGroupInstances` | Остановка ВМ из группы
`instancegroup.UpdateInstanceGroup` | Изменение группы ВМ
`instancegroup.UpdateInstanceGroupAccessBindings` | Изменение ролей для группы ВМ

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`serialssh.ConnectSerialPort` | Подключение к серийному порту инстанса
`MigrateInstance` | [Динамическая миграция](concepts/live-migration.md) ВМ ^*^ 

\* В аудитный лог попадают события только для ВМ с настроенной [политикой обслуживания](concepts/maintenance-policies.md).