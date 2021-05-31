---
editable: false
---

# InstanceGroupService

Набор методов для управления ресурсами InstanceGroup.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс InstanceGroup. |
| [List](#List) | Возвращает список доступных ресурсов InstanceGroup в указанном каталоге. |
| [Create](#Create) | Создает группу виртуальных машин в указанном каталоге. |
| [CreateFromYaml](#CreateFromYaml) | Создает группу виртуальных машин в указанном каталоге из YAML-файла. |
| [Update](#Update) | Изменяет указанную группу виртуальных машин. |
| [UpdateFromYaml](#UpdateFromYaml) | Обновляет указанную группу виртуальных машин из YAML-файла. |
| [Stop](#Stop) | Останавливает указанную группу виртуальных машин. |
| [Start](#Start) | Запускает указанную группу виртуальных машин. |
| [Delete](#Delete) | Удаляет указанную группу виртуальных машин. |
| [ListInstances](#ListInstances) | Возвращает список виртуальных машин для указанной группы ВМ. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанной группы виртуальных машин. |
| [ListLogRecords](#ListLogRecords) | Возвращает список логов для указанной группы виртуальных машин. |

## Вызовы InstanceGroupService {#calls}

## Get {#Get}

Возвращает указанный ресурс InstanceGroup. <br>Чтобы получить список доступных ресурсов InstanceGroup, используйте запрос [List](#List).

**rpc Get ([GetInstanceGroupRequest](#GetInstanceGroupRequest)) returns ([InstanceGroup](#InstanceGroup))**

### GetInstanceGroupRequest {#GetInstanceGroupRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса InstanceGroup. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). Максимальная длина строки в символах — 50.
view | enum **InstanceGroupView**<br>Определяет, какая информация о ресурсе Instance должна быть возвращена в ответе. <ul><li>`BASIC`: Не включает метаданные шаблона виртуальной машины в ответ сервера.</li><li>`FULL`: Возвращает метаданные шаблона виртуальной машины в ответе сервера.</li><ul/>


### InstanceGroup {#InstanceGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](#InstanceTemplate)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](#DeployPolicy)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


### InstanceTemplate {#InstanceTemplate}

Поле | Описание
--- | ---
description | **string**<br>Описание шаблона виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec)**<br>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec)**<br>Массив дополнительных дисков, которые будут подключенны к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec)**<br>Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине. Количество элементов должно быть ровно 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy)**<br>Политика планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для привязки к виртуальной машине. 


### ResourcesSpec {#ResourcesSpec}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Максимальное значение — 274877906944.
cores | **int64**<br>Количество ядер, доступное виртуальной машине. Значение должно быть равно 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. Значение должно быть равно 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Обязательное поле. Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Значение должно соответствовать регулярному выражению ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec)**<br>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk). 


### DiskSpec {#DiskSpec}

Поле | Описание
--- | ---
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Обязательное поле. Идентификатор типа диска. 
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source_oneof | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан диск. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан диск. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор облачной сети. 
subnet_ids[] | **string**<br>Идентификаторы подсетей. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec)**<br>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет. 


### OneToOneNatSpec {#OneToOneNatSpec}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy}

Поле | Описание
--- | ---
preemptible | **bool**<br>Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale` или `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale)**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#fixed-scale-policy) группы виртуальных машин. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale)**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#auto-scale-policy) группы виртуальных машин. 


### AutoScale {#AutoScale}

Поле | Описание
--- | ---
min_zone_size | **int64**<br>Минимальное количество виртуальных машин в каждой зоне. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100. Допустимые значения — от 0 до 100 включительно.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Время в секундах, отведенное на усреднение метрик. Допустимые значения — от 1m до 10m включительно.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются. Максимальное значение — 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться. Допустимые значения — от 1m до 30m включительно.
initial_size | **int64**<br>Размер целевой группы. Минимальная значение — 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule)**<br>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин. 
custom_rules[] | **[CustomRule](#CustomRule)**<br>Определяет правило автомасштабирования на основе [пользовательской метрики](/docs/monitoring/operations/metric/add) из Yandex Monitoring. Максимальное количество элементов — 1.


### CpuUtilizationRule {#CpuUtilizationRule}

Поле | Описание
--- | ---
utilization_target | **double**<br>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Допустимые значения — от 10 до 100 включительно.


### CustomRule {#CustomRule}

Поле | Описание
--- | ---
rule_type | enum **RuleType**<br>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`. <ul><li>`UTILIZATION`: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li><li>`WORKLOAD`: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li><ul/>
metric_type | enum **MetricType**<br>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики. <ul><li>`GAUGE`: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине. <br>Instance Groups вычисляет среднее значение метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale).</li><li>`COUNTER`: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине. <br>Instance Groups вычисляет средний прирост метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale).</li><ul/>
metric_name | **string**<br>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
target | **double**<br>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Значение должно быть больше 0.


### FixedScale {#FixedScale}

Поле | Описание
--- | ---
size | **int64**<br>Количество виртуальных машин в группе ВМ. Допустимые значения — от 1 до 100 включительно.


### DeployPolicy {#DeployPolicy}

Поле | Описание
--- | ---
max_unavailable | **int64**<br>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `max_expansion` не указано или равно нулю, `max_unavailable` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
max_deleting | **int64**<br>Максимальное количество удаляемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_creating | **int64**<br>Максимальное количество создаваемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_expansion | **int64**<br>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `max_unavailable` не указан или равен нулю, `max_expansion` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status`. Допустимые значения — от 0m до 1h включительно.


### AllocationPolicy {#AllocationPolicy}

Поле | Описание
--- | ---
zones[] | **[Zone](#Zone)**<br>Список зон доступности. Минимальное количество элементов — 1.


### Zone {#Zone}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. 


### LoadBalancerState {#LoadBalancerState}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор целевой группы для распределения нагрузки. 
status_message | **string**<br>Сообщение о состоянии целевой группы. 


### ManagedInstancesState {#ManagedInstancesState}

Поле | Описание
--- | ---
target_size | **int64**<br>Целевое количество виртуальных машин для данной группы ВМ. 
running_actual_count | **int64**<br>Число запущенных виртуальных машин, соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>Число запущенных виртуальных машин, не соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>Количество виртуальных машин, находящихся в процессе обновления, запуска, удаления. Дополнительные сведения см. в разделе [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses}

Поле | Описание
--- | ---
creating | **int64**<br>Виртуальная машина создается. 
starting | **int64**<br>Виртуальная машина запускается. 
opening | **int64**<br>Виртуальная машина открывается для получения трафика. 
warming | **int64**<br>Виртуальная машина прогревается. 
running | **int64**<br>Виртуальная машина работает нормально. 
closing | **int64**<br>Виртуальная машина закрывается для получения трафика. 
stopping | **int64**<br>Виртуальная машина останавливается. 
updating | **int64**<br>Виртуальная машина обновляется. 
deleting | **int64**<br>Виртуальная машина удаляется. 
failed | **int64**<br>Сбой виртуальной машины, которую необходимо пересоздать. 


### LoadBalancerSpec {#LoadBalancerSpec}

Поле | Описание
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec)**<br>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе [Целевые ресурсы и группы](/docs/load-balancer/concepts/target-resources). 


### TargetGroupSpec {#TargetGroupSpec}

Поле | Описание
--- | ---
name | **string**<br>Имя целевой группы. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec}

Поле | Описание
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). Минимальное количество элементов — 1.


### HealthCheckSpec {#HealthCheckSpec}

Поле | Описание
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал проверок. Значение по умолчанию — 2 секунды. Допустимые значения — от 1s до 300s включительно.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время ожидания ответа. Значение по умолчанию — 1 секунда. Допустимые значения — от 1s до 60s включительно.
unhealthy_threshold | **int64**<br>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` или `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions)**<br>Параметры для проверки состояний по протоколу TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions)**<br>Параметры для проверки состояний по протоколу HTTP. 


### TcpOptions {#TcpOptions}

Поле | Описание
--- | ---
port | **int64**<br>Порт TCP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions}

Поле | Описание
--- | ---
port | **int64**<br>Порт HTTP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL, по которому будут выполняться проверки (для HTTP). 


## List {#List}

Возвращает список доступных ресурсов InstanceGroup в указанном каталоге.

**rpc List ([ListInstanceGroupsRequest](#ListInstanceGroupsRequest)) returns ([ListInstanceGroupsResponse](#ListInstanceGroupsResponse))**

### ListInstanceGroupsRequest {#ListInstanceGroupsRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка групп виртуальных машин. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListInstanceGroupsResponse.next_page_token](#ListInstanceGroupsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListInstanceGroupsResponse.next_page_token](#ListInstanceGroupsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [InstanceGroup.name](#InstanceGroup1). Максимальная длина строки в символах — 1000.
view | enum **InstanceGroupView**<br>Определяет, какая информация о ресурсе Instance должна быть возвращена в ответе. <ul><li>`BASIC`: Не включает метаданные шаблона виртуальной машины в ответ сервера.</li><li>`FULL`: Возвращает метаданные шаблона виртуальной машины в ответе сервера.</li><ul/>


### ListInstanceGroupsResponse {#ListInstanceGroupsResponse}

Поле | Описание
--- | ---
instance_groups[] | **[InstanceGroup](#InstanceGroup1)**<br>Список групп виртуальных машин для указанного каталога. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListInstanceGroupsRequest.page_size](#ListInstanceGroupsRequest), используйте `next_page_token` в качестве значения параметра [ListInstanceGroupsRequest.page_token](#ListInstanceGroupsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### InstanceGroup {#InstanceGroup1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](#InstanceTemplate1)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy1)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](#DeployPolicy1)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy1)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState1)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState1)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec1)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec1)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


### InstanceTemplate {#InstanceTemplate1}

Поле | Описание
--- | ---
description | **string**<br>Описание шаблона виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec1)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec1)**<br>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec1)**<br>Массив дополнительных дисков, которые будут подключенны к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec1)**<br>Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине. Количество элементов должно быть ровно 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy1)**<br>Политика планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для привязки к виртуальной машине. 


