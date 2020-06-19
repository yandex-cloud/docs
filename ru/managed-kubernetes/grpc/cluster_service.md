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
status | enum **Status**<br>Статус кластера Kubernetes. <ul><li>`PROVISIONING`: Кластер Kubernetes ожидает выделения ресурсов.</li><li>`RUNNING`: Кластер Kubernetes запущен.</li><li>`RECONCILING`: Кластер Kubernetes согласовывается.</li><li>`STOPPING`: Кластер Kubernetes останавливается.</li><li>`STOPPED`: Кластер Kubernetes остановлен.</li><li>`DELETING`: Кластер Kubernetes удаляется.</li><ul/>
health | enum **Health**<br>Состояние кластера Kubernetes. <ul><li>`HEALTHY`: Кластер Kubernetes работает нормально.</li><li>`UNHEALTHY`: Кластер Kubernetes не работает и не может выполнять свои основные функции.</li><ul/>
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит кластер Kubernetes. 
master | **[Master](#Master)**<br>Свойства мастера для кластера Kubernetes. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy)**<br>Политика распределения IP-адресов для служб и модулей внутри кластера Kubernetes в разных зонах доступности. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Адрес шлюза IPv4. 
service_account_id | **string**<br>Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. 
node_service_account_id | **string**<br>Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла. 


### Master {#Master}

Поле | Описание
--- | ---
master_type | **oneof:** `zonal_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster)**<br>Параметры зоны доступности мастера. 
version | **string**<br>Версия компонентов Kubernetes, которая запущена на мастере. 
endpoints | **[MasterEndpoints](#MasterEndpoints)**<br>Эндпойнт мастера. Эндпойнты состоят из схемы и порта (т. е. `https://ip-address:port`) и могут использоваться клиентами для связи с API Kubernetes кластера Kubernetes. 
master_auth | **[MasterAuth](#MasterAuth)**<br>Параметры, используемые для аутентификации мастера. 


### ZonalMaster {#ZonalMaster}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится мастер. 
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


### IPAllocationPolicy {#IPAllocationPolicy}

Поле | Описание
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для подов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. Статические маршруты будут настроены для этих блоков CIDR в подсетях узлов. 
service_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для сервисов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. 


## List {#List}

Возвращает список кластеров Kubernetes в указанном каталоге.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка кластеров Kubernetes. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List). 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClustersResponse.next_page_token](#ListClustersResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClustersResponse.next_page_token](#ListClustersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Cluster.name](#Cluster1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 1 до 61 символов, совпадающее с регулярным выражением `|[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> Максимальная длина строки в символах — 1000.


### ListClustersResponse {#ListClustersResponse}

Поле | Описание
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>Список кластеров Kubernetes. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClustersRequest.page_size](#ListClustersRequest1), используйте `next_page_token` в качестве значения параметра [ListClustersRequest.page_token](#ListClustersRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Kubernetes. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Kubernetes. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Kubernetes. 
description | **string**<br>Описание кластера Kubernetes. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус кластера Kubernetes. <ul><li>`PROVISIONING`: Кластер Kubernetes ожидает выделения ресурсов.</li><li>`RUNNING`: Кластер Kubernetes запущен.</li><li>`RECONCILING`: Кластер Kubernetes согласовывается.</li><li>`STOPPING`: Кластер Kubernetes останавливается.</li><li>`STOPPED`: Кластер Kubernetes остановлен.</li><li>`DELETING`: Кластер Kubernetes удаляется.</li><ul/>
health | enum **Health**<br>Состояние кластера Kubernetes. <ul><li>`HEALTHY`: Кластер Kubernetes работает нормально.</li><li>`UNHEALTHY`: Кластер Kubernetes не работает и не может выполнять свои основные функции.</li><ul/>
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит кластер Kubernetes. 
master | **[Master](#Master1)**<br>Свойства мастера для кластера Kubernetes. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy1)**<br>Политика распределения IP-адресов для служб и модулей внутри кластера Kubernetes в разных зонах доступности. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Адрес шлюза IPv4. 
service_account_id | **string**<br>Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. 
node_service_account_id | **string**<br>Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла. 


### Master {#Master}

Поле | Описание
--- | ---
master_type | **oneof:** `zonal_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster1)**<br>Параметры зоны доступности мастера. 
version | **string**<br>Версия компонентов Kubernetes, которая запущена на мастере. 
endpoints | **[MasterEndpoints](#MasterEndpoints1)**<br>Эндпойнт мастера. Эндпойнты состоят из схемы и порта (т. е. `https://ip-address:port`) и могут использоваться клиентами для связи с API Kubernetes кластера Kubernetes. 
master_auth | **[MasterAuth](#MasterAuth1)**<br>Параметры, используемые для аутентификации мастера. 


### ZonalMaster {#ZonalMaster}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится мастер. 
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


### IPAllocationPolicy {#IPAllocationPolicy}

Поле | Описание
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для подов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. Статические маршруты будут настроены для этих блоков CIDR в подсетях узлов. 
service_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для сервисов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. 


## Create {#Create}

Создает кластер Kubernetes в указанном каталоге.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором нужно создать кластер Kubernetes. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List). 
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


### MasterSpec {#MasterSpec}

Поле | Описание
--- | ---
master_type | **oneof:** `zonal_master_spec`<br>
&nbsp;&nbsp;zonal_master_spec | **[ZonalMasterSpec](#ZonalMasterSpec)**<br>Спецификация зоны доступности мастера. 


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



### IPAllocationPolicy {#IPAllocationPolicy}

Поле | Описание
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для подов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. Статические маршруты будут настроены для этих блоков CIDR в подсетях узлов. 
service_ipv4_cidr_block | **string**<br>CIDR. Диапазон IP-адресов для сервисов. <br>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. 


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


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Kubernetes. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Kubernetes. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Kubernetes. 
description | **string**<br>Описание кластера Kubernetes. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус кластера Kubernetes. <ul><li>`PROVISIONING`: Кластер Kubernetes ожидает выделения ресурсов.</li><li>`RUNNING`: Кластер Kubernetes запущен.</li><li>`RECONCILING`: Кластер Kubernetes согласовывается.</li><li>`STOPPING`: Кластер Kubernetes останавливается.</li><li>`STOPPED`: Кластер Kubernetes остановлен.</li><li>`DELETING`: Кластер Kubernetes удаляется.</li><ul/>
health | enum **Health**<br>Состояние кластера Kubernetes. <ul><li>`HEALTHY`: Кластер Kubernetes работает нормально.</li><li>`UNHEALTHY`: Кластер Kubernetes не работает и не может выполнять свои основные функции.</li><ul/>
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит кластер Kubernetes. 
master | **[Master](#Master2)**<br>Свойства мастера для кластера Kubernetes. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy3)**<br>Политика распределения IP-адресов для служб и модулей внутри кластера Kubernetes в разных зонах доступности. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Адрес шлюза IPv4. 
service_account_id | **string**<br>Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. 
node_service_account_id | **string**<br>Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла. 


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


### Operation {#Operation}

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


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Kubernetes. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Kubernetes. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Kubernetes. 
description | **string**<br>Описание кластера Kubernetes. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус кластера Kubernetes. <ul><li>`PROVISIONING`: Кластер Kubernetes ожидает выделения ресурсов.</li><li>`RUNNING`: Кластер Kubernetes запущен.</li><li>`RECONCILING`: Кластер Kubernetes согласовывается.</li><li>`STOPPING`: Кластер Kubernetes останавливается.</li><li>`STOPPED`: Кластер Kubernetes остановлен.</li><li>`DELETING`: Кластер Kubernetes удаляется.</li><ul/>
health | enum **Health**<br>Состояние кластера Kubernetes. <ul><li>`HEALTHY`: Кластер Kubernetes работает нормально.</li><li>`UNHEALTHY`: Кластер Kubernetes не работает и не может выполнять свои основные функции.</li><ul/>
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит кластер Kubernetes. 
master | **[Master](#Master2)**<br>Свойства мастера для кластера Kubernetes. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy3)**<br>Политика распределения IP-адресов для служб и модулей внутри кластера Kubernetes в разных зонах доступности. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Адрес шлюза IPv4. 
service_account_id | **string**<br>Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. 
node_service_account_id | **string**<br>Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла. 


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


### Operation {#Operation}

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


## ListNodeGroups {#ListNodeGroups}

Список групп узлов для указанного кластера Kubernetes.

**rpc ListNodeGroups ([ListClusterNodeGroupsRequest](#ListClusterNodeGroupsRequest)) returns ([ListClusterNodeGroupsResponse](#ListClusterNodeGroupsResponse))**

### ListClusterNodeGroupsRequest {#ListClusterNodeGroupsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Kubernetes, для которого запрашивается список групп узлов. Чтобы получить идентификатор кластера Kubernetes, используйте [ClusterService.List](#List) запрос. 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterNodeGroupsResponse.next_page_token](#ListClusterNodeGroupsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterNodeGroupsResponse.next_page_token](#ListClusterNodeGroupsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [Cluster.name](#Cluster4). Максимальная длина строки в символах — 1000.


### ListClusterNodeGroupsResponse {#ListClusterNodeGroupsResponse}

Поле | Описание
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup)**<br>Список групп узлов для указанного кластера Kubernetes. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterNodeGroupsRequest.page_size](#ListClusterNodeGroupsRequest1), используйте `next_page_token` в качестве значения параметра [ListClusterNodeGroupsRequest.page_token](#ListClusterNodeGroupsRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### NodeGroup {#NodeGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы узлов. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит группа узлов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Новое имя группы узлов. Имя уникально в рамках каталога. 
description | **string**<br>Новое описание группы узлов. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус группы узлов. <ul><li>`PROVISIONING`: Группа узлов ожидает выделения ресурсов.</li><li>`RUNNING`: Группа узлов запущена.</li><li>`RECONCILING`: Группа узлов ожидает выполнения некоторых работ, например, обновления программного обеспечения узла.</li><li>`STOPPING`: Группа узлов останавливается.</li><li>`STOPPED`: Группа узлов остановлена.</li><li>`DELETING`: Группа узлов удаляется.</li><ul/>
node_template | **[NodeTemplate](#NodeTemplate)**<br>Шаблон узла, задающий параметры вычислительных экземпляров для группы узлов. 
scale_policy | **[ScalePolicy](#ScalePolicy)**<br>Политика масштабирования группы узлов. Дополнительные сведения см. в разделе [Политика масштабирования](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy)**<br>Политика распределения, с помощью которой ресурсы для групп узлов распределяются по зонам и регионам. 
instance_group_id | **string**<br>Идентификатор группы виртуальных машин, связанной с этой группой узлов. 
node_version | **string**<br>Версия компонентов Kubernetes, которая запущена на узлах. 


### NodeTemplate {#NodeTemplate}

Поле | Описание
--- | ---
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources_spec | **[ResourcesSpec](#ResourcesSpec)**<br>Вычислительные ресурсы узла, такие как объем памяти и количество ядер. 
boot_disk_spec | **[DiskSpec](#DiskSpec)**<br>Спецификация загрузочного диска, который будет подключен к узлу. Метаданные, назначаемые этому шаблону виртуальной машины, в формате ``key:value``. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, вы можете использовать метаданные для предоставления вашего открытого SSH-ключа узлу. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). 
metadata | **map<string,string>**<br> Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 131072. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec)**<br>Спецификация для создания сетевых интерфейсов для вычислительных экземпляров группы узлов. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy)**<br>Конфигурация политики планирования. 


### ResourcesSpec {#ResourcesSpec}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. Допустимые значения — от 0 до 274877906944 включительно.
cores | **int64**<br>Количество ядер, доступное узлу. Значение должно быть равно 0,1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. Значение должно быть равно 0,5,20,50,100.


### DiskSpec {#DiskSpec}

Поле | Описание
--- | ---
disk_type_id | **string**<br>Идентификатор типа диска. Значение должно соответствовать регулярному выражению ` |network-nvme|network-hdd `.
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
preemptible | **bool**<br>Если значение равно true — будет создана прерываемая виртуальная машина. Значение по умолчанию: false. Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale)**<br>Политика масштабирования группы узлов. 


### FixedScale {#FixedScale}

Поле | Описание
--- | ---
size | **int64**<br>Количество узлов в группе узлов. Минимальная значение — 1.


### NodeGroupAllocationPolicy {#NodeGroupAllocationPolicy}

Поле | Описание
--- | ---
locations[] | **[NodeGroupLocation](#NodeGroupLocation)**<br>Список местоположений (зон доступности и подсетей), в которых будут выделены ресурсы для группы узлов. 


### NodeGroupLocation {#NodeGroupLocation}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, в которой могут находиться узлы. 
subnet_id | **string**<br>Идентификатор подсети. Если сеть, выбранная для кластера Kubernetes, имеет только одну подсеть в указанной зоне, идентификатор подсети может быть опущен. 


## ListOperations {#ListOperations}

Список операций для указанного кластера Kubernetes.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Kubernetes, для которого запрашивается список операций. 
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [Cluster.name](#Cluster4). Максимальная длина строки в символах — 1000.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>Список операций для указанного кластера Kubernetes. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest1), используйте `next_page_token` в качестве значения параметра [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


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


