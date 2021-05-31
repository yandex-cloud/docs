---
editable: false
---

# HostGroupService

Набор методов для управления группами выделенных хостов.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает информацию об указанной группе выделенных хостов. |
| [List](#List) | Возвращает список доступных групп выделенных хостов в указанном каталоге. |
| [Create](#Create) | Создает группу выделенных хостов в указанном каталоге. |
| [Update](#Update) | Обновляет параметры указанной группы выделенных хостов. |
| [Delete](#Delete) | Удаляет указанную группу выделенных хостов. |
| [ListOperations](#ListOperations) | Возвращает список операций указанной группы выделенных хостов. |
| [ListInstances](#ListInstances) | Список ВМ, привязанных к указанной группе выделенных хостов. |
| [ListHosts](#ListHosts) | Список выделенных хостов, привязанных к указанной группе хостов. |

## Вызовы HostGroupService {#calls}

## Get {#Get}

Возвращает информацию об указанной группе выделенных хостов.

**rpc Get ([GetHostGroupRequest](#GetHostGroupRequest)) returns ([HostGroup](#HostGroup))**

### GetHostGroupRequest {#GetHostGroupRequest}

Поле | Описание
--- | ---
host_group_id | **string**<br>Обязательное поле. Идентификатор группы выделенных хостов. Чтобы получить идентификатор группы выделенных хостов, используйте запрос [HostGroupService.List](#List). Максимальная длина строки в символах — 50.


### HostGroup {#HostGroup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы выделенных хостов. 
folder_id | **string**<br>Идентификатор каталога, к которому принадлежит группа выделенных хостов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания группы выделенных хостов в текстовом формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя группы выделенных хостов. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание группы выделенных хостов. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
zone_id | **string**<br>Зона доступности, в которой размещены все выделенные хосты. 
status | enum **Status**<br>Статус группы выделенных хостов. <ul><ul/>
type_id | **string**<br>Идентификатор типа выделенного хоста. Ресурсы, предоставляемые каждым выделенным хостом группы. 
maintenance_policy | enum **MaintenancePolicy**<br>Политика обслуживания. <ul><li>`RESTART`: После обслуживания перезапустить ВМ на том же выделенном хосте.</li><li>`MIGRATE`: Перенести ВМ на другой выделенный хост перед обслуживанием.</li><ul/>
scale_policy | **[ScalePolicy](#ScalePolicy)**<br>Политика масштабирования. На данный момент поддерживается только фиксированное количество выделенных хостов. 


### ScalePolicy {#ScalePolicy}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale)**<br> 


### FixedScale {#FixedScale}

Поле | Описание
--- | ---
size | **int64**<br> 


## List {#List}

Возвращает список доступных групп выделенных хостов в указанном каталоге.

**rpc List ([ListHostGroupsRequest](#ListHostGroupsRequest)) returns ([ListHostGroupsResponse](#ListHostGroupsResponse))**

### ListHostGroupsRequest {#ListHostGroupsRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором созданы группы выделенных хостов. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListHostGroupsResponse.next_page_token](#ListHostGroupsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListHostGroupsResponse.next_page_token](#ListHostGroupsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурса в ответе. В настоящее время фильтрация осуществляется только по полю [HostGroup.name](#HostGroup1). Максимальная длина строки в символах — 1000.


### ListHostGroupsResponse {#ListHostGroupsResponse}

Поле | Описание
--- | ---
host_groups[] | **[HostGroup](#HostGroup1)**<br>Возвращает список групп выделенных хостов указанного каталога. 
next_page_token | **string**<br>Этот токен позволяет получить следующую страницу результатов для списка запросов. Если количество результатов больше чем [ListHostGroupsRequest.page_size](#ListHostGroupsRequest), используйте `next_page_token` в качестве значения параметра [ListHostGroupsRequest.page_token](#ListHostGroupsRequest) в следующем запросе списка ресурсов. Каждая следующая страница будет иметь свой `next_page_token` для продолжения перебора страниц результатов. 


### HostGroup {#HostGroup1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы выделенных хостов. 
folder_id | **string**<br>Идентификатор каталога, к которому принадлежит группа выделенных хостов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания группы выделенных хостов в текстовом формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя группы выделенных хостов. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание группы выделенных хостов. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
zone_id | **string**<br>Зона доступности, в которой размещены все выделенные хосты. 
status | enum **Status**<br>Статус группы выделенных хостов. <ul><ul/>
type_id | **string**<br>Идентификатор типа выделенного хоста. Ресурсы, предоставляемые каждым выделенным хостом группы. 
maintenance_policy | enum **MaintenancePolicy**<br>Политика обслуживания. <ul><li>`RESTART`: После обслуживания перезапустить ВМ на том же выделенном хосте.</li><li>`MIGRATE`: Перенести ВМ на другой выделенный хост перед обслуживанием.</li><ul/>
scale_policy | **[ScalePolicy](#ScalePolicy1)**<br>Политика масштабирования. На данный момент поддерживается только фиксированное количество выделенных хостов. 


### ScalePolicy {#ScalePolicy1}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale1)**<br> 


### FixedScale {#FixedScale1}

Поле | Описание
--- | ---
size | **int64**<br> 


## Create {#Create}

Создает группу выделенных хостов в указанном каталоге.

**rpc Create ([CreateHostGroupRequest](#CreateHostGroupRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateHostGroupMetadata](#CreateHostGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[HostGroup](#HostGroup2)<br>

### CreateHostGroupRequest {#CreateHostGroupRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором будет создана группа выделенных хостов. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Имя группы выделенных хостов. Значение должно соответствовать регулярному выражению ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Описание группы выделенных хостов. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_./\\@0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_./\\@0-9a-z]* `.
zone_id | **string**<br>Обязательное поле. Зона доступности, в которой размещены все выделенные хосты. Максимальная длина строки в символах — 50.
type_id | **string**<br>Обязательное поле. Идентификатор типа выделенного хоста. Ресурсы, предоставляемые каждым выделенным хостом группы. Максимальная длина строки в символах — 50.
maintenance_policy | enum **MaintenancePolicy**<br>Политика обслуживания. <ul><li>`RESTART`: После обслуживания перезапустить ВМ на том же выделенном хосте.</li><li>`MIGRATE`: Перенести ВМ на другой выделенный хост перед обслуживанием.</li><ul/>
scale_policy | **[ScalePolicy](#ScalePolicy2)**<br>Политика масштабирования. На данный момент поддерживается только фиксированное количество выделенных хостов. 


### ScalePolicy {#ScalePolicy2}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale2)**<br> 


### FixedScale {#FixedScale2}

Поле | Описание
--- | ---
size | **int64**<br> 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateHostGroupMetadata](#CreateHostGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[HostGroup](#HostGroup2)>**<br>в случае успешного выполнения операции. 


### CreateHostGroupMetadata {#CreateHostGroupMetadata}

Поле | Описание
--- | ---
host_group_id | **string**<br>Идентификатор создаваемой группы выделенных хостов. 


### HostGroup {#HostGroup2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы выделенных хостов. 
folder_id | **string**<br>Идентификатор каталога, к которому принадлежит группа выделенных хостов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания группы выделенных хостов в текстовом формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя группы выделенных хостов. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание группы выделенных хостов. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
zone_id | **string**<br>Зона доступности, в которой размещены все выделенные хосты. 
status | enum **Status**<br>Статус группы выделенных хостов. <ul><ul/>
type_id | **string**<br>Идентификатор типа выделенного хоста. Ресурсы, предоставляемые каждым выделенным хостом группы. 
maintenance_policy | enum **MaintenancePolicy**<br>Политика обслуживания. <ul><li>`RESTART`: После обслуживания перезапустить ВМ на том же выделенном хосте.</li><li>`MIGRATE`: Перенести ВМ на другой выделенный хост перед обслуживанием.</li><ul/>
scale_policy | **[ScalePolicy](#ScalePolicy3)**<br>Политика масштабирования. На данный момент поддерживается только фиксированное количество выделенных хостов. 


### ScalePolicy {#ScalePolicy3}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale3)**<br> 


### FixedScale {#FixedScale3}

Поле | Описание
--- | ---
size | **int64**<br> 


## Update {#Update}

Обновляет параметры указанной группы выделенных хостов.

**rpc Update ([UpdateHostGroupRequest](#UpdateHostGroupRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateHostGroupMetadata](#UpdateHostGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[HostGroup](#HostGroup3)<br>

### UpdateHostGroupRequest {#UpdateHostGroupRequest}

Поле | Описание
--- | ---
host_group_id | **string**<br>Обязательное поле. Идентификатор обновляемой группы выделенных хостов. Для получения идентификатора группы выделенных хостов используйте запрос [HostGroupService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса HostGroup будут обновлены. 
name | **string**<br>Имя группы выделенных хостов. Значение должно соответствовать регулярному выражению ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Описание группы выделенных хостов. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. <br>Существующий набор меток полностью заменяется предоставленным набором. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_./\\@0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_./\\@0-9a-z]* `.
maintenance_policy | enum **MaintenancePolicy**<br>Политика обслуживания. <ul><li>`RESTART`: После обслуживания перезапустить ВМ на том же выделенном хосте.</li><li>`MIGRATE`: Перенести ВМ на другой выделенный хост перед обслуживанием.</li><ul/>
scale_policy | **[ScalePolicy](#ScalePolicy4)**<br>Политика масштабирования. На данный момент поддерживается только фиксированное количество выделенных хостов. 


### ScalePolicy {#ScalePolicy4}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale4)**<br> 


### FixedScale {#FixedScale4}

Поле | Описание
--- | ---
size | **int64**<br> 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateHostGroupMetadata](#UpdateHostGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[HostGroup](#HostGroup3)>**<br>в случае успешного выполнения операции. 


### UpdateHostGroupMetadata {#UpdateHostGroupMetadata}

Поле | Описание
--- | ---
host_group_id | **string**<br>Идентификатор обновлеяемой группы выделенных хостов. 


### HostGroup {#HostGroup3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор группы выделенных хостов. 
folder_id | **string**<br>Идентификатор каталога, к которому принадлежит группа выделенных хостов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания группы выделенных хостов в текстовом формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя группы выделенных хостов. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание группы выделенных хостов. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
zone_id | **string**<br>Зона доступности, в которой размещены все выделенные хосты. 
status | enum **Status**<br>Статус группы выделенных хостов. <ul><ul/>
type_id | **string**<br>Идентификатор типа выделенного хоста. Ресурсы, предоставляемые каждым выделенным хостом группы. 
maintenance_policy | enum **MaintenancePolicy**<br>Политика обслуживания. <ul><li>`RESTART`: После обслуживания перезапустить ВМ на том же выделенном хосте.</li><li>`MIGRATE`: Перенести ВМ на другой выделенный хост перед обслуживанием.</li><ul/>
scale_policy | **[ScalePolicy](#ScalePolicy5)**<br>Политика масштабирования. На данный момент поддерживается только фиксированное количество выделенных хостов. 


### ScalePolicy {#ScalePolicy5}

Поле | Описание
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale5)**<br> 


### FixedScale {#FixedScale5}

Поле | Описание
--- | ---
size | **int64**<br> 


## Delete {#Delete}

Удаляет указанную группу выделенных хостов.

**rpc Delete ([DeleteHostGroupRequest](#DeleteHostGroupRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteHostGroupMetadata](#DeleteHostGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteHostGroupRequest {#DeleteHostGroupRequest}

Поле | Описание
--- | ---
host_group_id | **string**<br>Обязательное поле. Идентификатор группы выделенных хостов, которую следует удалить. Чтобы получить идентификатор группы выделенных хостов, используйте запрос [HostGroupService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteHostGroupMetadata](#DeleteHostGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteHostGroupMetadata {#DeleteHostGroupMetadata}

Поле | Описание
--- | ---
host_group_id | **string**<br>Идентификатор удаляемой группы выделенных хостов. 


## ListOperations {#ListOperations}

Возвращает список операций указанной группы выделенных хостов.

**rpc ListOperations ([ListHostGroupOperationsRequest](#ListHostGroupOperationsRequest)) returns ([ListHostGroupOperationsResponse](#ListHostGroupOperationsResponse))**

### ListHostGroupOperationsRequest {#ListHostGroupOperationsRequest}

Поле | Описание
--- | ---
host_group_id | **string**<br>Обязательное поле. Идентификатор группы выделенных хостов для которой запрашивается список операций. Чтобы получить идентификатор группы выделенных хостов, используйте запрос [HostGroupService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListHostGroupOperationsResponse.next_page_token](#ListHostGroupOperationsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListHostGroupOperationsResponse.next_page_token](#ListHostGroupOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListHostGroupOperationsResponse {#ListHostGroupOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>Список операций для указанной группы выделенных хостов. 
next_page_token | **string**<br>Этот токен позволяет получить следующую страницу результатов для списка запросов. Если количество результатов больше чем [ListHostGroupOperationsRequest.page_size](#ListHostGroupOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListHostGroupOperationsRequest.page_token](#ListHostGroupOperationsRequest) в следующем запросе списка ресурсов. Каждая следующая страница будет иметь свой `next_page_token` для продолжения перебора страниц результатов. 


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


## ListInstances {#ListInstances}

Список ВМ, привязанных к указанной группе выделенных хостов.

**rpc ListInstances ([ListHostGroupInstancesRequest](#ListHostGroupInstancesRequest)) returns ([ListHostGroupInstancesResponse](#ListHostGroupInstancesResponse))**

### ListHostGroupInstancesRequest {#ListHostGroupInstancesRequest}

Поле | Описание
--- | ---
host_group_id | **string**<br>Обязательное поле. Идентификатор группы выделенных хостов, для которой запрашивается список ВМ. Чтобы получить идентификатор группы выделенных хостов, используйте запрос [HostGroupService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListHostGroupInstancesResponse.next_page_token](#ListHostGroupInstancesResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListHostGroupInstancesResponse.next_page_token](#ListHostGroupInstancesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [Host.id](#Host). Чтобы получить идентификатор выделенного хоста, используйте запрос [HostGroupService.ListHosts](#ListHosts). Максимальная длина строки в символах — 1000.


### ListHostGroupInstancesResponse {#ListHostGroupInstancesResponse}

Поле | Описание
--- | ---
instances[] | **[Instance](#Instance)**<br>Список ВМ для указанной группы выделенных хостов. 
next_page_token | **string**<br>Этот токен позволяет получить следующую страницу результатов для списка запросов. Если количество результатов больше чем [ListHostGroupInstancesRequest.page_size](#ListHostGroupInstancesRequest), используйте `next_page_token` в качестве значения параметра [ListHostGroupInstancesRequest.page_token](#ListHostGroupInstancesRequest) в следующем запросе списка ресурсов. Каждая следующая страница будет иметь свой `next_page_token` для продолжения перебора страниц результатов. 


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


## ListHosts {#ListHosts}

Список выделенных хостов, привязанных к указанной группе хостов.

**rpc ListHosts ([ListHostGroupHostsRequest](#ListHostGroupHostsRequest)) returns ([ListHostGroupHostsResponse](#ListHostGroupHostsResponse))**

### ListHostGroupHostsRequest {#ListHostGroupHostsRequest}

Поле | Описание
--- | ---
host_group_id | **string**<br>Обязательное поле. Идентификатор группы выделенных хостов, для которой запрашивается список хостов. Чтобы получить идентификатор группы выделенных хостов, используйте запрос [HostGroupService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListHostGroupHostsResponse.next_page_token](#ListHostGroupHostsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListHostGroupHostsResponse.next_page_token](#ListHostGroupHostsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListHostGroupHostsResponse {#ListHostGroupHostsResponse}

Поле | Описание
--- | ---
hosts[] | **[Host](#Host)**<br>Список выделенных хостов для указанной группы хостов. 
next_page_token | **string**<br>Этот токен позволяет получить следующую страницу результатов для списка запросов. Если количество результатов больше чем [ListHostGroupHostsRequest.page_size](#ListHostGroupHostsRequest), используйте `next_page_token` в качестве значения параметра [ListHostGroupHostsRequest.page_token](#ListHostGroupHostsRequest) в следующем запросе списка ресурсов. Каждая следующая страница будет иметь свой `next_page_token` для продолжения перебора страниц результатов. 


### Host {#Host}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор выделенного хоста. 
status | enum **Status**<br>Текущий статус выделенного хоста. Новые ВМ не могут запускаться на выделенном хосте в статусе DOWN. <ul><ul/>
server_id | **string**<br>Идентификатор физического сервера, которому принадлежит выделенный хост. 