### ResourcesSpec {#ResourcesSpec1}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Максимальное значение — 274877906944.
cores | **int64**<br>Количество ядер, доступное виртуальной машине. Значение должно быть равно 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. Значение должно быть равно 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec1}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Обязательное поле. Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Значение должно соответствовать регулярному выражению ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec1)**<br>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk). 


### DiskSpec {#DiskSpec1}

Поле | Описание
--- | ---
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Обязательное поле. Идентификатор типа диска. 
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source_oneof | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан диск. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан диск. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec1}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор облачной сети. 
subnet_ids[] | **string**<br>Идентификаторы подсетей. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec1)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec1)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec1}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec1)**<br>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет. 


### OneToOneNatSpec {#OneToOneNatSpec1}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy1}

Поле | Описание
--- | ---
preemptible | **bool**<br>Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy1}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale` или `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale1)**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#fixed-scale-policy) группы виртуальных машин. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale1)**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#auto-scale-policy) группы виртуальных машин. 


### AutoScale {#AutoScale1}

Поле | Описание
--- | ---
min_zone_size | **int64**<br>Минимальное количество виртуальных машин в каждой зоне. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100. Допустимые значения — от 0 до 100 включительно.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Время в секундах, отведенное на усреднение метрик. Допустимые значения — от 1m до 10m включительно.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются. Максимальное значение — 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться. Допустимые значения — от 1m до 30m включительно.
initial_size | **int64**<br>Размер целевой группы. Минимальная значение — 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule1)**<br>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин. 
custom_rules[] | **[CustomRule](#CustomRule1)**<br>Определяет правило автомасштабирования на основе [пользовательской метрики](/docs/monitoring/operations/metric/add) из Yandex Monitoring. Максимальное количество элементов — 1.


### CpuUtilizationRule {#CpuUtilizationRule1}

Поле | Описание
--- | ---
utilization_target | **double**<br>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Допустимые значения — от 10 до 100 включительно.


### CustomRule {#CustomRule1}

Поле | Описание
--- | ---
rule_type | enum **RuleType**<br>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`. <ul><li>`UTILIZATION`: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li><li>`WORKLOAD`: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li><ul/>
metric_type | enum **MetricType**<br>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики. <ul><li>`GAUGE`: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине. <br>Instance Groups вычисляет среднее значение метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale1).</li><li>`COUNTER`: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине. <br>Instance Groups вычисляет средний прирост метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale1).</li><ul/>
metric_name | **string**<br>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
target | **double**<br>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Значение должно быть больше 0.


### FixedScale {#FixedScale1}

Поле | Описание
--- | ---
size | **int64**<br>Количество виртуальных машин в группе ВМ. Допустимые значения — от 1 до 100 включительно.


### DeployPolicy {#DeployPolicy1}

Поле | Описание
--- | ---
max_unavailable | **int64**<br>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `max_expansion` не указано или равно нулю, `max_unavailable` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
max_deleting | **int64**<br>Максимальное количество удаляемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_creating | **int64**<br>Максимальное количество создаваемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_expansion | **int64**<br>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `max_unavailable` не указан или равен нулю, `max_expansion` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status`. Допустимые значения — от 0m до 1h включительно.


### AllocationPolicy {#AllocationPolicy1}

Поле | Описание
--- | ---
zones[] | **[Zone](#Zone1)**<br>Список зон доступности. Минимальное количество элементов — 1.


### Zone {#Zone1}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. 


### LoadBalancerState {#LoadBalancerState1}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор целевой группы для распределения нагрузки. 
status_message | **string**<br>Сообщение о состоянии целевой группы. 


### ManagedInstancesState {#ManagedInstancesState1}

Поле | Описание
--- | ---
target_size | **int64**<br>Целевое количество виртуальных машин для данной группы ВМ. 
running_actual_count | **int64**<br>Число запущенных виртуальных машин, соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>Число запущенных виртуальных машин, не соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>Количество виртуальных машин, находящихся в процессе обновления, запуска, удаления. Дополнительные сведения см. в разделе [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses1}

Поле | Описание
--- | ---
creating | **int64**<br>Виртуальная машина создается. 
starting | **int64**<br>Виртуальная машина запускается. 
opening | **int64**<br>Виртуальная машина открывается для получения трафика. 
warming | **int64**<br>Виртуальная машина прогревается. 
running | **int64**<br>Виртуальная машина работает нормально. 
closing | **int64**<br>Виртуальная машина закрывается для получения трафика. 
stopping | **int64**<br>Виртуальная машина останавливается. 
updating | **int64**<br>Виртуальная машина обновляется. 
deleting | **int64**<br>Виртуальная машина удаляется. 
failed | **int64**<br>Сбой виртуальной машины, которую необходимо пересоздать. 


### LoadBalancerSpec {#LoadBalancerSpec1}

Поле | Описание
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec1)**<br>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе [Целевые ресурсы и группы](/docs/load-balancer/concepts/target-resources). 


### TargetGroupSpec {#TargetGroupSpec1}

Поле | Описание
--- | ---
name | **string**<br>Имя целевой группы. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec1}

Поле | Описание
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec1)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). Минимальное количество элементов — 1.


### HealthCheckSpec {#HealthCheckSpec1}

Поле | Описание
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал проверок. Значение по умолчанию — 2 секунды. Допустимые значения — от 1s до 300s включительно.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время ожидания ответа. Значение по умолчанию — 1 секунда. Допустимые значения — от 1s до 60s включительно.
unhealthy_threshold | **int64**<br>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` или `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions1)**<br>Параметры для проверки состояний по протоколу TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions1)**<br>Параметры для проверки состояний по протоколу HTTP. 


### TcpOptions {#TcpOptions1}

Поле | Описание
--- | ---
port | **int64**<br>Порт TCP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions1}

Поле | Описание
--- | ---
port | **int64**<br>Порт HTTP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL, по которому будут выполняться проверки (для HTTP). 


## Create {#Create}

Создает группу виртуальных машин в указанном каталоге. Этот метод запускает операцию, которая может быть отменена другой операцией.

**rpc Create ([CreateInstanceGroupRequest](#CreateInstanceGroupRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateInstanceGroupMetadata](#CreateInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup2)<br>

### CreateInstanceGroupRequest {#CreateInstanceGroupRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для создания группы виртуальных машин. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
name | **string**<br>Имя группы виртуальных машин. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание группы виртуальных машин. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
instance_template | **[InstanceTemplate](#InstanceTemplate2)**<br>Обязательное поле. Шаблон виртуальной машины, на основе которого создается группа ВМ. 
scale_policy | **[ScalePolicy](#ScalePolicy2)**<br>Обязательное поле. [Политика масштабирования](/docs/compute/concepts/instance-groups/scale) группы виртуальных машин. 
deploy_policy | **[DeployPolicy](#DeployPolicy2)**<br>Обязательное поле. Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy2)**<br>Обязательное поле. Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec2)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec2)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т.п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 


### InstanceTemplate {#InstanceTemplate2}

Поле | Описание
--- | ---
description | **string**<br>Описание шаблона виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec2)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec2)**<br>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec2)**<br>Массив дополнительных дисков, которые будут подключенны к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec2)**<br>Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине. Количество элементов должно быть ровно 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy2)**<br>Политика планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для привязки к виртуальной машине. 


### ResourcesSpec {#ResourcesSpec2}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Максимальное значение — 274877906944.
cores | **int64**<br>Количество ядер, доступное виртуальной машине. Значение должно быть равно 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. Значение должно быть равно 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec2}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Обязательное поле. Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Значение должно соответствовать регулярному выражению ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec2)**<br>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk). 


### DiskSpec {#DiskSpec2}

Поле | Описание
--- | ---
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Обязательное поле. Идентификатор типа диска. 
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source_oneof | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан диск. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан диск. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec2}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор облачной сети. 
subnet_ids[] | **string**<br>Идентификаторы подсетей. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec2)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec2)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec2}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec2)**<br>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет. 


### OneToOneNatSpec {#OneToOneNatSpec2}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy2}

Поле | Описание
--- | ---
preemptible | **bool**<br>Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy2}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale` или `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale2)**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#fixed-scale-policy) группы виртуальных машин. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale2)**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#auto-scale-policy) группы виртуальных машин. 


### AutoScale {#AutoScale2}

