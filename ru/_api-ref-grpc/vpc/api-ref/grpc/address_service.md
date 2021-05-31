---
editable: false
---

# AddressService

Набор методов для управления адресами.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает информацию об указанном адресе. |
| [GetByValue](#GetByValue) | Возвращает информацию об указанном адресе по его значению. |
| [List](#List) | Возвращает список доступных адресов в указанном каталоге. |
| [Create](#Create) | Создает адрес в указанном каталоге и сети. |
| [Update](#Update) | Обновляет параметры указанного адреса. |
| [Delete](#Delete) | Удаляет указанный адрес. |
| [ListOperations](#ListOperations) | Возвращает список операций указанного адреса. |

## Вызовы AddressService {#calls}

## Get {#Get}

Возвращает информацию об указанном адресе. <br>Чтобы получить список доступных адресов, используйте запрос [List](#List).

**rpc Get ([GetAddressRequest](#GetAddressRequest)) returns ([Address](#Address))**

### GetAddressRequest {#GetAddressRequest}

Поле | Описание
--- | ---
address_id | **string**<br>Обязательное поле. Идентификатор возвращаемого адреса. <br>Чтобы получить идентификатор адреса, используйте запрос [AddressService.List](#List). Максимальная длина строки в символах — 50.


### Address {#Address}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор адреса. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит адрес. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя адреса. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание адреса. 
labels | **map<string,string>**<br>Метки адреса в формате `ключ:значение`. 
address | **oneof:** `external_ipv4_address`<br>Спецификация публичного IPv4-адреса.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address)**<br>Спецификация публичного IPv4-адреса. 
reserved | **bool**<br>Определяет, зарезервирован ли адрес (статический ли он). 
used | **bool**<br>Определяет, используется ли адрес. 


### ExternalIpv4Address {#ExternalIpv4Address}

Поле | Описание
--- | ---
address | **string**<br>Значение адреса. 
zone_id | **string**<br>Зона доступности, из которой будет выделен адрес. 
requirements | **[AddressRequirements](#AddressRequirements)**<br>Параметры выделяемого адреса, например защита от DDoS-атак. 


### AddressRequirements {#AddressRequirements}

Поле | Описание
--- | ---
ddos_protection_provider | **string**<br>Идентификатор провайдера защиты от DDoS-атак. 
outgoing_smtp_capability | **string**<br>Возможность отправки SMTP-трафика. 


## GetByValue {#GetByValue}

Возвращает информацию об указанном адресе по его значению. <br>Чтобы получить список доступных адресов, используйте запрос [List](#List).

**rpc GetByValue ([GetAddressByValueRequest](#GetAddressByValueRequest)) returns ([Address](#Address1))**

### GetAddressByValueRequest {#GetAddressByValueRequest}

Поле | Описание
--- | ---
address | **oneof:** `external_ipv4_address`<br>Спецификация публичного IPv4-адреса.
&nbsp;&nbsp;external_ipv4_address | **string**<br>Спецификация публичного IPv4-адреса. 


### Address {#Address1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор адреса. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит адрес. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя адреса. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание адреса. 
labels | **map<string,string>**<br>Метки адреса в формате `ключ:значение`. 
address | **oneof:** `external_ipv4_address`<br>Спецификация публичного IPv4-адреса.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address1)**<br>Спецификация публичного IPv4-адреса. 
reserved | **bool**<br>Определяет, зарезервирован ли адрес (статический ли он). 
used | **bool**<br>Определяет, используется ли адрес. 


### ExternalIpv4Address {#ExternalIpv4Address1}

Поле | Описание
--- | ---
address | **string**<br>Значение адреса. 
zone_id | **string**<br>Зона доступности, из которой будет выделен адрес. 
requirements | **[AddressRequirements](#AddressRequirements1)**<br>Параметры выделяемого адреса, например защита от DDoS-атак. 


### AddressRequirements {#AddressRequirements1}

Поле | Описание
--- | ---
ddos_protection_provider | **string**<br>Идентификатор провайдера защиты от DDoS-атак. 
outgoing_smtp_capability | **string**<br>Возможность отправки SMTP-трафика. 


## List {#List}

Возвращает список доступных адресов в указанном каталоге.

**rpc List ([ListAddressesRequest](#ListAddressesRequest)) returns ([ListAddressesResponse](#ListAddressesResponse))**

### ListAddressesRequest {#ListAddressesRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, которому принадлежит адрес. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListAddressesResponse.next_page_token](#ListAddressesResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListAddressesResponse.next_page_token](#ListAddressesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Address.name](#Address2). </li><li>Оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol> 


### ListAddressesResponse {#ListAddressesResponse}

Поле | Описание
--- | ---
addresses[] | **[Address](#Address2)**<br>Список адресов. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListAddressesRequest.page_size](#ListAddressesRequest), используйте `next_page_token` в качестве значения параметра [ListAddressesRequest.page_token](#ListAddressesRequest) в следующем запросе списка ресурсов. <br>Каждая следующая страница будет иметь свой `next_page_token` для продолжения перебора страниц результатов. 


### Address {#Address2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор адреса. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит адрес. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя адреса. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание адреса. 
labels | **map<string,string>**<br>Метки адреса в формате `ключ:значение`. 
address | **oneof:** `external_ipv4_address`<br>Спецификация публичного IPv4-адреса.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address2)**<br>Спецификация публичного IPv4-адреса. 
reserved | **bool**<br>Определяет, зарезервирован ли адрес (статический ли он). 
used | **bool**<br>Определяет, используется ли адрес. 


### ExternalIpv4Address {#ExternalIpv4Address2}

Поле | Описание
--- | ---
address | **string**<br>Значение адреса. 
zone_id | **string**<br>Зона доступности, из которой будет выделен адрес. 
requirements | **[AddressRequirements](#AddressRequirements2)**<br>Параметры выделяемого адреса, например защита от DDoS-атак. 


### AddressRequirements {#AddressRequirements2}

Поле | Описание
--- | ---
ddos_protection_provider | **string**<br>Идентификатор провайдера защиты от DDoS-атак. 
outgoing_smtp_capability | **string**<br>Возможность отправки SMTP-трафика. 


## Create {#Create}

Создает адрес в указанном каталоге и сети.

**rpc Create ([CreateAddressRequest](#CreateAddressRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateAddressMetadata](#CreateAddressMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Address](#Address3)<br>

### CreateAddressRequest {#CreateAddressRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается адрес. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Имя адреса. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание адреса. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки адресов в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
address_spec | **oneof:** `external_ipv4_address_spec`<br>Спецификация публичного ipv4-адреса.
&nbsp;&nbsp;external_ipv4_address_spec | **[ExternalIpv4AddressSpec](#ExternalIpv4AddressSpec)**<br>Спецификация публичного ipv4-адреса. 


### ExternalIpv4AddressSpec {#ExternalIpv4AddressSpec}

Поле | Описание
--- | ---
address | **string**<br>Значение адреса. 
zone_id | **string**<br>Зона доступности, из которой будет выделен адрес. 
requirements | **[AddressRequirements](#AddressRequirements3)**<br>Параметры выделяемого адреса, например защита от DDoS-атак. 


### AddressRequirements {#AddressRequirements3}

Поле | Описание
--- | ---
ddos_protection_provider | **string**<br>Идентификатор провайдера защиты от DDoS-атак. 
outgoing_smtp_capability | **string**<br>Возможность отправки SMTP-трафика. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateAddressMetadata](#CreateAddressMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Address](#Address3)>**<br>в случае успешного выполнения операции. 


### CreateAddressMetadata {#CreateAddressMetadata}

Поле | Описание
--- | ---
address_id | **string**<br>Идентификатор создаваемого адреса. 


### Address {#Address3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор адреса. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит адрес. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя адреса. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание адреса. 
labels | **map<string,string>**<br>Метки адреса в формате `ключ:значение`. 
address | **oneof:** `external_ipv4_address`<br>Спецификация публичного IPv4-адреса.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address3)**<br>Спецификация публичного IPv4-адреса. 
reserved | **bool**<br>Определяет, зарезервирован ли адрес (статический ли он). 
used | **bool**<br>Определяет, используется ли адрес. 


### ExternalIpv4Address {#ExternalIpv4Address3}

Поле | Описание
--- | ---
address | **string**<br>Значение адреса. 
zone_id | **string**<br>Зона доступности, из которой будет выделен адрес. 
requirements | **[AddressRequirements](#AddressRequirements4)**<br>Параметры выделяемого адреса, например защита от DDoS-атак. 


### AddressRequirements {#AddressRequirements4}

Поле | Описание
--- | ---
ddos_protection_provider | **string**<br>Идентификатор провайдера защиты от DDoS-атак. 
outgoing_smtp_capability | **string**<br>Возможность отправки SMTP-трафика. 


## Update {#Update}

Обновляет параметры указанного адреса.

**rpc Update ([UpdateAddressRequest](#UpdateAddressRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAddressMetadata](#UpdateAddressMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Address](#Address4)<br>

### UpdateAddressRequest {#UpdateAddressRequest}

Поле | Описание
--- | ---
address_id | **string**<br>Обязательное поле. Идентификатор обновляемого адреса. <br>Для получения идентификатора адреса используйте запрос [AddressService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие атрибуты адреса должны быть обновлены. 
name | **string**<br>Новое имя для адреса. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Новое описание адреса. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br><ol><li>Запросите текущий набор меток с помощью запроса [AddressService.Get](#Get). </li><li>Добавьте или удалите метку в этом наборе. </li><li>Отправьте новый набор в этом поле.</li></ol> Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
reserved | **bool**<br>Определяет, зарезервирован ли адрес (статический ли он). 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAddressMetadata](#UpdateAddressMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Address](#Address4)>**<br>в случае успешного выполнения операции. 


### UpdateAddressMetadata {#UpdateAddressMetadata}

Поле | Описание
--- | ---
address_id | **string**<br>Идентификатор обновляемого адреса. 


### Address {#Address4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор адреса. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит адрес. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя адреса. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание адреса. 
labels | **map<string,string>**<br>Метки адреса в формате `ключ:значение`. 
address | **oneof:** `external_ipv4_address`<br>Спецификация публичного IPv4-адреса.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address4)**<br>Спецификация публичного IPv4-адреса. 
reserved | **bool**<br>Определяет, зарезервирован ли адрес (статический ли он). 
used | **bool**<br>Определяет, используется ли адрес. 


### ExternalIpv4Address {#ExternalIpv4Address4}

Поле | Описание
--- | ---
address | **string**<br>Значение адреса. 
zone_id | **string**<br>Зона доступности, из которой будет выделен адрес. 
requirements | **[AddressRequirements](#AddressRequirements5)**<br>Параметры выделяемого адреса, например защита от DDoS-атак. 


### AddressRequirements {#AddressRequirements5}

Поле | Описание
--- | ---
ddos_protection_provider | **string**<br>Идентификатор провайдера защиты от DDoS-атак. 
outgoing_smtp_capability | **string**<br>Возможность отправки SMTP-трафика. 


## Delete {#Delete}

Удаляет указанный адрес.

**rpc Delete ([DeleteAddressRequest](#DeleteAddressRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteAddressMetadata](#DeleteAddressMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteAddressRequest {#DeleteAddressRequest}

Поле | Описание
--- | ---
address_id | **string**<br>Обязательное поле. Идентификатор адреса, который следует удалить. <br>Чтобы получить идентификатор адреса, используйте запрос [AddressService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteAddressMetadata](#DeleteAddressMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteAddressMetadata {#DeleteAddressMetadata}

Поле | Описание
--- | ---
address_id | **string**<br>Идентификатор удаляемого адреса. 


## ListOperations {#ListOperations}

Возвращает список операций указанного адреса.

**rpc ListOperations ([ListAddressOperationsRequest](#ListAddressOperationsRequest)) returns ([ListAddressOperationsResponse](#ListAddressOperationsResponse))**

### ListAddressOperationsRequest {#ListAddressOperationsRequest}

Поле | Описание
--- | ---
address_id | **string**<br>Обязательное поле. Идентификатор адреса для которого запрашивается список операций. <br>Чтобы получить идентификатор адреса, используйте запрос [AddressService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListAddressOperationsResponse.next_page_token](#ListAddressOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListAddressOperationsResponse.next_page_token](#ListAddressOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListAddressOperationsResponse {#ListAddressOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>Возвращает список операций для указанного адреса. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListAddressOperationsRequest.page_size](#ListAddressOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListAddressOperationsRequest.page_token](#ListAddressOperationsRequest) в следующем запросе списка ресурсов. <br>Каждая следующая страница будет иметь свой `next_page_token` для продолжения перебора страниц результатов. 


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


