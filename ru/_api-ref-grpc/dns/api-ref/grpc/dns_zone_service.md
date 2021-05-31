---
editable: false
---

# DnsZoneService

Набор методов для управления зонами DNS.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанную зону DNS. |
| [List](#List) | Возвращает список зон DNS в указанном каталоге. |
| [Create](#Create) | Создает зону DNS в указанном каталоге. |
| [Update](#Update) | Обновляет указанную зону DNS. |
| [Delete](#Delete) | Удаляет указанную зону DNS. |
| [GetRecordSet](#GetRecordSet) | Возвращает указанный набор записей. |
| [ListRecordSets](#ListRecordSets) | Возвращает список наборов записей в указанном каталоге. |
| [UpdateRecordSets](#UpdateRecordSets) | Метод со строгим контролем за изменением состояния зоны. |
| [UpsertRecordSets](#UpsertRecordSets) | Метод без строгого контроля за изменением состояния зоны. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанной зоны DNS. |
| [ListAccessBindings](#ListAccessBindings) | Возвращает список привязок прав доступа для указанной зоны DNS. |
| [SetAccessBindings](#SetAccessBindings) | Задает список привязок прав доступа для указанной зоны DNS. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Обновляет привязки прав доступа для указанной зоны DNS. |

## Вызовы DnsZoneService {#calls}

## Get {#Get}

Возвращает указанную зону DNS. <br>Чтобы получить список доступных зон, используйте запрос [List](#List).

**rpc Get ([GetDnsZoneRequest](#GetDnsZoneRequest)) returns ([DnsZone](#DnsZone))**

### GetDnsZoneRequest {#GetDnsZoneRequest}

Поле | Описание
--- | ---
dns_zone_id | **string**<br>Обязательное поле. Идентификатор возвращаемой зоны DNS. <br>Чтобы получить идентификатор зоны DNS, выполните запрос [DnsZoneService.List](#List). 


### DnsZone {#DnsZone}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор зоны DNS. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит зона DNS. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя зоны DNS. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание зоны DNS. 
labels | **map<string,string>**<br>Метки зон DNS в формате `key:value`. 
zone | **string**<br>Суффикс зоны DNS. 
private_visibility | **[PrivateVisibility](#PrivateVisibility)**<br>Настройки внутренней зоны. Указывают, будут ли записи в зоне видны только из сетей VPC. 
public_visibility | **[PublicVisibility](#PublicVisibility)**<br>Настройки публичной зоны. Указывают, являются ли записи в пределах зоны публичными. 


### PrivateVisibility {#PrivateVisibility}

Поле | Описание
--- | ---
network_ids[] | **string**<br>Идентификаторы сетей. Количество элементов должно находиться в диапазоне от 0 до 10. Длина строки в символах должна быть равна 20.


### PublicVisibility {#PublicVisibility}



## List {#List}

Возвращает список зон DNS в указанном каталоге.

**rpc List ([ListDnsZonesRequest](#ListDnsZonesRequest)) returns ([ListDnsZonesResponse](#ListDnsZonesResponse))**

### ListDnsZonesRequest {#ListDnsZonesRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка зон DNS. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListDnsZonesResponse.next_page_token](#ListDnsZonesResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListDnsZonesResponse.next_page_token](#ListDnsZonesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 1000.
filter | **string**<br><ol><li>Имя поля. Фильтрация осуществляется только по полю [DnsZone.name](#DnsZone1). </li><li>Оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. </li><li>Значение или списки значений. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Пример фильтра: `name=my-dns-zone`.</li></ol> Максимальная длина строки в символах — 1000.


### ListDnsZonesResponse {#ListDnsZonesResponse}

Поле | Описание
--- | ---
dns_zones[] | **[DnsZone](#DnsZone1)**<br>Зоны DNS в указанном каталоге. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListDnsZonesRequest.page_size](#ListDnsZonesRequest), используйте `next_page_token` в качестве значения параметра [ListDnsZonesRequest.page_token](#ListDnsZonesRequest) в следующем запросе списка ресурсов. <br>Каждая следующая страница будет иметь свой `next_page_token` для продолжения перебора страниц результатов. 


### DnsZone {#DnsZone1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор зоны DNS. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит зона DNS. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя зоны DNS. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание зоны DNS. 
labels | **map<string,string>**<br>Метки зон DNS в формате `key:value`. 
zone | **string**<br>Суффикс зоны DNS. 
private_visibility | **[PrivateVisibility](#PrivateVisibility1)**<br>Настройки внутренней зоны. Указывают, будут ли записи в зоне видны только из сетей VPC. 
public_visibility | **[PublicVisibility](#PublicVisibility1)**<br>Настройки публичной зоны. Указывают, являются ли записи в пределах зоны публичными. 


### PrivateVisibility {#PrivateVisibility1}

Поле | Описание
--- | ---
network_ids[] | **string**<br>Идентификаторы сетей. Количество элементов должно находиться в диапазоне от 0 до 10. Длина строки в символах должна быть равна 20.


### PublicVisibility {#PublicVisibility1}



## Create {#Create}

Создает зону DNS в указанном каталоге.

**rpc Create ([CreateDnsZoneRequest](#CreateDnsZoneRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDnsZoneMetadata](#CreateDnsZoneMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DnsZone](#DnsZone2)<br>

### CreateDnsZoneRequest {#CreateDnsZoneRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка зон DNS. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Имя зоны DNS. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Описание зоны DNS. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки зон DNS в формате `key:value`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_./\\@0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_./\\@0-9a-z]* `.
zone | **string**<br>Обязательное поле. Суффикс зоны DNS. Максимальная длина строки в символах — 255. Значение должно соответствовать регулярному выражению ` [.]|[a-z0-9][-a-z0-9.]*\\. `.
private_visibility | **[PrivateVisibility](#PrivateVisibility2)**<br>Настройки внутренней зоны. Должно быть указано хотя бы одно из двух полей настроек видимости. 
public_visibility | **[PublicVisibility](#PublicVisibility2)**<br>Настройки публичной зоны. Должно быть указано хотя бы одно из двух полей настроек видимости. 


### PrivateVisibility {#PrivateVisibility2}

Поле | Описание
--- | ---
network_ids[] | **string**<br>Идентификаторы сетей. Количество элементов должно находиться в диапазоне от 0 до 10. Длина строки в символах должна быть равна 20.


### PublicVisibility {#PublicVisibility2}



### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateDnsZoneMetadata](#CreateDnsZoneMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DnsZone](#DnsZone2)>**<br>в случае успешного выполнения операции. 


### CreateDnsZoneMetadata {#CreateDnsZoneMetadata}

Поле | Описание
--- | ---
dns_zone_id | **string**<br>Идентификатор создаваемой зоны DNS. 


### DnsZone {#DnsZone2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор зоны DNS. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит зона DNS. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя зоны DNS. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание зоны DNS. 
labels | **map<string,string>**<br>Метки зон DNS в формате `key:value`. 
zone | **string**<br>Суффикс зоны DNS. 
private_visibility | **[PrivateVisibility](#PrivateVisibility3)**<br>Настройки внутренней зоны. Указывают, будут ли записи в зоне видны только из сетей VPC. 
public_visibility | **[PublicVisibility](#PublicVisibility3)**<br>Настройки публичной зоны. Указывают, являются ли записи в пределах зоны публичными. 


### PrivateVisibility {#PrivateVisibility3}

Поле | Описание
--- | ---
network_ids[] | **string**<br>Идентификаторы сетей. Количество элементов должно находиться в диапазоне от 0 до 10. Длина строки в символах должна быть равна 20.


### PublicVisibility {#PublicVisibility3}



## Update {#Update}

Обновляет указанную зону DNS.

**rpc Update ([UpdateDnsZoneRequest](#UpdateDnsZoneRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateDnsZoneMetadata](#UpdateDnsZoneMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DnsZone](#DnsZone3)<br>

### UpdateDnsZoneRequest {#UpdateDnsZoneRequest}

Поле | Описание
--- | ---
dns_zone_id | **string**<br>Идентификатор обновляемой зоны DNS. <br>Чтобы получить идентификатор зоны DNS, выполните запрос [DnsZoneService.List](#List). Длина строки в символах должна быть равна 20.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска поля, указывающая, какие поля ресурса DnsZone будут обновлены. 
name | **string**<br>Новое имя для зоны DNS. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Новое описание зоны DNS. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br><ol><li>Запросите текущий набор меток с помощью запроса [DnsZoneService.Get](#Get). </li><li>Добавьте или удалите метку в этом наборе. </li><li>Отправьте новый набор в этом поле.</li></ol> Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_./\\@0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_./\\@0-9a-z]* `.
private_visibility | **[PrivateVisibility](#PrivateVisibility4)**<br>Новые идентификаторы сетей для внутренних зон. 
public_visibility | **[PublicVisibility](#PublicVisibility4)**<br>Конфигурация публичной видимости зоны. 


### PrivateVisibility {#PrivateVisibility4}

Поле | Описание
--- | ---
network_ids[] | **string**<br>Идентификаторы сетей. Количество элементов должно находиться в диапазоне от 0 до 10. Длина строки в символах должна быть равна 20.


### PublicVisibility {#PublicVisibility4}



### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateDnsZoneMetadata](#UpdateDnsZoneMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DnsZone](#DnsZone3)>**<br>в случае успешного выполнения операции. 


### UpdateDnsZoneMetadata {#UpdateDnsZoneMetadata}

Поле | Описание
--- | ---
dns_zone_id | **string**<br>Идентификатор обновляемой зоны DNS. 


### DnsZone {#DnsZone3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор зоны DNS. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит зона DNS. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя зоны DNS. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание зоны DNS. 
labels | **map<string,string>**<br>Метки зон DNS в формате `key:value`. 
zone | **string**<br>Суффикс зоны DNS. 
private_visibility | **[PrivateVisibility](#PrivateVisibility5)**<br>Настройки внутренней зоны. Указывают, будут ли записи в зоне видны только из сетей VPC. 
public_visibility | **[PublicVisibility](#PublicVisibility5)**<br>Настройки публичной зоны. Указывают, являются ли записи в пределах зоны публичными. 


### PrivateVisibility {#PrivateVisibility5}

Поле | Описание
--- | ---
network_ids[] | **string**<br>Идентификаторы сетей. Количество элементов должно находиться в диапазоне от 0 до 10. Длина строки в символах должна быть равна 20.


### PublicVisibility {#PublicVisibility5}



## Delete {#Delete}

Удаляет указанную зону DNS.

**rpc Delete ([DeleteDnsZoneRequest](#DeleteDnsZoneRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDnsZoneMetadata](#DeleteDnsZoneMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDnsZoneRequest {#DeleteDnsZoneRequest}

Поле | Описание
--- | ---
dns_zone_id | **string**<br>Идентификатор удаляемой зоны DNS. <br>Чтобы получить идентификатор зоны DNS, выполните запрос [DnsZoneService.List](#List). Длина строки в символах должна быть равна 20.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDnsZoneMetadata](#DeleteDnsZoneMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteDnsZoneMetadata {#DeleteDnsZoneMetadata}

Поле | Описание
--- | ---
dns_zone_id | **string**<br>Идентификатор удаляемой зоны DNS. 


## GetRecordSet {#GetRecordSet}

Возвращает указанный набор записей.

**rpc GetRecordSet ([GetDnsZoneRecordSetRequest](#GetDnsZoneRecordSetRequest)) returns ([RecordSet](#RecordSet))**

### GetDnsZoneRecordSetRequest {#GetDnsZoneRecordSetRequest}

Поле | Описание
--- | ---
dns_zone_id | **string**<br>Идентификатор зоны DNS для получения набора записей. <br>Чтобы получить идентификатор зоны DNS, выполните запрос [DnsZoneService.List](#List). Длина строки в символах должна быть равна 20.
name | **string**<br>Обязательное поле. Имя набора записей. Максимальная длина строки в символах — 255.
type | **string**<br>Обязательное поле. Тип набора записей. Максимальная длина строки в символах — 10.


### RecordSet {#RecordSet}

Поле | Описание
--- | ---
name | **string**<br>Доменное имя. Длина строки в символах должна быть от 1 до 254.
type | **string**<br>Тип записи. Длина строки в символах должна быть от 1 до 20.
ttl | **int64**<br>Время жизни записи в секундах. Допустимые значения — от 0 до 2147483647 включительно.
data[] | **string**<br>Значение набора записей. Количество элементов должно находиться в диапазоне от 1 до 100. Длина строки в символах для каждого значения должна быть от 1 до 255.


## ListRecordSets {#ListRecordSets}

Возвращает список наборов записей в указанном каталоге.

**rpc ListRecordSets ([ListDnsZoneRecordSetsRequest](#ListDnsZoneRecordSetsRequest)) returns ([ListDnsZoneRecordSetsResponse](#ListDnsZoneRecordSetsResponse))**

### ListDnsZoneRecordSetsRequest {#ListDnsZoneRecordSetsRequest}

Поле | Описание
--- | ---
dns_zone_id | **string**<br>Идентификатор зоны DNS для получения списка наборов записей. <br>Чтобы получить идентификатор зоны DNS, выполните запрос [DnsZoneService.List](#List). Длина строки в символах должна быть равна 20.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListDnsZoneRecordSetsResponse.next_page_token](#ListDnsZoneRecordSetsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListDnsZoneRecordSetsResponse.next_page_token](#ListDnsZoneRecordSetsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 1000.
filter | **string**<br><ol><li>Имя поля. В настоящее время вы можете использовать фильтрацию только для полей [RecordSet.name](#RecordSet1) и [RecordSet.type](#RecordSet1) . </li><li>Оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. </li><li>Значение или списки значений. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Пример фильтра: `name=my-record-set`.</li></ol> Максимальная длина строки в символах — 1000.


### ListDnsZoneRecordSetsResponse {#ListDnsZoneRecordSetsResponse}

Поле | Описание
--- | ---
record_sets[] | **[RecordSet](#RecordSet1)**<br>Список наборов записей в указанной зоне DNS. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListDnsZoneRecordSetsRequest.page_size](#ListDnsZoneRecordSetsRequest), используйте `next_page_token` в качестве значения параметра [ListDnsZoneRecordSetsRequest.page_token](#ListDnsZoneRecordSetsRequest) в следующем запросе списка ресурсов. <br>Каждая следующая страница будет иметь свой `next_page_token` для продолжения перебора страниц результатов. 


### RecordSet {#RecordSet1}

Поле | Описание
--- | ---
name | **string**<br>Доменное имя. Длина строки в символах должна быть от 1 до 254.
type | **string**<br>Тип записи. Длина строки в символах должна быть от 1 до 20.
ttl | **int64**<br>Время жизни записи в секундах. Допустимые значения — от 0 до 2147483647 включительно.
data[] | **string**<br>Значение набора записей. Количество элементов должно находиться в диапазоне от 1 до 100. Длина строки в символах для каждого значения должна быть от 1 до 255.


## UpdateRecordSets {#UpdateRecordSets}

<ol><li>Удаленная запись не найдена. </li><li>Найдена запись с совпадающим типом и именем, но другим TTL или значением. </li><li>Предпринята попытка добавить запись с существующим именем и типом. Сначала происходит удаление. Если запись с одинаковым именем и типом существует в обоих списках, то существующая запись будет удалена, а новая добавлена.</li></ol>

**rpc UpdateRecordSets ([UpdateRecordSetsRequest](#UpdateRecordSetsRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateRecordSetsMetadata](#UpdateRecordSetsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateRecordSetsRequest {#UpdateRecordSetsRequest}

Поле | Описание
--- | ---
dns_zone_id | **string**<br>Идентификатор зоны DNS, в которой требуется обновить набор записей. <br>Чтобы получить идентификатор зоны DNS, выполните запрос [DnsZoneService.List](#List). Длина строки в символах должна быть равна 20.
deletions[] | **[RecordSet](#RecordSet2)**<br>Список наборов записей, которые следует удалить. Максимальное количество элементов — 1000.
additions[] | **[RecordSet](#RecordSet2)**<br>Список наборов записей, которые следует добавить. Максимальное количество элементов — 1000.


### RecordSet {#RecordSet2}

Поле | Описание
--- | ---
name | **string**<br>Доменное имя. Длина строки в символах должна быть от 1 до 254.
type | **string**<br>Тип записи. Длина строки в символах должна быть от 1 до 20.
ttl | **int64**<br>Время жизни записи в секундах. Допустимые значения — от 0 до 2147483647 включительно.
data[] | **string**<br>Значение набора записей. Количество элементов должно находиться в диапазоне от 1 до 100. Длина строки в символах для каждого значения должна быть от 1 до 255.


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateRecordSetsMetadata](#UpdateRecordSetsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### UpdateRecordSetsMetadata {#UpdateRecordSetsMetadata}



## UpsertRecordSets {#UpsertRecordSets}

Метод без строгого контроля за изменением состояния зоны. Если удаленная запись не существует, ничего не происходит. Удаляет записи, соответствующие всем указанным полям, что позволяет удалять только указанные записи из набора записей.

**rpc UpsertRecordSets ([UpsertRecordSetsRequest](#UpsertRecordSetsRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpsertRecordSetsMetadata](#UpsertRecordSetsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpsertRecordSetsRequest {#UpsertRecordSetsRequest}

Поле | Описание
--- | ---
dns_zone_id | **string**<br>Идентификатор зоны DNS, в которую нужно добавить новую запись или обновить существующую. <br>Чтобы получить идентификатор зоны DNS, выполните запрос [DnsZoneService.List](#List). Длина строки в символах должна быть равна 20.
deletions[] | **[RecordSet](#RecordSet3)**<br>Удаление только указанных записей из соответствующих наборов записей. Максимальное количество элементов — 1000.
replacements[] | **[RecordSet](#RecordSet3)**<br>Полная замена указанных наборов записей. Максимальное количество элементов — 1000.
merges[] | **[RecordSet](#RecordSet3)**<br>Замена указанных записей или добавление новых, если указанных наборов записей не существует. Максимальное количество элементов — 1000.


### RecordSet {#RecordSet3}

Поле | Описание
--- | ---
name | **string**<br>Доменное имя. Длина строки в символах должна быть от 1 до 254.
type | **string**<br>Тип записи. Длина строки в символах должна быть от 1 до 20.
ttl | **int64**<br>Время жизни записи в секундах. Допустимые значения — от 0 до 2147483647 включительно.
data[] | **string**<br>Значение набора записей. Количество элементов должно находиться в диапазоне от 1 до 100. Длина строки в символах для каждого значения должна быть от 1 до 255.


### Operation {#Operation4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpsertRecordSetsMetadata](#UpsertRecordSetsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### UpsertRecordSetsMetadata {#UpsertRecordSetsMetadata}



## ListOperations {#ListOperations}

Возвращает список операций для указанной зоны DNS.

**rpc ListOperations ([ListDnsZoneOperationsRequest](#ListDnsZoneOperationsRequest)) returns ([ListDnsZoneOperationsResponse](#ListDnsZoneOperationsResponse))**

### ListDnsZoneOperationsRequest {#ListDnsZoneOperationsRequest}

Поле | Описание
--- | ---
dns_zone_id | **string**<br>Идентификатор зоны DNS, для которой запрашивается список операций. <br>Чтобы получить идентификатор зоны DNS, выполните запрос [DnsZoneService.List](#List). Длина строки в символах должна быть равна 20.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListDnsZoneOperationsResponse.next_page_token](#ListDnsZoneOperationsResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListDnsZoneOperationsResponse.next_page_token](#ListDnsZoneOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 1000.
filter | **string**<br><ol><li>Имя поля. Фильтрация осуществляется только по полю [DnsZone.name](#DnsZone4). </li><li>Оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. </li><li>Значение или списки значений. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Пример фильтра: `name=my-dns-zone`.</li></ol> Максимальная длина строки в символах — 1000.


### ListDnsZoneOperationsResponse {#ListDnsZoneOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>Список операций для указанной зоны DNS. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListDnsZoneOperationsRequest.page_size](#ListDnsZoneOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListDnsZoneOperationsRequest.page_token](#ListDnsZoneOperationsRequest) в следующем запросе списка ресурсов. <br>Каждая следующая страница будет иметь свой `next_page_token` для продолжения перебора страниц результатов. 


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


## ListAccessBindings {#ListAccessBindings}

Возвращает список привязок прав доступа для указанной зоны DNS.

**rpc ListAccessBindings ([ListAccessBindingsRequest](#ListAccessBindingsRequest)) returns ([ListAccessBindingsResponse](#ListAccessBindingsResponse))**

### ListAccessBindingsRequest {#ListAccessBindingsRequest}

Поле | Описание
--- | ---
resource_id | **string**<br>Обязательное поле. Идентификатор ресурса, для которого запрашивается список привязок прав доступа. <br>Чтобы получить идентификатор ресурса, используйте соответствующий запрос List. Например, используйте запрос [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/cloud_service#List) для получения идентификатора ресурса Cloud. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size`, сервис вернет значение [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListAccessBindingsResponse {#ListAccessBindingsResponse}

Поле | Описание
--- | ---
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Список привязок прав доступа для указанного ресурса. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListAccessBindingsRequest.page_size](#ListAccessBindingsRequest), используйте `next_page_token` в качестве значения параметра [ListAccessBindingsRequest.page_token](#ListAccessBindingsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### AccessBinding {#AccessBinding}

Поле | Описание
--- | ---
role_id | **string**<br>Обязательное поле. Идентификатор ресурса `yandex.cloud.iam.v1.Role` который назначен для субъекта, указанного в параметре `subject`. Максимальная длина строки в символах — 50.
subject | **[Subject](#Subject)**<br>Обязательное поле. Субъект, для которого создается привязка прав доступа. Может представлять собой аккаунт с уникальным идентификатором в облаке или системную группу с общим системным идентификатором. 


### Subject {#Subject}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. <ul><li>`allAuthenticatedUsers`: Специальный системный идентификатор, представляющий любого пользователя, прошедшего аутентификацию. Его можно использовать только если в параметре `type` указано `system`. </li><li>`allUsers`: Специальный системный идентификатор, представляющий любого пользователя. Аутентификация не требуется. Например, при запросе через API не надо будет указывать IAM-токен. </li><li>`<идентификатор пользователя в облаке>`: Идентификатор, представляющий учетную запись пользователя. Его можно использовать только если в параметре `type` передано одно из следующих значений: `userAccount`, `federatedUser` или `serviceAccount`.</li></ul> Максимальная длина строки в символах — 50.
type | **string**<br>Обязательное поле. <ul><li>`userAccount` — аккаунт на Яндексе или Яндекс.Коннекте, добавленный в Яндекс.Облако. </li><li>`serviceAccount` — сервисный аккаунт. Этот тип представляет ресурс `yandex.cloud.iam.v1.ServiceAccount`. </li><li>`federatedUser` — федеративный аккаунт. Этот тип представляет пользователя из федерации удостоверений, например Active Directory. </li><li>`system` — системная группа. Представляет набор аккаунтов, который описывается общим системным идентификатором. </li></ul> Максимальная длина строки в символах — 100.


## SetAccessBindings {#SetAccessBindings}

Задает список привязок прав доступа для указанной зоны DNS.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation6))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### SetAccessBindingsRequest {#SetAccessBindingsRequest}

Поле | Описание
--- | ---
resource_id | **string**<br>Обязательное поле. Идентификатор ресурса, для которого задается список привязок прав доступа. <br>Чтобы получить идентификатор ресурса, используйте соответствующий запрос List. Максимальная длина строки в символах — 50.
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Обязательное поле. Привязки прав доступа, которые будут установлены. Дополнительные сведения см. в разделе [Привязка прав доступа](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding1}

Поле | Описание
--- | ---
role_id | **string**<br>Обязательное поле. Идентификатор ресурса `yandex.cloud.iam.v1.Role` который назначен для субъекта, указанного в параметре `subject`. Максимальная длина строки в символах — 50.
subject | **[Subject](#Subject)**<br>Обязательное поле. Субъект, для которого создается привязка прав доступа. Может представлять собой аккаунт с уникальным идентификатором в облаке или системную группу с общим системным идентификатором. 


### Subject {#Subject1}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. <ul><li>`allAuthenticatedUsers`: Специальный системный идентификатор, представляющий любого пользователя, прошедшего аутентификацию. Его можно использовать только если в параметре `type` указано `system`. </li><li>`allUsers`: Специальный системный идентификатор, представляющий любого пользователя. Аутентификация не требуется. Например, при запросе через API не надо будет указывать IAM-токен. </li><li>`<идентификатор пользователя в облаке>`: Идентификатор, представляющий учетную запись пользователя. Его можно использовать только если в параметре `type` передано одно из следующих значений: `userAccount`, `federatedUser` или `serviceAccount`.</li></ul> Максимальная длина строки в символах — 50.
type | **string**<br>Обязательное поле. <ul><li>`userAccount` — аккаунт на Яндексе или Яндекс.Коннекте, добавленный в Яндекс.Облако. </li><li>`serviceAccount` — сервисный аккаунт. Этот тип представляет ресурс `yandex.cloud.iam.v1.ServiceAccount`. </li><li>`federatedUser` — федеративный аккаунт. Этот тип представляет пользователя из федерации удостоверений, например Active Directory. </li><li>`system` — системная группа. Представляет набор аккаунтов, который описывается общим системным идентификатором. </li></ul> Максимальная длина строки в символах — 100.


### Operation {#Operation6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### SetAccessBindingsMetadata {#SetAccessBindingsMetadata}

Поле | Описание
--- | ---
resource_id | **string**<br>Идентификатор ресурса, для которого задается список привязок прав доступа. 


## UpdateAccessBindings {#UpdateAccessBindings}

Обновляет привязки прав доступа для указанной зоны DNS.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation7))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateAccessBindingsRequest {#UpdateAccessBindingsRequest}

Поле | Описание
--- | ---
resource_id | **string**<br>Обязательное поле. Идентификатор ресурса, для которого обновляется список привязок прав доступа. Максимальная длина строки в символах — 50.
access_binding_deltas[] | **[AccessBindingDelta](#AccessBindingDelta)**<br>Обязательное поле. Изменения в список привязок прав доступа. Количество элементов должно быть больше 0.


### AccessBindingDelta {#AccessBindingDelta}

Поле | Описание
--- | ---
action | enum **AccessBindingAction**<br>Обязательное поле. Действие, которое надо выполнить с привязкой прав доступа. <ul><li>`ADD`: Добавление новой привязки прав доступа.</li><li>`REMOVE`: Удаление привязки прав доступа.</li><ul/>
access_binding | **[AccessBinding](#AccessBinding)**<br>Обязательное поле. Привязка прав доступа. Дополнительные сведения см. в разделе [Привязка прав доступа](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding2}

Поле | Описание
--- | ---
role_id | **string**<br>Обязательное поле. Идентификатор ресурса `yandex.cloud.iam.v1.Role` который назначен для субъекта, указанного в параметре `subject`. Максимальная длина строки в символах — 50.
subject | **[Subject](#Subject)**<br>Обязательное поле. Субъект, для которого создается привязка прав доступа. Может представлять собой аккаунт с уникальным идентификатором в облаке или системную группу с общим системным идентификатором. 


### Subject {#Subject2}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. <ul><li>`allAuthenticatedUsers`: Специальный системный идентификатор, представляющий любого пользователя, прошедшего аутентификацию. Его можно использовать только если в параметре `type` указано `system`. </li><li>`allUsers`: Специальный системный идентификатор, представляющий любого пользователя. Аутентификация не требуется. Например, при запросе через API не надо будет указывать IAM-токен. </li><li>`<идентификатор пользователя в облаке>`: Идентификатор, представляющий учетную запись пользователя. Его можно использовать только если в параметре `type` передано одно из следующих значений: `userAccount`, `federatedUser` или `serviceAccount`.</li></ul> Максимальная длина строки в символах — 50.
type | **string**<br>Обязательное поле. <ul><li>`userAccount` — аккаунт на Яндексе или Яндекс.Коннекте, добавленный в Яндекс.Облако. </li><li>`serviceAccount` — сервисный аккаунт. Этот тип представляет ресурс `yandex.cloud.iam.v1.ServiceAccount`. </li><li>`federatedUser` — федеративный аккаунт. Этот тип представляет пользователя из федерации удостоверений, например Active Directory. </li><li>`system` — системная группа. Представляет набор аккаунтов, который описывается общим системным идентификатором. </li></ul> Максимальная длина строки в символах — 100.


### Operation {#Operation7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### UpdateAccessBindingsMetadata {#UpdateAccessBindingsMetadata}

Поле | Описание
--- | ---
resource_id | **string**<br>Идентификатор ресурса, для которого обновляется список привязок прав доступа. 