Поле | Описание
--- | ---
min_zone_size | **int64**<br>Минимальное количество виртуальных машин в каждой зоне. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100. Допустимые значения — от 0 до 100 включительно.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Время в секундах, отведенное на усреднение метрик. Допустимые значения — от 1m до 10m включительно.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются. Максимальное значение — 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться. Допустимые значения — от 1m до 30m включительно.
initial_size | **int64**<br>Размер целевой группы. Минимальная значение — 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule2)**<br>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин. 
custom_rules[] | **[CustomRule](#CustomRule2)**<br>Определяет правило автомасштабирования на основе [пользовательской метрики](/docs/monitoring/operations/metric/add) из Yandex Monitoring. Максимальное количество элементов — 1.


### CpuUtilizationRule {#CpuUtilizationRule2}

Поле | Описание
--- | ---
utilization_target | **double**<br>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Допустимые значения — от 10 до 100 включительно.


### CustomRule {#CustomRule2}

Поле | Описание
--- | ---
rule_type | enum **RuleType**<br>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`. <ul><li>`UTILIZATION`: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li><li>`WORKLOAD`: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li><ul/>
metric_type | enum **MetricType**<br>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики. <ul><li>`GAUGE`: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине. <br>Instance Groups вычисляет среднее значение метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale2).</li><li>`COUNTER`: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине. <br>Instance Groups вычисляет средний прирост метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale2).</li><ul/>
metric_name | **string**<br>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
target | **double**<br>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Значение должно быть больше 0.


### FixedScale {#FixedScale2}

Поле | Описание
--- | ---
size | **int64**<br>Количество виртуальных машин в группе ВМ. Допустимые значения — от 1 до 100 включительно.


### DeployPolicy {#DeployPolicy2}

Поле | Описание
--- | ---
max_unavailable | **int64**<br>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `max_expansion` не указано или равно нулю, `max_unavailable` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
max_deleting | **int64**<br>Максимальное количество удаляемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_creating | **int64**<br>Максимальное количество создаваемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_expansion | **int64**<br>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `max_unavailable` не указан или равен нулю, `max_expansion` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status`. Допустимые значения — от 0m до 1h включительно.


### AllocationPolicy {#AllocationPolicy2}

Поле | Описание
--- | ---
zones[] | **[Zone](#Zone2)**<br>Список зон доступности. Минимальное количество элементов — 1.


### Zone {#Zone2}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. 


### LoadBalancerSpec {#LoadBalancerSpec2}

Поле | Описание
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec2)**<br>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе [Целевые ресурсы и группы](/docs/load-balancer/concepts/target-resources). 


### TargetGroupSpec {#TargetGroupSpec2}

Поле | Описание
--- | ---
name | **string**<br>Имя целевой группы. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec2}

Поле | Описание
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec2)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). Минимальное количество элементов — 1.


### HealthCheckSpec {#HealthCheckSpec2}

Поле | Описание
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал проверок. Значение по умолчанию — 2 секунды. Допустимые значения — от 1s до 300s включительно.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время ожидания ответа. Значение по умолчанию — 1 секунда. Допустимые значения — от 1s до 60s включительно.
unhealthy_threshold | **int64**<br>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` или `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions2)**<br>Параметры для проверки состояний по протоколу TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions2)**<br>Параметры для проверки состояний по протоколу HTTP. 


### TcpOptions {#TcpOptions2}

Поле | Описание
--- | ---
port | **int64**<br>Порт TCP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions2}

Поле | Описание
--- | ---
port | **int64**<br>Порт HTTP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL, по которому будут выполняться проверки (для HTTP). 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateInstanceGroupMetadata](#CreateInstanceGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup2)>**<br>в случае успешного выполнения операции. 


### CreateInstanceGroupMetadata {#CreateInstanceGroupMetadata}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Идентификатор создаваемой группы виртуальных машин. Максимальная длина строки в символах — 50.


### InstanceGroup {#InstanceGroup2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](#InstanceTemplate3)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy3)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](#DeployPolicy3)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy3)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState2)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState2)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec3)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec3)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


### InstanceTemplate {#InstanceTemplate3}

Поле | Описание
--- | ---
description | **string**<br>Описание шаблона виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec3)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec3)**<br>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec3)**<br>Массив дополнительных дисков, которые будут подключенны к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec3)**<br>Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине. Количество элементов должно быть ровно 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy3)**<br>Политика планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для привязки к виртуальной машине. 


### ResourcesSpec {#ResourcesSpec3}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Максимальное значение — 274877906944.
cores | **int64**<br>Количество ядер, доступное виртуальной машине. Значение должно быть равно 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. Значение должно быть равно 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec3}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Обязательное поле. Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Значение должно соответствовать регулярному выражению ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec3)**<br>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk). 


### DiskSpec {#DiskSpec3}

Поле | Описание
--- | ---
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Обязательное поле. Идентификатор типа диска. 
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source_oneof | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан диск. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан диск. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec3}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор облачной сети. 
subnet_ids[] | **string**<br>Идентификаторы подсетей. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec3)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec3)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec3}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec3)**<br>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет. 


### OneToOneNatSpec {#OneToOneNatSpec3}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy3}

Поле | Описание
--- | ---
preemptible | **bool**<br>Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy3}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale` или `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale3)**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#fixed-scale-policy) группы виртуальных машин. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale3)**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#auto-scale-policy) группы виртуальных машин. 


### AutoScale {#AutoScale3}

Поле | Описание
--- | ---
min_zone_size | **int64**<br>Минимальное количество виртуальных машин в каждой зоне. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100. Допустимые значения — от 0 до 100 включительно.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Время в секундах, отведенное на усреднение метрик. Допустимые значения — от 1m до 10m включительно.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются. Максимальное значение — 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться. Допустимые значения — от 1m до 30m включительно.
initial_size | **int64**<br>Размер целевой группы. Минимальная значение — 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule3)**<br>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин. 
custom_rules[] | **[CustomRule](#CustomRule3)**<br>Определяет правило автомасштабирования на основе [пользовательской метрики](/docs/monitoring/operations/metric/add) из Yandex Monitoring. Максимальное количество элементов — 1.


### CpuUtilizationRule {#CpuUtilizationRule3}

Поле | Описание
--- | ---
utilization_target | **double**<br>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Допустимые значения — от 10 до 100 включительно.


### CustomRule {#CustomRule3}

Поле | Описание
--- | ---
rule_type | enum **RuleType**<br>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`. <ul><li>`UTILIZATION`: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li><li>`WORKLOAD`: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li><ul/>
metric_type | enum **MetricType**<br>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики. <ul><li>`GAUGE`: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине. <br>Instance Groups вычисляет среднее значение метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale3).</li><li>`COUNTER`: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине. <br>Instance Groups вычисляет средний прирост метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale3).</li><ul/>
metric_name | **string**<br>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
target | **double**<br>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Значение должно быть больше 0.


### FixedScale {#FixedScale3}

Поле | Описание
--- | ---
size | **int64**<br>Количество виртуальных машин в группе ВМ. Допустимые значения — от 1 до 100 включительно.


### DeployPolicy {#DeployPolicy3}

Поле | Описание
--- | ---
max_unavailable | **int64**<br>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `max_expansion` не указано или равно нулю, `max_unavailable` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
max_deleting | **int64**<br>Максимальное количество удаляемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_creating | **int64**<br>Максимальное количество создаваемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_expansion | **int64**<br>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `max_unavailable` не указан или равен нулю, `max_expansion` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status`. Допустимые значения — от 0m до 1h включительно.


### AllocationPolicy {#AllocationPolicy3}

Поле | Описание
--- | ---
zones[] | **[Zone](#Zone3)**<br>Список зон доступности. Минимальное количество элементов — 1.


### Zone {#Zone3}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. 


### LoadBalancerState {#LoadBalancerState2}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор целевой группы для распределения нагрузки. 
status_message | **string**<br>Сообщение о состоянии целевой группы. 


### ManagedInstancesState {#ManagedInstancesState2}

Поле | Описание
--- | ---
target_size | **int64**<br>Целевое количество виртуальных машин для данной группы ВМ. 
running_actual_count | **int64**<br>Число запущенных виртуальных машин, соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>Число запущенных виртуальных машин, не соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>Количество виртуальных машин, находящихся в процессе обновления, запуска, удаления. Дополнительные сведения см. в разделе [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses2}

Поле | Описание
--- | ---
creating | **int64**<br>Виртуальная машина создается. 
starting | **int64**<br>Виртуальная машина запускается. 
opening | **int64**<br>Виртуальная машина открывается для получения трафика. 
warming | **int64**<br>Виртуальная машина прогревается. 
running | **int64**<br>Виртуальная машина работает нормально. 
closing | **int64**<br>Виртуальная машина закрывается для получения трафика. 
stopping | **int64**<br>Виртуальная машина останавливается. 
updating | **int64**<br>Виртуальная машина обновляется. 
deleting | **int64**<br>Виртуальная машина удаляется. 
failed | **int64**<br>Сбой виртуальной машины, которую необходимо пересоздать. 


### LoadBalancerSpec {#LoadBalancerSpec3}

Поле | Описание
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec3)**<br>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе [Целевые ресурсы и группы](/docs/load-balancer/concepts/target-resources). 


### TargetGroupSpec {#TargetGroupSpec3}

Поле | Описание
--- | ---
name | **string**<br>Имя целевой группы. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec3}

Поле | Описание
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec3)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). Минимальное количество элементов — 1.


### HealthCheckSpec {#HealthCheckSpec3}

Поле | Описание
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал проверок. Значение по умолчанию — 2 секунды. Допустимые значения — от 1s до 300s включительно.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время ожидания ответа. Значение по умолчанию — 1 секунда. Допустимые значения — от 1s до 60s включительно.
unhealthy_threshold | **int64**<br>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` или `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions3)**<br>Параметры для проверки состояний по протоколу TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions3)**<br>Параметры для проверки состояний по протоколу HTTP. 


### TcpOptions {#TcpOptions3}

Поле | Описание
--- | ---
port | **int64**<br>Порт TCP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions3}

Поле | Описание
--- | ---
port | **int64**<br>Порт HTTP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL, по которому будут выполняться проверки (для HTTP). 


## CreateFromYaml {#CreateFromYaml}

Создает группу виртуальных машин в указанном каталоге из YAML-файла. Этот метод запускает операцию, которая может быть отменена другой операцией.

