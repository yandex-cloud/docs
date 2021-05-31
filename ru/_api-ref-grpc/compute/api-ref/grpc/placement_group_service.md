---
editable: false
---

# PlacementGroupService

Набор методов для управления группами размещения.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанную группу размещения. |
| [List](#List) | Возвращает список групп размещения в указанном каталоге. |
| [Create](#Create) | Создает группу размещения в указанном каталоге. |
| [Update](#Update) | Обновляет указанную группу размещения. |
| [Delete](#Delete) | Удаляет указанную группу размещения. |
| [ListInstances](#ListInstances) | Возвращает список виртуальных машин в указанной группе размещения. |
| [ListOperations](#ListOperations) | Возвращает список операций указанной группы размещения. |

## Вызовы PlacementGroupService {#calls}

## Get {#Get}

Возвращает указанную группу размещения. <br>Чтобы получить список доступных групп размещения, используйте запрос [List](#List).

**rpc Get ([GetPlacementGroupRequest](#GetPlacementGroupRequest)) returns ([PlacementGroup](#PlacementGroup))**

### GetPlacementGroupRequest {#GetPlacementGroupRequest}

Поле | Описание
--- | ---
placement_group_id | **string**<br>Идентификатор возвращаемой группы размещения. <br>Чтобы получить идентификатор группы размещения выполните запрос [PlacementGroupService.List](#List). 


### PlacementGroup {#PlacementGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы размещения. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа размещения. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя группы размещения. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы размещения. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки групп размещения в формате `key:value`. 
placement_strategy | **oneof:** `spread_placement_strategy`<br>Стратегия размещения. Чтобы указать стратегию размещения, передайте соответствующее поле с пустой структурой.
&nbsp;&nbsp;spread_placement_strategy | **[SpreadPlacementStrategy](#SpreadPlacementStrategy)**<br>Стратегия распределенного размещения (`spread`). Каждая из виртуальных машин в группе расположена на отдельной стойке. 


### SpreadPlacementStrategy {#SpreadPlacementStrategy}



## List {#List}

Возвращает список групп размещения в указанном каталоге.

**rpc List ([ListPlacementGroupsRequest](#ListPlacementGroupsRequest)) returns ([ListPlacementGroupsResponse](#ListPlacementGroupsResponse))**

### ListPlacementGroupsRequest {#ListPlacementGroupsRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Идентификатор каталога для получения списка групп размещения. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListPlacementGroupsResponse.next_page_token](#ListPlacementGroupsResponse), которое можно использовать для получения следующей страницы. 
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListPlacementGroupsResponse.next_page_token](#ListPlacementGroupsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. 
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [PlacementGroup.name](#PlacementGroup1). 


### ListPlacementGroupsResponse {#ListPlacementGroupsResponse}

Поле | Описание
--- | ---
placement_groups[] | **[PlacementGroup](#PlacementGroup1)**<br>Выводит список групп размещения для указанного каталога. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [<RequestMessage>.page_size], используйте `next_page_token` в качестве значения параметра [<RequestMessage>.page_token] в следующем запросе списка ресурсов. <br>Каждая следующая страница будет иметь свой `next_page_token` для продолжения перебора страниц результатов. 


### PlacementGroup {#PlacementGroup1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы размещения. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа размещения. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя группы размещения. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы размещения. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки групп размещения в формате `key:value`. 
placement_strategy | **oneof:** `spread_placement_strategy`<br>Стратегия размещения. Чтобы указать стратегию размещения, передайте соответствующее поле с пустой структурой.
&nbsp;&nbsp;spread_placement_strategy | **[SpreadPlacementStrategy](#SpreadPlacementStrategy1)**<br>Стратегия распределенного размещения (`spread`). Каждая из виртуальных машин в группе расположена на отдельной стойке. 


### SpreadPlacementStrategy {#SpreadPlacementStrategy1}



## Create {#Create}

Создает группу размещения в указанном каталоге.

**rpc Create ([CreatePlacementGroupRequest](#CreatePlacementGroupRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreatePlacementGroupMetadata](#CreatePlacementGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[PlacementGroup](#PlacementGroup2)<br>

### CreatePlacementGroupRequest {#CreatePlacementGroupRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Идентификатор каталога, в котором создается группа размещения. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
name | **string**<br>Имя группы размещения. 
description | **string**<br>Описание группы размещения. 
labels | **map<string,string>**<br>Метки группы размещения в формате `key:value`. 
placement_strategy | **oneof:** `spread_placement_strategy`<br>Стратегия размещения виртуальных машин.
&nbsp;&nbsp;spread_placement_strategy | **[SpreadPlacementStrategy](#SpreadPlacementStrategy2)**<br>Стратегия распределенного размещения (`spread`). Каждая из виртуальных машин в группе расположена на отдельной стойке. 


### SpreadPlacementStrategy {#SpreadPlacementStrategy2}



### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreatePlacementGroupMetadata](#CreatePlacementGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PlacementGroup](#PlacementGroup2)>**<br>в случае успешного выполнения операции. 


### CreatePlacementGroupMetadata {#CreatePlacementGroupMetadata}

Поле | Описание
--- | ---
placement_group_id | **string**<br>Идентификатор создаваемой группы размещения. 


### PlacementGroup {#PlacementGroup2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы размещения. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа размещения. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя группы размещения. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы размещения. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки групп размещения в формате `key:value`. 
placement_strategy | **oneof:** `spread_placement_strategy`<br>Стратегия размещения. Чтобы указать стратегию размещения, передайте соответствующее поле с пустой структурой.
&nbsp;&nbsp;spread_placement_strategy | **[SpreadPlacementStrategy](#SpreadPlacementStrategy3)**<br>Стратегия распределенного размещения (`spread`). Каждая из виртуальных машин в группе расположена на отдельной стойке. 


### SpreadPlacementStrategy {#SpreadPlacementStrategy3}



## Update {#Update}

Обновляет указанную группу размещения.

**rpc Update ([UpdatePlacementGroupRequest](#UpdatePlacementGroupRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdatePlacementGroupMetadata](#UpdatePlacementGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[PlacementGroup](#PlacementGroup3)<br>

### UpdatePlacementGroupRequest {#UpdatePlacementGroupRequest}

Поле | Описание
--- | ---
placement_group_id | **string**<br>Идентификатор обновляемой группы размещения. <br>Чтобы получить идентификатор группы размещения, используйте запрос [PlacementGroupService.List](#List). 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие атрибуты группы размещения должны быть обновлены. 
name | **string**<br>Имя группы размещения. 
description | **string**<br>Описание группы размещения. 
labels | **map<string,string>**<br>Метки группы размещения в формате `key:value`. <br>Существующий набор `labels` полностью перезаписывается набором, переданным в запросе. 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdatePlacementGroupMetadata](#UpdatePlacementGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PlacementGroup](#PlacementGroup3)>**<br>в случае успешного выполнения операции. 


### UpdatePlacementGroupMetadata {#UpdatePlacementGroupMetadata}

Поле | Описание
--- | ---
placement_group_id | **string**<br>Идентификатор обновляемой группы размещения. 


### PlacementGroup {#PlacementGroup3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы размещения. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит группа размещения. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя группы размещения. Имя уникально в рамках каталога. 
description | **string**<br>Описание группы размещения. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки групп размещения в формате `key:value`. 
placement_strategy | **oneof:** `spread_placement_strategy`<br>Стратегия размещения. Чтобы указать стратегию размещения, передайте соответствующее поле с пустой структурой.
&nbsp;&nbsp;spread_placement_strategy | **[SpreadPlacementStrategy](#SpreadPlacementStrategy4)**<br>Стратегия распределенного размещения (`spread`). Каждая из виртуальных машин в группе расположена на отдельной стойке. 


### SpreadPlacementStrategy {#SpreadPlacementStrategy4}



## Delete {#Delete}

Удаляет указанную группу размещения.

**rpc Delete ([DeletePlacementGroupRequest](#DeletePlacementGroupRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeletePlacementGroupMetadata](#DeletePlacementGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeletePlacementGroupRequest {#DeletePlacementGroupRequest}

Поле | Описание
--- | ---
placement_group_id | **string**<br>Идентификатор удаляемой группы размещения. <br>Чтобы получить идентификатор группы размещения, используйте запрос [PlacementGroupService.List](#List). 


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeletePlacementGroupMetadata](#DeletePlacementGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeletePlacementGroupMetadata {#DeletePlacementGroupMetadata}

Поле | Описание
--- | ---
placement_group_id | **string**<br>Идентификатор удаляемой группы размещения. 


## ListInstances {#ListInstances}

Возвращает список виртуальных машин в указанной группе размещения.

**rpc ListInstances ([ListPlacementGroupInstancesRequest](#ListPlacementGroupInstancesRequest)) returns ([ListPlacementGroupInstancesResponse](#ListPlacementGroupInstancesResponse))**

### ListPlacementGroupInstancesRequest {#ListPlacementGroupInstancesRequest}

Поле | Описание
--- | ---
placement_group_id | **string**<br>Идентификатор группы размещения для получения списка виртуальных машин. <br>Чтобы получить идентификатор группы размещения, используйте запрос [PlacementGroupService.List](#List). 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListPlacementGroupInstancesResponse.next_page_token](#ListPlacementGroupInstancesResponse), которое можно использовать для получения следующей страницы. 
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListPlacementGroupInstancesResponse.next_page_token](#ListPlacementGroupInstancesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. 


### ListPlacementGroupInstancesResponse {#ListPlacementGroupInstancesResponse}

Поле | Описание
--- | ---
instances[] | **[Instance](#Instance)**<br>Возвращает список виртуальных машин в указанной группе размещения. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListPlacementGroupInstancesRequest.page_size](#ListPlacementGroupInstancesRequest), используйте `next_page_token` в качестве значения параметра [ListPlacementGroupInstancesRequest.page_token](#ListPlacementGroupInstancesRequest) в следующем запросе списка ресурсов. Каждая следующая страница будет иметь свой `next_page_token` для перебора страниц результатов. 


### Instance {#Instance}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор виртуальной машины. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит виртуальная машина. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя виртуальной машины. Длина 1-63 символов. 
description | **string**<br>Описание виртуальной машины. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
zone_id | **string**<br>Идентификатор зоны доступности, где находится виртуальная машина. 
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
status | enum **Status**<br>Статус виртуальной машины. <ul><li>`PROVISIONING`: Виртуальная машина ожидает выделения ресурсов.</li><li>`RUNNING`: Виртуальная машина работает нормально.</li><li>`STOPPING`: Виртуальная машина останавливается.</li><li>`STOPPED`: Виртуальная машина остановлена.</li><li>`STARTING`: Виртуальная машина запускается.</li><li>`RESTARTING`: Виртуальная машина перезапускается.</li><li>`UPDATING`: Виртуальная машина обновляется.</li><li>`ERROR`: С виртуальной машиной произошла ошибка, блокирующая работу.</li><li>`CRASHED`: Виртуальная машина аварийно завершила работу и будет перезапущена автоматически.</li><li>`DELETING`: Виртуальная машина удаляется.</li><ul/>
metadata | **map<string,string>**<br>Метаданные в формате пар `key:value`, назначаемые данной виртуальной машине. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk)**<br>Загрузочный диск, подключенный к виртуальной машине. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk)**<br>Массив дополнительных дисков, подключенных к виртуальной машине. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface)**<br>Массив сетевых интерфейсов, присоединенных к виртуальной машине. 
fqdn | **string**<br>Доменное имя виртуальной машины. FQDN определяется сервером в формате `<hostname>.<region_id>.internal` при создании виртуальной машины. Если имя хоста не было указано при создании виртуальной машины, FQDN будет `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy)**<br>Конфигурация политики планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для [аутентификации изнутри виртуальной машины](/docs/compute/operations/vm-connect/auth-inside-vm). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
network_settings | **[NetworkSettings](#NetworkSettings)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. 


### Resources {#Resources}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. 
cores | **int64**<br>Количество ядер, доступное виртуальной машине. 
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. 
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. 


### AttachedDisk {#AttachedDisk}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который отображается в директории /dev/disk/by-id/ на виртуальной машине с операционной системой Linux. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. 
auto_delete | **bool**<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины. 
disk_id | **string**<br>Идентификатор диска, подключенного к виртуальной машине. 


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
address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat)**<br>Конфигурация one-to-one NAT. Если она отсутствует, NAT не был настроен. 


### OneToOneNat {#OneToOneNat}

Поле | Описание
--- | ---
address | **string**<br>Публичный IP-адрес, связанный с данной виртуальной машиной. 
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.0.2.235.</li><li>`IPV6`: <ol><li>На данный момент не доступен.</li></ol></li><ul/>


### SchedulingPolicy {#SchedulingPolicy}

Поле | Описание
--- | ---
preemptible | **bool**<br>Если значение равно true — будет создана прерываемая виртуальная машина. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. <ul><li>`STANDARD`: Стандартная сеть.</li><li>`SOFTWARE_ACCELERATED`: Сеть с программным ускорением.</li><li>`HARDWARE_ACCELERATED`: Сеть с аппаратным ускорением (этот тип пока недоступен, значение зарезервировано для использования в будущем).</li><ul/>


## ListOperations {#ListOperations}

Возвращает список операций указанной группы размещения.

**rpc ListOperations ([ListPlacementGroupOperationsRequest](#ListPlacementGroupOperationsRequest)) returns ([ListPlacementGroupOperationsResponse](#ListPlacementGroupOperationsResponse))**

### ListPlacementGroupOperationsRequest {#ListPlacementGroupOperationsRequest}

Поле | Описание
--- | ---
placement_group_id | **string**<br>Идентификатор группы размещения для получения списка операций. <br>Чтобы получить идентификатор группы размещения, используйте запрос [PlacementGroupService.List](#List). 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListPlacementGroupOperationsResponse.next_page_token](#ListPlacementGroupOperationsResponse), которое можно использовать для получения следующей страницы. 
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListPlacementGroupOperationsResponse.next_page_token](#ListPlacementGroupOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. 


### ListPlacementGroupOperationsResponse {#ListPlacementGroupOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>Список операций для указанной группы размещения. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListPlacementGroupOperationsRequest.page_size](#ListPlacementGroupOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListPlacementGroupOperationsRequest.page_token](#ListPlacementGroupOperationsRequest) в следующем запросе списка ресурсов. Каждая следующая страница будет иметь свой `next_page_token` для продолжения перебора страниц результатов. 


### Operation {#Operation3}

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


