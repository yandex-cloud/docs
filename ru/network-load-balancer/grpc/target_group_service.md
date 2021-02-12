---
editable: false
---

# TargetGroupService

Набор методов для управления ресурсами TargetGroup.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс TargetGroup. |
| [List](#List) | Возвращает список TargetGroup ресурсов в указанном каталоге.. |
| [Create](#Create) | Создает целевую группу в указанном каталоге и добавляет в нее указанные целевые ресурсы. |
| [Update](#Update) | Обновляет указанную целевую группу. |
| [Delete](#Delete) | Удаляет указанную целевую группу. |
| [AddTargets](#AddTargets) | Добавляет ресурсы в целевую группу. |
| [RemoveTargets](#RemoveTargets) | Удаляет ресурсы из целевой группы. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанной целевой группы. |

## Вызовы TargetGroupService {#calls}

## Get {#Get}

Возвращает указанный ресурс TargetGroup.

**rpc Get ([GetTargetGroupRequest](#GetTargetGroupRequest)) returns ([TargetGroup](#TargetGroup))**

### GetTargetGroupRequest {#GetTargetGroupRequest}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса TargetGroup. Чтобы узнать идентификатор целевой группы, используйте запрос [TargetGroupService.List](#List). Максимальная длина строки в символах — 50.


### TargetGroup {#TargetGroup}

Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор целевой группы. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит целевая группа. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Только для вывода. Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя целевой группы. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание целевой группы. Длина 0-256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс. 
region_id | **string**<br>Идентификатор региона, в котором находится целевая группа. 
targets[] | **[Target](#Target)**<br>Список целевых ресурсов в целевой группе. 


### Target {#Target}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор подсети, к которой подключены целевые ресурсы. В пределах одной зоны доступности все ресурсы целевой группы должны быть подключены к одной подсети. Максимальная длина строки в символах — 50.
address | **string**<br>IP-адрес целевого ресурса. 


## List {#List}

Возвращает список TargetGroup ресурсов в указанном каталоге..

**rpc List ([ListTargetGroupsRequest](#ListTargetGroupsRequest)) returns ([ListTargetGroupsResponse](#ListTargetGroupsResponse))**

### ListTargetGroupsRequest {#ListTargetGroupsRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для вывода списка целевых групп. Чтобы получить идентификатор каталога, используйте запрос [TargetGroupService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListTargetGroupsResponse.next_page_token](#ListTargetGroupsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListTargetGroupsResponse.next_page_token](#ListTargetGroupsResponse), прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [TargetGroup.name](#TargetGroup1). </li><li>Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> Максимальная длина строки в символах — 1000.


### ListTargetGroupsResponse {#ListTargetGroupsResponse}

Поле | Описание
--- | ---
target_groups[] | **[TargetGroup](#TargetGroup1)**<br>Список ресурсов TargetGroup. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListTargetGroupsRequest.page_size](#ListTargetGroupsRequest), используйте `next_page_token` в качестве значения параметра [ListTargetGroupsRequest.page_token](#ListTargetGroupsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token`, для перебора страниц результатов. 


### TargetGroup {#TargetGroup1}

Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор целевой группы. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит целевая группа. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Только для вывода. Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя целевой группы. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание целевой группы. Длина 0-256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс. 
region_id | **string**<br>Идентификатор региона, в котором находится целевая группа. 
targets[] | **[Target](#Target1)**<br>Список целевых ресурсов в целевой группе. 


### Target {#Target1}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор подсети, к которой подключены целевые ресурсы. В пределах одной зоны доступности все ресурсы целевой группы должны быть подключены к одной подсети. Максимальная длина строки в символах — 50.
address | **string**<br>IP-адрес целевого ресурса. 


## Create {#Create}

Создает целевую группу в указанном каталоге и добавляет в нее указанные целевые ресурсы.

**rpc Create ([CreateTargetGroupRequest](#CreateTargetGroupRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTargetGroupMetadata](#CreateTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup2)<br>

### CreateTargetGroupRequest {#CreateTargetGroupRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для вывода списка целевых групп. Чтобы получить идентификатор каталога, используйте запрос [TargetGroupService.List](#List). Максимальная длина строки в символах — 50.
name | **string**<br>Обязательное поле. Имя целевой группы. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
region_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, в которой находится целевая группа. Максимальная длина строки в символах — 50.
targets[] | **[Target](#Target2)**<br>Список целевых ресурсов в целевой группе. 


### Target {#Target2}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор подсети, к которой подключены целевые ресурсы. В пределах одной зоны доступности все ресурсы целевой группы должны быть подключены к одной подсети. Максимальная длина строки в символах — 50.
address | **string**<br>IP-адрес целевого ресурса. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateTargetGroupMetadata](#CreateTargetGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[TargetGroup](#TargetGroup2)>**<br>в случае успешного выполнения операции. 


### CreateTargetGroupMetadata {#CreateTargetGroupMetadata}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор создаваемой целевой группы. 


### TargetGroup {#TargetGroup2}

Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор целевой группы. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит целевая группа. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Только для вывода. Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя целевой группы. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание целевой группы. Длина 0-256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс. 
region_id | **string**<br>Идентификатор региона, в котором находится целевая группа. 
targets[] | **[Target](#Target3)**<br>Список целевых ресурсов в целевой группе. 


### Target {#Target3}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор подсети, к которой подключены целевые ресурсы. В пределах одной зоны доступности все ресурсы целевой группы должны быть подключены к одной подсети. Максимальная длина строки в символах — 50.
address | **string**<br>IP-адрес целевого ресурса. 


## Update {#Update}

Обновляет указанную целевую группу.

**rpc Update ([UpdateTargetGroupRequest](#UpdateTargetGroupRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateTargetGroupMetadata](#UpdateTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup3)<br>

### UpdateTargetGroupRequest {#UpdateTargetGroupRequest}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор изменяемого ресурса TargetGroup. Чтобы узнать идентификатор целевой группы, используйте запрос [TargetGroupService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса TargetGroup будут обновлены. 
name | **string**<br>Имя целевой группы. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание целевой группы. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. <br>Имеющийся набор меток полностью перезаписывается набором, переданным в запросе. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
targets[] | **[Target](#Target4)**<br>Новый список ресурсов для этой целевой группы. 


### Target {#Target4}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор подсети, к которой подключены целевые ресурсы. В пределах одной зоны доступности все ресурсы целевой группы должны быть подключены к одной подсети. Максимальная длина строки в символах — 50.
address | **string**<br>IP-адрес целевого ресурса. 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateTargetGroupMetadata](#UpdateTargetGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[TargetGroup](#TargetGroup3)>**<br>в случае успешного выполнения операции. 


### UpdateTargetGroupMetadata {#UpdateTargetGroupMetadata}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор обновляемой целевой группы. 


### TargetGroup {#TargetGroup3}

Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор целевой группы. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит целевая группа. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Только для вывода. Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя целевой группы. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание целевой группы. Длина 0-256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс. 
region_id | **string**<br>Идентификатор региона, в котором находится целевая группа. 
targets[] | **[Target](#Target5)**<br>Список целевых ресурсов в целевой группе. 


### Target {#Target5}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор подсети, к которой подключены целевые ресурсы. В пределах одной зоны доступности все ресурсы целевой группы должны быть подключены к одной подсети. Максимальная длина строки в символах — 50.
address | **string**<br>IP-адрес целевого ресурса. 


## Delete {#Delete}

Удаляет указанную целевую группу.

**rpc Delete ([DeleteTargetGroupRequest](#DeleteTargetGroupRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteTargetGroupMetadata](#DeleteTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteTargetGroupRequest {#DeleteTargetGroupRequest}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор удаляемой целевой группы. Чтобы узнать идентификатор целевой группы, используйте запрос [TargetGroupService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteTargetGroupMetadata](#DeleteTargetGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteTargetGroupMetadata {#DeleteTargetGroupMetadata}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор удаляемой целевой группы. 


## AddTargets {#AddTargets}

Добавляет ресурсы в целевую группу.

**rpc AddTargets ([AddTargetsRequest](#AddTargetsRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddTargetsMetadata](#AddTargetsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup4)<br>

### AddTargetsRequest {#AddTargetsRequest}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор ресурса TargetGroup для добавления целевого ресурса. Чтобы узнать идентификатор целевой группы, используйте запрос [TargetGroupService.List](#List). Максимальная длина строки в символах — 50.
targets[] | **[Target](#Target6)**<br>Список целевых объектов для добавления в целевую группу. Минимальное количество элементов — 1.


### Target {#Target6}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор подсети, к которой подключены целевые ресурсы. В пределах одной зоны доступности все ресурсы целевой группы должны быть подключены к одной подсети. Максимальная длина строки в символах — 50.
address | **string**<br>IP-адрес целевого ресурса. 


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddTargetsMetadata](#AddTargetsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[TargetGroup](#TargetGroup4)>**<br>в случае успешного выполнения операции. 


### AddTargetsMetadata {#AddTargetsMetadata}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор целевой группы, в которую добавляются целевые ресурсы. 


### TargetGroup {#TargetGroup4}

Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор целевой группы. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит целевая группа. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Только для вывода. Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя целевой группы. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание целевой группы. Длина 0-256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс. 
region_id | **string**<br>Идентификатор региона, в котором находится целевая группа. 
targets[] | **[Target](#Target7)**<br>Список целевых ресурсов в целевой группе. 


### Target {#Target7}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор подсети, к которой подключены целевые ресурсы. В пределах одной зоны доступности все ресурсы целевой группы должны быть подключены к одной подсети. Максимальная длина строки в символах — 50.
address | **string**<br>IP-адрес целевого ресурса. 


## RemoveTargets {#RemoveTargets}

Удаляет ресурсы из целевой группы.

**rpc RemoveTargets ([RemoveTargetsRequest](#RemoveTargetsRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveTargetsMetadata](#RemoveTargetsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup5)<br>

### RemoveTargetsRequest {#RemoveTargetsRequest}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор целевой группы из которой будут удалены целевые ресурсы. Чтобы узнать идентификатор целевой группы, используйте запрос [TargetGroupService.List](#List). Максимальная длина строки в символах — 50.
targets[] | **[Target](#Target8)**<br>Список ресурсов для удаления из целевой группы. Минимальное количество элементов — 1.


### Target {#Target8}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор подсети, к которой подключены целевые ресурсы. В пределах одной зоны доступности все ресурсы целевой группы должны быть подключены к одной подсети. Максимальная длина строки в символах — 50.
address | **string**<br>IP-адрес целевого ресурса. 


### Operation {#Operation4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RemoveTargetsMetadata](#RemoveTargetsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[TargetGroup](#TargetGroup5)>**<br>в случае успешного выполнения операции. 


### RemoveTargetsMetadata {#RemoveTargetsMetadata}

Поле | Описание
--- | ---
target_group_id | **string**<br>Идентификатор целевой группы, из которой удаляются ресурсы. 


### TargetGroup {#TargetGroup5}

Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор целевой группы. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит целевая группа. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Только для вывода. Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя целевой группы. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание целевой группы. Длина 0-256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс. 
region_id | **string**<br>Идентификатор региона, в котором находится целевая группа. 
targets[] | **[Target](#Target9)**<br>Список целевых ресурсов в целевой группе. 


### Target {#Target9}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор подсети, к которой подключены целевые ресурсы. В пределах одной зоны доступности все ресурсы целевой группы должны быть подключены к одной подсети. Максимальная длина строки в символах — 50.
address | **string**<br>IP-адрес целевого ресурса. 


## ListOperations {#ListOperations}

Возвращает список операций для указанной целевой группы.

**rpc ListOperations ([ListTargetGroupOperationsRequest](#ListTargetGroupOperationsRequest)) returns ([ListTargetGroupOperationsResponse](#ListTargetGroupOperationsResponse))**

### ListTargetGroupOperationsRequest {#ListTargetGroupOperationsRequest}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор изменяемого ресурса TargetGroup. Чтобы узнать идентификатор целевой группы, используйте запрос [TargetGroupService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListTargetGroupOperationsResponse.next_page_token](#ListTargetGroupOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListTargetGroupOperationsResponse.next_page_token](#ListTargetGroupOperationsResponse), прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListTargetGroupOperationsResponse {#ListTargetGroupOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>Список операций для указанной целевой группы. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListTargetGroupOperationsRequest.page_size](#ListTargetGroupOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListTargetGroupOperationsRequest.page_token](#ListTargetGroupOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token`, для перебора страниц результатов. 


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