**rpc CreateFromYaml ([CreateInstanceGroupFromYamlRequest](#CreateInstanceGroupFromYamlRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateInstanceGroupMetadata](#CreateInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup3)<br>

### CreateInstanceGroupFromYamlRequest {#CreateInstanceGroupFromYamlRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для создания группы виртуальных машин. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
instance_group_yaml | **string**<br>Обязательное поле. [InstanceGroupService.Create](#Create) request in YAML format. Максимальная длина строки в символах — 1048576.


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateInstanceGroupMetadata](#CreateInstanceGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup3)>**<br>в случае успешного выполнения операции. 


### CreateInstanceGroupMetadata {#CreateInstanceGroupMetadata1}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Идентификатор создаваемой группы виртуальных машин. Максимальная длина строки в символах — 50.


### InstanceGroup {#InstanceGroup3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](#InstanceTemplate4)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy4)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](#DeployPolicy4)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy4)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState3)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState3)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec4)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec4)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


### InstanceTemplate {#InstanceTemplate4}

Поле | Описание
--- | ---
description | **string**<br>Описание шаблона виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec4)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec4)**<br>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec4)**<br>Массив дополнительных дисков, которые будут подключенны к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec4)**<br>Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине. Количество элементов должно быть ровно 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy4)**<br>Политика планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для привязки к виртуальной машине. 


### ResourcesSpec {#ResourcesSpec4}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Максимальное значение — 274877906944.
cores | **int64**<br>Количество ядер, доступное виртуальной машине. Значение должно быть равно 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. Значение должно быть равно 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec4}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Обязательное поле. Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Значение должно соответствовать регулярному выражению ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec4)**<br>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk). 


### DiskSpec {#DiskSpec4}

Поле | Описание
--- | ---
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Обязательное поле. Идентификатор типа диска. 
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source_oneof | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан диск. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан диск. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec4}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор облачной сети. 
subnet_ids[] | **string**<br>Идентификаторы подсетей. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec4)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec4)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec4}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec4)**<br>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет. 


### OneToOneNatSpec {#OneToOneNatSpec4}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy4}

Поле | Описание
--- | ---
preemptible | **bool**<br>Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy4}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale` или `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale4)**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#fixed-scale-policy) группы виртуальных машин. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale4)**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#auto-scale-policy) группы виртуальных машин. 


### AutoScale {#AutoScale4}

Поле | Описание
--- | ---
min_zone_size | **int64**<br>Минимальное количество виртуальных машин в каждой зоне. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100. Допустимые значения — от 0 до 100 включительно.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Время в секундах, отведенное на усреднение метрик. Допустимые значения — от 1m до 10m включительно.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются. Максимальное значение — 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться. Допустимые значения — от 1m до 30m включительно.
initial_size | **int64**<br>Размер целевой группы. Минимальная значение — 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule4)**<br>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин. 
custom_rules[] | **[CustomRule](#CustomRule4)**<br>Определяет правило автомасштабирования на основе [пользовательской метрики](/docs/monitoring/operations/metric/add) из Yandex Monitoring. Максимальное количество элементов — 1.


### CpuUtilizationRule {#CpuUtilizationRule4}

Поле | Описание
--- | ---
utilization_target | **double**<br>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Допустимые значения — от 10 до 100 включительно.


### CustomRule {#CustomRule4}

Поле | Описание
--- | ---
rule_type | enum **RuleType**<br>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`. <ul><li>`UTILIZATION`: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li><li>`WORKLOAD`: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li><ul/>
metric_type | enum **MetricType**<br>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики. <ul><li>`GAUGE`: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине. <br>Instance Groups вычисляет среднее значение метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale4).</li><li>`COUNTER`: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине. <br>Instance Groups вычисляет средний прирост метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale4).</li><ul/>
metric_name | **string**<br>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
target | **double**<br>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Значение должно быть больше 0.


### FixedScale {#FixedScale4}

Поле | Описание
--- | ---
size | **int64**<br>Количество виртуальных машин в группе ВМ. Допустимые значения — от 1 до 100 включительно.


### DeployPolicy {#DeployPolicy4}

Поле | Описание
--- | ---
max_unavailable | **int64**<br>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `max_expansion` не указано или равно нулю, `max_unavailable` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
max_deleting | **int64**<br>Максимальное количество удаляемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_creating | **int64**<br>Максимальное количество создаваемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_expansion | **int64**<br>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `max_unavailable` не указан или равен нулю, `max_expansion` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status`. Допустимые значения — от 0m до 1h включительно.


### AllocationPolicy {#AllocationPolicy4}

Поле | Описание
--- | ---
zones[] | **[Zone](#Zone4)**<br>Список зон доступности. Минимальное количество элементов — 1.


### Zone {#Zone4}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. 


### LoadBalancerState {#LoadBalancerState3}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор целевой группы для распределения нагрузки. 
status_message | **string**<br>Сообщение о состоянии целевой группы. 


### ManagedInstancesState {#ManagedInstancesState3}

Поле | Описание
--- | ---
target_size | **int64**<br>Целевое количество виртуальных машин для данной группы ВМ. 
running_actual_count | **int64**<br>Число запущенных виртуальных машин, соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>Число запущенных виртуальных машин, не соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>Количество виртуальных машин, находящихся в процессе обновления, запуска, удаления. Дополнительные сведения см. в разделе [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses3}

Поле | Описание
--- | ---
creating | **int64**<br>Виртуальная машина создается. 
starting | **int64**<br>Виртуальная машина запускается. 
opening | **int64**<br>Виртуальная машина открывается для получения трафика. 
warming | **int64**<br>Виртуальная машина прогревается. 
running | **int64**<br>Виртуальная машина работает нормально. 
closing | **int64**<br>Виртуальная машина закрывается для получения трафика. 
stopping | **int64**<br>Виртуальная машина останавливается. 
updating | **int64**<br>Виртуальная машина обновляется. 
deleting | **int64**<br>Виртуальная машина удаляется. 
failed | **int64**<br>Сбой виртуальной машины, которую необходимо пересоздать. 


### LoadBalancerSpec {#LoadBalancerSpec4}

Поле | Описание
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec4)**<br>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе [Целевые ресурсы и группы](/docs/load-balancer/concepts/target-resources). 


### TargetGroupSpec {#TargetGroupSpec4}

Поле | Описание
--- | ---
name | **string**<br>Имя целевой группы. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec4}

Поле | Описание
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec4)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). Минимальное количество элементов — 1.


### HealthCheckSpec {#HealthCheckSpec4}

Поле | Описание
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал проверок. Значение по умолчанию — 2 секунды. Допустимые значения — от 1s до 300s включительно.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время ожидания ответа. Значение по умолчанию — 1 секунда. Допустимые значения — от 1s до 60s включительно.
unhealthy_threshold | **int64**<br>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` или `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions4)**<br>Параметры для проверки состояний по протоколу TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions4)**<br>Параметры для проверки состояний по протоколу HTTP. 


### TcpOptions {#TcpOptions4}

Поле | Описание
--- | ---
port | **int64**<br>Порт TCP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions4}

Поле | Описание
--- | ---
port | **int64**<br>Порт HTTP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL, по которому будут выполняться проверки (для HTTP). 


## Update {#Update}

Изменяет указанную группу виртуальных машин. Этот метод запускает операцию, которая может быть отменена другой операцией.

**rpc Update ([UpdateInstanceGroupRequest](#UpdateInstanceGroupRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateInstanceGroupMetadata](#UpdateInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup4)<br>

### UpdateInstanceGroupRequest {#UpdateInstanceGroupRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор обновляемой группы виртуальных машин. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса InstanceGroup будут обновлены. 
name | **string**<br>Имя группы виртуальных машин. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание группы виртуальных машин. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. <br>Существующий набор `labels` полностью перезаписывается набором, переданным в запросе. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
instance_template | **[InstanceTemplate](#InstanceTemplate5)**<br>Обязательное поле. Шаблон виртуальной машины, на основе которого создается группа ВМ. 
scale_policy | **[ScalePolicy](#ScalePolicy5)**<br>Обязательное поле. [Политика масштабирования](/docs/compute/concepts/instance-groups/scale) группы виртуальных машин. 
deploy_policy | **[DeployPolicy](#DeployPolicy5)**<br>Обязательное поле. Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy5)**<br>Обязательное поле. Политика распределения группы виртуальных машин по зонам и регионам. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec5)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т.п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec5)**<br>Спецификация балансировщика нагрузки для управления распределением нагрузки. 


### InstanceTemplate {#InstanceTemplate5}

Поле | Описание
--- | ---
description | **string**<br>Описание шаблона виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec5)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec5)**<br>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec5)**<br>Массив дополнительных дисков, которые будут подключенны к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec5)**<br>Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине. Количество элементов должно быть ровно 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy5)**<br>Политика планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для привязки к виртуальной машине. 


### ResourcesSpec {#ResourcesSpec5}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Максимальное значение — 274877906944.
cores | **int64**<br>Количество ядер, доступное виртуальной машине. Значение должно быть равно 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. Значение должно быть равно 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec5}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Обязательное поле. Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Значение должно соответствовать регулярному выражению ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec5)**<br>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk). 


### DiskSpec {#DiskSpec5}

Поле | Описание
--- | ---
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Обязательное поле. Идентификатор типа диска. 
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source_oneof | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан диск. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан диск. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec5}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор облачной сети. 
subnet_ids[] | **string**<br>Идентификаторы подсетей. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec5)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec5)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec5}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec5)**<br>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет. 


### OneToOneNatSpec {#OneToOneNatSpec5}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy5}

Поле | Описание
--- | ---
preemptible | **bool**<br>Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy5}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale` или `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale5)**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#fixed-scale-policy) группы виртуальных машин. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale5)**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#auto-scale-policy) группы виртуальных машин. 


### AutoScale {#AutoScale5}

