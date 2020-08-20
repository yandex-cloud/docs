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

**rpc Get ([GetInstanceGroupRequest](#GetInstanceGroupRequest)) returns ([InstanceGroup](../instance_group.proto#InstanceGroup))**

### GetInstanceGroupRequest {#GetInstanceGroupRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса InstanceGroup. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). false Максимальная длина строки в символах — 50.
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
instance_template | **[InstanceTemplate](../instance_group.proto#InstanceTemplate)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](../instance_group.proto#ScalePolicy)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](../instance_group.proto#DeployPolicy)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](../instance_group.proto#AllocationPolicy)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](../instance_group.proto#LoadBalancerState)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](../instance_group.proto#ManagedInstancesState)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](../instance_group.proto#LoadBalancerSpec)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](../instance_group.proto#HealthChecksSpec)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


### InstanceTemplate {#InstanceTemplate}

Поле | Описание
--- | ---
description | **string**<br>Описание шаблона виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). false
resources_spec | **[ResourcesSpec](../instance_group.proto#ResourcesSpec)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. false
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](../instance_group.proto#AttachedDiskSpec)**<br>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине. false
secondary_disk_specs[] | **[AttachedDiskSpec](../instance_group.proto#AttachedDiskSpec)**<br>Массив дополнительных дисков, которые будут подключенны к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](../instance_group.proto#NetworkInterfaceSpec)**<br>Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине. Количество элементов должно быть ровно 1.
scheduling_policy | **[SchedulingPolicy](../instance_group.proto#SchedulingPolicy)**<br>Политика планирования. 
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
mode | enum **Mode**<br>Обязательное поле. Режим доступа к ресурсу Disk. false<ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Значение должно соответствовать регулярному выражению ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](../instance_group.proto#DiskSpec)**<br>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk). false


### DiskSpec {#DiskSpec}

Поле | Описание
--- | ---
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Обязательное поле. Идентификатор типа диска. false
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source_oneof | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан диск. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан диск. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор облачной сети. 
subnet_ids[] | **string**<br>Идентификаторы подсетей. 
primary_v4_address_spec | **[PrimaryAddressSpec](../instance_group.proto#PrimaryAddressSpec)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](../instance_group.proto#PrimaryAddressSpec)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](../instance_group.proto#OneToOneNatSpec)**<br>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет. 


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
&nbsp;&nbsp;fixed_scale | **[FixedScale](../instance_group.proto#FixedScale)**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/scale#fixed-policy) группы виртуальных машин. 
&nbsp;&nbsp;auto_scale | **[AutoScale](../instance_group.proto#AutoScale)**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/scale#auto-scale) группы виртуальных машин. 


### AutoScale {#AutoScale}

Поле | Описание
--- | ---
min_zone_size | **int64**<br>Минимальное количество виртуальных машин в каждой зоне. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100. Допустимые значения — от 0 до 100 включительно.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Время в секундах, отведенное на усреднение метрик. false Допустимые значения — от 1m до 10m включительно.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются. Максимальное значение — 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться. Допустимые значения — от 1m до 30m включительно.
initial_size | **int64**<br>Размер целевой группы. Минимальная значение — 1.
cpu_utilization_rule | **[CpuUtilizationRule](../instance_group.proto#CpuUtilizationRule)**<br>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин. 
custom_rules[] | **[CustomRule](../instance_group.proto#CustomRule)**<br>Определяет правило автомасштабирования на основе [пользовательской метрики](/docs/monitoring/operations/metric/add) из Yandex Monitoring. Максимальное количество элементов — 1.


### CpuUtilizationRule {#CpuUtilizationRule}

Поле | Описание
--- | ---
utilization_target | **double**<br>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Допустимые значения — от 10 до 100 включительно.


### CustomRule {#CustomRule}

Поле | Описание
--- | ---
rule_type | enum **RuleType**<br>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`. false<ul><li>`UTILIZATION`: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li><li>`WORKLOAD`: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li><ul/>
metric_type | enum **MetricType**<br>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики. false<ul><li>`GAUGE`: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине. <br>Instance Groups вычисляет среднее значение метрики за период, указанный в поле [AutoScale.measurement_duration](../instance_group.proto#AutoScale).</li><li>`COUNTER`: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине. <br>Instance Groups вычисляет средний прирост метрики за период, указанный в поле [AutoScale.measurement_duration](../instance_group.proto#AutoScale).</li><ul/>
metric_name | **string**<br>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования. false Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
target | **double**<br>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Значение должно быть больше 0.


### FixedScale {#FixedScale}

Поле | Описание
--- | ---
size | **int64**<br>Количество виртуальных машин в группе ВМ. Допустимые значения — от 1 до 100 включительно.


### DeployPolicy {#DeployPolicy}

Поле | Описание
--- | ---
max_unavailable | **int64**<br>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `max_expansion` не указано или равно нулю, `max_unavailable` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
max_deleting | **int64**<br>Максимальное количество удаляемых одновременно виртуальных машин. Допустимые значения — от 0 до 100 включительно.
max_creating | **int64**<br>Максимальное количество создаваемых одновременно виртуальных машин. Допустимые значения — от 0 до 100 включительно.
max_expansion | **int64**<br>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `max_unavailable` не указан или равен нулю, `max_expansion` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status`. Допустимые значения — от 0m до 1h включительно.


### AllocationPolicy {#AllocationPolicy}

Поле | Описание
--- | ---
zones[] | **[Zone](../instance_group.proto#Zone)**<br>Список зон доступности. Минимальное количество элементов — 1.


### Zone {#Zone}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. false


### LoadBalancerState {#LoadBalancerState}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор целевой группы для распределения нагрузки. 
status_message | **string**<br>Сообщение о состоянии целевой группы. 


### ManagedInstancesState {#ManagedInstancesState}

Поле | Описание
--- | ---
target_size | **int64**<br>Целевое количество виртуальных машин для данной группы ВМ. 
running_actual_count | **int64**<br>Число запущенных виртуальных машин, соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_ACTUAL](../instance_group.proto#ManagedInstance). 
running_outdated_count | **int64**<br>Число запущенных виртуальных машин, не соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_OUTDATED](../instance_group.proto#ManagedInstance). 
processing_count | **int64**<br>Количество виртуальных машин, находящихся в процессе обновления, запуска, удаления. Дополнительные сведения см. в разделе [ManagedInstance.Status](../instance_group.proto#ManagedInstance). 


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
target_group_spec | **[TargetGroupSpec](../instance_group.proto#TargetGroupSpec)**<br>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе [Целевые ресурсы и группы](/docs/load-balancer/target-resources). 


### TargetGroupSpec {#TargetGroupSpec}

Поле | Описание
--- | ---
name | **string**<br>Имя целевой группы. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec}

Поле | Описание
--- | ---
health_check_specs[] | **[HealthCheckSpec](../instance_group.proto#HealthCheckSpec)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). Минимальное количество элементов — 1.


### HealthCheckSpec {#HealthCheckSpec}

Поле | Описание
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал проверок. Значение по умолчанию — 2 секунды. Допустимые значения — от 1s до 300s включительно.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время ожидания ответа. Значение по умолчанию — 1 секунда. Допустимые значения — от 1s до 60s включительно.
unhealthy_threshold | **int64**<br>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` или `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](../instance_group.proto#TcpOptions)**<br>Параметры для проверки состояний по протоколу TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](../instance_group.proto#HttpOptions)**<br>Параметры для проверки состояний по протоколу HTTP. 


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
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка групп виртуальных машин. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List). false
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListInstanceGroupsResponse.next_page_token](#ListInstanceGroupsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListInstanceGroupsResponse.next_page_token](#ListInstanceGroupsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [InstanceGroup.name](../instance_group.proto#InstanceGroup1). Максимальная длина строки в символах — 1000.
view | enum **InstanceGroupView**<br>Определяет, какая информация о ресурсе Instance должна быть возвращена в ответе. <ul><li>`BASIC`: Не включает метаданные шаблона виртуальной машины в ответ сервера.</li><li>`FULL`: Возвращает метаданные шаблона виртуальной машины в ответе сервера.</li><ul/>


### ListInstanceGroupsResponse {#ListInstanceGroupsResponse}

Поле | Описание
--- | ---
instance_groups[] | **[InstanceGroup](../instance_group.proto#InstanceGroup1)**<br>Список групп виртуальных машин для указанного каталога. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListInstanceGroupsRequest.page_size](#ListInstanceGroupsRequest1), используйте `next_page_token` в качестве значения параметра [ListInstanceGroupsRequest.page_token](#ListInstanceGroupsRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### InstanceGroup {#InstanceGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](../instance_group.proto#InstanceTemplate1)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](../instance_group.proto#ScalePolicy1)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](../instance_group.proto#DeployPolicy1)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](../instance_group.proto#AllocationPolicy1)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](../instance_group.proto#LoadBalancerState1)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](../instance_group.proto#ManagedInstancesState1)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](../instance_group.proto#LoadBalancerSpec1)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](../instance_group.proto#HealthChecksSpec1)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


### InstanceTemplate {#InstanceTemplate}

Поле | Описание
--- | ---
description | **string**<br>Описание шаблона виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). false
resources_spec | **[ResourcesSpec](../instance_group.proto#ResourcesSpec1)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. false
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](../instance_group.proto#AttachedDiskSpec1)**<br>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине. false
secondary_disk_specs[] | **[AttachedDiskSpec](../instance_group.proto#AttachedDiskSpec1)**<br>Массив дополнительных дисков, которые будут подключенны к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](../instance_group.proto#NetworkInterfaceSpec1)**<br>Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине. Количество элементов должно быть ровно 1.
scheduling_policy | **[SchedulingPolicy](../instance_group.proto#SchedulingPolicy1)**<br>Политика планирования. 
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
mode | enum **Mode**<br>Обязательное поле. Режим доступа к ресурсу Disk. false<ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Значение должно соответствовать регулярному выражению ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](../instance_group.proto#DiskSpec1)**<br>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk). false


### DiskSpec {#DiskSpec}

Поле | Описание
--- | ---
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Обязательное поле. Идентификатор типа диска. false
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source_oneof | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан диск. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан диск. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор облачной сети. 
subnet_ids[] | **string**<br>Идентификаторы подсетей. 
primary_v4_address_spec | **[PrimaryAddressSpec](../instance_group.proto#PrimaryAddressSpec1)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](../instance_group.proto#PrimaryAddressSpec1)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](../instance_group.proto#OneToOneNatSpec1)**<br>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет. 


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
&nbsp;&nbsp;fixed_scale | **[FixedScale](../instance_group.proto#FixedScale1)**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/scale#fixed-policy) группы виртуальных машин. 
&nbsp;&nbsp;auto_scale | **[AutoScale](../instance_group.proto#AutoScale1)**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/scale#auto-scale) группы виртуальных машин. 


### AutoScale {#AutoScale}

Поле | Описание
--- | ---
min_zone_size | **int64**<br>Минимальное количество виртуальных машин в каждой зоне. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100. Допустимые значения — от 0 до 100 включительно.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Время в секундах, отведенное на усреднение метрик. false Допустимые значения — от 1m до 10m включительно.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются. Максимальное значение — 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться. Допустимые значения — от 1m до 30m включительно.
initial_size | **int64**<br>Размер целевой группы. Минимальная значение — 1.
cpu_utilization_rule | **[CpuUtilizationRule](../instance_group.proto#CpuUtilizationRule1)**<br>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин. 
custom_rules[] | **[CustomRule](../instance_group.proto#CustomRule1)**<br>Определяет правило автомасштабирования на основе [пользовательской метрики](/docs/monitoring/operations/metric/add) из Yandex Monitoring. Максимальное количество элементов — 1.


### CpuUtilizationRule {#CpuUtilizationRule}

Поле | Описание
--- | ---
utilization_target | **double**<br>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Допустимые значения — от 10 до 100 включительно.


### CustomRule {#CustomRule}

Поле | Описание
--- | ---
rule_type | enum **RuleType**<br>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`. false<ul><li>`UTILIZATION`: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li><li>`WORKLOAD`: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li><ul/>
metric_type | enum **MetricType**<br>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики. false<ul><li>`GAUGE`: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине. <br>Instance Groups вычисляет среднее значение метрики за период, указанный в поле [AutoScale.measurement_duration](../instance_group.proto#AutoScale1).</li><li>`COUNTER`: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине. <br>Instance Groups вычисляет средний прирост метрики за период, указанный в поле [AutoScale.measurement_duration](../instance_group.proto#AutoScale1).</li><ul/>
metric_name | **string**<br>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования. false Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
target | **double**<br>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Значение должно быть больше 0.


### FixedScale {#FixedScale}

Поле | Описание
--- | ---
size | **int64**<br>Количество виртуальных машин в группе ВМ. Допустимые значения — от 1 до 100 включительно.


### DeployPolicy {#DeployPolicy}

Поле | Описание
--- | ---
max_unavailable | **int64**<br>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `max_expansion` не указано или равно нулю, `max_unavailable` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
max_deleting | **int64**<br>Максимальное количество удаляемых одновременно виртуальных машин. Допустимые значения — от 0 до 100 включительно.
max_creating | **int64**<br>Максимальное количество создаваемых одновременно виртуальных машин. Допустимые значения — от 0 до 100 включительно.
max_expansion | **int64**<br>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `max_unavailable` не указан или равен нулю, `max_expansion` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status`. Допустимые значения — от 0m до 1h включительно.


### AllocationPolicy {#AllocationPolicy}

Поле | Описание
--- | ---
zones[] | **[Zone](../instance_group.proto#Zone1)**<br>Список зон доступности. Минимальное количество элементов — 1.


### Zone {#Zone}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. false


### LoadBalancerState {#LoadBalancerState}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор целевой группы для распределения нагрузки. 
status_message | **string**<br>Сообщение о состоянии целевой группы. 


### ManagedInstancesState {#ManagedInstancesState}

Поле | Описание
--- | ---
target_size | **int64**<br>Целевое количество виртуальных машин для данной группы ВМ. 
running_actual_count | **int64**<br>Число запущенных виртуальных машин, соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_ACTUAL](../instance_group.proto#ManagedInstance). 
running_outdated_count | **int64**<br>Число запущенных виртуальных машин, не соответствующих текущему шаблону. Дополнительные сведения см. в разделе [ManagedInstance.Status.RUNNING_OUTDATED](../instance_group.proto#ManagedInstance). 
processing_count | **int64**<br>Количество виртуальных машин, находящихся в процессе обновления, запуска, удаления. Дополнительные сведения см. в разделе [ManagedInstance.Status](../instance_group.proto#ManagedInstance). 


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
target_group_spec | **[TargetGroupSpec](../instance_group.proto#TargetGroupSpec1)**<br>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе [Целевые ресурсы и группы](/docs/load-balancer/target-resources). 


### TargetGroupSpec {#TargetGroupSpec}

Поле | Описание
--- | ---
name | **string**<br>Имя целевой группы. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec}

Поле | Описание
--- | ---
health_check_specs[] | **[HealthCheckSpec](../instance_group.proto#HealthCheckSpec1)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). Минимальное количество элементов — 1.


### HealthCheckSpec {#HealthCheckSpec}

Поле | Описание
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал проверок. Значение по умолчанию — 2 секунды. Допустимые значения — от 1s до 300s включительно.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время ожидания ответа. Значение по умолчанию — 1 секунда. Допустимые значения — от 1s до 60s включительно.
unhealthy_threshold | **int64**<br>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` или `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](../instance_group.proto#TcpOptions1)**<br>Параметры для проверки состояний по протоколу TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](../instance_group.proto#HttpOptions1)**<br>Параметры для проверки состояний по протоколу HTTP. 


### TcpOptions {#TcpOptions}

Поле | Описание
--- | ---
port | **int64**<br>Порт TCP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions}

Поле | Описание
--- | ---
port | **int64**<br>Порт HTTP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL, по которому будут выполняться проверки (для HTTP). 


## Create {#Create}

Создает группу виртуальных машин в указанном каталоге. Этот метод запускает операцию, которая может быть отменена другой операцией.

**rpc Create ([CreateInstanceGroupRequest](#CreateInstanceGroupRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateInstanceGroupMetadata](#CreateInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](../instance_group.proto#InstanceGroup2)<br>

### CreateInstanceGroupRequest {#CreateInstanceGroupRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для создания группы виртуальных машин. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List). false
name | **string**<br>Имя группы виртуальных машин. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание группы виртуальных машин. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
instance_template | **[InstanceTemplate](../instance_group.proto#InstanceTemplate2)**<br>Обязательное поле. Шаблон виртуальной машины, на основе которого создается группа ВМ. false
scale_policy | **[ScalePolicy](../instance_group.proto#ScalePolicy2)**<br>Обязательное поле. [Политика масштабирования](/docs/compute/concepts/instance-groups/scale) группы виртуальных машин. false
deploy_policy | **[DeployPolicy](../instance_group.proto#DeployPolicy2)**<br>Обязательное поле. Политика развертывания группы виртуальных машин. false
allocation_policy | **[AllocationPolicy](../instance_group.proto#AllocationPolicy2)**<br>Обязательное поле. Политика распределения группы виртуальных машин по зонам и регионам. false
load_balancer_spec | **[LoadBalancerSpec](../instance_group.proto#LoadBalancerSpec2)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](../instance_group.proto#HealthChecksSpec2)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т.п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List). 


### InstanceTemplate {#InstanceTemplate}

Поле | Описание
--- | ---
description | **string**<br>Описание шаблона виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). false
resources_spec | **[ResourcesSpec](../instance_group.proto#ResourcesSpec2)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. false
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](../instance_group.proto#AttachedDiskSpec2)**<br>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине. false
secondary_disk_specs[] | **[AttachedDiskSpec](../instance_group.proto#AttachedDiskSpec2)**<br>Массив дополнительных дисков, которые будут подключенны к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](../instance_group.proto#NetworkInterfaceSpec2)**<br>Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине. Количество элементов должно быть ровно 1.
scheduling_policy | **[SchedulingPolicy](../instance_group.proto#SchedulingPolicy2)**<br>Политика планирования. 
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
mode | enum **Mode**<br>Обязательное поле. Режим доступа к ресурсу Disk. false<ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Значение должно соответствовать регулярному выражению ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](../instance_group.proto#DiskSpec2)**<br>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk). false


### DiskSpec {#DiskSpec}

Поле | Описание
--- | ---
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Обязательное поле. Идентификатор типа диска. false
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source_oneof | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан диск. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан диск. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор облачной сети. 
subnet_ids[] | **string**<br>Идентификаторы подсетей. 
primary_v4_address_spec | **[PrimaryAddressSpec](../instance_group.proto#PrimaryAddressSpec2)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](../instance_group.proto#PrimaryAddressSpec2)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](../instance_group.proto#OneToOneNatSpec2)**<br>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет. 


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
&nbsp;&nbsp;fixed_scale | **[FixedScale](../instance_group.proto#FixedScale2)**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/scale#fixed-policy) группы виртуальных машин. 
&nbsp;&nbsp;auto_scale | **[AutoScale](../instance_group.proto#AutoScale2)**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/scale#auto-scale) группы виртуальных машин. 


### AutoScale {#AutoScale}

Поле | Описание
--- | ---
min_zone_size | **int64**<br>Минимальное количество виртуальных машин в каждой зоне. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100. Допустимые значения — от 0 до 100 включительно.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Время в секундах, отведенное на усреднение метрик. false Допустимые значения — от 1m до 10m включительно.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются. Максимальное значение — 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться. Допустимые значения — от 1m до 30m включительно.
initial_size | **int64**<br>Размер целевой группы. Минимальная значение — 1.
cpu_utilization_rule | **[CpuUtilizationRule](../instance_group.proto#CpuUtilizationRule2)**<br>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин. 
custom_rules[] | **[CustomRule](../instance_group.proto#CustomRule2)**<br>Определяет правило автомасштабирования на основе [пользовательской метрики](/docs/monitoring/operations/metric/add) из Yandex Monitoring. Максимальное количество элементов — 1.


### CpuUtilizationRule {#CpuUtilizationRule}

Поле | Описание
--- | ---
utilization_target | **double**<br>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Допустимые значения — от 10 до 100 включительно.


### CustomRule {#CustomRule}

Поле | Описание
--- | ---
rule_type | enum **RuleType**<br>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`. false<ul><li>`UTILIZATION`: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li><li>`WORKLOAD`: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li><ul/>
metric_type | enum **MetricType**<br>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики. false<ul><li>`GAUGE`: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине. <br>Instance Groups вычисляет среднее значение метрики за период, указанный в поле [AutoScale.measurement_duration](../instance_group.proto#AutoScale2).</li><li>`COUNTER`: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине. <br>Instance Groups вычисляет средний прирост метрики за период, указанный в поле [AutoScale.measurement_duration](../instance_group.proto#AutoScale2).</li><ul/>
metric_name | **string**<br>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования. false Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
target | **double**<br>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Значение должно быть больше 0.


### FixedScale {#FixedScale}

Поле | Описание
--- | ---
size | **int64**<br>Количество виртуальных машин в группе ВМ. Допустимые значения — от 1 до 100 включительно.


### DeployPolicy {#DeployPolicy}

Поле | Описание
--- | ---
max_unavailable | **int64**<br>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `max_expansion` не указано или равно нулю, `max_unavailable` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
max_deleting | **int64**<br>Максимальное количество удаляемых одновременно виртуальных машин. Допустимые значения — от 0 до 100 включительно.
max_creating | **int64**<br>Максимальное количество создаваемых одновременно виртуальных машин. Допустимые значения — от 0 до 100 включительно.
max_expansion | **int64**<br>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `max_unavailable` не указан или равен нулю, `max_expansion` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status`. Допустимые значения — от 0m до 1h включительно.


### AllocationPolicy {#AllocationPolicy}

Поле | Описание
--- | ---
zones[] | **[Zone](../instance_group.proto#Zone2)**<br>Список зон доступности. Минимальное количество элементов — 1.


### Zone {#Zone}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. false


### LoadBalancerSpec {#LoadBalancerSpec}

Поле | Описание
--- | ---
target_group_spec | **[TargetGroupSpec](../instance_group.proto#TargetGroupSpec2)**<br>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе [Целевые ресурсы и группы](/docs/load-balancer/target-resources). 


### TargetGroupSpec {#TargetGroupSpec}

Поле | Описание
--- | ---
name | **string**<br>Имя целевой группы. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec}

Поле | Описание
--- | ---
health_check_specs[] | **[HealthCheckSpec](../instance_group.proto#HealthCheckSpec2)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). Минимальное количество элементов — 1.


### HealthCheckSpec {#HealthCheckSpec}

Поле | Описание
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал проверок. Значение по умолчанию — 2 секунды. Допустимые значения — от 1s до 300s включительно.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время ожидания ответа. Значение по умолчанию — 1 секунда. Допустимые значения — от 1s до 60s включительно.
unhealthy_threshold | **int64**<br>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` или `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](../instance_group.proto#TcpOptions2)**<br>Параметры для проверки состояний по протоколу TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](../instance_group.proto#HttpOptions2)**<br>Параметры для проверки состояний по протоколу HTTP. 


### TcpOptions {#TcpOptions}

Поле | Описание
--- | ---
port | **int64**<br>Порт TCP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](../instance_group.proto#InstanceGroup2)>**<br>в случае успешного выполнения операции. 


### CreateInstanceGroupMetadata {#CreateInstanceGroupMetadata}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Идентификатор создаваемой группы виртуальных машин. Максимальная длина строки в символах — 50.


### InstanceGroup {#InstanceGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](../instance_group.proto#InstanceTemplate3)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](../instance_group.proto#ScalePolicy3)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](../instance_group.proto#DeployPolicy3)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](../instance_group.proto#AllocationPolicy3)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](../instance_group.proto#LoadBalancerState2)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](../instance_group.proto#ManagedInstancesState2)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](../instance_group.proto#LoadBalancerSpec3)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](../instance_group.proto#HealthChecksSpec3)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


## CreateFromYaml {#CreateFromYaml}

Создает группу виртуальных машин в указанном каталоге из YAML-файла. Этот метод запускает операцию, которая может быть отменена другой операцией.

**rpc CreateFromYaml ([CreateInstanceGroupFromYamlRequest](#CreateInstanceGroupFromYamlRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateInstanceGroupMetadata](#CreateInstanceGroupMetadata1)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](../instance_group.proto#InstanceGroup3)<br>

### CreateInstanceGroupFromYamlRequest {#CreateInstanceGroupFromYamlRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для создания группы виртуальных машин. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List). false
instance_group_yaml | **string**<br>Обязательное поле. [InstanceGroupService.Create](#Create) request in YAML format. false Максимальная длина строки в символах — 1048576.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateInstanceGroupMetadata](#CreateInstanceGroupMetadata1)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](../instance_group.proto#InstanceGroup3)>**<br>в случае успешного выполнения операции. 


### CreateInstanceGroupMetadata {#CreateInstanceGroupMetadata}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Идентификатор создаваемой группы виртуальных машин. Максимальная длина строки в символах — 50.


### InstanceGroup {#InstanceGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](../instance_group.proto#InstanceTemplate3)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](../instance_group.proto#ScalePolicy3)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](../instance_group.proto#DeployPolicy3)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](../instance_group.proto#AllocationPolicy3)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](../instance_group.proto#LoadBalancerState2)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](../instance_group.proto#ManagedInstancesState2)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](../instance_group.proto#LoadBalancerSpec3)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](../instance_group.proto#HealthChecksSpec3)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


## Update {#Update}

Изменяет указанную группу виртуальных машин. Этот метод запускает операцию, которая может быть отменена другой операцией.

**rpc Update ([UpdateInstanceGroupRequest](#UpdateInstanceGroupRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateInstanceGroupMetadata](#UpdateInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](../instance_group.proto#InstanceGroup4)<br>

### UpdateInstanceGroupRequest {#UpdateInstanceGroupRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор обновляемой группы виртуальных машин. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). false Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса InstanceGroup будут обновлены. 
name | **string**<br>Имя группы виртуальных машин. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание группы виртуальных машин. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. <br>Существующий набор `labels` полностью перезаписывается набором, переданным в запросе. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
instance_template | **[InstanceTemplate](../instance_group.proto#InstanceTemplate3)**<br>Обязательное поле. Шаблон виртуальной машины, на основе которого создается группа ВМ. false
scale_policy | **[ScalePolicy](../instance_group.proto#ScalePolicy3)**<br>Обязательное поле. [Политика масштабирования](/docs/compute/concepts/instance-groups/scale) группы виртуальных машин. false
deploy_policy | **[DeployPolicy](../instance_group.proto#DeployPolicy3)**<br>Обязательное поле. Политика развертывания группы виртуальных машин. false
allocation_policy | **[AllocationPolicy](../instance_group.proto#AllocationPolicy3)**<br>Обязательное поле. Политика распределения группы виртуальных машин по зонам и регионам. false
health_checks_spec | **[HealthChecksSpec](../instance_group.proto#HealthChecksSpec3)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т.п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List). 
load_balancer_spec | **[LoadBalancerSpec](../instance_group.proto#LoadBalancerSpec3)**<br>Спецификация балансировщика нагрузки для управления распределением нагрузки. 


### InstanceTemplate {#InstanceTemplate}

Поле | Описание
--- | ---
description | **string**<br>Описание шаблона виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). false
resources_spec | **[ResourcesSpec](../instance_group.proto#ResourcesSpec3)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. false
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](../instance_group.proto#AttachedDiskSpec3)**<br>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине. false
secondary_disk_specs[] | **[AttachedDiskSpec](../instance_group.proto#AttachedDiskSpec3)**<br>Массив дополнительных дисков, которые будут подключенны к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](../instance_group.proto#NetworkInterfaceSpec3)**<br>Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине. Количество элементов должно быть ровно 1.
scheduling_policy | **[SchedulingPolicy](../instance_group.proto#SchedulingPolicy3)**<br>Политика планирования. 
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
mode | enum **Mode**<br>Обязательное поле. Режим доступа к ресурсу Disk. false<ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Значение должно соответствовать регулярному выражению ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](../instance_group.proto#DiskSpec3)**<br>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk). false


### DiskSpec {#DiskSpec}

Поле | Описание
--- | ---
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Обязательное поле. Идентификатор типа диска. false
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source_oneof | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан диск. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан диск. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор облачной сети. 
subnet_ids[] | **string**<br>Идентификаторы подсетей. 
primary_v4_address_spec | **[PrimaryAddressSpec](../instance_group.proto#PrimaryAddressSpec3)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](../instance_group.proto#PrimaryAddressSpec3)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](../instance_group.proto#OneToOneNatSpec3)**<br>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет. 


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
&nbsp;&nbsp;fixed_scale | **[FixedScale](../instance_group.proto#FixedScale3)**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/scale#fixed-policy) группы виртуальных машин. 
&nbsp;&nbsp;auto_scale | **[AutoScale](../instance_group.proto#AutoScale3)**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/scale#auto-scale) группы виртуальных машин. 


### AutoScale {#AutoScale}

Поле | Описание
--- | ---
min_zone_size | **int64**<br>Минимальное количество виртуальных машин в каждой зоне. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100. Допустимые значения — от 0 до 100 включительно.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Время в секундах, отведенное на усреднение метрик. false Допустимые значения — от 1m до 10m включительно.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются. Максимальное значение — 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться. Допустимые значения — от 1m до 30m включительно.
initial_size | **int64**<br>Размер целевой группы. Минимальная значение — 1.
cpu_utilization_rule | **[CpuUtilizationRule](../instance_group.proto#CpuUtilizationRule3)**<br>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин. 
custom_rules[] | **[CustomRule](../instance_group.proto#CustomRule3)**<br>Определяет правило автомасштабирования на основе [пользовательской метрики](/docs/monitoring/operations/metric/add) из Yandex Monitoring. Максимальное количество элементов — 1.


### CpuUtilizationRule {#CpuUtilizationRule}

Поле | Описание
--- | ---
utilization_target | **double**<br>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Допустимые значения — от 10 до 100 включительно.


### CustomRule {#CustomRule}

Поле | Описание
--- | ---
rule_type | enum **RuleType**<br>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`. false<ul><li>`UTILIZATION`: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li><li>`WORKLOAD`: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li><ul/>
metric_type | enum **MetricType**<br>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики. false<ul><li>`GAUGE`: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине. <br>Instance Groups вычисляет среднее значение метрики за период, указанный в поле [AutoScale.measurement_duration](../instance_group.proto#AutoScale3).</li><li>`COUNTER`: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине. <br>Instance Groups вычисляет средний прирост метрики за период, указанный в поле [AutoScale.measurement_duration](../instance_group.proto#AutoScale3).</li><ul/>
metric_name | **string**<br>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования. false Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
target | **double**<br>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности. Значение должно быть больше 0.


### FixedScale {#FixedScale}

Поле | Описание
--- | ---
size | **int64**<br>Количество виртуальных машин в группе ВМ. Допустимые значения — от 1 до 100 включительно.


### DeployPolicy {#DeployPolicy}

Поле | Описание
--- | ---
max_unavailable | **int64**<br>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `max_expansion` не указано или равно нулю, `max_unavailable` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
max_deleting | **int64**<br>Максимальное количество удаляемых одновременно виртуальных машин. Допустимые значения — от 0 до 100 включительно.
max_creating | **int64**<br>Максимальное количество создаваемых одновременно виртуальных машин. Допустимые значения — от 0 до 100 включительно.
max_expansion | **int64**<br>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `max_unavailable` не указан или равен нулю, `max_expansion` должно быть ненулевым. Допустимые значения — от 0 до 100 включительно.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status`. Допустимые значения — от 0m до 1h включительно.


### AllocationPolicy {#AllocationPolicy}

Поле | Описание
--- | ---
zones[] | **[Zone](../instance_group.proto#Zone3)**<br>Список зон доступности. Минимальное количество элементов — 1.


### Zone {#Zone}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. false


### HealthChecksSpec {#HealthChecksSpec}

Поле | Описание
--- | ---
health_check_specs[] | **[HealthCheckSpec](../instance_group.proto#HealthCheckSpec3)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). Минимальное количество элементов — 1.


### HealthCheckSpec {#HealthCheckSpec}

Поле | Описание
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал проверок. Значение по умолчанию — 2 секунды. Допустимые значения — от 1s до 300s включительно.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время ожидания ответа. Значение по умолчанию — 1 секунда. Допустимые значения — от 1s до 60s включительно.
unhealthy_threshold | **int64**<br>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2. Значение должно быть равно 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` или `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](../instance_group.proto#TcpOptions3)**<br>Параметры для проверки состояний по протоколу TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](../instance_group.proto#HttpOptions3)**<br>Параметры для проверки состояний по протоколу HTTP. 


### TcpOptions {#TcpOptions}

Поле | Описание
--- | ---
port | **int64**<br>Порт TCP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions}

Поле | Описание
--- | ---
port | **int64**<br>Порт HTTP для проверки состояния. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL, по которому будут выполняться проверки (для HTTP). 


### LoadBalancerSpec {#LoadBalancerSpec}

Поле | Описание
--- | ---
target_group_spec | **[TargetGroupSpec](../instance_group.proto#TargetGroupSpec3)**<br>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе [Целевые ресурсы и группы](/docs/load-balancer/target-resources). 


### TargetGroupSpec {#TargetGroupSpec}

Поле | Описание
--- | ---
name | **string**<br>Имя целевой группы. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](../instance_group.proto#InstanceGroup4)>**<br>в случае успешного выполнения операции. 


### UpdateInstanceGroupMetadata {#UpdateInstanceGroupMetadata}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Идентификатор изменяемого ресурса InstanceGroup. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). 


### InstanceGroup {#InstanceGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](../instance_group.proto#InstanceTemplate4)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](../instance_group.proto#ScalePolicy4)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](../instance_group.proto#DeployPolicy4)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](../instance_group.proto#AllocationPolicy4)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](../instance_group.proto#LoadBalancerState2)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](../instance_group.proto#ManagedInstancesState2)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](../instance_group.proto#LoadBalancerSpec4)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](../instance_group.proto#HealthChecksSpec4)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


## UpdateFromYaml {#UpdateFromYaml}

Обновляет указанную группу виртуальных машин из YAML-файла. Этот метод запускает операцию, которая может быть отменена другой операцией.

**rpc UpdateFromYaml ([UpdateInstanceGroupFromYamlRequest](#UpdateInstanceGroupFromYamlRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateInstanceGroupMetadata](#UpdateInstanceGroupMetadata1)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](../instance_group.proto#InstanceGroup5)<br>

### UpdateInstanceGroupFromYamlRequest {#UpdateInstanceGroupFromYamlRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор обновляемой группы виртуальных машин. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). false Максимальная длина строки в символах — 50.
instance_group_yaml | **string**<br>Обязательное поле. [InstanceGroupService.Update](#Update) request in YAML format. false Максимальная длина строки в символах — 1048576.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateInstanceGroupMetadata](#UpdateInstanceGroupMetadata1)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](../instance_group.proto#InstanceGroup5)>**<br>в случае успешного выполнения операции. 


### UpdateInstanceGroupMetadata {#UpdateInstanceGroupMetadata}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Идентификатор изменяемого ресурса InstanceGroup. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). 


### InstanceGroup {#InstanceGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](../instance_group.proto#InstanceTemplate4)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](../instance_group.proto#ScalePolicy4)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](../instance_group.proto#DeployPolicy4)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](../instance_group.proto#AllocationPolicy4)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](../instance_group.proto#LoadBalancerState2)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](../instance_group.proto#ManagedInstancesState2)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](../instance_group.proto#LoadBalancerSpec4)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](../instance_group.proto#HealthChecksSpec4)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


## Stop {#Stop}

Останавливает указанную группу виртуальных машин.

**rpc Stop ([StopInstanceGroupRequest](#StopInstanceGroupRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopInstanceGroupMetadata](#StopInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](../instance_group.proto#InstanceGroup6)<br>

### StopInstanceGroupRequest {#StopInstanceGroupRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор останавливаемой группы виртуальных машин. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). false Максимальная длина строки в символах — 50.


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](../instance_group.proto#InstanceGroup6)>**<br>в случае успешного выполнения операции. 


### StopInstanceGroupMetadata {#StopInstanceGroupMetadata}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Идентификатор останавливаемой группы виртуальных машин. 


### InstanceGroup {#InstanceGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](../instance_group.proto#InstanceTemplate4)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](../instance_group.proto#ScalePolicy4)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](../instance_group.proto#DeployPolicy4)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](../instance_group.proto#AllocationPolicy4)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](../instance_group.proto#LoadBalancerState2)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](../instance_group.proto#ManagedInstancesState2)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](../instance_group.proto#LoadBalancerSpec4)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](../instance_group.proto#HealthChecksSpec4)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


## Start {#Start}

Запускает указанную группу виртуальных машин.

**rpc Start ([StartInstanceGroupRequest](#StartInstanceGroupRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartInstanceGroupMetadata](#StartInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](../instance_group.proto#InstanceGroup7)<br>

### StartInstanceGroupRequest {#StartInstanceGroupRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор запускаемой группы виртуальных машин. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). false Максимальная длина строки в символах — 50.


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](../instance_group.proto#InstanceGroup7)>**<br>в случае успешного выполнения операции. 


### StartInstanceGroupMetadata {#StartInstanceGroupMetadata}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Идентификатор запускаемой группы виртуальных машин. 


### InstanceGroup {#InstanceGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы виртуальных машин. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа виртуальных машин. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя группы виртуальных машин. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы виртуальных машин. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
instance_template | **[InstanceTemplate](../instance_group.proto#InstanceTemplate4)**<br>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе [Шаблон виртуальной машины](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](../instance_group.proto#ScalePolicy4)**<br>Политика масштабирования группы виртуальных машин. 
deploy_policy | **[DeployPolicy](../instance_group.proto#DeployPolicy4)**<br>Политика развертывания группы виртуальных машин. 
allocation_policy | **[AllocationPolicy](../instance_group.proto#AllocationPolicy4)**<br>Политика распределения группы виртуальных машин по зонам и регионам. 
load_balancer_state | **[LoadBalancerState](../instance_group.proto#LoadBalancerState2)**<br>Информация, указывающая, какие объекты связаны с данным балансировщиком. 
managed_instances_state | **[ManagedInstancesState](../instance_group.proto#ManagedInstancesState2)**<br>Состояния виртуальных машин для данной группы ВМ. 
load_balancer_spec | **[LoadBalancerSpec](../instance_group.proto#LoadBalancerSpec4)**<br>Спецификация балансировщика нагрузки. 
health_checks_spec | **[HealthChecksSpec](../instance_group.proto#HealthChecksSpec4)**<br>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе [Проверка состояния ресурсов](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List). 
status | enum **Status**<br>Статус группы виртуальных машин. <ul><li>`STARTING`: Группа виртуальных машин запускается и скоро станет активной.</li><li>`ACTIVE`: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li><li>`STOPPED`: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Группа виртуальных машин удаляется.</li><ul/>


## Delete {#Delete}

Удаляет указанную группу виртуальных машин.

**rpc Delete ([DeleteInstanceGroupRequest](#DeleteInstanceGroupRequest)) returns ([operation.Operation](#Operation6))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteInstanceGroupMetadata](#DeleteInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteInstanceGroupRequest {#DeleteInstanceGroupRequest}

Поле | Описание
--- | ---
instance_group_id | **string**<br>Обязательное поле. Идентификатор удаляемой группы виртуальных машин. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). false Максимальная длина строки в символах — 50.


### Operation {#Operation}

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
instance_group_id | **string**<br>Обязательное поле. Идентификатор ресурса InstanceGroup для получения списка виртуальных машин. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). false Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListInstanceGroupInstancesResponse.next_page_token](#ListInstanceGroupInstancesResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListInstanceGroupInstancesResponse.next_page_token](#ListInstanceGroupInstancesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [InstanceGroup.name](../instance_group.proto#InstanceGroup8). Максимальная длина строки в символах — 1000.


### ListInstanceGroupInstancesResponse {#ListInstanceGroupInstancesResponse}

Поле | Описание
--- | ---
instances[] | **[ManagedInstance](../instance_group.proto#ManagedInstance)**<br>Возвращает список виртуальных машин для указанной группы ВМ. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListInstanceGroupInstancesRequest.page_size](#ListInstanceGroupInstancesRequest1), используйте `next_page_token` в качестве значения параметра [ListInstanceGroupInstancesRequest.page_token](#ListInstanceGroupInstancesRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


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
network_interfaces[] | **[NetworkInterface](../instance_group.proto#NetworkInterface)**<br>Массив сетевых интерфейсов, присоединенных к виртуальной машине. 
status_changed_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последнего изменения состояния виртуальной машины в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 


### NetworkInterface {#NetworkInterface}

Поле | Описание
--- | ---
index | **string**<br>Индекс сетевого интерфейса, генерируемого сервером, 0,1,2... В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс. 
mac_address | **string**<br>MAC-адрес, назначенный сетевому интерфейсу. 
subnet_id | **string**<br>Идентификатор подсети. 
primary_v4_address | **[PrimaryAddress](../instance_group.proto#PrimaryAddress)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address | **[PrimaryAddress](../instance_group.proto#PrimaryAddress)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddress {#PrimaryAddress}

Поле | Описание
--- | ---
address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. Если не указано, системой будет назначен неиспользуемый внутренний IP-адрес. 
one_to_one_nat | **[OneToOneNat](../instance_group.proto#OneToOneNat)**<br>Конфигурация one-to-one NAT. Если отсутствует, NAT не был настроен. 


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
instance_group_id | **string**<br>Обязательное поле. Идентификатор ресурса InstanceGroup, для которого запрашивается список операций. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). false Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListInstanceGroupOperationsResponse.next_page_token](#ListInstanceGroupOperationsResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListInstanceGroupOperationsResponse.next_page_token](#ListInstanceGroupOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [InstanceGroup.name](../instance_group.proto#InstanceGroup8). Максимальная длина строки в символах — 1000.


### ListInstanceGroupOperationsResponse {#ListInstanceGroupOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>Возвращает список операций для указанной группы виртуальных машин. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListInstanceGroupOperationsRequest.page_size](#ListInstanceGroupOperationsRequest1), используйте `next_page_token` в качестве значения параметра [ListInstanceGroupOperationsRequest.page_token](#ListInstanceGroupOperationsRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Operation {#Operation}

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
instance_group_id | **string**<br>Обязательное поле. Идентификатор ресурса InstanceGroup для получения списка логов. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [InstanceGroupService.List](#List). false
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListInstanceGroupLogRecordsResponse.next_page_token](#ListInstanceGroupLogRecordsResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListInstanceGroupLogRecordsResponse.next_page_token](#ListInstanceGroupLogRecordsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [InstanceGroup.name](../instance_group.proto#InstanceGroup8). Максимальная длина строки в символах — 1000.


### ListInstanceGroupLogRecordsResponse {#ListInstanceGroupLogRecordsResponse}

Поле | Описание
--- | ---
log_records[] | **[LogRecord](../instance_group.proto#LogRecord)**<br>Возвращает список логов для указанной группы виртуальных машин. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListInstanceGroupLogRecordsRequest.page_size](#ListInstanceGroupLogRecordsRequest1), используйте `next_page_token` в качестве значения параметра [ListInstanceGroupLogRecordsRequest.page_token](#ListInstanceGroupLogRecordsRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### LogRecord {#LogRecord}

Поле | Описание
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время записи лога в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
message | **string**<br>Сообщение. 


