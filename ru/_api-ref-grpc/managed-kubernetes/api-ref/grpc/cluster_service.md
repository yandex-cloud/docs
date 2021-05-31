---
editable: false
---

# ClusterService

Набор методов для управления кластером Kubernetes.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный кластер Kubernetes. |
| [List](#List) | Возвращает список кластеров Kubernetes в указанном каталоге. |
| [Create](#Create) | Создает кластер Kubernetes в указанном каталоге. |
| [Update](#Update) | Обновляет указанный кластер Kubernetes. |
| [Delete](#Delete) | Удаляет указанный кластер Kubernetes. |
| [Stop](#Stop) | Останавливает указанный кластер Kubernetes. |
| [Start](#Start) | Запускает указанный кластер Kubernetes. |
| [ListNodeGroups](#ListNodeGroups) | Список групп узлов для указанного кластера Kubernetes. |
| [ListOperations](#ListOperations) | Список операций для указанного кластера Kubernetes. |

## Вызовы ClusterService {#calls}

## Get {#Get}

Возвращает указанный кластер Kubernetes. <br>Чтобы получить список доступных кластеров Kubernetes, сделайте запрос [List](#List).

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор возвращаемого кластера Kubernetes. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Kubernetes. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Kubernetes. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Kubernetes. 
description | **string**<br>Описание кластера Kubernetes. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус кластера Kubernetes. <ul><li>`PROVISIONING`: Кластер Kubernetes ожидает выделения ресурсов.</li><li>`RUNNING`: Кластер Kubernetes запущен.</li><li>`RECONCILING`: Кластер Kubernetes согласовывается.</li><li>`STOPPING`: Кластер Kubernetes останавливается.</li><li>`STOPPED`: Кластер Kubernetes остановлен.</li><li>`DELETING`: Кластер Kubernetes удаляется.</li><li>`STARTING`: Кластер Kubernetes запускается.</li><ul/>
health | enum **Health**<br>Состояние кластера Kubernetes. <ul><li>`HEALTHY`: Кластер Kubernetes работает нормально.</li><li>`UNHEALTHY`: Кластер Kubernetes не работает и не может выполнять свои основные функции.</li><ul/>
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит кластер Kubernetes. 
master | **[Master](#Master)**<br>Свойства мастера для кластера Kubernetes. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy)**<br>Политика распределения IP-адресов для служб и модулей внутри кластера Kubernetes в разных зонах доступности. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Адрес шлюза IPv4. Максимальная длина строки в символах — 15.
service_account_id | **string**<br>Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. 
node_service_account_id | **string**<br>Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла. 
release_channel | enum **ReleaseChannel**<br>При создании кластера Kubernetes вы должны указать один из трех релизных каналов. Релизный канал содержит несколько версий Kubernetes. Каналы отличаются набором доступных версий, управлением автоматическими обновлениями и получаемыми обновлениями. Изменить канал после создания кластера Kubernetes нельзя, возможно только пересоздать кластер Kubernetes и указать новый релизный канал. Дополнительные сведения см. в [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates). <ul><li>`RAPID`: На канале часто появляются минорные обновления, содержащие новую функциональность и улучшения. Вы не можете отключить автоматическое обновление на этом канале, но вы можете указать период времени для автоматического обновления.</li><li>`REGULAR`: Новая функциональность и улучшения порциями попадают на канал через некоторое время после того, как были предоставлены на канале `RAPID`.</li><li>`STABLE`: На канале происходят только обновления, касающиеся исправление ошибок или улучшения безопасности.</li><ul/>
network_policy | **[NetworkPolicy](#NetworkPolicy)**<br> 


### Master {#Master}

Поле | Описание
--- | ---
master_type | **oneof:** `zonal_master` или `regional_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster)**<br>Параметры зоны доступности мастера. 
&nbsp;&nbsp;regional_master | **[RegionalMaster](#RegionalMaster)**<br>Параметры региона для мастера. 
version | **string**<br>Версия компонентов Kubernetes, которая запущена на мастере. 
endpoints | **[MasterEndpoints](#MasterEndpoints)**<br>Эндпойнт мастера. Эндпойнты состоят из схемы и порта (т. е. `https://ip-address:port`) и могут использоваться клиентами для связи с API Kubernetes кластера Kubernetes. 
master_auth | **[MasterAuth](#MasterAuth)**<br>Параметры, используемые для аутентификации мастера. 
version_info | **[VersionInfo](#VersionInfo)**<br>Подробная информация о версии Kubernetes, которая запущена на мастере. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy)**<br>Политика обновления мастера. 


### ZonalMaster {#ZonalMaster}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится мастер. 
internal_v4_address | **string**<br>Внутренний IPv4-адрес, назначенный мастеру. 
external_v4_address | **string**<br>Внешний IPv4-адрес, назначенный мастеру. 


### RegionalMaster {#RegionalMaster}

Поле | Описание
--- | ---
region_id | **string**<br>Идентификатор региона, в котором находится мастер. 
internal_v4_address | **string**<br>Внутренний IPv4-адрес, назначенный мастеру. 
external_v4_address | **string**<br>Внешний IPv4-адрес, назначенный мастеру. 


### MasterEndpoints {#MasterEndpoints}

Поле | Описание
--- | ---
internal_v4_endpoint | **string**<br>Внутренний эндпойнт, который может использоваться для подключения к мастеру из облачных сетей. 
external_v4_endpoint | **string**<br>Внешний эндпойнт, который может использоваться для доступа к API кластера Kubernetes из интернета (вне Облака). 


### MasterAuth {#MasterAuth}

Поле | Описание
--- | ---
cluster_ca_certificate | **string**<br>Публичный PEM-закодированный сертификат, подтверждающий подлинность кластера Kubernetes. 


### VersionInfo {#VersionInfo}

Поле | Описание
--- | ---
current_version | **string**<br>Текущая версия Kubernetes, формат: major.minor (например, 1.15). 
new_revision_available | **bool**<br>Новые версии могут включать патчи Kubernetes (например, 1.15.1 -> 1.15.2), а также некоторые обновления внутренних компонентов — новые функции или исправления ошибок в конкретных компонентах Яндекса на мастере или на узлах. 
new_revision_summary | **string**<br>Описание изменений, которые будут применены при обновлении до последней версии. Пусто, если поле `new_revision_available` имеет значение `false`. 
version_deprecated | **bool**<br>Текущая версия устарела, компонент кластера Kubernetes (мастер или группа узлов) должен быть обновлен. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy}

Поле | Описание
--- | ---
auto_upgrade | **bool**<br>Если установлено значение `true`, автоматическое обновление устанавливается без участия пользователя в заданный промежуток времени. Если установлено значение `false`, автоматическое обновление отключено. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC. 


### MaintenanceWindow {#MaintenanceWindow}

Поле | Описание
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` или `weekly_maintenance_window`<br>Политика обновления.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow)**<br>Обновление мастера в любое время. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow)**<br>Обновление мастера в любой день в течение указанного временного окна. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow)**<br>Обновление мастера в выбранные дни в течение указанного временного окна. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



### DailyMaintenanceWindow {#DailyMaintenanceWindow}

Поле | Описание
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Поле | Описание
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow)**<br>Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow}

Поле | Описание
--- | ---
days[] | **google.type.DayOfWeek**<br>Дни недели, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### IPAllocationPolicy {#IPAllocationPolicy}

Поле | Описание
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для подов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. Статические маршруты будут настроены для этих блоков CIDR в подсетях узлов. 
service_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для сервисов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. 


### NetworkPolicy {#NetworkPolicy}

Поле | Описание
--- | ---
provider | enum **Provider**<br> <ul><ul/>


## List {#List}

Возвращает список кластеров Kubernetes в указанном каталоге.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка кластеров Kubernetes. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClustersResponse.next_page_token](#ListClustersResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClustersResponse.next_page_token](#ListClustersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Cluster.name](#Cluster1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 1 до 61 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListClustersResponse {#ListClustersResponse}

Поле | Описание
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>Список кластеров Kubernetes. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClustersRequest.page_size](#ListClustersRequest), используйте `next_page_token` в качестве значения параметра [ListClustersRequest.page_token](#ListClustersRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Cluster {#Cluster1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Kubernetes. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Kubernetes. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Kubernetes. 
description | **string**<br>Описание кластера Kubernetes. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус кластера Kubernetes. <ul><li>`PROVISIONING`: Кластер Kubernetes ожидает выделения ресурсов.</li><li>`RUNNING`: Кластер Kubernetes запущен.</li><li>`RECONCILING`: Кластер Kubernetes согласовывается.</li><li>`STOPPING`: Кластер Kubernetes останавливается.</li><li>`STOPPED`: Кластер Kubernetes остановлен.</li><li>`DELETING`: Кластер Kubernetes удаляется.</li><li>`STARTING`: Кластер Kubernetes запускается.</li><ul/>
health | enum **Health**<br>Состояние кластера Kubernetes. <ul><li>`HEALTHY`: Кластер Kubernetes работает нормально.</li><li>`UNHEALTHY`: Кластер Kubernetes не работает и не может выполнять свои основные функции.</li><ul/>
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит кластер Kubernetes. 
master | **[Master](#Master1)**<br>Свойства мастера для кластера Kubernetes. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy1)**<br>Политика распределения IP-адресов для служб и модулей внутри кластера Kubernetes в разных зонах доступности. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Адрес шлюза IPv4. Максимальная длина строки в символах — 15.
service_account_id | **string**<br>Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. 
node_service_account_id | **string**<br>Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла. 
release_channel | enum **ReleaseChannel**<br>При создании кластера Kubernetes вы должны указать один из трех релизных каналов. Релизный канал содержит несколько версий Kubernetes. Каналы отличаются набором доступных версий, управлением автоматическими обновлениями и получаемыми обновлениями. Изменить канал после создания кластера Kubernetes нельзя, возможно только пересоздать кластер Kubernetes и указать новый релизный канал. Дополнительные сведения см. в [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates). <ul><li>`RAPID`: На канале часто появляются минорные обновления, содержащие новую функциональность и улучшения. Вы не можете отключить автоматическое обновление на этом канале, но вы можете указать период времени для автоматического обновления.</li><li>`REGULAR`: Новая функциональность и улучшения порциями попадают на канал через некоторое время после того, как были предоставлены на канале `RAPID`.</li><li>`STABLE`: На канале происходят только обновления, касающиеся исправление ошибок или улучшения безопасности.</li><ul/>
network_policy | **[NetworkPolicy](#NetworkPolicy1)**<br> 


### Master {#Master1}

Поле | Описание
--- | ---
master_type | **oneof:** `zonal_master` или `regional_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster1)**<br>Параметры зоны доступности мастера. 
&nbsp;&nbsp;regional_master | **[RegionalMaster](#RegionalMaster1)**<br>Параметры региона для мастера. 
version | **string**<br>Версия компонентов Kubernetes, которая запущена на мастере. 
endpoints | **[MasterEndpoints](#MasterEndpoints1)**<br>Эндпойнт мастера. Эндпойнты состоят из схемы и порта (т. е. `https://ip-address:port`) и могут использоваться клиентами для связи с API Kubernetes кластера Kubernetes. 
master_auth | **[MasterAuth](#MasterAuth1)**<br>Параметры, используемые для аутентификации мастера. 
version_info | **[VersionInfo](#VersionInfo1)**<br>Подробная информация о версии Kubernetes, которая запущена на мастере. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy1)**<br>Политика обновления мастера. 


### ZonalMaster {#ZonalMaster1}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится мастер. 
internal_v4_address | **string**<br>Внутренний IPv4-адрес, назначенный мастеру. 
external_v4_address | **string**<br>Внешний IPv4-адрес, назначенный мастеру. 


### RegionalMaster {#RegionalMaster1}

Поле | Описание
--- | ---
region_id | **string**<br>Идентификатор региона, в котором находится мастер. 
internal_v4_address | **string**<br>Внутренний IPv4-адрес, назначенный мастеру. 
external_v4_address | **string**<br>Внешний IPv4-адрес, назначенный мастеру. 


### MasterEndpoints {#MasterEndpoints1}

Поле | Описание
--- | ---
internal_v4_endpoint | **string**<br>Внутренний эндпойнт, который может использоваться для подключения к мастеру из облачных сетей. 
external_v4_endpoint | **string**<br>Внешний эндпойнт, который может использоваться для доступа к API кластера Kubernetes из интернета (вне Облака). 


### MasterAuth {#MasterAuth1}

Поле | Описание
--- | ---
cluster_ca_certificate | **string**<br>Публичный PEM-закодированный сертификат, подтверждающий подлинность кластера Kubernetes. 


### VersionInfo {#VersionInfo1}

Поле | Описание
--- | ---
current_version | **string**<br>Текущая версия Kubernetes, формат: major.minor (например, 1.15). 
new_revision_available | **bool**<br>Новые версии могут включать патчи Kubernetes (например, 1.15.1 -> 1.15.2), а также некоторые обновления внутренних компонентов — новые функции или исправления ошибок в конкретных компонентах Яндекса на мастере или на узлах. 
new_revision_summary | **string**<br>Описание изменений, которые будут применены при обновлении до последней версии. Пусто, если поле `new_revision_available` имеет значение `false`. 
version_deprecated | **bool**<br>Текущая версия устарела, компонент кластера Kubernetes (мастер или группа узлов) должен быть обновлен. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy1}

Поле | Описание
--- | ---
auto_upgrade | **bool**<br>Если установлено значение `true`, автоматическое обновление устанавливается без участия пользователя в заданный промежуток времени. Если установлено значение `false`, автоматическое обновление отключено. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC. 


### MaintenanceWindow {#MaintenanceWindow1}

Поле | Описание
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` или `weekly_maintenance_window`<br>Политика обновления.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow1)**<br>Обновление мастера в любое время. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow1)**<br>Обновление мастера в любой день в течение указанного временного окна. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow1)**<br>Обновление мастера в выбранные дни в течение указанного временного окна. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow1}



### DailyMaintenanceWindow {#DailyMaintenanceWindow1}

Поле | Описание
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow1}

Поле | Описание
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow1)**<br>Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow1}

Поле | Описание
--- | ---
days[] | **google.type.DayOfWeek**<br>Дни недели, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### IPAllocationPolicy {#IPAllocationPolicy1}

Поле | Описание
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для подов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. Статические маршруты будут настроены для этих блоков CIDR в подсетях узлов. 
service_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для сервисов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. 


### NetworkPolicy {#NetworkPolicy1}

Поле | Описание
--- | ---
provider | enum **Provider**<br> <ul><ul/>


## Create {#Create}

Создает кластер Kubernetes в указанном каталоге.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором нужно создать кластер Kubernetes. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
name | **string**<br>Имя кластера Kubernetes. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание кластера Kubernetes. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
network_id | **string**<br>Обязательное поле. Идентификатор облачной сети. 
master_spec | **[MasterSpec](#MasterSpec)**<br>Обязательное поле. Политика распределения кластера Kubernetes. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy2)**<br>Политика распределения кластера Kubernetes. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Адрес шлюза IPv4. 
service_account_id | **string**<br>Обязательное поле. Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. Выбранный сервисный аккаунт должна иметь `edit` роль в каталоге, в котором будет расположен кластер Kubernetes, и в каталоге, в котором находится выбранная сеть. 
node_service_account_id | **string**<br>Обязательное поле. Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла. 
release_channel | enum **ReleaseChannel**<br>Релизный канал для мастера. <ul><li>`RAPID`: На канале часто появляются минорные обновления, содержащие новую функциональность и улучшения. Вы не можете отключить автоматическое обновление на этом канале, но вы можете указать период времени для автоматического обновления.</li><li>`REGULAR`: Новая функциональность и улучшения порциями попадают на канал через некоторое время после того, как были предоставлены на канале `RAPID`.</li><li>`STABLE`: На канале происходят только обновления, касающиеся исправление ошибок или улучшения безопасности.</li><ul/>
network_policy | **[NetworkPolicy](#NetworkPolicy2)**<br> 


### MasterSpec {#MasterSpec}

Поле | Описание
--- | ---
master_type | **oneof:** `zonal_master_spec` или `regional_master_spec`<br>
&nbsp;&nbsp;zonal_master_spec | **[ZonalMasterSpec](#ZonalMasterSpec)**<br>Спецификация зонального мастера. 
&nbsp;&nbsp;regional_master_spec | **[RegionalMasterSpec](#RegionalMasterSpec)**<br>Спецификация регионального мастера. 
version | **string**<br>Версия компонентов Kubernetes, которая запущена на мастере. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy2)**<br>Политика обновления мастера. 


### ZonalMasterSpec {#ZonalMasterSpec}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности. 
internal_v4_address_spec | **[InternalAddressSpec](#InternalAddressSpec)**<br>Спецификация параметров для внутренней IPv4 сети. 
external_v4_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec)**<br>Спецификация параметров для внешней IPv4 сети. 


### InternalAddressSpec {#InternalAddressSpec}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор подсети. Если идентификатор не указан, а в указанной зоне имеется только одна подсеть, адрес будет выделен в этой подсети. 


### ExternalAddressSpec {#ExternalAddressSpec}



### RegionalMasterSpec {#RegionalMasterSpec}

Поле | Описание
--- | ---
region_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, в которой находится мастер. 
locations[] | **[MasterLocation](#MasterLocation)**<br>Список местоположений (зон доступности и подсетей), в которых будут выделены ресурсы для мастера. 
external_v4_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec)**<br>Указывается для выделения статического публичного IP-адреса для мастера. 


### MasterLocation {#MasterLocation}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности. 
internal_v4_address_spec | **[InternalAddressSpec](#InternalAddressSpec)**<br>Если параметр не указан и в указанной зоне доступности только одна подсеть, то адрес будет выделен в этой подсети. 


### InternalAddressSpec {#InternalAddressSpec1}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор подсети. Если идентификатор не указан, а в указанной зоне имеется только одна подсеть, адрес будет выделен в этой подсети. 


### ExternalAddressSpec {#ExternalAddressSpec1}



### MasterMaintenancePolicy {#MasterMaintenancePolicy2}

Поле | Описание
--- | ---
auto_upgrade | **bool**<br>Если установлено значение `true`, автоматическое обновление устанавливается без участия пользователя в заданный промежуток времени. Если установлено значение `false`, автоматическое обновление отключено. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC. 


### MaintenanceWindow {#MaintenanceWindow2}

Поле | Описание
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` или `weekly_maintenance_window`<br>Политика обновления.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow2)**<br>Обновление мастера в любое время. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow2)**<br>Обновление мастера в любой день в течение указанного временного окна. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow2)**<br>Обновление мастера в выбранные дни в течение указанного временного окна. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow2}



### DailyMaintenanceWindow {#DailyMaintenanceWindow2}

Поле | Описание
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow2}

Поле | Описание
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow2)**<br>Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow2}

Поле | Описание
--- | ---
days[] | **google.type.DayOfWeek**<br>Дни недели, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### IPAllocationPolicy {#IPAllocationPolicy2}

Поле | Описание
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для подов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. Статические маршруты будут настроены для этих блоков CIDR в подсетях узлов. 
service_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для сервисов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. 


### NetworkPolicy {#NetworkPolicy2}

Поле | Описание
--- | ---
provider | enum **Provider**<br> <ul><ul/>


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateClusterMetadata](#CreateClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster2)>**<br>в случае успешного выполнения операции. 


### CreateClusterMetadata {#CreateClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор создаваемого кластера Kubernetes. 


### Cluster {#Cluster2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Kubernetes. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Kubernetes. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Kubernetes. 
description | **string**<br>Описание кластера Kubernetes. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус кластера Kubernetes. <ul><li>`PROVISIONING`: Кластер Kubernetes ожидает выделения ресурсов.</li><li>`RUNNING`: Кластер Kubernetes запущен.</li><li>`RECONCILING`: Кластер Kubernetes согласовывается.</li><li>`STOPPING`: Кластер Kubernetes останавливается.</li><li>`STOPPED`: Кластер Kubernetes остановлен.</li><li>`DELETING`: Кластер Kubernetes удаляется.</li><li>`STARTING`: Кластер Kubernetes запускается.</li><ul/>
health | enum **Health**<br>Состояние кластера Kubernetes. <ul><li>`HEALTHY`: Кластер Kubernetes работает нормально.</li><li>`UNHEALTHY`: Кластер Kubernetes не работает и не может выполнять свои основные функции.</li><ul/>
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит кластер Kubernetes. 
master | **[Master](#Master2)**<br>Свойства мастера для кластера Kubernetes. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy3)**<br>Политика распределения IP-адресов для служб и модулей внутри кластера Kubernetes в разных зонах доступности. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Адрес шлюза IPv4. Максимальная длина строки в символах — 15.
service_account_id | **string**<br>Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. 
node_service_account_id | **string**<br>Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла. 
release_channel | enum **ReleaseChannel**<br>При создании кластера Kubernetes вы должны указать один из трех релизных каналов. Релизный канал содержит несколько версий Kubernetes. Каналы отличаются набором доступных версий, управлением автоматическими обновлениями и получаемыми обновлениями. Изменить канал после создания кластера Kubernetes нельзя, возможно только пересоздать кластер Kubernetes и указать новый релизный канал. Дополнительные сведения см. в [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates). <ul><li>`RAPID`: На канале часто появляются минорные обновления, содержащие новую функциональность и улучшения. Вы не можете отключить автоматическое обновление на этом канале, но вы можете указать период времени для автоматического обновления.</li><li>`REGULAR`: Новая функциональность и улучшения порциями попадают на канал через некоторое время после того, как были предоставлены на канале `RAPID`.</li><li>`STABLE`: На канале происходят только обновления, касающиеся исправление ошибок или улучшения безопасности.</li><ul/>
network_policy | **[NetworkPolicy](#NetworkPolicy3)**<br> 


### Master {#Master2}

Поле | Описание
--- | ---
master_type | **oneof:** `zonal_master` или `regional_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster2)**<br>Параметры зоны доступности мастера. 
&nbsp;&nbsp;regional_master | **[RegionalMaster](#RegionalMaster2)**<br>Параметры региона для мастера. 
version | **string**<br>Версия компонентов Kubernetes, которая запущена на мастере. 
endpoints | **[MasterEndpoints](#MasterEndpoints2)**<br>Эндпойнт мастера. Эндпойнты состоят из схемы и порта (т. е. `https://ip-address:port`) и могут использоваться клиентами для связи с API Kubernetes кластера Kubernetes. 
master_auth | **[MasterAuth](#MasterAuth2)**<br>Параметры, используемые для аутентификации мастера. 
version_info | **[VersionInfo](#VersionInfo2)**<br>Подробная информация о версии Kubernetes, которая запущена на мастере. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy3)**<br>Политика обновления мастера. 


### ZonalMaster {#ZonalMaster2}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится мастер. 
internal_v4_address | **string**<br>Внутренний IPv4-адрес, назначенный мастеру. 
external_v4_address | **string**<br>Внешний IPv4-адрес, назначенный мастеру. 


### RegionalMaster {#RegionalMaster2}

Поле | Описание
--- | ---
region_id | **string**<br>Идентификатор региона, в котором находится мастер. 
internal_v4_address | **string**<br>Внутренний IPv4-адрес, назначенный мастеру. 
external_v4_address | **string**<br>Внешний IPv4-адрес, назначенный мастеру. 


### MasterEndpoints {#MasterEndpoints2}

Поле | Описание
--- | ---
internal_v4_endpoint | **string**<br>Внутренний эндпойнт, который может использоваться для подключения к мастеру из облачных сетей. 
external_v4_endpoint | **string**<br>Внешний эндпойнт, который может использоваться для доступа к API кластера Kubernetes из интернета (вне Облака). 


### MasterAuth {#MasterAuth2}

Поле | Описание
--- | ---
cluster_ca_certificate | **string**<br>Публичный PEM-закодированный сертификат, подтверждающий подлинность кластера Kubernetes. 


### VersionInfo {#VersionInfo2}

Поле | Описание
--- | ---
current_version | **string**<br>Текущая версия Kubernetes, формат: major.minor (например, 1.15). 
new_revision_available | **bool**<br>Новые версии могут включать патчи Kubernetes (например, 1.15.1 -> 1.15.2), а также некоторые обновления внутренних компонентов — новые функции или исправления ошибок в конкретных компонентах Яндекса на мастере или на узлах. 
new_revision_summary | **string**<br>Описание изменений, которые будут применены при обновлении до последней версии. Пусто, если поле `new_revision_available` имеет значение `false`. 
version_deprecated | **bool**<br>Текущая версия устарела, компонент кластера Kubernetes (мастер или группа узлов) должен быть обновлен. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy3}

Поле | Описание
--- | ---
auto_upgrade | **bool**<br>Если установлено значение `true`, автоматическое обновление устанавливается без участия пользователя в заданный промежуток времени. Если установлено значение `false`, автоматическое обновление отключено. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC. 


### MaintenanceWindow {#MaintenanceWindow3}

Поле | Описание
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` или `weekly_maintenance_window`<br>Политика обновления.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow3)**<br>Обновление мастера в любое время. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow3)**<br>Обновление мастера в любой день в течение указанного временного окна. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow3)**<br>Обновление мастера в выбранные дни в течение указанного временного окна. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow3}



### DailyMaintenanceWindow {#DailyMaintenanceWindow3}

Поле | Описание
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow3}

Поле | Описание
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow3)**<br>Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow3}

Поле | Описание
--- | ---
days[] | **google.type.DayOfWeek**<br>Дни недели, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### IPAllocationPolicy {#IPAllocationPolicy3}

Поле | Описание
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для подов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. Статические маршруты будут настроены для этих блоков CIDR в подсетях узлов. 
service_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для сервисов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. 


### NetworkPolicy {#NetworkPolicy3}

Поле | Описание
--- | ---
provider | enum **Provider**<br> <ul><ul/>


## Update {#Update}

Обновляет указанный кластер Kubernetes.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор обновляемого кластера Kubernetes. Чтобы получить идентификатор кластера Kubernetes, используйте [ClusterService.List](#List) запрос. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
name | **string**<br>Имя кластера Kubernetes. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание кластера Kubernetes. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. <br>Существующий набор `labels` полностью перезаписывается набором, переданным в запросе. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Адрес шлюза IPv4. Максимальная длина строки в символах — 15.
master_spec | **[MasterUpdateSpec](#MasterUpdateSpec)**<br>Спецификация обновления мастера. 
service_account_id | **string**<br>Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. Выбранный сервисный аккаунт должна иметь `edit` роль в каталоге, в котором будет расположен кластер Kubernetes, и в каталоге, в котором находится выбранная сеть. 
node_service_account_id | **string**<br>Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла. 
network_policy | **[NetworkPolicy](#NetworkPolicy4)**<br> 


### MasterUpdateSpec {#MasterUpdateSpec}

Поле | Описание
--- | ---
version | **[UpdateVersionSpec](#UpdateVersionSpec)**<br>Спецификация обновления мастера. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy4)**<br>Политика обновления мастера. 


### UpdateVersionSpec {#UpdateVersionSpec}

Поле | Описание
--- | ---
specifier | **oneof:** `version` или `latest_revision`<br>
&nbsp;&nbsp;version | **string**<br>Запрос обновления до более новой версии Kubernetes (1.x - > 1.y). 
&nbsp;&nbsp;latest_revision | **bool**<br>Запрос минорного обновления, содержащего новую функциональность и улучшения, для текущей версии Kubernetes. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy4}

Поле | Описание
--- | ---
auto_upgrade | **bool**<br>Если установлено значение `true`, автоматическое обновление устанавливается без участия пользователя в заданный промежуток времени. Если установлено значение `false`, автоматическое обновление отключено. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC. 


### MaintenanceWindow {#MaintenanceWindow4}

Поле | Описание
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` или `weekly_maintenance_window`<br>Политика обновления.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow4)**<br>Обновление мастера в любое время. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow4)**<br>Обновление мастера в любой день в течение указанного временного окна. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow4)**<br>Обновление мастера в выбранные дни в течение указанного временного окна. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow4}



### DailyMaintenanceWindow {#DailyMaintenanceWindow4}

Поле | Описание
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow4}

Поле | Описание
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow4)**<br>Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow4}

Поле | Описание
--- | ---
days[] | **google.type.DayOfWeek**<br>Дни недели, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### NetworkPolicy {#NetworkPolicy4}

Поле | Описание
--- | ---
provider | enum **Provider**<br> <ul><ul/>


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateClusterMetadata](#UpdateClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster3)>**<br>в случае успешного выполнения операции. 


### UpdateClusterMetadata {#UpdateClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера Kubernetes, который обновляется. 


### Cluster {#Cluster3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Kubernetes. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Kubernetes. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Kubernetes. 
description | **string**<br>Описание кластера Kubernetes. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус кластера Kubernetes. <ul><li>`PROVISIONING`: Кластер Kubernetes ожидает выделения ресурсов.</li><li>`RUNNING`: Кластер Kubernetes запущен.</li><li>`RECONCILING`: Кластер Kubernetes согласовывается.</li><li>`STOPPING`: Кластер Kubernetes останавливается.</li><li>`STOPPED`: Кластер Kubernetes остановлен.</li><li>`DELETING`: Кластер Kubernetes удаляется.</li><li>`STARTING`: Кластер Kubernetes запускается.</li><ul/>
health | enum **Health**<br>Состояние кластера Kubernetes. <ul><li>`HEALTHY`: Кластер Kubernetes работает нормально.</li><li>`UNHEALTHY`: Кластер Kubernetes не работает и не может выполнять свои основные функции.</li><ul/>
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит кластер Kubernetes. 
master | **[Master](#Master3)**<br>Свойства мастера для кластера Kubernetes. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy4)**<br>Политика распределения IP-адресов для служб и модулей внутри кластера Kubernetes в разных зонах доступности. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Адрес шлюза IPv4. Максимальная длина строки в символах — 15.
service_account_id | **string**<br>Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. 
node_service_account_id | **string**<br>Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла. 
release_channel | enum **ReleaseChannel**<br>При создании кластера Kubernetes вы должны указать один из трех релизных каналов. Релизный канал содержит несколько версий Kubernetes. Каналы отличаются набором доступных версий, управлением автоматическими обновлениями и получаемыми обновлениями. Изменить канал после создания кластера Kubernetes нельзя, возможно только пересоздать кластер Kubernetes и указать новый релизный канал. Дополнительные сведения см. в [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates). <ul><li>`RAPID`: На канале часто появляются минорные обновления, содержащие новую функциональность и улучшения. Вы не можете отключить автоматическое обновление на этом канале, но вы можете указать период времени для автоматического обновления.</li><li>`REGULAR`: Новая функциональность и улучшения порциями попадают на канал через некоторое время после того, как были предоставлены на канале `RAPID`.</li><li>`STABLE`: На канале происходят только обновления, касающиеся исправление ошибок или улучшения безопасности.</li><ul/>
network_policy | **[NetworkPolicy](#NetworkPolicy5)**<br> 


### Master {#Master3}

Поле | Описание
--- | ---
master_type | **oneof:** `zonal_master` или `regional_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster3)**<br>Параметры зоны доступности мастера. 
&nbsp;&nbsp;regional_master | **[RegionalMaster](#RegionalMaster3)**<br>Параметры региона для мастера. 
version | **string**<br>Версия компонентов Kubernetes, которая запущена на мастере. 
endpoints | **[MasterEndpoints](#MasterEndpoints3)**<br>Эндпойнт мастера. Эндпойнты состоят из схемы и порта (т. е. `https://ip-address:port`) и могут использоваться клиентами для связи с API Kubernetes кластера Kubernetes. 
master_auth | **[MasterAuth](#MasterAuth3)**<br>Параметры, используемые для аутентификации мастера. 
version_info | **[VersionInfo](#VersionInfo3)**<br>Подробная информация о версии Kubernetes, которая запущена на мастере. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy5)**<br>Политика обновления мастера. 


### ZonalMaster {#ZonalMaster3}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится мастер. 
internal_v4_address | **string**<br>Внутренний IPv4-адрес, назначенный мастеру. 
external_v4_address | **string**<br>Внешний IPv4-адрес, назначенный мастеру. 


### RegionalMaster {#RegionalMaster3}

Поле | Описание
--- | ---
region_id | **string**<br>Идентификатор региона, в котором находится мастер. 
internal_v4_address | **string**<br>Внутренний IPv4-адрес, назначенный мастеру. 
external_v4_address | **string**<br>Внешний IPv4-адрес, назначенный мастеру. 


### MasterEndpoints {#MasterEndpoints3}

Поле | Описание
--- | ---
internal_v4_endpoint | **string**<br>Внутренний эндпойнт, который может использоваться для подключения к мастеру из облачных сетей. 
external_v4_endpoint | **string**<br>Внешний эндпойнт, который может использоваться для доступа к API кластера Kubernetes из интернета (вне Облака). 


### MasterAuth {#MasterAuth3}

Поле | Описание
--- | ---
cluster_ca_certificate | **string**<br>Публичный PEM-закодированный сертификат, подтверждающий подлинность кластера Kubernetes. 


### VersionInfo {#VersionInfo3}

Поле | Описание
--- | ---
current_version | **string**<br>Текущая версия Kubernetes, формат: major.minor (например, 1.15). 
new_revision_available | **bool**<br>Новые версии могут включать патчи Kubernetes (например, 1.15.1 -> 1.15.2), а также некоторые обновления внутренних компонентов — новые функции или исправления ошибок в конкретных компонентах Яндекса на мастере или на узлах. 
new_revision_summary | **string**<br>Описание изменений, которые будут применены при обновлении до последней версии. Пусто, если поле `new_revision_available` имеет значение `false`. 
version_deprecated | **bool**<br>Текущая версия устарела, компонент кластера Kubernetes (мастер или группа узлов) должен быть обновлен. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy5}

Поле | Описание
--- | ---
auto_upgrade | **bool**<br>Если установлено значение `true`, автоматическое обновление устанавливается без участия пользователя в заданный промежуток времени. Если установлено значение `false`, автоматическое обновление отключено. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow5)**<br>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC. 


### MaintenanceWindow {#MaintenanceWindow5}

Поле | Описание
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` или `weekly_maintenance_window`<br>Политика обновления.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow5)**<br>Обновление мастера в любое время. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow5)**<br>Обновление мастера в любой день в течение указанного временного окна. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow5)**<br>Обновление мастера в выбранные дни в течение указанного временного окна. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow5}



### DailyMaintenanceWindow {#DailyMaintenanceWindow5}

Поле | Описание
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow5}

Поле | Описание
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow5)**<br>Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow5}

Поле | Описание
--- | ---
days[] | **google.type.DayOfWeek**<br>Дни недели, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### IPAllocationPolicy {#IPAllocationPolicy4}

Поле | Описание
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для подов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. Статические маршруты будут настроены для этих блоков CIDR в подсетях узлов. 
service_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для сервисов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. 


### NetworkPolicy {#NetworkPolicy5}

Поле | Описание
--- | ---
provider | enum **Provider**<br> <ul><ul/>


## Delete {#Delete}

Удаляет указанный кластер Kubernetes.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор удаляемого кластера Kubernetes. Чтобы получить идентификатор кластера Kubernetes, используйте запрос [ClusterService.List](#List). 


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteClusterMetadata](#DeleteClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteClusterMetadata {#DeleteClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера Kubernetes, который удаляется. 


## Stop {#Stop}

Останавливает указанный кластер Kubernetes.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StopClusterRequest {#StopClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Kubernetes, который следует остановить. Чтобы получить идентификатор кластера Kubernetes, используйте запрос [ClusterService.List](#List). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта с ролью на остановку кластера Kubernetes. 


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopClusterMetadata](#StopClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster4)>**<br>в случае успешного выполнения операции. 


### StopClusterMetadata {#StopClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера Kubernetes, который останавливается. 


### Cluster {#Cluster4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Kubernetes. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Kubernetes. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Kubernetes. 
description | **string**<br>Описание кластера Kubernetes. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус кластера Kubernetes. <ul><li>`PROVISIONING`: Кластер Kubernetes ожидает выделения ресурсов.</li><li>`RUNNING`: Кластер Kubernetes запущен.</li><li>`RECONCILING`: Кластер Kubernetes согласовывается.</li><li>`STOPPING`: Кластер Kubernetes останавливается.</li><li>`STOPPED`: Кластер Kubernetes остановлен.</li><li>`DELETING`: Кластер Kubernetes удаляется.</li><li>`STARTING`: Кластер Kubernetes запускается.</li><ul/>
health | enum **Health**<br>Состояние кластера Kubernetes. <ul><li>`HEALTHY`: Кластер Kubernetes работает нормально.</li><li>`UNHEALTHY`: Кластер Kubernetes не работает и не может выполнять свои основные функции.</li><ul/>
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит кластер Kubernetes. 
master | **[Master](#Master4)**<br>Свойства мастера для кластера Kubernetes. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy5)**<br>Политика распределения IP-адресов для служб и модулей внутри кластера Kubernetes в разных зонах доступности. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Адрес шлюза IPv4. Максимальная длина строки в символах — 15.
service_account_id | **string**<br>Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. 
node_service_account_id | **string**<br>Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла. 
release_channel | enum **ReleaseChannel**<br>При создании кластера Kubernetes вы должны указать один из трех релизных каналов. Релизный канал содержит несколько версий Kubernetes. Каналы отличаются набором доступных версий, управлением автоматическими обновлениями и получаемыми обновлениями. Изменить канал после создания кластера Kubernetes нельзя, возможно только пересоздать кластер Kubernetes и указать новый релизный канал. Дополнительные сведения см. в [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates). <ul><li>`RAPID`: На канале часто появляются минорные обновления, содержащие новую функциональность и улучшения. Вы не можете отключить автоматическое обновление на этом канале, но вы можете указать период времени для автоматического обновления.</li><li>`REGULAR`: Новая функциональность и улучшения порциями попадают на канал через некоторое время после того, как были предоставлены на канале `RAPID`.</li><li>`STABLE`: На канале происходят только обновления, касающиеся исправление ошибок или улучшения безопасности.</li><ul/>
network_policy | **[NetworkPolicy](#NetworkPolicy6)**<br> 


### Master {#Master4}

Поле | Описание
--- | ---
master_type | **oneof:** `zonal_master` или `regional_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster4)**<br>Параметры зоны доступности мастера. 
&nbsp;&nbsp;regional_master | **[RegionalMaster](#RegionalMaster4)**<br>Параметры региона для мастера. 
version | **string**<br>Версия компонентов Kubernetes, которая запущена на мастере. 
endpoints | **[MasterEndpoints](#MasterEndpoints4)**<br>Эндпойнт мастера. Эндпойнты состоят из схемы и порта (т. е. `https://ip-address:port`) и могут использоваться клиентами для связи с API Kubernetes кластера Kubernetes. 
master_auth | **[MasterAuth](#MasterAuth4)**<br>Параметры, используемые для аутентификации мастера. 
version_info | **[VersionInfo](#VersionInfo4)**<br>Подробная информация о версии Kubernetes, которая запущена на мастере. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy6)**<br>Политика обновления мастера. 


### ZonalMaster {#ZonalMaster4}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится мастер. 
internal_v4_address | **string**<br>Внутренний IPv4-адрес, назначенный мастеру. 
external_v4_address | **string**<br>Внешний IPv4-адрес, назначенный мастеру. 


### RegionalMaster {#RegionalMaster4}

Поле | Описание
--- | ---
region_id | **string**<br>Идентификатор региона, в котором находится мастер. 
internal_v4_address | **string**<br>Внутренний IPv4-адрес, назначенный мастеру. 
external_v4_address | **string**<br>Внешний IPv4-адрес, назначенный мастеру. 


### MasterEndpoints {#MasterEndpoints4}

Поле | Описание
--- | ---
internal_v4_endpoint | **string**<br>Внутренний эндпойнт, который может использоваться для подключения к мастеру из облачных сетей. 
external_v4_endpoint | **string**<br>Внешний эндпойнт, который может использоваться для доступа к API кластера Kubernetes из интернета (вне Облака). 


### MasterAuth {#MasterAuth4}

Поле | Описание
--- | ---
cluster_ca_certificate | **string**<br>Публичный PEM-закодированный сертификат, подтверждающий подлинность кластера Kubernetes. 


### VersionInfo {#VersionInfo4}

Поле | Описание
--- | ---
current_version | **string**<br>Текущая версия Kubernetes, формат: major.minor (например, 1.15). 
new_revision_available | **bool**<br>Новые версии могут включать патчи Kubernetes (например, 1.15.1 -> 1.15.2), а также некоторые обновления внутренних компонентов — новые функции или исправления ошибок в конкретных компонентах Яндекса на мастере или на узлах. 
new_revision_summary | **string**<br>Описание изменений, которые будут применены при обновлении до последней версии. Пусто, если поле `new_revision_available` имеет значение `false`. 
version_deprecated | **bool**<br>Текущая версия устарела, компонент кластера Kubernetes (мастер или группа узлов) должен быть обновлен. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy6}

Поле | Описание
--- | ---
auto_upgrade | **bool**<br>Если установлено значение `true`, автоматическое обновление устанавливается без участия пользователя в заданный промежуток времени. Если установлено значение `false`, автоматическое обновление отключено. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC. 


### MaintenanceWindow {#MaintenanceWindow6}

Поле | Описание
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` или `weekly_maintenance_window`<br>Политика обновления.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow6)**<br>Обновление мастера в любое время. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow6)**<br>Обновление мастера в любой день в течение указанного временного окна. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow6)**<br>Обновление мастера в выбранные дни в течение указанного временного окна. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow6}



### DailyMaintenanceWindow {#DailyMaintenanceWindow6}

Поле | Описание
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow6}

Поле | Описание
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow6)**<br>Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow6}

Поле | Описание
--- | ---
days[] | **google.type.DayOfWeek**<br>Дни недели, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### IPAllocationPolicy {#IPAllocationPolicy5}

Поле | Описание
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для подов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. Статические маршруты будут настроены для этих блоков CIDR в подсетях узлов. 
service_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для сервисов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. 


### NetworkPolicy {#NetworkPolicy6}

Поле | Описание
--- | ---
provider | enum **Provider**<br> <ul><ul/>


## Start {#Start}

Запускает указанный кластер Kubernetes.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StartClusterRequest {#StartClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Kubernetes, который следует запустить. Чтобы получить идентификатор кластера Kubernetes, используйте запрос [ClusterService.List](#List). 


### Operation {#Operation4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartClusterMetadata](#StartClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster5)>**<br>в случае успешного выполнения операции. 


### StartClusterMetadata {#StartClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера Kubernetes, который запускается. 


### Cluster {#Cluster5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Kubernetes. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Kubernetes. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Kubernetes. 
description | **string**<br>Описание кластера Kubernetes. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус кластера Kubernetes. <ul><li>`PROVISIONING`: Кластер Kubernetes ожидает выделения ресурсов.</li><li>`RUNNING`: Кластер Kubernetes запущен.</li><li>`RECONCILING`: Кластер Kubernetes согласовывается.</li><li>`STOPPING`: Кластер Kubernetes останавливается.</li><li>`STOPPED`: Кластер Kubernetes остановлен.</li><li>`DELETING`: Кластер Kubernetes удаляется.</li><li>`STARTING`: Кластер Kubernetes запускается.</li><ul/>
health | enum **Health**<br>Состояние кластера Kubernetes. <ul><li>`HEALTHY`: Кластер Kubernetes работает нормально.</li><li>`UNHEALTHY`: Кластер Kubernetes не работает и не может выполнять свои основные функции.</li><ul/>
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит кластер Kubernetes. 
master | **[Master](#Master5)**<br>Свойства мастера для кластера Kubernetes. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy6)**<br>Политика распределения IP-адресов для служб и модулей внутри кластера Kubernetes в разных зонах доступности. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Адрес шлюза IPv4. Максимальная длина строки в символах — 15.
service_account_id | **string**<br>Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. 
node_service_account_id | **string**<br>Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла. 
release_channel | enum **ReleaseChannel**<br>При создании кластера Kubernetes вы должны указать один из трех релизных каналов. Релизный канал содержит несколько версий Kubernetes. Каналы отличаются набором доступных версий, управлением автоматическими обновлениями и получаемыми обновлениями. Изменить канал после создания кластера Kubernetes нельзя, возможно только пересоздать кластер Kubernetes и указать новый релизный канал. Дополнительные сведения см. в [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates). <ul><li>`RAPID`: На канале часто появляются минорные обновления, содержащие новую функциональность и улучшения. Вы не можете отключить автоматическое обновление на этом канале, но вы можете указать период времени для автоматического обновления.</li><li>`REGULAR`: Новая функциональность и улучшения порциями попадают на канал через некоторое время после того, как были предоставлены на канале `RAPID`.</li><li>`STABLE`: На канале происходят только обновления, касающиеся исправление ошибок или улучшения безопасности.</li><ul/>
network_policy | **[NetworkPolicy](#NetworkPolicy7)**<br> 


### Master {#Master5}

Поле | Описание
--- | ---
master_type | **oneof:** `zonal_master` или `regional_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster5)**<br>Параметры зоны доступности мастера. 
&nbsp;&nbsp;regional_master | **[RegionalMaster](#RegionalMaster5)**<br>Параметры региона для мастера. 
version | **string**<br>Версия компонентов Kubernetes, которая запущена на мастере. 
endpoints | **[MasterEndpoints](#MasterEndpoints5)**<br>Эндпойнт мастера. Эндпойнты состоят из схемы и порта (т. е. `https://ip-address:port`) и могут использоваться клиентами для связи с API Kubernetes кластера Kubernetes. 
master_auth | **[MasterAuth](#MasterAuth5)**<br>Параметры, используемые для аутентификации мастера. 
version_info | **[VersionInfo](#VersionInfo5)**<br>Подробная информация о версии Kubernetes, которая запущена на мастере. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy7)**<br>Политика обновления мастера. 


### ZonalMaster {#ZonalMaster5}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится мастер. 
internal_v4_address | **string**<br>Внутренний IPv4-адрес, назначенный мастеру. 
external_v4_address | **string**<br>Внешний IPv4-адрес, назначенный мастеру. 


### RegionalMaster {#RegionalMaster5}

Поле | Описание
--- | ---
region_id | **string**<br>Идентификатор региона, в котором находится мастер. 
internal_v4_address | **string**<br>Внутренний IPv4-адрес, назначенный мастеру. 
external_v4_address | **string**<br>Внешний IPv4-адрес, назначенный мастеру. 


### MasterEndpoints {#MasterEndpoints5}

Поле | Описание
--- | ---
internal_v4_endpoint | **string**<br>Внутренний эндпойнт, который может использоваться для подключения к мастеру из облачных сетей. 
external_v4_endpoint | **string**<br>Внешний эндпойнт, который может использоваться для доступа к API кластера Kubernetes из интернета (вне Облака). 


### MasterAuth {#MasterAuth5}

Поле | Описание
--- | ---
cluster_ca_certificate | **string**<br>Публичный PEM-закодированный сертификат, подтверждающий подлинность кластера Kubernetes. 


### VersionInfo {#VersionInfo5}

Поле | Описание
--- | ---
current_version | **string**<br>Текущая версия Kubernetes, формат: major.minor (например, 1.15). 
new_revision_available | **bool**<br>Новые версии могут включать патчи Kubernetes (например, 1.15.1 -> 1.15.2), а также некоторые обновления внутренних компонентов — новые функции или исправления ошибок в конкретных компонентах Яндекса на мастере или на узлах. 
new_revision_summary | **string**<br>Описание изменений, которые будут применены при обновлении до последней версии. Пусто, если поле `new_revision_available` имеет значение `false`. 
version_deprecated | **bool**<br>Текущая версия устарела, компонент кластера Kubernetes (мастер или группа узлов) должен быть обновлен. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy7}

Поле | Описание
--- | ---
auto_upgrade | **bool**<br>Если установлено значение `true`, автоматическое обновление устанавливается без участия пользователя в заданный промежуток времени. Если установлено значение `false`, автоматическое обновление отключено. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow7)**<br>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC. 


### MaintenanceWindow {#MaintenanceWindow7}

Поле | Описание
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` или `weekly_maintenance_window`<br>Политика обновления.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow7)**<br>Обновление мастера в любое время. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow7)**<br>Обновление мастера в любой день в течение указанного временного окна. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow7)**<br>Обновление мастера в выбранные дни в течение указанного временного окна. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow7}



### DailyMaintenanceWindow {#DailyMaintenanceWindow7}

Поле | Описание
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow7}

Поле | Описание
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow7)**<br>Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow7}

Поле | Описание
--- | ---
days[] | **google.type.DayOfWeek**<br>Дни недели, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### IPAllocationPolicy {#IPAllocationPolicy6}

Поле | Описание
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для подов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. Статические маршруты будут настроены для этих блоков CIDR в подсетях узлов. 
service_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для сервисов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. 


### NetworkPolicy {#NetworkPolicy7}

Поле | Описание
--- | ---
provider | enum **Provider**<br> <ul><ul/>


## ListNodeGroups {#ListNodeGroups}

Список групп узлов для указанного кластера Kubernetes.

**rpc ListNodeGroups ([ListClusterNodeGroupsRequest](#ListClusterNodeGroupsRequest)) returns ([ListClusterNodeGroupsResponse](#ListClusterNodeGroupsResponse))**

### ListClusterNodeGroupsRequest {#ListClusterNodeGroupsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Kubernetes, для которого запрашивается список групп узлов. Чтобы получить идентификатор кластера Kubernetes, используйте[ClusterService.List](#List) запрос. 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterNodeGroupsResponse.next_page_token](#ListClusterNodeGroupsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterNodeGroupsResponse.next_page_token](#ListClusterNodeGroupsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [Cluster.name](#Cluster6). Максимальная длина строки в символах — 1000.


### ListClusterNodeGroupsResponse {#ListClusterNodeGroupsResponse}

Поле | Описание
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup)**<br>Список групп узлов для указанного кластера Kubernetes. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterNodeGroupsRequest.page_size](#ListClusterNodeGroupsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterNodeGroupsRequest.page_token](#ListClusterNodeGroupsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


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
node_template | **[NodeTemplate](#NodeTemplate)**<br>Шаблон узла, задающий параметры вычислительных экземпляров для группы узлов. 
scale_policy | **[ScalePolicy](#ScalePolicy)**<br>Политика масштабирования группы узлов. Дополнительные сведения см. в разделе [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy)**<br>Политика распределения, с помощью которой ресурсы для групп узлов распределяются по зонам и регионам. 
instance_group_id | **string**<br>Идентификатор группы виртуальных машин, связанной с этой группой узлов. 
node_version | **string**<br>Версия компонентов Kubernetes, которая запущена на узлах. Устарел. Используйте version_info.current_version. 
version_info | **[VersionInfo](#VersionInfo6)**<br>Подробная информация о версии Kubernetes, которая запущена на мастере. 
maintenance_policy | **[NodeGroupMaintenancePolicy](#NodeGroupMaintenancePolicy)**<br>Политика обновления группы узлов. 
allowed_unsafe_sysctls[] | **string**<br>Поддержка параметров unsafe sysctl. Дополнительные сведения см. в [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). 


### NodeTemplate {#NodeTemplate}

Поле | Описание
--- | ---
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources_spec | **[ResourcesSpec](#ResourcesSpec)**<br>Вычислительные ресурсы узла, такие как объем памяти и количество ядер. 
boot_disk_spec | **[DiskSpec](#DiskSpec)**<br>Спецификация загрузочного диска, который будет подключен к узлу. 
metadata | **map<string,string>**<br>Метаданные, назначаемые этому шаблону виртуальной машины, в формате ``key:value``. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, вы можете использовать метаданные для предоставления вашего открытого SSH-ключа узлу. Дополнительные сведения см. в разделе [Metadata](/docs/compute/concepts/vm-metadata). Не более 128 на ресурс. Максимальная длина строки в символах для каждого значения — 262144. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec)**<br>Спецификация для создания сетевых интерфейсов для вычислительных экземпляров группы узлов. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy)**<br>Политика планирования. 


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
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec)**<br>Конфигурация one-to-one NAT. Настройка one-to-one NAT гарантирует, что узлам будут назначены публичные IP-адреса. Поэтому интернет будет доступен на всех узлах группы узлов. Если поле не задано, NAT не будет настроен. 


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
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale)**<br>Политика масштабирования группы узлов. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale)**<br>Политика масштабирования группы узлов. 


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
locations[] | **[NodeGroupLocation](#NodeGroupLocation)**<br>Список местоположений (зон доступности и подсетей), в которых будут выделены ресурсы для группы узлов. 


### NodeGroupLocation {#NodeGroupLocation}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, в которой могут находиться узлы. 
subnet_id | **string**<br>Идентификатор подсети. Если сеть, выбранная для кластера Kubernetes, имеет только одну подсеть в указанной зоне, идентификатор подсети может быть опущен. 


### VersionInfo {#VersionInfo6}

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
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow8)**<br>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC. 


### MaintenanceWindow {#MaintenanceWindow8}

Поле | Описание
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` или `weekly_maintenance_window`<br>Политика обновления.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow8)**<br>Обновление мастера в любое время. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow8)**<br>Обновление мастера в любой день в течение указанного временного окна. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow8)**<br>Обновление мастера в выбранные дни в течение указанного временного окна. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow8}



### DailyMaintenanceWindow {#DailyMaintenanceWindow8}

Поле | Описание
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow8}

Поле | Описание
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow8)**<br>Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow8}

Поле | Описание
--- | ---
days[] | **google.type.DayOfWeek**<br>Дни недели, когда разрешены автоматические обновления. Количество элементов должно находиться в диапазоне от 1 до 7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Длительность окна обновлений. Допустимые значения — от 1h до 24h включительно.


## ListOperations {#ListOperations}

Список операций для указанного кластера Kubernetes.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Kubernetes, для которого запрашивается список операций. 
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [Cluster.name](#Cluster6). Максимальная длина строки в символах — 1000.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>Список операций для указанного кластера Kubernetes. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Operation {#Operation5}

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