Поле | Описание
--- | ---
min_zone_size | **int64**<br>Минимальное количество виртуальных машин в каждой зоне. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100. Допустимые значения — от 0 до 100 включительно.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Время в секундах, отведенное на усреднение метрик. Допустимые значения — от 1m до 10m включительно.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются. Максимальное значение — 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться. Допустимые значения — от 1m до 30m включительно.
initial_size | **int64**<br>Размер целевой группы. Минимальная значение — 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule5)**<br>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин. 
custom_rules[] | **[CustomRule](#CustomRule5)**<br>Определяет правило автомасштабирования на основе [пользовательской метрики](/docs/monitoring/operations/metric/add) из Yandex Monitoring. Максимальное количество элементов — 1.


### CpuUtilizationRule {#CpuUtilizationRule5}

Поле | Описание
--- | ---
utilization_target | **double**<br>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Допустимые значения — от 10 до 100 включительно.


### CustomRule {#CustomRule5}

Поле | Описание
--- | ---
rule_type | enum **RuleType**<br>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`. <ul><li>`UTILIZATION`: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li><li>`WORKLOAD`: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li><ul/>
metric_type | enum **MetricType**<br>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики. <ul><li>`GAUGE`: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине. <br>Instance Groups вычисляет среднее значение метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale5).</li><li>`COUNTER`: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине. <br>Instance Groups вычисляет средний прирост метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale5).</li><ul/>
metric_name | **string**<br>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
target | **double**<br>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Значение должно быть больше 0.


### FixedScale {#FixedScale5}

Поле | Описание
--- | ---
size | **int64**<br>Количество виртуальных машин в группе ВМ. Допустимые значения — от 1 до 100 включительно.


### DeployPolicy {#DeployPolicy5}

Поле | Описание
--- | ---
max_unavailable | **int64**<br>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `max_expansion` не указано или равно нулю, `max_unavailable` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
max_deleting | **int64**<br>Максимальное количество удаляемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_creating | **int64**<br>Максимальное количество создаваемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_expansion | **int64**<br>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `max_unavailable` не указан или равен нулю, `max_expansion` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status`. Допустимые значения — от 0m до 1h включительно.


### AllocationPolicy {#AllocationPolicy5}

Поле | Описание
--- | ---
zones[] | **[Zone](#Zone5)**<br>Список зон доступности. Минимальное количество элементов — 1.


### Zone {#Zone5}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. 


### HealthChecksSpec {#HealthChecksSpec5}

Поле | Описание
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec5)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). Минимальное количество элементов — 1.


### HealthCheckSpec {#HealthCheckSpec5}

Поле | Описание
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал проверок. Значение по умолчанию — 2 секунды. Допустимые значения — от 1s до 300s включительно.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время ожидания ответа. Значение по умолчанию — 1 секунда. Допустимые значения — от 1s до 60s включительно.
unhealthy_threshold | **int64**<br>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` или `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions5)**<br>Параметры для проверки состояний по протоколу TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions5)**<br>Параметры для проверки состояний по протоколу HTTP. 


### TcpOptions {#TcpOptions5}

Поле | Описание
--- | ---
port | **int64**<br>Порт TCP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions5}

Поле | Описание
--- | ---
port | **int64**<br>Порт HTTP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL, по которому будут выполняться проверки (для HTTP). 


### LoadBalancerSpec {#LoadBalancerSpec5}

Поле | Описание
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec5)**<br>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе [Целевые ресурсы и группы](/docs/load-balancer/concepts/target-resources). 


### TargetGroupSpec {#TargetGroupSpec5}

Поле | Описание
--- | ---
name | **string**<br>Имя целевой группы. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateInstanceGroupMetadata](#UpdateInstanceGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup4)>**<br>в случае успешного выполнения операции. 


### UpdateInstanceGroupMetadata {#UpdateInstanceGroupMetadata}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Идентификатор изменяемого ресурса InstanceGroup. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). 


### InstanceGroup {#InstanceGroup4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](#InstanceTemplate6)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy6)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](#DeployPolicy6)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy6)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState4)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState4)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec6)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec6)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


### InstanceTemplate {#InstanceTemplate6}

Поле | Описание
--- | ---
description | **string**<br>Описание шаблона виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec6)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec6)**<br>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec6)**<br>Массив дополнительных дисков, которые будут подключенны к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec6)**<br>Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине. Количество элементов должно быть ровно 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy6)**<br>Политика планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для привязки к виртуальной машине. 


### ResourcesSpec {#ResourcesSpec6}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Максимальное значение — 274877906944.
cores | **int64**<br>Количество ядер, доступное виртуальной машине. Значение должно быть равно 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. Значение должно быть равно 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec6}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Обязательное поле. Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Значение должно соответствовать регулярному выражению ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec6)**<br>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk). 


### DiskSpec {#DiskSpec6}

Поле | Описание
--- | ---
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Обязательное поле. Идентификатор типа диска. 
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source_oneof | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан диск. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан диск. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec6}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор облачной сети. 
subnet_ids[] | **string**<br>Идентификаторы подсетей. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec6)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec6)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec6}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec6)**<br>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет. 


### OneToOneNatSpec {#OneToOneNatSpec6}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy6}

Поле | Описание
--- | ---
preemptible | **bool**<br>Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy6}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale` или `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale6)**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#fixed-scale-policy) группы виртуальных машин. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale6)**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#auto-scale-policy) группы виртуальных машин. 


### AutoScale {#AutoScale6}

Поле | Описание
--- | ---
min_zone_size | **int64**<br>Минимальное количество виртуальных машин в каждой зоне. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100. Допустимые значения — от 0 до 100 включительно.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Время в секундах, отведенное на усреднение метрик. Допустимые значения — от 1m до 10m включительно.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются. Максимальное значение — 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться. Допустимые значения — от 1m до 30m включительно.
initial_size | **int64**<br>Размер целевой группы. Минимальная значение — 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule6)**<br>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин. 
custom_rules[] | **[CustomRule](#CustomRule6)**<br>Определяет правило автомасштабирования на основе [пользовательской метрики](/docs/monitoring/operations/metric/add) из Yandex Monitoring. Максимальное количество элементов — 1.


### CpuUtilizationRule {#CpuUtilizationRule6}

Поле | Описание
--- | ---
utilization_target | **double**<br>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Допустимые значения — от 10 до 100 включительно.


### CustomRule {#CustomRule6}

Поле | Описание
--- | ---
rule_type | enum **RuleType**<br>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`. <ul><li>`UTILIZATION`: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li><li>`WORKLOAD`: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li><ul/>
metric_type | enum **MetricType**<br>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики. <ul><li>`GAUGE`: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине. <br>Instance Groups вычисляет среднее значение метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale6).</li><li>`COUNTER`: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине. <br>Instance Groups вычисляет средний прирост метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale6).</li><ul/>
metric_name | **string**<br>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
target | **double**<br>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Значение должно быть больше 0.


### FixedScale {#FixedScale6}

Поле | Описание
--- | ---
size | **int64**<br>Количество виртуальных машин в группе ВМ. Допустимые значения — от 1 до 100 включительно.


### DeployPolicy {#DeployPolicy6}

Поле | Описание
--- | ---
max_unavailable | **int64**<br>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `max_expansion` не указано или равно нулю, `max_unavailable` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
max_deleting | **int64**<br>Максимальное количество удаляемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_creating | **int64**<br>Максимальное количество создаваемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_expansion | **int64**<br>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `max_unavailable` не указан или равен нулю, `max_expansion` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status`. Допустимые значения — от 0m до 1h включительно.


### AllocationPolicy {#AllocationPolicy6}

Поле | Описание
--- | ---
zones[] | **[Zone](#Zone6)**<br>Список зон доступности. Минимальное количество элементов — 1.


### Zone {#Zone6}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. 


### LoadBalancerState {#LoadBalancerState4}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор целевой группы для распределения нагрузки. 
status_message | **string**<br>Сообщение о состоянии целевой группы. 


### ManagedInstancesState {#ManagedInstancesState4}

Поле | Описание
--- | ---
target_size | **int64**<br>Целевое количество виртуальных машин для данной группы ВМ. 
running_actual_count | **int64**<br>Число запущенных виртуальных машин, соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>Число запущенных виртуальных машин, не соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>Количество виртуальных машин, находящихся в процессе обновления, запуска, удаления. Дополнительные сведения см. в разделе [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses4}

Поле | Описание
--- | ---
creating | **int64**<br>Виртуальная машина создается. 
starting | **int64**<br>Виртуальная машина запускается. 
opening | **int64**<br>Виртуальная машина открывается для получения трафика. 
warming | **int64**<br>Виртуальная машина прогревается. 
running | **int64**<br>Виртуальная машина работает нормально. 
closing | **int64**<br>Виртуальная машина закрывается для получения трафика. 
stopping | **int64**<br>Виртуальная машина останавливается. 
updating | **int64**<br>Виртуальная машина обновляется. 
deleting | **int64**<br>Виртуальная машина удаляется. 
failed | **int64**<br>Сбой виртуальной машины, которую необходимо пересоздать. 


### LoadBalancerSpec {#LoadBalancerSpec6}

Поле | Описание
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec6)**<br>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе [Целевые ресурсы и группы](/docs/load-balancer/concepts/target-resources). 


### TargetGroupSpec {#TargetGroupSpec6}

Поле | Описание
--- | ---
name | **string**<br>Имя целевой группы. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec6}

Поле | Описание
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec6)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). Минимальное количество элементов — 1.


### HealthCheckSpec {#HealthCheckSpec6}

Поле | Описание
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал проверок. Значение по умолчанию — 2 секунды. Допустимые значения — от 1s до 300s включительно.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время ожидания ответа. Значение по умолчанию — 1 секунда. Допустимые значения — от 1s до 60s включительно.
unhealthy_threshold | **int64**<br>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` или `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions6)**<br>Параметры для проверки состояний по протоколу TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions6)**<br>Параметры для проверки состояний по протоколу HTTP. 


