Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ dataproc-name }}:

Метка | Значение
----|----
service | Идентификатор сервиса: `data-proc`
resource_type | Тип ресурса: `cluster`
resource_id | Идентификатор кластера
zone_id | Зона размещения
host | FQDN хоста

## Метрики HDFS {#data-proc-hdfs-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `dfs.cluster.Free_bytes`<br/>`DGAUGE`, байты | Доступное место на HDFS. |
| `dfs.cluster.NonDfsUsedSpace_bytes`<br/>`DGAUGE`, байты | Место, используемое подкластерами хранения данных (DataNode), недоступное для HDFS. |
| `dfs.cluster.PercentRemaining`<br/>`DGAUGE`, % | Доступное место на HDFS. |
| `dfs.cluster.PercentUsed`<br/>`DGAUGE`, % | Использованное место на HDFS. |
| `dfs.cluster.Total_bytes`<br/>`DGAUGE`, байты | Размер HDFS. |
| `dfs.cluster.Used_bytes`<br/>`DGAUGE`, байты | Использованное место на HDFS. |

## Метрики дисков {#data-proc-disk-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `system.disk.free_bytes`<br/>`DGAUGE`, байты | Доступное место в системном хранилище. |
| `system.disk.inodes_free`<br/>`DGAUGE`, штуки | Число свободных индексных дескриптеров. |
| `system.disk.inodes_total`<br/>`DGAUGE`, штуки | Общее число индексных дескрипторов. |
| `system.disk.inodes_used`<br/>`DGAUGE`, штуки | Число использованных индексных дескрипторов. |
| `system.disk.inodes_used_percent`<br/>`DGAUGE`, % | Процент использованных индексных дескрипторов. |
| `system.disk.total_bytes`<br/>`DGAUGE`, байты | Размер системного хранилища. |
| `system.disk.used_bytes`<br/>`DGAUGE`, байты | Использованное место на диске. |
| `system.disk.used_percent`<br/>`DGAUGE`, % | Использованное место на диске. |

## Метрики YARN {#data-proc-yarn-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `yarn.cluster.activeNodes`<br/>`DGAUGE`, штуки | Число активных нод. |
| `yarn.cluster.allocatedMB`<br/>`DGAUGE`, мегабайты | Размер выделенной памяти. |
| `yarn.cluster.allocatedVirtualCores`<br/>`DGAUGE`, штуки | Число выделенных виртуальных ядер. |
| `yarn.cluster.appsCompleted`<br/>`DGAUGE`, штуки | Успешно завершенные приложения. |
| `yarn.cluster.appsFailed`<br/>`DGAUGE`, штуки | Неуспешно завершенные приложения. |
| `yarn.cluster.appsKilled`<br/>`DGAUGE`, штуки | Прерванные приложения. |
| `yarn.cluster.appsPending`<br/>`DGAUGE`, штуки | Приложения в очереди. |
| `yarn.cluster.appsRunning`<br/>`DGAUGE`, штуки | Работающие приложения. |
| `yarn.cluster.appsSubmitted`<br/>`DGAUGE`, штуки | Запущенные приложения. |
| `yarn.cluster.availableMB`<br/>`DGAUGE`, мегабайты | Размер доступной памяти. |
| `yarn.cluster.availableVirtualCores`<br/>`DGAUGE`, штуки | Число доступных виртуальных ядер. |
| `yarn.cluster.containersAllocated`<br/>`DGAUGE`, штуки | Число выделенных контейнеров. |
| `yarn.cluster.containersPending`<br/>`DGAUGE`, штуки | Число контейнеров в очереди. |
| `yarn.cluster.containersReserved`<br/>`DGAUGE`, штуки | Число зарезервированных контейнеров. |
| `yarn.cluster.decommissionedNodes`<br/>`DGAUGE`, штуки | Число выведенных из эксплуатации. |
| `yarn.cluster.decommissioningNodes`<br/>`DGAUGE`, штуки | Ноды в процессе выведения из эксплуатации. |
| `yarn.cluster.lostNodes`<br/>`DGAUGE`, штуки | Число потерянных нод. |
| `yarn.cluster.rebootedNodes`<br/>`DGAUGE`, штуки | Число перезагруженных нод. |
| `yarn.cluster.reservedMB`<br/>`DGAUGE`, мегабайты | Зарезервированная память. |
| `yarn.cluster.reservedVirtualCores`<br/>`DGAUGE`, штуки | Число зарезервированных виртуальных ядер. |
| `yarn.cluster.shutdownNodes`<br/>`DGAUGE`, штуки | Число выключенных нод. |
| `yarn.cluster.totalAllocatedContainersAcrossPartition`<br/>`DGAUGE`, штуки | Выделенные контейнеры в партициях. |
| `yarn.cluster.totalMB`<br/>`DGAUGE`, мегабайты | Общий размер памяти. |
| `yarn.cluster.totalNodes`<br/>`DGAUGE`, штуки | Общее число нод. |
| `yarn.cluster.totalReservedResourcesAcrossPartition_memory`<br/>`DGAUGE` | Зарезервированная память во всех партициях. |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_0_maximumAllocation`<br/>`DGAUGE` | Максимальный объем зарезервированных ресурсов типа `0` во всех партициях. |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_0_minimumAllocation`<br/>`DGAUGE` | Минимальный объем зарезервированных ресурсов типа `0` во всех партициях. |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_0_value`<br/>`DGAUGE` | Текущий объем зарезервированных ресурсов типа `0` во всех партициях. |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_1_maximumAllocation`<br/>`DGAUGE` | Максимальный объем зарезервированных ресурсов типа `1` во всех партициях. |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_1_minimumAllocation`<br/>`DGAUGE` | Минимальный объем зарезервированных ресурсов типа `1` во всех партициях. |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_1_value`<br/>`DGAUGE` | Текущий объем зарезервированных ресурсов типа `1` во всех партициях. |
| `yarn.cluster.totalReservedResourcesAcrossPartition_vCores`<br/>`DGAUGE`, штуки | Зарезервированные виртуальные ядра во всех партициях. |
| `yarn.cluster.totalVirtualCores`<br/>`DGAUGE`, штуки | Общее число виртуальных ядер. |
| `yarn.cluster.unhealthyNodes`<br/>`DGAUGE`, штуки | Ноды в опасном состоянии. |
| `yarn.cluster.utilizedMBPercent`<br/>`DGAUGE`, % | Утилизация памяти. |
| `yarn.cluster.utilizedVirtualCoresPercent`<br/>`DGAUGE`, % | Утилизация виртуальных ядер. |

## Прочие метрики {#data-proc-other-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `dataproc.cluster.health_status`<br/>`IGAUGE`, 0/1/2 | Уровень работоспособности и техническое состояние кластера:<br/>`0` — Кластер неработоспособен: все его хосты не работают.<br/>`1` — Кластер работает не на полную мощность: минимум один из хостов имеет состояние, отличное от `ALIVE`.<br/>`2` — Кластер работает в штатном режиме. |
| `dataproc.cluster.neededAutoscalingNodesNumber`<br/>`DGAUGE`, штуки | Метрика сервиса {{ dataproc-full-name }} для масштабирования по умолчанию. |
