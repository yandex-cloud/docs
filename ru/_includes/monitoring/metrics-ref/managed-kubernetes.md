Имя метрики пишется в метку `name`.

Все метрики сервиса {{ managed-k8s-name }} имеют общую метку `service=managed-kubernetes`.

## Метрики контейнера {#managed-kubernetes-container-metrics}

Общие метки для всех метрик контейнера:

Метка | Значение
----|----
cluster_id | Идентификатор кластера
container | Имя контейнера
namespace | Имя пространства имен
pod | Имя пода

Метрики контейнера:

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `container.cpu.core_usage_time`<br/>`COUNTER`, миллисекунды | Совокупная загрузка процессора на всех ядрах, используемых контейнером. |
| `container.cpu.limit_cores`<br/>`DGAUGE`, % | Ограничение количества ядер процессора в контейнере. |
| `container.cpu.limit_utilization`<br/>`DGAUGE`, % | Утилизация количества ядер процессора. |
| `container.cpu.request_cores`<br/>`DGAUGE`, % | Количество ядер процессора, запрошенных контейнером. |
| `container.cpu.request_utilization`<br/>`DGAUGE`, % | Утилизация количества ядер процессора, запрошенных контейнером. |
| `container.ephemeral_storage.used_bytes`<br/>`IGAUGE`, байты | Использование эфемерного хранилища. |
| `container.memory.limit_bytes`<br/>`IGAUGE`, байты | Ограничение объема памяти контейнера. |
| `container.memory.limit_utilization`<br/>`DGAUGE`, % | Утилизация памяти контейнера. |
| `container.memory.page_fault_count`<br/>`COUNTER`, байты | Ошибки страниц памяти в разбивке по типам: major и minor.<br/>Дополнительные метки: `fault_type`. |
| `container.memory.request_bytes`<br/>`IGAUGE`, байты | Объем памяти, запрошенной контейнером. |
| `container.memory.request_utilization`<br/>`DGAUGE`, % | Утилизация памяти, запрошенной контейнером. |
| `container.memory.used_bytes`<br/>`IGAUGE`, байты | Использование памяти контейнером. |
| `container.memory.working_set_bytes`<br/>`IGAUGE`, байты | Используемая память рабочего набора контейнера. |
| `container.restart_count`<br/>`COUNTER`, штуки | Количество перезапусков контейнера. |
| `container.uptime_seconds`<br/>`DGAUGE`, миллисекунды | Время работы контейнера с момента запуска. |

## Метрики мастера {#managed-kubernetes-master-metrics}

Общие метки для всех метрик мастера:

Метка | Значение
----|----
cluster_id | Идентификатор кластера
host | Идентификатор кластера

Метрики мастера:

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `master.cpu.utilization_percent`<br/>`DGAUGE`, % | Утилизация процессора. |
| `master.memory.utilization_percent`<br/>`DGAUGE`, % | Утилизация памяти. |

## Метрики узла {#managed-kubernetes-node-metrics}

Общие метки для всех метрик узла:

Метка | Значение
----|----
cluster_id | Идентификатор кластера
node | Имя узла

Метрики узла:

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `node.cpu.allocatable_cores`<br/>`DGAUGE`, % | Количество доступных ресурсов процессора на узле. |
| `node.cpu.core_usage_time`<br/>`COUNTER`, миллисекунды | Совокупная загрузка процессора на всех ядрах, используемых узлом. |
| `node.cpu.total_cores`<br/>`DGAUGE`, штуки | Общее количество процессорных ядер узла. |
| `node.ephemeral_storage.allocatable_bytes`<br/>`IGAUGE`, байты | Количество доступных ресурсов эфемерного хранилища на узле. |
| `node.ephemeral_storage.inodes_free`<br/>`IGAUGE`, штуки | Число свободных индексных дескрипторов. |
| `node.ephemeral_storage.inodes_total`<br/>`IGAUGE`, штуки | Общее число индексных дескрипторов. |
| `node.ephemeral_storage.total_bytes`<br/>`IGAUGE`, байты | Размер эфемерного хранилища. |
| `node.ephemeral_storage.used_bytes`<br/>`IGAUGE`, байты | Использование эфемерного хранилища узлом. |
| `node.memory.allocatable_bytes`<br/>`IGAUGE`, байты | Количество доступных ресурсов оперативной памяти на узле. |
| `node.memory.total_bytes`<br/>`IGAUGE`, байты | Общий объем памяти узла. |
| `node.memory.used_bytes`<br/>`IGAUGE`, байты | Использование памяти узлом. |
| `node.memory.working_set_bytes`<br/>`IGAUGE`, байты | Используемая память рабочего набора узла. |
| `node.network.received_bytes_count`<br/>`COUNTER`, байты | Входящий трафик (получено байтов из сети). |
| `node.network.sent_bytes_count`<br/>`COUNTER`, байты | Исходящий трафик (передано байтов в сеть). |
| `node.pid.limit`<br/>`IGAUGE`, штуки | Ограничение количества идентификаторов процессов в узле. |
| `node.pid.used`<br/>`IGAUGE`, штуки | Использование идентификаторов процессов в узле. |

## Метрики пода {#managed-kubernetes-pod-metrics}

Общие метки для всех метрик пода:

Метка | Значение
----|----
cluster_id | Идентификатор кластера
namespace | Имя пространства имен
pod | Имя пода

Метрики пода:

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `pod.cpu.core_usage_time`<br/>`COUNTER`, миллисекунды | Совокупная загрузка процессора на всех ядрах, используемых подом. |
| `pod.ephemeral_storage.used_bytes`<br/>`IGAUGE`, байты | Использование эфемерного хранилища подом. |
| `pod.memory.used_bytes`<br/>`IGAUGE`, байты | Использование памяти подом. |
| `pod.memory.working_set_bytes`<br/>`IGAUGE`, байты | Используемая память рабочего набора пода. |
| `pod.network.received_bytes_count`<br/>`COUNTER`, байты | Входящий трафик (получено байтов из сети). |
| `pod.network.sent_bytes_count`<br/>`COUNTER`, байты | Исходящий трафик (передано байтов в сеть). |
| `pod.volume.total_bytes`<br/>`IGAUGE`, байты | Общий объем временного тома.<br/>Дополнительные метки: `volume`. |
| `pod.volume.used_bytes`<br/>`IGAUGE`, байты | Использование временного тома.<br/>Дополнительные метки: `volume`. |
| `pod.volume.utilization`<br/>`DGAUGE`, % | Утилизация временного тома.<br/>Дополнительные метки: `volume`. |

## Метрики постоянного тома {#managed-kubernetes-persistent-volume-metrics}

Общие метки для всех метрик постоянного тома:

Метка | Значение
----|----
cluster_id | Идентификатор кластера
namespace | Имя пространства имен
persistentvolumeclaim | Имя Persistent Volume Claim

Метрики постоянного тома:

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `persistent_volume.inodes_free`<br/>`IGAUGE`, штуки | Число свободных индексных дескрипторов. |
| `persistent_volume.inodes_total`<br/>`IGAUGEE`, штуки | Общее число индексных дескрипторов. |
| `persistent_volume.total_bytes`<br/>`IGAUGE`, байты | Общий объем постоянного тома. |
| `persistent_volume.used_bytes`<br/>`IGAUGE`, байты | Использование постоянного тома. |
| `persistent_volume.utilization`<br/>`DGAUGE`, % | Утилизация постоянного тома. |