### TcpOptions {#TcpOptions6}

Поле | Описание
--- | ---
port | **int64**<br>Порт TCP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions6}

Поле | Описание
--- | ---
port | **int64**<br>Порт HTTP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL, по которому будут выполняться проверки (для HTTP). 


## UpdateFromYaml {#UpdateFromYaml}

Обновляет указанную группу виртуальных машин из YAML-файла. Этот метод запускает операцию, которая может быть отменена другой операцией.

**rpc UpdateFromYaml ([UpdateInstanceGroupFromYamlRequest](#UpdateInstanceGroupFromYamlRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateInstanceGroupMetadata](#UpdateInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup5)<br>

### UpdateInstanceGroupFromYamlRequest {#UpdateInstanceGroupFromYamlRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор обновляемой группы виртуальных машин. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). Максимальная длина строки в символах — 50.
instance_group_yaml | **string**<br>Обязательное поле. [InstanceGroupService.Update](#Update) request in YAML format. Максимальная длина строки в символах — 1048576.


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateInstanceGroupMetadata](#UpdateInstanceGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup5)>**<br>в случае успешного выполнения операции. 


### UpdateInstanceGroupMetadata {#UpdateInstanceGroupMetadata1}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Идентификатор изменяемого ресурса InstanceGroup. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). 


### InstanceGroup {#InstanceGroup5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](#InstanceTemplate7)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy7)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](#DeployPolicy7)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy7)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState5)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState5)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec7)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec7)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


### InstanceTemplate {#InstanceTemplate7}

Поле | Описание
--- | ---
description | **string**<br>Описание шаблона виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec7)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec7)**<br>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec7)**<br>Массив дополнительных дисков, которые будут подключенны к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec7)**<br>Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине. Количество элементов должно быть ровно 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy7)**<br>Политика планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для привязки к виртуальной машине. 


### ResourcesSpec {#ResourcesSpec7}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Максимальное значение — 274877906944.
cores | **int64**<br>Количество ядер, доступное виртуальной машине. Значение должно быть равно 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. Значение должно быть равно 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec7}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Обязательное поле. Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Значение должно соответствовать регулярному выражению ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec7)**<br>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk). 


### DiskSpec {#DiskSpec7}

Поле | Описание
--- | ---
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Обязательное поле. Идентификатор типа диска. 
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source_oneof | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан диск. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан диск. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec7}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор облачной сети. 
subnet_ids[] | **string**<br>Идентификаторы подсетей. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec7)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec7)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec7}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec7)**<br>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет. 


### OneToOneNatSpec {#OneToOneNatSpec7}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy7}

Поле | Описание
--- | ---
preemptible | **bool**<br>Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy7}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale` или `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale7)**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#fixed-scale-policy) группы виртуальных машин. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale7)**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#auto-scale-policy) группы виртуальных машин. 


### AutoScale {#AutoScale7}

Поле | Описание
--- | ---
min_zone_size | **int64**<br>Минимальное количество виртуальных машин в каждой зоне. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100. Допустимые значения — от 0 до 100 включительно.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Время в секундах, отведенное на усреднение метрик. Допустимые значения — от 1m до 10m включительно.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются. Максимальное значение — 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться. Допустимые значения — от 1m до 30m включительно.
initial_size | **int64**<br>Размер целевой группы. Минимальная значение — 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule7)**<br>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин. 
custom_rules[] | **[CustomRule](#CustomRule7)**<br>Определяет правило автомасштабирования на основе [пользовательской метрики](/docs/monitoring/operations/metric/add) из Yandex Monitoring. Максимальное количество элементов — 1.


### CpuUtilizationRule {#CpuUtilizationRule7}

Поле | Описание
--- | ---
utilization_target | **double**<br>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Допустимые значения — от 10 до 100 включительно.


### CustomRule {#CustomRule7}

Поле | Описание
--- | ---
rule_type | enum **RuleType**<br>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`. <ul><li>`UTILIZATION`: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li><li>`WORKLOAD`: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li><ul/>
metric_type | enum **MetricType**<br>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики. <ul><li>`GAUGE`: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине. <br>Instance Groups вычисляет среднее значение метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale7).</li><li>`COUNTER`: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине. <br>Instance Groups вычисляет средний прирост метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale7).</li><ul/>
metric_name | **string**<br>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
target | **double**<br>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Значение должно быть больше 0.


### FixedScale {#FixedScale7}

Поле | Описание
--- | ---
size | **int64**<br>Количество виртуальных машин в группе ВМ. Допустимые значения — от 1 до 100 включительно.


### DeployPolicy {#DeployPolicy7}

Поле | Описание
--- | ---
max_unavailable | **int64**<br>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `max_expansion` не указано или равно нулю, `max_unavailable` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
max_deleting | **int64**<br>Максимальное количество удаляемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_creating | **int64**<br>Максимальное количество создаваемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_expansion | **int64**<br>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `max_unavailable` не указан или равен нулю, `max_expansion` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status`. Допустимые значения — от 0m до 1h включительно.


### AllocationPolicy {#AllocationPolicy7}

Поле | Описание
--- | ---
zones[] | **[Zone](#Zone7)**<br>Список зон доступности. Минимальное количество элементов — 1.


### Zone {#Zone7}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. 


### LoadBalancerState {#LoadBalancerState5}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор целевой группы для распределения нагрузки. 
status_message | **string**<br>Сообщение о состоянии целевой группы. 


### ManagedInstancesState {#ManagedInstancesState5}

Поле | Описание
--- | ---
target_size | **int64**<br>Целевое количество виртуальных машин для данной группы ВМ. 
running_actual_count | **int64**<br>Число запущенных виртуальных машин, соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>Число запущенных виртуальных машин, не соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>Количество виртуальных машин, находящихся в процессе обновления, запуска, удаления. Дополнительные сведения см. в разделе [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses5}

Поле | Описание
--- | ---
creating | **int64**<br>Виртуальная машина создается. 
starting | **int64**<br>Виртуальная машина запускается. 
opening | **int64**<br>Виртуальная машина открывается для получения трафика. 
warming | **int64**<br>Виртуальная машина прогревается. 
running | **int64**<br>Виртуальная машина работает нормально. 
closing | **int64**<br>Виртуальная машина закрывается для получения трафика. 
stopping | **int64**<br>Виртуальная машина останавливается. 
updating | **int64**<br>Виртуальная машина обновляется. 
deleting | **int64**<br>Виртуальная машина удаляется. 
failed | **int64**<br>Сбой виртуальной машины, которую необходимо пересоздать. 


### LoadBalancerSpec {#LoadBalancerSpec7}

Поле | Описание
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec7)**<br>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе [Целевые ресурсы и группы](/docs/load-balancer/concepts/target-resources). 


### TargetGroupSpec {#TargetGroupSpec7}

Поле | Описание
--- | ---
name | **string**<br>Имя целевой группы. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec7}

Поле | Описание
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec7)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). Минимальное количество элементов — 1.


### HealthCheckSpec {#HealthCheckSpec7}

Поле | Описание
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал проверок. Значение по умолчанию — 2 секунды. Допустимые значения — от 1s до 300s включительно.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время ожидания ответа. Значение по умолчанию — 1 секунда. Допустимые значения — от 1s до 60s включительно.
unhealthy_threshold | **int64**<br>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` или `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions7)**<br>Параметры для проверки состояний по протоколу TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions7)**<br>Параметры для проверки состояний по протоколу HTTP. 


### TcpOptions {#TcpOptions7}

Поле | Описание
--- | ---
port | **int64**<br>Порт TCP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions7}

Поле | Описание
--- | ---
port | **int64**<br>Порт HTTP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL, по которому будут выполняться проверки (для HTTP). 


## Stop {#Stop}

Останавливает указанную группу виртуальных машин.

**rpc Stop ([StopInstanceGroupRequest](#StopInstanceGroupRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopInstanceGroupMetadata](#StopInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup6)<br>

### StopInstanceGroupRequest {#StopInstanceGroupRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор останавливаемой группы виртуальных машин. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopInstanceGroupMetadata](#StopInstanceGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup6)>**<br>в случае успешного выполнения операции. 


### StopInstanceGroupMetadata {#StopInstanceGroupMetadata}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Идентификатор останавливаемой группы виртуальных машин. 


### InstanceGroup {#InstanceGroup6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](#InstanceTemplate8)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy8)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](#DeployPolicy8)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy8)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState6)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState6)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec8)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec8)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


### InstanceTemplate {#InstanceTemplate8}

Поле | Описание
--- | ---
description | **string**<br>Описание шаблона виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec8)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec8)**<br>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec8)**<br>Массив дополнительных дисков, которые будут подключенны к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec8)**<br>Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине. Количество элементов должно быть ровно 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy8)**<br>Политика планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для привязки к виртуальной машине. 


### ResourcesSpec {#ResourcesSpec8}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Максимальное значение — 274877906944.
cores | **int64**<br>Количество ядер, доступное виртуальной машине. Значение должно быть равно 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. Значение должно быть равно 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec8}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Обязательное поле. Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Значение должно соответствовать регулярному выражению ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec8)**<br>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk). 


### DiskSpec {#DiskSpec8}

Поле | Описание
--- | ---
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Обязательное поле. Идентификатор типа диска. 
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source_oneof | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан диск. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан диск. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec8}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор облачной сети. 
subnet_ids[] | **string**<br>Идентификаторы подсетей. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec8)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec8)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec8}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec8)**<br>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет. 


### OneToOneNatSpec {#OneToOneNatSpec8}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy8}

