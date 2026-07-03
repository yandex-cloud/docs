# Дисковая подсистема

Дисковая подсистема {{ stackland-name }} обеспечивает динамическое выделение блочного хранилища для рабочих нагрузок Kubernetes.

## Архитектура {#architecture}

Дисковая подсистема состоит из четырех компонентов:

* **topolvm-controller** — центральный контроллер CSI. Обрабатывает запросы на создание и удаление томов, управляет привязкой PersistentVolumeClaim к узлам.
* **topolvm-node** — агент на каждом узле кластера. Создает и удаляет логические тома LVM по запросу контроллера, предоставляет метрики свободного места.
* **lvmd** — демон на каждом узле. Управляет LVM напрямую: создает и удаляет логические тома, сообщает о состоянии Volume Groups.
* **topovgm-operator** — оператор управления Volume Groups. Следит за ресурсами `VolumeGroup` и синхронизирует их с реальным состоянием LVM на узлах.

Схема работы при создании тома:

1. Пользователь создает `PersistentVolumeClaim` с нужным Storage Class.
1. topolvm-controller выбирает узел с достаточным свободным местом в соответствующей Volume Group.
1. topolvm-node на выбранном узле создает логический том LVM через lvmd.
1. Kubernetes монтирует том в под.

## Автоматическое обнаружение дисков {#auto-discovery}

При запуске topovgm-operator автоматически обнаруживает диски на каждом узле и создает Volume Groups по типам дисков. Диск включается в Volume Group, если он прошел все проверки.

Диск исключается из автоматического обнаружения по следующим причинам:

* `NotDisk` — устройство не является диском (раздел, loop-устройство, оптический привод).
* `Removable` — съемный диск.
* `TooSmall` — диск меньше минимального допустимого размера.
* `SystemDisk` — системный диск с разделами ОС или корневой файловой системой.
* `HasData` — на диске есть файловая система, таблица разделов или другие данные.
* `HasHolders` — диск используется устройствами dm-* или md.
* `WrongTier` — диск принадлежит другому уровню хранения.
* `Mounted` — диск или его раздел смонтирован.
* `ForeignLVM` — диск входит в Volume Group, не управляемую оператором.
* `NoStableId` — у диска нет стабильного идентификатора (WWN, серийный номер).
* `DuplicateId` — другой диск с таким же идентификатором уже обработан.
* `LockFailed` — оператор не смог получить эксклюзивную блокировку диска.
* `ReadError` — ошибка ввода-вывода или чтения udev при проверке диска.

Статус обнаружения каждого диска отображается в поле `status.discoveredDevices` ресурса `VolumeGroup`.

## Storage Classes {#storage-classes}

{{ stackland-name }} автоматически создает четыре Storage Class, соответствующих типам дисков:

* `stackland-nvme` — для NVMe-дисков.
* `stackland-ssd` — для SSD-дисков.
* `stackland-hdd` — для HDD-дисков.
* `stackland-other` — для остальных дисков. Используется по умолчанию.

Все Storage Classes имеют одинаковые параметры:

* Файловая система: XFS.
* Режим привязки тома: `WaitForFirstConsumer` — том создается только после планирования пода на узел.
* Расширение тома: разрешено.

Чтобы использовать конкретный Storage Class, укажите его имя в манифесте `PersistentVolumeClaim`:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
  namespace: my-project
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: stackland-ssd
  resources:
    requests:
      storage: 10Gi
```

Если `storageClassName` не указан, используется Storage Class по умолчанию, определенный в `StacklandClusterConfig.spec.storage.defaultStorageClass`. Подробнее см. в разделе [Начальная конфигурация](../../quickstart.md#configuration).

## Ресурс VolumeGroup {#volumegroup}

Ресурс `VolumeGroup` описывает желаемое состояние LVM Volume Group на конкретном узле. Оператор topovgm-operator следит за этими ресурсами и синхронизирует их с реальным состоянием LVM.

Пример ресурса `VolumeGroup` с выбором дисков по признаку вращения:

```yaml
apiVersion: topolvm.io/v1alpha1
kind: VolumeGroup
metadata:
  name: stackland-ssd
spec:
  nodeName: <имя_узла>
  physicalVolumeSelector:
    - matchLSBLK:
        - key: ROTA
          operator: In
          values:
            - "0"
```

Пример ресурса `VolumeGroup` с явным указанием дисков:

```yaml
apiVersion: topolvm.io/v1alpha1
kind: VolumeGroup
metadata:
  name: stackland-nvme
spec:
  nodeName: <имя_узла>
  physicalVolumeSelector:
    - matchLSBLK:
        - key: PATH
          operator: In
          values:
            - /dev/nvme0n1
            - /dev/nvme1n1
