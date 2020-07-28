---
editable: false
---

# NodeGroupService

Набор методов для управления группами узлов.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанную группу узлов. |
| [List](#List) | Возвращает список групп узлов в указанном кластере Kubernetes. |
| [Create](#Create) | Создает группу узлов в указанном кластере Kubernetes. |
| [Update](#Update) | Изменяет указанную группу узлов. |
| [Delete](#Delete) | Удаляет указанную группу узлов. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанной группы узлов. |

## Вызовы NodeGroupService {#calls}

## Get {#Get}

Возвращает указанную группу узлов. <br>Чтобы получить список доступных групп узлов, выполните запрос [List](#List).

**rpc Get ([GetNodeGroupRequest](#GetNodeGroupRequest)) returns ([NodeGroup](../node_group.proto#NodeGroup))**

### GetNodeGroupRequest {#GetNodeGroupRequest}

Поле | Описание
--- | ---
node_group_id | **string**<br>Обязательное поле. Идентификатор возвращаемой группы узлов. Чтобы получить идентификатор группы узлов, используйте запрос [NodeGroupService.List](#List). false


### NodeGroup {#NodeGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы узлов. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит группа узлов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Новое имя группы узлов. Имя уникально в рамках каталога. 
description | **string**<br>Новое описание группы узлов. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус группы узлов. <ul><li>`PROVISIONING`: Группа узлов ожидает выделения ресурсов.</li><li>`RUNNING`: Группа узлов запущена.</li><li>`RECONCILING`: Группа узлов ожидает выполнения некоторых работ, например, обновления программного обеспечения узла.</li><li>`STOPPING`: Группа узлов останавливается.</li><li>`STOPPED`: Группа узлов остановлена.</li><li>`DELETING`: Группа узлов удаляется.</li><li>`STARTING`: Группа узлов запускается.</li><ul/>
node_template | **[NodeTemplate](../node_group.proto#NodeTemplate)**<br>Шаблон узла, задающий параметры вычислительных экземпляров для группы узлов. 
scale_policy | **[ScalePolicy](../node_group.proto#ScalePolicy)**<br>Политика масштабирования группы узлов. Дополнительные сведения см. в разделе [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](../node_group.proto#NodeGroupAllocationPolicy)**<br>Политика распределения, с помощью которой ресурсы для групп узлов распределяются по зонам и регионам. 
instance_group_id | **string**<br>Идентификатор группы виртуальных машин, связанной с этой группой узлов. 
node_version | **string**<br>Версия компонентов Kubernetes, которая запущена на узлах. Устарел. Используйте version_info.current_version. 
version_info | **[VersionInfo](../version.proto#VersionInfo)**<br>Подробная информация о версии Kubernetes, которая запущена на мастере. 
maintenance_policy | **[NodeGroupMaintenancePolicy](../node_group.proto#NodeGroupMaintenancePolicy)**<br>Политика обновления группы узлов. 
allowed_unsafe_sysctls[] | **string**<br>Поддержка параметров unsafe sysctl. Дополнительные сведения см. в [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). 


### NodeTemplate {#NodeTemplate}

Поле | Описание
--- | ---
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources_spec | **[ResourcesSpec](../node_group.proto#ResourcesSpec)**<br>Вычислительные ресурсы узла, такие как объем памяти и количество ядер. 
boot_disk_spec | **[DiskSpec](../node_group.proto#DiskSpec)**<br>Спецификация загрузочного диска, который будет подключен к узлу. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате ``key:value``. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, вы можете использовать метаданные для предоставления вашего открытого SSH-ключа узлу. Дополнительные сведения см. в разделе [Metadata](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](../node_group.proto#NodeAddressSpec)**<br>Спецификация для создания сетевых интерфейсов для вычислительных экземпляров группы узлов. 
scheduling_policy | **[SchedulingPolicy](../node_group.proto#SchedulingPolicy)**<br>Политика планирования. 


### ResourcesSpec {#ResourcesSpec}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Допустимые значения — от 0 до 274877906944 включительно.
cores | **int64**<br>Количество ядер, доступное узлу. Значение должно быть равно 0,1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.


### DiskSpec {#DiskSpec}

Поле | Описание
--- | ---
disk_type_id | **string**<br>Идентификатор типа диска. Значение должно соответствовать регулярному выражению ` |network-ssd|network-hdd `.
disk_size | **int64**<br>Размер диска в байтах. Допустимые значения — от 0 до 4398046511104 включительно.


### NodeAddressSpec {#NodeAddressSpec}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](../node_group.proto#OneToOneNatSpec)**<br>Конфигурация one-to-one NAT. Настройка one-to-one NAT гарантирует, что узлам будут назначены публичные IP-адреса. Поэтому интернет будет доступен на всех узлах группы узлов. Если поле не задано, NAT не будет настроен. 


### OneToOneNatSpec {#OneToOneNatSpec}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy}

Поле | Описание
--- | ---
preemptible | **bool**<br>Если значение равно `true` — будет создана прерываемая виртуальная машина. Значение по умолчанию: `false`. Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale` или `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](../node_group.proto#FixedScale)**<br>Политика масштабирования группы узлов. 
&nbsp;&nbsp;auto_scale | **[AutoScale](../node_group.proto#AutoScale)**<br>Политика масштабирования группы узлов. 


### FixedScale {#FixedScale}

Поле | Описание
--- | ---
size | **int64**<br>Количество узлов в группе узлов. Допустимые значения — от 0 до 100 включительно.


### AutoScale {#AutoScale}

Поле | Описание
--- | ---
min_size | **int64**<br>Минимальное количество узлов в группе узлов. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное количество узлов в группе узлов. Допустимые значения — от 0 до 100 включительно.
initial_size | **int64**<br>Начальный размер группы узлов. Допустимые значения — от 0 до 100 включительно.


### NodeGroupAllocationPolicy {#NodeGroupAllocationPolicy}

Поле | Описание
--- | ---
locations[] | **[NodeGroupLocation](../node_group.proto#NodeGroupLocation)**<br>Список местоположений (зон доступности и подсетей), в которых будут выделены ресурсы для группы узлов. 


### NodeGroupLocation {#NodeGroupLocation}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, в которой могут находиться узлы. false
subnet_id | **string**<br>Идентификатор подсети. Если сеть, выбранная для кластера Kubernetes, имеет только одну подсеть в указанной зоне, идентификатор подсети может быть опущен. 


### VersionInfo {#VersionInfo}

Поле | Описание
--- | ---
current_version | **string**<br>Текущая версия Kubernetes, формат: major.minor (например, 1.15). 
new_revision_available | **bool**<br>Новые версии могут включать патчи Kubernetes (например, 1.15.1 -> 1.15.2), а также некоторые обновления внутренних компонентов — новые функции или исправления ошибок в конкретных компонентах Яндекса на мастере или на узлах. 
new_revision_summary | **string**<br>Описание изменений, которые будут применены при обновлении до последней версии. Пусто, если поле `new_revision_available` имеет значение `false`. 
version_deprecated | **bool**<br>Текущая версия устарела, компонент кластера Kubernetes (мастер или группа узлов) должен быть обновлен. 


### NodeGroupMaintenancePolicy {#NodeGroupMaintenancePolicy}

Поле | Описание
--- | ---
auto_upgrade | **bool**<br>Если установлено значение `true`, автоматическое обновление устанавливается без участия пользователя в заданный промежуток времени. Если установлено значение `false`, автоматическое обновление отключено. 
auto_repair | **bool**<br>Если установлено значение `true`, автоматическое восстановление включено. Значение по умолчанию: `false`. 
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow)**<br>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC. 


### MaintenanceWindow {#MaintenanceWindow}

Поле | Описание
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` или `weekly_maintenance_window`<br>Политика обновления.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](../maintenance.proto#AnytimeMaintenanceWindow)**<br>Обновление мастера в любое время. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](../maintenance.proto#DailyMaintenanceWindow)**<br>Обновление мастера в любой день в течение указанного временного окна. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](../maintenance.proto#WeeklyMaintenanceWindow)**<br>Обновление мастера в выбранные дни в течение указанного временного окна. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



### DailyMaintenanceWindow {#DailyMaintenanceWindow}

Поле | Описание
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. false
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Поле | Описание
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](../maintenance.proto#DaysOfWeekMaintenanceWindow)**<br>Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow}

Поле | Описание
--- | ---
days[] | **google.type.DayOfWeek**<br>Дни недели, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. false
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


## List {#List}

Возвращает список групп узлов в указанном кластере Kubernetes.

**rpc List ([ListNodeGroupsRequest](#ListNodeGroupsRequest)) returns ([ListNodeGroupsResponse](#ListNodeGroupsResponse))**

### ListNodeGroupsRequest {#ListNodeGroupsRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка групп узлов. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List). false
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListNodeGroupsResponse.next_page_token](#ListNodeGroupsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListNodeGroupsResponse.next_page_token](#ListNodeGroupsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [NodeGroup.name](../node_group.proto#NodeGroup1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 1 до 61 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListNodeGroupsResponse {#ListNodeGroupsResponse}

Поле | Описание
--- | ---
node_groups[] | **[NodeGroup](../node_group.proto#NodeGroup1)**<br>Список групп узлов. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListNodeGroupsRequest.page_size](#ListNodeGroupsRequest1), используйте `next_page_token` в качестве значения параметра [ListNodeGroupsRequest.page_token](#ListNodeGroupsRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### NodeGroup {#NodeGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы узлов. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит группа узлов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Новое имя группы узлов. Имя уникально в рамках каталога. 
description | **string**<br>Новое описание группы узлов. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус группы узлов. <ul><li>`PROVISIONING`: Группа узлов ожидает выделения ресурсов.</li><li>`RUNNING`: Группа узлов запущена.</li><li>`RECONCILING`: Группа узлов ожидает выполнения некоторых работ, например, обновления программного обеспечения узла.</li><li>`STOPPING`: Группа узлов останавливается.</li><li>`STOPPED`: Группа узлов остановлена.</li><li>`DELETING`: Группа узлов удаляется.</li><li>`STARTING`: Группа узлов запускается.</li><ul/>
node_template | **[NodeTemplate](../node_group.proto#NodeTemplate1)**<br>Шаблон узла, задающий параметры вычислительных экземпляров для группы узлов. 
scale_policy | **[ScalePolicy](../node_group.proto#ScalePolicy1)**<br>Политика масштабирования группы узлов. Дополнительные сведения см. в разделе [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](../node_group.proto#NodeGroupAllocationPolicy1)**<br>Политика распределения, с помощью которой ресурсы для групп узлов распределяются по зонам и регионам. 
instance_group_id | **string**<br>Идентификатор группы виртуальных машин, связанной с этой группой узлов. 
node_version | **string**<br>Версия компонентов Kubernetes, которая запущена на узлах. Устарел. Используйте version_info.current_version. 
version_info | **[VersionInfo](../version.proto#VersionInfo1)**<br>Подробная информация о версии Kubernetes, которая запущена на мастере. 
maintenance_policy | **[NodeGroupMaintenancePolicy](../node_group.proto#NodeGroupMaintenancePolicy1)**<br>Политика обновления группы узлов. 
allowed_unsafe_sysctls[] | **string**<br>Поддержка параметров unsafe sysctl. Дополнительные сведения см. в [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). 


### NodeTemplate {#NodeTemplate}

Поле | Описание
--- | ---
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources_spec | **[ResourcesSpec](../node_group.proto#ResourcesSpec1)**<br>Вычислительные ресурсы узла, такие как объем памяти и количество ядер. 
boot_disk_spec | **[DiskSpec](../node_group.proto#DiskSpec1)**<br>Спецификация загрузочного диска, который будет подключен к узлу. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате ``key:value``. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, вы можете использовать метаданные для предоставления вашего открытого SSH-ключа узлу. Дополнительные сведения см. в разделе [Metadata](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](../node_group.proto#NodeAddressSpec1)**<br>Спецификация для создания сетевых интерфейсов для вычислительных экземпляров группы узлов. 
scheduling_policy | **[SchedulingPolicy](../node_group.proto#SchedulingPolicy1)**<br>Политика планирования. 


### ResourcesSpec {#ResourcesSpec}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Допустимые значения — от 0 до 274877906944 включительно.
cores | **int64**<br>Количество ядер, доступное узлу. Значение должно быть равно 0,1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.


### DiskSpec {#DiskSpec}

Поле | Описание
--- | ---
disk_type_id | **string**<br>Идентификатор типа диска. Значение должно соответствовать регулярному выражению ` |network-ssd|network-hdd `.
disk_size | **int64**<br>Размер диска в байтах. Допустимые значения — от 0 до 4398046511104 включительно.


### NodeAddressSpec {#NodeAddressSpec}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](../node_group.proto#OneToOneNatSpec1)**<br>Конфигурация one-to-one NAT. Настройка one-to-one NAT гарантирует, что узлам будут назначены публичные IP-адреса. Поэтому интернет будет доступен на всех узлах группы узлов. Если поле не задано, NAT не будет настроен. 


### OneToOneNatSpec {#OneToOneNatSpec}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy}

Поле | Описание
--- | ---
preemptible | **bool**<br>Если значение равно `true` — будет создана прерываемая виртуальная машина. Значение по умолчанию: `false`. Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale` или `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](../node_group.proto#FixedScale1)**<br>Политика масштабирования группы узлов. 
&nbsp;&nbsp;auto_scale | **[AutoScale](../node_group.proto#AutoScale1)**<br>Политика масштабирования группы узлов. 


### FixedScale {#FixedScale}

Поле | Описание
--- | ---
size | **int64**<br>Количество узлов в группе узлов. Допустимые значения — от 0 до 100 включительно.


### AutoScale {#AutoScale}

Поле | Описание
--- | ---
min_size | **int64**<br>Минимальное количество узлов в группе узлов. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное количество узлов в группе узлов. Допустимые значения — от 0 до 100 включительно.
initial_size | **int64**<br>Начальный размер группы узлов. Допустимые значения — от 0 до 100 включительно.


### NodeGroupAllocationPolicy {#NodeGroupAllocationPolicy}

Поле | Описание
--- | ---
locations[] | **[NodeGroupLocation](../node_group.proto#NodeGroupLocation1)**<br>Список местоположений (зон доступности и подсетей), в которых будут выделены ресурсы для группы узлов. 


### NodeGroupLocation {#NodeGroupLocation}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, в которой могут находиться узлы. false
subnet_id | **string**<br>Идентификатор подсети. Если сеть, выбранная для кластера Kubernetes, имеет только одну подсеть в указанной зоне, идентификатор подсети может быть опущен. 


### VersionInfo {#VersionInfo}

Поле | Описание
--- | ---
current_version | **string**<br>Текущая версия Kubernetes, формат: major.minor (например, 1.15). 
new_revision_available | **bool**<br>Новые версии могут включать патчи Kubernetes (например, 1.15.1 -> 1.15.2), а также некоторые обновления внутренних компонентов — новые функции или исправления ошибок в конкретных компонентах Яндекса на мастере или на узлах. 
new_revision_summary | **string**<br>Описание изменений, которые будут применены при обновлении до последней версии. Пусто, если поле `new_revision_available` имеет значение `false`. 
version_deprecated | **bool**<br>Текущая версия устарела, компонент кластера Kubernetes (мастер или группа узлов) должен быть обновлен. 


### NodeGroupMaintenancePolicy {#NodeGroupMaintenancePolicy}

Поле | Описание
--- | ---
auto_upgrade | **bool**<br>Если установлено значение `true`, автоматическое обновление устанавливается без участия пользователя в заданный промежуток времени. Если установлено значение `false`, автоматическое обновление отключено. 
auto_repair | **bool**<br>Если установлено значение `true`, автоматическое восстановление включено. Значение по умолчанию: `false`. 
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow1)**<br>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC. 


### MaintenanceWindow {#MaintenanceWindow}

Поле | Описание
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` или `weekly_maintenance_window`<br>Политика обновления.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](../maintenance.proto#AnytimeMaintenanceWindow1)**<br>Обновление мастера в любое время. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](../maintenance.proto#DailyMaintenanceWindow1)**<br>Обновление мастера в любой день в течение указанного временного окна. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](../maintenance.proto#WeeklyMaintenanceWindow1)**<br>Обновление мастера в выбранные дни в течение указанного временного окна. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



### DailyMaintenanceWindow {#DailyMaintenanceWindow}

Поле | Описание
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. false
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Поле | Описание
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](../maintenance.proto#DaysOfWeekMaintenanceWindow1)**<br>Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow}

Поле | Описание
--- | ---
days[] | **google.type.DayOfWeek**<br>Дни недели, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. false
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


## Create {#Create}

Создает группу узлов в указанном кластере Kubernetes.

**rpc Create ([CreateNodeGroupRequest](#CreateNodeGroupRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateNodeGroupMetadata](#CreateNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NodeGroup](../node_group.proto#NodeGroup2)<br>

### CreateNodeGroupRequest {#CreateNodeGroupRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Kubernetes, в котором следует создать группу узлов. Чтобы получить идентификатор кластера Kubernetes, используйте [ClusterService.List](./cluster_service#List) запрос. false
name | **string**<br>Новое имя группы узлов. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Новое описание группы узлов. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
node_template | **[NodeTemplate](../node_group.proto#NodeTemplate2)**<br>Обязательное поле. Шаблон узла для создания группы узлов. false
scale_policy | **[ScalePolicy](../node_group.proto#ScalePolicy2)**<br>Обязательное поле. Политика масштабирования группы узлов. false
allocation_policy | **[NodeGroupAllocationPolicy](../node_group.proto#NodeGroupAllocationPolicy2)**<br>Политика распределения группы узлов по зонам и регионам. 
version | **string**<br>Версия компонентов Kubernetes, которая запущена на узлах. 
maintenance_policy | **[NodeGroupMaintenancePolicy](../node_group.proto#NodeGroupMaintenancePolicy2)**<br>Политика обновления группы узлов. 
allowed_unsafe_sysctls[] | **string**<br>Поддержка параметров unsafe sysctl. Дополнительные сведения см. в [документации](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). 


### NodeTemplate {#NodeTemplate}

Поле | Описание
--- | ---
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources_spec | **[ResourcesSpec](../node_group.proto#ResourcesSpec2)**<br>Вычислительные ресурсы узла, такие как объем памяти и количество ядер. 
boot_disk_spec | **[DiskSpec](../node_group.proto#DiskSpec2)**<br>Спецификация загрузочного диска, который будет подключен к узлу. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате ``key:value``. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, вы можете использовать метаданные для предоставления вашего открытого SSH-ключа узлу. Дополнительные сведения см. в разделе [Metadata](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](../node_group.proto#NodeAddressSpec2)**<br>Спецификация для создания сетевых интерфейсов для вычислительных экземпляров группы узлов. 
scheduling_policy | **[SchedulingPolicy](../node_group.proto#SchedulingPolicy2)**<br>Политика планирования. 


### ResourcesSpec {#ResourcesSpec}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Допустимые значения — от 0 до 274877906944 включительно.
cores | **int64**<br>Количество ядер, доступное узлу. Значение должно быть равно 0,1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.


### DiskSpec {#DiskSpec}

Поле | Описание
--- | ---
disk_type_id | **string**<br>Идентификатор типа диска. Значение должно соответствовать регулярному выражению ` |network-ssd|network-hdd `.
disk_size | **int64**<br>Размер диска в байтах. Допустимые значения — от 0 до 4398046511104 включительно.


### NodeAddressSpec {#NodeAddressSpec}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](../node_group.proto#OneToOneNatSpec2)**<br>Конфигурация one-to-one NAT. Настройка one-to-one NAT гарантирует, что узлам будут назначены публичные IP-адреса. Поэтому интернет будет доступен на всех узлах группы узлов. Если поле не задано, NAT не будет настроен. 


### OneToOneNatSpec {#OneToOneNatSpec}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy}

Поле | Описание
--- | ---
preemptible | **bool**<br>Если значение равно `true` — будет создана прерываемая виртуальная машина. Значение по умолчанию: `false`. Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale` или `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](../node_group.proto#FixedScale2)**<br>Политика масштабирования группы узлов. 
&nbsp;&nbsp;auto_scale | **[AutoScale](../node_group.proto#AutoScale2)**<br>Политика масштабирования группы узлов. 


### FixedScale {#FixedScale}

Поле | Описание
--- | ---
size | **int64**<br>Количество узлов в группе узлов. Допустимые значения — от 0 до 100 включительно.


### AutoScale {#AutoScale}

Поле | Описание
--- | ---
min_size | **int64**<br>Минимальное количество узлов в группе узлов. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное количество узлов в группе узлов. Допустимые значения — от 0 до 100 включительно.
initial_size | **int64**<br>Начальный размер группы узлов. Допустимые значения — от 0 до 100 включительно.


### NodeGroupAllocationPolicy {#NodeGroupAllocationPolicy}

Поле | Описание
--- | ---
locations[] | **[NodeGroupLocation](../node_group.proto#NodeGroupLocation2)**<br>Список местоположений (зон доступности и подсетей), в которых будут выделены ресурсы для группы узлов. 


### NodeGroupLocation {#NodeGroupLocation}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, в которой могут находиться узлы. false
subnet_id | **string**<br>Идентификатор подсети. Если сеть, выбранная для кластера Kubernetes, имеет только одну подсеть в указанной зоне, идентификатор подсети может быть опущен. 


### NodeGroupMaintenancePolicy {#NodeGroupMaintenancePolicy}

Поле | Описание
--- | ---
auto_upgrade | **bool**<br>Если установлено значение `true`, автоматическое обновление устанавливается без участия пользователя в заданный промежуток времени. Если установлено значение `false`, автоматическое обновление отключено. 
auto_repair | **bool**<br>Если установлено значение `true`, автоматическое восстановление включено. Значение по умолчанию: `false`. 
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow2)**<br>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC. 


### MaintenanceWindow {#MaintenanceWindow}

Поле | Описание
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` или `weekly_maintenance_window`<br>Политика обновления.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](../maintenance.proto#AnytimeMaintenanceWindow2)**<br>Обновление мастера в любое время. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](../maintenance.proto#DailyMaintenanceWindow2)**<br>Обновление мастера в любой день в течение указанного временного окна. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](../maintenance.proto#WeeklyMaintenanceWindow2)**<br>Обновление мастера в выбранные дни в течение указанного временного окна. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



### DailyMaintenanceWindow {#DailyMaintenanceWindow}

Поле | Описание
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. false
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Поле | Описание
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](../maintenance.proto#DaysOfWeekMaintenanceWindow2)**<br>Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow}

Поле | Описание
--- | ---
days[] | **google.type.DayOfWeek**<br>Дни недели, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. false
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateNodeGroupMetadata](#CreateNodeGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NodeGroup](../node_group.proto#NodeGroup2)>**<br>в случае успешного выполнения операции. 


### CreateNodeGroupMetadata {#CreateNodeGroupMetadata}

Поле | Описание
--- | ---
node_group_id | **string**<br>Идентификатор создаваемой группы узлов. 


### NodeGroup {#NodeGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы узлов. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит группа узлов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Новое имя группы узлов. Имя уникально в рамках каталога. 
description | **string**<br>Новое описание группы узлов. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус группы узлов. <ul><li>`PROVISIONING`: Группа узлов ожидает выделения ресурсов.</li><li>`RUNNING`: Группа узлов запущена.</li><li>`RECONCILING`: Группа узлов ожидает выполнения некоторых работ, например, обновления программного обеспечения узла.</li><li>`STOPPING`: Группа узлов останавливается.</li><li>`STOPPED`: Группа узлов остановлена.</li><li>`DELETING`: Группа узлов удаляется.</li><li>`STARTING`: Группа узлов запускается.</li><ul/>
node_template | **[NodeTemplate](../node_group.proto#NodeTemplate3)**<br>Шаблон узла, задающий параметры вычислительных экземпляров для группы узлов. 
scale_policy | **[ScalePolicy](../node_group.proto#ScalePolicy3)**<br>Политика масштабирования группы узлов. Дополнительные сведения см. в разделе [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](../node_group.proto#NodeGroupAllocationPolicy3)**<br>Политика распределения, с помощью которой ресурсы для групп узлов распределяются по зонам и регионам. 
instance_group_id | **string**<br>Идентификатор группы виртуальных машин, связанной с этой группой узлов. 
node_version | **string**<br>Версия компонентов Kubernetes, которая запущена на узлах. Устарел. Используйте version_info.current_version. 
version_info | **[VersionInfo](../version.proto#VersionInfo2)**<br>Подробная информация о версии Kubernetes, которая запущена на мастере. 
maintenance_policy | **[NodeGroupMaintenancePolicy](../node_group.proto#NodeGroupMaintenancePolicy3)**<br>Политика обновления группы узлов. 
allowed_unsafe_sysctls[] | **string**<br>Поддержка параметров unsafe sysctl. Дополнительные сведения см. в [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). 


## Update {#Update}

Изменяет указанную группу узлов.

**rpc Update ([UpdateNodeGroupRequest](#UpdateNodeGroupRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateNodeGroupMetadata](#UpdateNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NodeGroup](../node_group.proto#NodeGroup3)<br>

### UpdateNodeGroupRequest {#UpdateNodeGroupRequest}

Поле | Описание
--- | ---
node_group_id | **string**<br>Обязательное поле. Идентификатор изменяемой группы узлов. Чтобы получить идентификатор группы узлов, используйте запрос [NodeGroupService.List](#List). false
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля группы узлов будут изменены. 
name | **string**<br>Новое имя группы узлов. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Новое описание группы узлов. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. <br>Существующий набор `labels` полностью перезаписывается набором, переданным в запросе. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
node_template | **[NodeTemplate](../node_group.proto#NodeTemplate3)**<br>Шаблон узла для создания группы узлов. Изменение может вызвать перезагрузку или повторное создание узлов. 
scale_policy | **[ScalePolicy](../node_group.proto#ScalePolicy3)**<br>Политика масштабирования группы узлов. 
allocation_policy | **[NodeGroupAllocationPolicy](../node_group.proto#NodeGroupAllocationPolicy3)**<br>Политика распределения группы узлов по зонам и регионам. 
version | **[UpdateVersionSpec](../version.proto#UpdateVersionSpec)**<br>Версия компонентов Kubernetes, которая запущена на узлах. 
maintenance_policy | **[NodeGroupMaintenancePolicy](../node_group.proto#NodeGroupMaintenancePolicy3)**<br>Политика обновления группы узлов. 
allowed_unsafe_sysctls[] | **string**<br>Поддержка параметров unsafe sysctl. Дополнительные сведения см. в [документации](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). 


### NodeTemplate {#NodeTemplate}

Поле | Описание
--- | ---
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources_spec | **[ResourcesSpec](../node_group.proto#ResourcesSpec3)**<br>Вычислительные ресурсы узла, такие как объем памяти и количество ядер. 
boot_disk_spec | **[DiskSpec](../node_group.proto#DiskSpec3)**<br>Спецификация загрузочного диска, который будет подключен к узлу. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате ``key:value``. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, вы можете использовать метаданные для предоставления вашего открытого SSH-ключа узлу. Дополнительные сведения см. в разделе [Metadata](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](../node_group.proto#NodeAddressSpec3)**<br>Спецификация для создания сетевых интерфейсов для вычислительных экземпляров группы узлов. 
scheduling_policy | **[SchedulingPolicy](../node_group.proto#SchedulingPolicy3)**<br>Политика планирования. 


### ResourcesSpec {#ResourcesSpec}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Допустимые значения — от 0 до 274877906944 включительно.
cores | **int64**<br>Количество ядер, доступное узлу. Значение должно быть равно 0,1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.


### DiskSpec {#DiskSpec}

Поле | Описание
--- | ---
disk_type_id | **string**<br>Идентификатор типа диска. Значение должно соответствовать регулярному выражению ` |network-ssd|network-hdd `.
disk_size | **int64**<br>Размер диска в байтах. Допустимые значения — от 0 до 4398046511104 включительно.


### NodeAddressSpec {#NodeAddressSpec}

Поле | Описание
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](../node_group.proto#OneToOneNatSpec3)**<br>Конфигурация one-to-one NAT. Настройка one-to-one NAT гарантирует, что узлам будут назначены публичные IP-адреса. Поэтому интернет будет доступен на всех узлах группы узлов. Если поле не задано, NAT не будет настроен. 


### OneToOneNatSpec {#OneToOneNatSpec}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.168.0.0.</li><li>`IPV6`: IPv6-адрес, на данный момент не доступен.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy}

Поле | Описание
--- | ---
preemptible | **bool**<br>Если значение равно `true` — будет создана прерываемая виртуальная машина. Значение по умолчанию: `false`. Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale` или `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](../node_group.proto#FixedScale3)**<br>Политика масштабирования группы узлов. 
&nbsp;&nbsp;auto_scale | **[AutoScale](../node_group.proto#AutoScale3)**<br>Политика масштабирования группы узлов. 


### FixedScale {#FixedScale}

Поле | Описание
--- | ---
size | **int64**<br>Количество узлов в группе узлов. Допустимые значения — от 0 до 100 включительно.


### AutoScale {#AutoScale}

Поле | Описание
--- | ---
min_size | **int64**<br>Минимальное количество узлов в группе узлов. Допустимые значения — от 0 до 100 включительно.
max_size | **int64**<br>Максимальное количество узлов в группе узлов. Допустимые значения — от 0 до 100 включительно.
initial_size | **int64**<br>Начальный размер группы узлов. Допустимые значения — от 0 до 100 включительно.


### NodeGroupAllocationPolicy {#NodeGroupAllocationPolicy}

Поле | Описание
--- | ---
locations[] | **[NodeGroupLocation](../node_group.proto#NodeGroupLocation3)**<br>Список местоположений (зон доступности и подсетей), в которых будут выделены ресурсы для группы узлов. 


### NodeGroupLocation {#NodeGroupLocation}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, в которой могут находиться узлы. false
subnet_id | **string**<br>Идентификатор подсети. Если сеть, выбранная для кластера Kubernetes, имеет только одну подсеть в указанной зоне, идентификатор подсети может быть опущен. 


### UpdateVersionSpec {#UpdateVersionSpec}

Поле | Описание
--- | ---
specifier | **oneof:** `version` или `latest_revision`<br>
&nbsp;&nbsp;version | **string**<br>Запрос обновления до более новой версии Kubernetes (1.x - > 1.y). 
&nbsp;&nbsp;latest_revision | **bool**<br>Запрос минорного обновления, содержащего новую функциональность и улучшения, для текущей версии Kubernetes. 


### NodeGroupMaintenancePolicy {#NodeGroupMaintenancePolicy}

Поле | Описание
--- | ---
auto_upgrade | **bool**<br>Если установлено значение `true`, автоматическое обновление устанавливается без участия пользователя в заданный промежуток времени. Если установлено значение `false`, автоматическое обновление отключено. 
auto_repair | **bool**<br>Если установлено значение `true`, автоматическое восстановление включено. Значение по умолчанию: `false`. 
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow3)**<br>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC. 


### MaintenanceWindow {#MaintenanceWindow}

Поле | Описание
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` или `weekly_maintenance_window`<br>Политика обновления.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](../maintenance.proto#AnytimeMaintenanceWindow3)**<br>Обновление мастера в любое время. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](../maintenance.proto#DailyMaintenanceWindow3)**<br>Обновление мастера в любой день в течение указанного временного окна. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](../maintenance.proto#WeeklyMaintenanceWindow3)**<br>Обновление мастера в выбранные дни в течение указанного временного окна. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



### DailyMaintenanceWindow {#DailyMaintenanceWindow}

Поле | Описание
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. false
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Поле | Описание
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](../maintenance.proto#DaysOfWeekMaintenanceWindow3)**<br>Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow}

Поле | Описание
--- | ---
days[] | **google.type.DayOfWeek**<br>Дни недели, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. false
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateNodeGroupMetadata](#UpdateNodeGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NodeGroup](../node_group.proto#NodeGroup3)>**<br>в случае успешного выполнения операции. 


### UpdateNodeGroupMetadata {#UpdateNodeGroupMetadata}

Поле | Описание
--- | ---
node_group_id | **string**<br>Обязательное поле. Идентификатор группы узлов, которая изменяется. false


### NodeGroup {#NodeGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы узлов. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит группа узлов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Новое имя группы узлов. Имя уникально в рамках каталога. 
description | **string**<br>Новое описание группы узлов. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус группы узлов. <ul><li>`PROVISIONING`: Группа узлов ожидает выделения ресурсов.</li><li>`RUNNING`: Группа узлов запущена.</li><li>`RECONCILING`: Группа узлов ожидает выполнения некоторых работ, например, обновления программного обеспечения узла.</li><li>`STOPPING`: Группа узлов останавливается.</li><li>`STOPPED`: Группа узлов остановлена.</li><li>`DELETING`: Группа узлов удаляется.</li><li>`STARTING`: Группа узлов запускается.</li><ul/>
node_template | **[NodeTemplate](../node_group.proto#NodeTemplate4)**<br>Шаблон узла, задающий параметры вычислительных экземпляров для группы узлов. 
scale_policy | **[ScalePolicy](../node_group.proto#ScalePolicy4)**<br>Политика масштабирования группы узлов. Дополнительные сведения см. в разделе [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](../node_group.proto#NodeGroupAllocationPolicy4)**<br>Политика распределения, с помощью которой ресурсы для групп узлов распределяются по зонам и регионам. 
instance_group_id | **string**<br>Идентификатор группы виртуальных машин, связанной с этой группой узлов. 
node_version | **string**<br>Версия компонентов Kubernetes, которая запущена на узлах. Устарел. Используйте version_info.current_version. 
version_info | **[VersionInfo](../version.proto#VersionInfo2)**<br>Подробная информация о версии Kubernetes, которая запущена на мастере. 
maintenance_policy | **[NodeGroupMaintenancePolicy](../node_group.proto#NodeGroupMaintenancePolicy4)**<br>Политика обновления группы узлов. 
allowed_unsafe_sysctls[] | **string**<br>Поддержка параметров unsafe sysctl. Дополнительные сведения см. в [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). 


## Delete {#Delete}

Удаляет указанную группу узлов.

**rpc Delete ([DeleteNodeGroupRequest](#DeleteNodeGroupRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteNodeGroupMetadata](#DeleteNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteNodeGroupRequest {#DeleteNodeGroupRequest}

Поле | Описание
--- | ---
node_group_id | **string**<br>Обязательное поле. Идентификатор удаляемой группы узлов. Чтобы получить идентификатор группы узлов, используйте запрос [NodeGroupService.List](#List). false


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteNodeGroupMetadata](#DeleteNodeGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteNodeGroupMetadata {#DeleteNodeGroupMetadata}

Поле | Описание
--- | ---
node_group_id | **string**<br>Идентификатор группы узлов, которая удаляется. 


## ListOperations {#ListOperations}

Возвращает список операций для указанной группы узлов.

**rpc ListOperations ([ListNodeGroupOperationsRequest](#ListNodeGroupOperationsRequest)) returns ([ListNodeGroupOperationsResponse](#ListNodeGroupOperationsResponse))**

### ListNodeGroupOperationsRequest {#ListNodeGroupOperationsRequest}

Поле | Описание
--- | ---
node_group_id | **string**<br>Обязательное поле. Идентификатор группы узлов, для которой запрашивается список операций. false
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size`, сервис вернет значение [ListNodeGroupOperationsResponse.next_page_token](#ListNodeGroupOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListNodeGroupOperationsResponse.next_page_token](#ListNodeGroupOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [NodeGroup.name](../node_group.proto#NodeGroup4). Максимальная длина строки в символах — 1000.


### ListNodeGroupOperationsResponse {#ListNodeGroupOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>Список операций для указанной группы узлов. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListNodeGroupOperationsRequest.page_size](#ListNodeGroupOperationsRequest1), используйте `next_page_token` в качестве значения параметра [ListNodeGroupOperationsRequest.page_token](#ListNodeGroupOperationsRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


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