Поле | Описание
--- | ---
preemptible | **bool**<br>Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy8}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale` или `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale8)**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#fixed-scale-policy) группы виртуальных машин. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale8)**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#auto-scale-policy) группы виртуальных машин. 


### AutoScale {#AutoScale8}

Поле | Описание
--- | ---
min_zone_size | **int64**<br>Минимальное количество виртуальных машин в каждой зоне. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100. Допустимые значения — от 0 до 100 включительно.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Время в секундах, отведенное на усреднение метрик. Допустимые значения — от 1m до 10m включительно.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются. Максимальное значение — 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться. Допустимые значения — от 1m до 30m включительно.
initial_size | **int64**<br>Размер целевой группы. Минимальная значение — 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule8)**<br>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин. 
custom_rules[] | **[CustomRule](#CustomRule8)**<br>Определяет правило автомасштабирования на основе [пользовательской метрики](/docs/monitoring/operations/metric/add) из Yandex Monitoring. Максимальное количество элементов — 1.


### CpuUtilizationRule {#CpuUtilizationRule8}

Поле | Описание
--- | ---
utilization_target | **double**<br>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Допустимые значения — от 10 до 100 включительно.


### CustomRule {#CustomRule8}

Поле | Описание
--- | ---
rule_type | enum **RuleType**<br>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`. <ul><li>`UTILIZATION`: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li><li>`WORKLOAD`: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li><ul/>
metric_type | enum **MetricType**<br>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики. <ul><li>`GAUGE`: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине. <br>Instance Groups вычисляет среднее значение метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale8).</li><li>`COUNTER`: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине. <br>Instance Groups вычисляет средний прирост метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale8).</li><ul/>
metric_name | **string**<br>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
target | **double**<br>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Значение должно быть больше 0.


### FixedScale {#FixedScale8}

Поле | Описание
--- | ---
size | **int64**<br>Количество виртуальных машин в группе ВМ. Допустимые значения — от 1 до 100 включительно.


### DeployPolicy {#DeployPolicy8}

Поле | Описание
--- | ---
max_unavailable | **int64**<br>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `max_expansion` не указано или равно нулю, `max_unavailable` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
max_deleting | **int64**<br>Максимальное количество удаляемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_creating | **int64**<br>Максимальное количество создаваемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_expansion | **int64**<br>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `max_unavailable` не указан или равен нулю, `max_expansion` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status`. Допустимые значения — от 0m до 1h включительно.


### AllocationPolicy {#AllocationPolicy8}

Поле | Описание
--- | ---
zones[] | **[Zone](#Zone8)**<br>Список зон доступности. Минимальное количество элементов — 1.


### Zone {#Zone8}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. 


### LoadBalancerState {#LoadBalancerState6}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор целевой группы для распределения нагрузки. 
status_message | **string**<br>Сообщение о состоянии целевой группы. 


### ManagedInstancesState {#ManagedInstancesState6}

Поле | Описание
--- | ---
target_size | **int64**<br>Целевое количество виртуальных машин для данной группы ВМ. 
running_actual_count | **int64**<br>Число запущенных виртуальных машин, соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>Число запущенных виртуальных машин, не соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>Количество виртуальных машин, находящихся в процессе обновления, запуска, удаления. Дополнительные сведения см. в разделе [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses6}

Поле | Описание
--- | ---
creating | **int64**<br>Виртуальная машина создается. 
starting | **int64**<br>Виртуальная машина запускается. 
opening | **int64**<br>Виртуальная машина открывается для получения трафика. 
warming | **int64**<br>Виртуальная машина прогревается. 
running | **int64**<br>Виртуальная машина работает нормально. 
closing | **int64**<br>Виртуальная машина закрывается для получения трафика. 
stopping | **int64**<br>Виртуальная машина останавливается. 
updating | **int64**<br>Виртуальная машина обновляется. 
deleting | **int64**<br>Виртуальная машина удаляется. 
failed | **int64**<br>Сбой виртуальной машины, которую необходимо пересоздать. 


### LoadBalancerSpec {#LoadBalancerSpec8}

Поле | Описание
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec8)**<br>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе [Целевые ресурсы и группы](/docs/load-balancer/concepts/target-resources). 


### TargetGroupSpec {#TargetGroupSpec8}

Поле | Описание
--- | ---
name | **string**<br>Имя целевой группы. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec8}

Поле | Описание
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec8)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). Минимальное количество элементов — 1.


### HealthCheckSpec {#HealthCheckSpec8}

Поле | Описание
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал проверок. Значение по умолчанию — 2 секунды. Допустимые значения — от 1s до 300s включительно.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время ожидания ответа. Значение по умолчанию — 1 секунда. Допустимые значения — от 1s до 60s включительно.
unhealthy_threshold | **int64**<br>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` или `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions8)**<br>Параметры для проверки состояний по протоколу TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions8)**<br>Параметры для проверки состояний по протоколу HTTP. 


### TcpOptions {#TcpOptions8}

Поле | Описание
--- | ---
port | **int64**<br>Порт TCP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions8}

Поле | Описание
--- | ---
port | **int64**<br>Порт HTTP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL, по которому будут выполняться проверки (для HTTP). 


## Start {#Start}

Запускает указанную группу виртуальных машин.

**rpc Start ([StartInstanceGroupRequest](#StartInstanceGroupRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartInstanceGroupMetadata](#StartInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup7)<br>

### StartInstanceGroupRequest {#StartInstanceGroupRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор запускаемой группы виртуальных машин. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartInstanceGroupMetadata](#StartInstanceGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup7)>**<br>в случае успешного выполнения операции. 


### StartInstanceGroupMetadata {#StartInstanceGroupMetadata}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Идентификатор запускаемой группы виртуальных машин. 


### InstanceGroup {#InstanceGroup7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](#InstanceTemplate9)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy9)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](#DeployPolicy9)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy9)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState7)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState7)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec9)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec9)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


### InstanceTemplate {#InstanceTemplate9}

Поле | Описание
--- | ---
description | **string**<br>Описание шаблона виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec9)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec9)**<br>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec9)**<br>Массив дополнительных дисков, которые будут подключенны к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec9)**<br>Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине. Количество элементов должно быть ровно 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy9)**<br>Политика планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для привязки к виртуальной машине. 


### ResourcesSpec {#ResourcesSpec9}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Максимальное значение — 274877906944.
cores | **int64**<br>Количество ядер, доступное виртуальной машине. Значение должно быть равно 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. Значение должно быть равно 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec9}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Обязательное поле. Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Значение должно соответствовать регулярному выражению ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec9)**<br>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk). 


### DiskSpec {#DiskSpec9}

Поле | Описание
--- | ---
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Обязательное поле. Идентификатор типа диска. 
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source_oneof | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан диск. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан диск. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec9}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор облачной сети. 
subnet_ids[] | **string**<br>Идентификаторы подсетей. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec9)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec9)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec9}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec9)**<br>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет. 


### OneToOneNatSpec {#OneToOneNatSpec9}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy9}

Поле | Описание
--- | ---
preemptible | **bool**<br>Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy9}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale` или `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale9)**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#fixed-scale-policy) группы виртуальных машин. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale9)**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#auto-scale-policy) группы виртуальных машин. 


### AutoScale {#AutoScale9}

Поле | Описание
--- | ---
min_zone_size | **int64**<br>Минимальное количество виртуальных машин в каждой зоне. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100. Допустимые значения — от 0 до 100 включительно.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Время в секундах, отведенное на усреднение метрик. Допустимые значения — от 1m до 10m включительно.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются. Максимальное значение — 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться. Допустимые значения — от 1m до 30m включительно.
initial_size | **int64**<br>Размер целевой группы. Минимальная значение — 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule9)**<br>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин. 
custom_rules[] | **[CustomRule](#CustomRule9)**<br>Определяет правило автомасштабирования на основе [пользовательской метрики](/docs/monitoring/operations/metric/add) из Yandex Monitoring. Максимальное количество элементов — 1.


### CpuUtilizationRule {#CpuUtilizationRule9}

Поле | Описание
--- | ---
utilization_target | **double**<br>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Допустимые значения — от 10 до 100 включительно.


### CustomRule {#CustomRule9}

Поле | Описание
--- | ---
rule_type | enum **RuleType**<br>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`. <ul><li>`UTILIZATION`: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li><li>`WORKLOAD`: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li><ul/>
metric_type | enum **MetricType**<br>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики. <ul><li>`GAUGE`: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине. <br>Instance Groups вычисляет среднее значение метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale9).</li><li>`COUNTER`: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине. <br>Instance Groups вычисляет средний прирост метрики за период, указанный в поле [AutoScale.measurement_duration](#AutoScale9).</li><ul/>
metric_name | **string**<br>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
target | **double**<br>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Значение должно быть больше 0.


### FixedScale {#FixedScale9}

Поле | Описание
--- | ---
size | **int64**<br>Количество виртуальных машин в группе ВМ. Допустимые значения — от 1 до 100 включительно.


### DeployPolicy {#DeployPolicy9}

Поле | Описание
--- | ---
max_unavailable | **int64**<br>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `max_expansion` не указано или равно нулю, `max_unavailable` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
max_deleting | **int64**<br>Максимальное количество удаляемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_creating | **int64**<br>Максимальное количество создаваемых одновременно виртуальных машин. <br>Значение 0 — любое количество виртуальных машин в рамках допустимых значений. Допустимые значения — от 0 до 100 включительно.
max_expansion | **int64**<br>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `max_unavailable` не указан или равен нулю, `max_expansion` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status`. Допустимые значения — от 0m до 1h включительно.


### AllocationPolicy {#AllocationPolicy9}

Поле | Описание
--- | ---
zones[] | **[Zone](#Zone9)**<br>Список зон доступности. Минимальное количество элементов — 1.


### Zone {#Zone9}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. 


### LoadBalancerState {#LoadBalancerState7}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор целевой группы для распределения нагрузки. 
status_message | **string**<br>Сообщение о состоянии целевой группы. 


### ManagedInstancesState {#ManagedInstancesState7}

Поле | Описание
--- | ---
target_size | **int64**<br>Целевое количество виртуальных машин для данной группы ВМ. 
running_actual_count | **int64**<br>Число запущенных виртуальных машин, соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>Число запущенных виртуальных машин, не соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>Количество виртуальных машин, находящихся в процессе обновления, запуска, удаления. Дополнительные сведения см. в разделе [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses7}

Поле | Описание
--- | ---
creating | **int64**<br>Виртуальная машина создается. 
starting | **int64**<br>Виртуальная машина запускается. 
opening | **int64**<br>Виртуальная машина открывается для получения трафика. 
warming | **int64**<br>Виртуальная машина прогревается. 
running | **int64**<br>Виртуальная машина работает нормально. 
closing | **int64**<br>Виртуальная машина закрывается для получения трафика. 
stopping | **int64**<br>Виртуальная машина останавливается. 
updating | **int64**<br>Виртуальная машина обновляется. 
deleting | **int64**<br>Виртуальная машина удаляется. 
failed | **int64**<br>Сбой виртуальной машины, которую необходимо пересоздать. 


### LoadBalancerSpec {#LoadBalancerSpec9}

Поле | Описание
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec9)**<br>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе [Целевые ресурсы и группы](/docs/load-balancer/concepts/target-resources). 


### TargetGroupSpec {#TargetGroupSpec9}

Поле | Описание
--- | ---
name | **string**<br>Имя целевой группы. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec9}