```

### Параметры VolumeGroup {#volumegroup-params}

* `spec.nodeName` — имя узла, на котором создается Volume Group. Неизменяемый параметр.
* `spec.physicalVolumeSelector` — селектор физических томов. Если не указан, оператор выбирает диски автоматически.
* `spec.deviceLossSynchronizationPolicy` — поведение при потере диска:
  * `Fail` (по умолчанию) — синхронизация прекращается до восстановления диска или ручного вмешательства.
  * `Remove` — отсутствующие физические тома удаляются из Volume Group, если на них нет логических томов.
  * `ForceRemove` — отсутствующие физические тома удаляются принудительно, даже если на них есть логические тома. Может привести к потере данных.
* `spec.deviceRemovalVolumePolicy` — поведение при удалении диска из селектора:
  * `MoveAndReduce` (по умолчанию) — данные переносятся на оставшиеся диски перед уменьшением Volume Group.
  * `Reduce` — Volume Group уменьшается немедленно. Завершится ошибкой, если на удаляемом диске есть логические тома.
  * `ForceReduce` — Volume Group уменьшается принудительно. Может привести к потере данных.
* `spec.tags` — теги Volume Group в LVM.
* `spec.allocationPolicy` — политика выделения экстентов: `Normal`, `Contiguous`, `Cling`, `Anywhere`, `ClingByTags` и `Inherit`.

### Статус VolumeGroup {#volumegroup-status}

Поле `status.conditions` содержит условие `VolumeGroupSyncedOnNode`:

* `True` — Volume Group присутствует на узле и доступна в LVM.
* `False` — синхронизация не выполнена. Причина указана в поле `reason`.

## Мониторинг {#monitoring}

### Метрики {#metrics}

Дисковая подсистема предоставляет метрики Prometheus.

Метрики TopoLVM (lvmd):

* `topolvm_volumegroup_available_bytes` — свободное место в Volume Group на узле;
* `topolvm_volumegroup_size_bytes` — общий размер Volume Group на узле.

Метрики TopoVGM:

* `topovgm_volumegroup_status` — статус Volume Group: `healthy`, `sync_failed`, `init_failed`.
* `topovgm_volumegroup_sync_errors_total` — счетчик ошибок синхронизации.
* `topovgm_volumegroup_last_sync_timestamp_seconds` — время последней успешной синхронизации.
* `topovgm_volumegroup_reconcile_duration_seconds` — длительность цикла согласования.
* `topovgm_volumegroup_phantom_device` — обнаружение фантомных устройств. Значение `1` означает, что физический том присутствует в LVM, но его блочное устройство отсутствует в sysfs. Запись выполняется без ошибок, но данные теряются.

### Алерты {#alerts}

{{ stackland-name }} включает набор готовых алертов для дисковой подсистемы:

* `VolumeGroupSpaceCritical` (critical) — свободное место в Volume Group менее 10%.
* `VolumeGroupSpaceLow` (warning) — свободное место в Volume Group менее 20%.
* `VolumeGroupMissing` (critical) — Volume Group не обнаружена на узле.
* `VolumeGroupMetricsStale` (critical) — метрики Volume Group не обновлялись более пяти минут.
* `VolumeGroupWillFillIn4Hours` (warning) — по тренду за час Volume Group заполнится менее чем за четыре часа.
* `VolumeGroupHealthDegraded` (critical) — Volume Group в состоянии `sync_failed` или `init_failed`.
* `VolumeGroupSyncErrors` (warning) — ошибки синхронизации Volume Group.
* `VolumeGroupNotSyncing` (warning) — Volume Group не синхронизировалась более 10 минут.
* `TopoLVMControllerDown` (critical) — контроллер TopoLVM недоступен.
* `TopoLVMNodeDown` (critical) — агент TopoLVM на узле недоступен.
* `TopoLVMLvmdDown` (critical) — демон lvmd на узле недоступен.
* `TopoVGMOperatorDown` (warning) — оператор TopoVGM недоступен.
* `PersistentVolumeClaimPending` (warning) — PVC в состоянии Pending более 5 минут.
* `TopoVGMReconcileErrors` (warning) — высокий error rate reconcile-контроллера VolumeGroup.
* `TopoVGMReconcileLatencyHigh` (warning) — P95 latency reconcile-контроллера VolumeGroup выше 10 секунд.
* `TopoVGMWorkQueueDepthHigh` (warning) — очередь контроллера VolumeGroup более 100 элементов.
* `StorageControllerReconcileErrors` (warning) — ошибки reconcile других storage-контроллеров в namespace stackland-volumes.
* `VolumeGroupNeverSynced` (warning) — оператор работает более 10 минут, но ни одна Volume Group не синхронизировалась.
* `VolumeGroupReconcileSlow` (warning) — P95 длительности reconcile Volume Group на узле выше 10 секунд.

Алерты дисковой подсистемы дополняют [мониторинг оборудования](../../concepts/hardware-monitoring.md), который отслеживает физическое состояние дисков (SMART, ошибки I/O, температуру).

### Дашборд Grafana {#grafana-dashboard}

Метрики дисковой подсистемы доступны в Grafana. Чтобы открыть дашборд:

1. Перейдите по адресу `grafana.sys.{{ cluster-domain }}`.
1. Откройте **Dashboards > stackland-monitoring > Storage**.