Поле | Описание
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec9)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). Минимальное количество элементов — 1.


### HealthCheckSpec {#HealthCheckSpec9}

Поле | Описание
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал проверок. Значение по умолчанию — 2 секунды. Допустимые значения — от 1s до 300s включительно.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время ожидания ответа. Значение по умолчанию — 1 секунда. Допустимые значения — от 1s до 60s включительно.
unhealthy_threshold | **int64**<br>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` или `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions9)**<br>Параметры для проверки состояний по протоколу TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions9)**<br>Параметры для проверки состояний по протоколу HTTP. 


### TcpOptions {#TcpOptions9}

Поле | Описание
--- | ---
port | **int64**<br>Порт TCP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions9}

Поле | Описание
--- | ---
port | **int64**<br>Порт HTTP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL, по которому будут выполняться проверки (для HTTP). 


## Delete {#Delete}

Удаляет указанную группу виртуальных машин.

**rpc Delete ([DeleteInstanceGroupRequest](#DeleteInstanceGroupRequest)) returns ([operation.Operation](#Operation6))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteInstanceGroupMetadata](#DeleteInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteInstanceGroupRequest {#DeleteInstanceGroupRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор удаляемой группы виртуальных машин. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteInstanceGroupMetadata](#DeleteInstanceGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteInstanceGroupMetadata {#DeleteInstanceGroupMetadata}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Идентификатор удаляемой группы виртуальных машин. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). 


## ListInstances {#ListInstances}

Возвращает список виртуальных машин для указанной группы ВМ.

**rpc ListInstances ([ListInstanceGroupInstancesRequest](#ListInstanceGroupInstancesRequest)) returns ([ListInstanceGroupInstancesResponse](#ListInstanceGroupInstancesResponse))**

### ListInstanceGroupInstancesRequest {#ListInstanceGroupInstancesRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор ресурса InstanceGroup для получения списка виртуальных машин. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListInstanceGroupInstancesResponse.next_page_token](#ListInstanceGroupInstancesResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListInstanceGroupInstancesResponse.next_page_token](#ListInstanceGroupInstancesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [InstanceGroup.name](#InstanceGroup8). Максимальная длина строки в символах — 1000.


### ListInstanceGroupInstancesResponse {#ListInstanceGroupInstancesResponse}

Поле | Описание
--- | ---
instances[] | **[ManagedInstance](#ManagedInstance)**<br>Возвращает список виртуальных машин для указанной группы ВМ. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListInstanceGroupInstancesRequest.page_size](#ListInstanceGroupInstancesRequest), используйте `next_page_token` в качестве значения параметра [ListInstanceGroupInstancesRequest.page_token](#ListInstanceGroupInstancesRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### ManagedInstance {#ManagedInstance}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор виртуальной машины. 
status | enum **Status**<br>Статус виртуальной машины. <ul><li>`CREATING_INSTANCE`: Виртуальная машина создается.</li><li>`UPDATING_INSTANCE`: Виртуальная машина обновляется.</li><li>`DELETING_INSTANCE`: Виртуальная машина удаляется.</li><li>`STARTING_INSTANCE`: Виртуальная машина запускается.</li><li>`STOPPING_INSTANCE`: Виртуальная машина останавливается.</li><li>`AWAITING_STARTUP_DURATION`: Виртуальная машина успешно создана, но время запуска еще не истекло.</li><li>`CHECKING_HEALTH`: Виртуальная машина успешно создана, время запуска истекло, но проверки состояний еще не прошли и виртуальная машина не готова получать трафик.</li><li>`OPENING_TRAFFIC`: Instance Groups инициирует проверку состояний и маршрутизацию трафика к виртуальным машинам.</li><li>`AWAITING_WARMUP_DURATION`: Виртуальная машина получает трафик, но время прогрева еще не истекло.</li><li>`CLOSING_TRAFFIC`: Instance Groups инициировала процесс остановки маршрутизации трафика к виртуальным машинам.</li><li>`RUNNING_ACTUAL`: Виртуальная машина работает нормально, и ее конфигурация соответствует текущему InstanceTemplate.</li><li>`RUNNING_OUTDATED`: Виртуальная машина работает нормально, но ее конфигурация не соответствует текущему InstanceTemplate. Будет обновлена, воссоздана или удалена в ближайшее время.</li><li>`STOPPED`: Виртуальная машина остановлена.</li><li>`DELETED`: Виртуальная машина удалена.</li><ul/>
instance_id | **string**<br>Идентификатор виртуальной машины. 
fqdn | **string**<br>Полное имя домена. 
name | **string**<br>Имя управляемой виртуальной машины. 
status_message | **string**<br>Сообщение о состоянии виртуальной машины. 
zone_id | **string**<br>Идентификатор зоны доступности, где находится виртуальная машина. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface)**<br>Массив сетевых интерфейсов, присоединенных к виртуальной машине. 
status_changed_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последнего изменения состояния виртуальной машины в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 


### NetworkInterface {#NetworkInterface}

Поле | Описание
--- | ---
index | **string**<br>Индекс сетевого интерфейса, генерируемого сервером, 0,1,2... В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс. 
mac_address | **string**<br>MAC-адрес, назначенный сетевому интерфейсу. 
subnet_id | **string**<br>Идентификатор подсети. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddress {#PrimaryAddress}

Поле | Описание
--- | ---
address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. Если не указано, системой будет назначен неиспользуемый внутренний IP-адрес. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat)**<br>Конфигурация one-to-one NAT. Если отсутствует, NAT не был настроен. 


### OneToOneNat {#OneToOneNat}

Поле | Описание
--- | ---
address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. 
ip_version | enum **IpVersion**<br>Версия публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


## ListOperations {#ListOperations}

Возвращает список операций для указанной группы виртуальных машин.

**rpc ListOperations ([ListInstanceGroupOperationsRequest](#ListInstanceGroupOperationsRequest)) returns ([ListInstanceGroupOperationsResponse](#ListInstanceGroupOperationsResponse))**

### ListInstanceGroupOperationsRequest {#ListInstanceGroupOperationsRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор ресурса InstanceGroup, для которого запрашивается список операций. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListInstanceGroupOperationsResponse.next_page_token](#ListInstanceGroupOperationsResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListInstanceGroupOperationsResponse.next_page_token](#ListInstanceGroupOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [InstanceGroup.name](#InstanceGroup8). Максимальная длина строки в символах — 1000.


### ListInstanceGroupOperationsResponse {#ListInstanceGroupOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>Возвращает список операций для указанной группы виртуальных машин. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListInstanceGroupOperationsRequest.page_size](#ListInstanceGroupOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListInstanceGroupOperationsRequest.page_token](#ListInstanceGroupOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Operation {#Operation7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`. 


## ListLogRecords {#ListLogRecords}

Возвращает список логов для указанной группы виртуальных машин.

**rpc ListLogRecords ([ListInstanceGroupLogRecordsRequest](#ListInstanceGroupLogRecordsRequest)) returns ([ListInstanceGroupLogRecordsResponse](#ListInstanceGroupLogRecordsResponse))**

### ListInstanceGroupLogRecordsRequest {#ListInstanceGroupLogRecordsRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор ресурса InstanceGroup для получения списка логов. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListInstanceGroupLogRecordsResponse.next_page_token](#ListInstanceGroupLogRecordsResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListInstanceGroupLogRecordsResponse.next_page_token](#ListInstanceGroupLogRecordsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [InstanceGroup.name](#InstanceGroup8). Максимальная длина строки в символах — 1000.


### ListInstanceGroupLogRecordsResponse {#ListInstanceGroupLogRecordsResponse}

Поле | Описание
--- | ---
log_records[] | **[LogRecord](#LogRecord)**<br>Возвращает список логов для указанной группы виртуальных машин. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListInstanceGroupLogRecordsRequest.page_size](#ListInstanceGroupLogRecordsRequest), используйте `next_page_token` в качестве значения параметра [ListInstanceGroupLogRecordsRequest.page_token](#ListInstanceGroupLogRecordsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### LogRecord {#LogRecord}

Поле | Описание
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время записи лога в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
message | **string**<br>Сообщение. 


