---
editable: false
---

# DeviceService

Набор методов для управления устройствами.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанное устройство. |
| [List](#List) | Возвращает список устройств в указанном реестре. |
| [Create](#Create) | Создает устройство в указанном реестре. |
| [Update](#Update) | Обновляет указанное устройство. |
| [Delete](#Delete) | Удаляет указанное устройство. |
| [ListCertificates](#ListCertificates) | Возвращает список сертификатов для указанного устройства. |
| [AddCertificate](#AddCertificate) | Добавляет сертификат. |
| [DeleteCertificate](#DeleteCertificate) | Удаляет указанное устройство. |
| [ListPasswords](#ListPasswords) | Возвращает список паролей для указанного устройства. |
| [AddPassword](#AddPassword) | Добавляет пароль для указанного устройства. |
| [DeletePassword](#DeletePassword) | Удаляет указанный пароль. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанного устройства. |

## Вызовы DeviceService {#calls}

## Get {#Get}

Возвращает указанное устройство. <br>Чтобы получить список доступных устройств, используйте запрос [List](#List).

**rpc Get ([GetDeviceRequest](#GetDeviceRequest)) returns ([Device](#Device))**

### GetDeviceRequest {#GetDeviceRequest}

Поле | Описание
--- | ---
device_id | **string**<br>Обязательное поле. Идентификатор возвращаемого устройства. <br>Для получения идентификатора устройства используйте запрос [DeviceService.List](#List). Максимальная длина строки в символах — 50.


### Device {#Device}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор устройства. 
registry_id | **string**<br>Идентификатор реестра, к которому принадлежит устройство. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя устройства. Имя является уникальным в рамках реестра. 
description | **string**<br>Описание устройства. Длина описания должна быть от 0 до 256 символов. 
topic_aliases | **map<string,string>**<br>Алиас топика устройства. <br>Алиас — это альтернативное имя топика устройства, назначенное пользователем. Алиас сопоставляется со стандартным топиком, например `my/custom/alias` эквивалентен `$device/abcdef/events`. 


## List {#List}

Возвращает список устройств в указанном реестре.

**rpc List ([ListDevicesRequest](#ListDevicesRequest)) returns ([ListDevicesResponse](#ListDevicesResponse))**

### ListDevicesRequest {#ListDevicesRequest}

Поле | Описание
--- | ---
id | **oneof:** `registry_id` или `folder_id`<br>
&nbsp;&nbsp;registry_id | **string**<br>Идентификатор реестра для получения списка устройств. <br>Чтобы получить идентификатор реестра, используйте запрос [yandex.cloud.iot.devices.v1.RegistryService.List](/docs/iot-core/api-ref/grpc/registry_service#List). Максимальная длина строки в символах — 50.
&nbsp;&nbsp;folder_id | **string**<br>Идентификатор каталога для получения списка устройств. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListDevicesResponse.next_page_token](#ListDevicesResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListDevicesResponse.next_page_token](#ListDevicesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListDevicesResponse {#ListDevicesResponse}

Поле | Описание
--- | ---
devices[] | **[Device](#Device1)**<br>Список устройств. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListDevicesRequest.page_size](#ListDevicesRequest), используйте `next_page_token` в качестве значения параметра [ListDevicesRequest.page_token](#ListDevicesRequest) в следующем запросе списка ресурсов. <br>Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Device {#Device1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор устройства. 
registry_id | **string**<br>Идентификатор реестра, к которому принадлежит устройство. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя устройства. Имя является уникальным в рамках реестра. 
description | **string**<br>Описание устройства. Длина описания должна быть от 0 до 256 символов. 
topic_aliases | **map<string,string>**<br>Алиас топика устройства. <br>Алиас — это альтернативное имя топика устройства, назначенное пользователем. Алиас сопоставляется со стандартным топиком, например `my/custom/alias` эквивалентен `$device/abcdef/events`. 


## Create {#Create}

Создает устройство в указанном реестре.

**rpc Create ([CreateDeviceRequest](#CreateDeviceRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDeviceMetadata](#CreateDeviceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Device](#Device2)<br>

### CreateDeviceRequest {#CreateDeviceRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра, в котором создается устройство. <br>Чтобы получить идентификатор реестра, используйте запрос [yandex.cloud.iot.devices.v1.RegistryService.List](/docs/iot-core/api-ref/grpc/registry_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Обязательное поле. Имя устройства. Имя должно быть уникальным в рамках реестра. Максимальная длина строки в символах — 50. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
description | **string**<br>Описание устройства. Максимальная длина строки в символах — 256.
certificates[] | **[Certificate](#Certificate)**<br>Сертификат устройства. 
topic_aliases | **map<string,string>**<br>Алиас топика устройства. <br>Алиас — это альтернативное имя топика устройства, назначенное пользователем. Алиас сопоставляется со стандартным топиком, например `my/custom/alias` эквивалентен `$device/{id}/events`. 
password | **string**<br>Пароль устройства. <br>Пароль должен содержать не менее трех категорий символов: строчные латинские буквы, прописные латинские буквы, цифры, специальные символы. 


### Certificate {#Certificate}

Поле | Описание
--- | ---
certificate_data | **string**<br>Публичная часть сертификата устройства. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateDeviceMetadata](#CreateDeviceMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Device](#Device2)>**<br>в случае успешного выполнения операции. 


### CreateDeviceMetadata {#CreateDeviceMetadata}

Поле | Описание
--- | ---
device_id | **string**<br>Идентификатор создаваемого диска. 


### Device {#Device2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор устройства. 
registry_id | **string**<br>Идентификатор реестра, к которому принадлежит устройство. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя устройства. Имя является уникальным в рамках реестра. 
description | **string**<br>Описание устройства. Длина описания должна быть от 0 до 256 символов. 
topic_aliases | **map<string,string>**<br>Алиас топика устройства. <br>Алиас — это альтернативное имя топика устройства, назначенное пользователем. Алиас сопоставляется со стандартным топиком, например `my/custom/alias` эквивалентен `$device/abcdef/events`. 


## Update {#Update}

Обновляет указанное устройство.

**rpc Update ([UpdateDeviceRequest](#UpdateDeviceRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateDeviceMetadata](#UpdateDeviceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Device](#Device3)<br>

### UpdateDeviceRequest {#UpdateDeviceRequest}

Поле | Описание
--- | ---
device_id | **string**<br>Обязательное поле. Идентификатор устройства для обновления. <br>Для получения идентификатора устройства используйте запрос [DeviceService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля устройства будут обновлены. 
name | **string**<br>Имя устройства. Имя должно быть уникальным в рамках реестра. Максимальная длина строки в символах — 50. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
description | **string**<br>Описание устройства. Максимальная длина строки в символах — 256.
topic_aliases | **map<string,string>**<br>Алиас топика устройства. <br>Алиас — это альтернативное имя топика устройства, назначенное пользователем. Алиас сопоставляется со стандартным топиком, например `my/custom/alias` эквивалентен `$device/{id}/events`. 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateDeviceMetadata](#UpdateDeviceMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Device](#Device3)>**<br>в случае успешного выполнения операции. 


### UpdateDeviceMetadata {#UpdateDeviceMetadata}

Поле | Описание
--- | ---
device_id | **string**<br>Идентификатор обновляемого устройства. 


### Device {#Device3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор устройства. 
registry_id | **string**<br>Идентификатор реестра, к которому принадлежит устройство. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя устройства. Имя является уникальным в рамках реестра. 
description | **string**<br>Описание устройства. Длина описания должна быть от 0 до 256 символов. 
topic_aliases | **map<string,string>**<br>Алиас топика устройства. <br>Алиас — это альтернативное имя топика устройства, назначенное пользователем. Алиас сопоставляется со стандартным топиком, например `my/custom/alias` эквивалентен `$device/abcdef/events`. 


## Delete {#Delete}

Удаляет указанное устройство.

**rpc Delete ([DeleteDeviceRequest](#DeleteDeviceRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDeviceMetadata](#DeleteDeviceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDeviceRequest {#DeleteDeviceRequest}

Поле | Описание
--- | ---
device_id | **string**<br>Обязательное поле. Идентификатор устройства для удаления. <br>Для получения идентификатора устройства используйте запрос [DeviceService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDeviceMetadata](#DeleteDeviceMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteDeviceMetadata {#DeleteDeviceMetadata}

Поле | Описание
--- | ---
device_id | **string**<br>Идентификатор удаляемого диска. 


## ListCertificates {#ListCertificates}

Возвращает список сертификатов для указанного устройства.

**rpc ListCertificates ([ListDeviceCertificatesRequest](#ListDeviceCertificatesRequest)) returns ([ListDeviceCertificatesResponse](#ListDeviceCertificatesResponse))**

### ListDeviceCertificatesRequest {#ListDeviceCertificatesRequest}

Поле | Описание
--- | ---
device_id | **string**<br>Обязательное поле. Идентификатор устройства для получения списка сертификатов. Максимальная длина строки в символах — 50.


### ListDeviceCertificatesResponse {#ListDeviceCertificatesResponse}

Поле | Описание
--- | ---
certificates[] | **[DeviceCertificate](#DeviceCertificate)**<br>Список сертификатов для указанного устройства. 


### DeviceCertificate {#DeviceCertificate}

Поле | Описание
--- | ---
device_id | **string**<br>Идентификатор устройства, которому принадлежит сертификат. 
fingerprint | **string**<br>SHA256-хэш сертификата. 
certificate_data | **string**<br>Публичная часть сертификата устройства. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 


## AddCertificate {#AddCertificate}

Добавляет сертификат.

**rpc AddCertificate ([AddDeviceCertificateRequest](#AddDeviceCertificateRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddDeviceCertificateMetadata](#AddDeviceCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DeviceCertificate](#DeviceCertificate1)<br>

### AddDeviceCertificateRequest {#AddDeviceCertificateRequest}

Поле | Описание
--- | ---
device_id | **string**<br>Обязательное поле. Идентификатор устройства, для которого добавляется сертификат. <br>Для получения идентификатора устройства используйте запрос [DeviceService.List](#List). Максимальная длина строки в символах — 50.
certificate_data | **string**<br>Публичная часть сертификата устройства. 


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddDeviceCertificateMetadata](#AddDeviceCertificateMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeviceCertificate](#DeviceCertificate1)>**<br>в случае успешного выполнения операции. 


### AddDeviceCertificateMetadata {#AddDeviceCertificateMetadata}

Поле | Описание
--- | ---
device_id | **string**<br>Идентификатор добавляемого сертификата устройства. 
fingerprint | **string**<br>Цифровой отпечаток добавляемого сертификата. 


### DeviceCertificate {#DeviceCertificate1}

Поле | Описание
--- | ---
device_id | **string**<br>Идентификатор устройства, которому принадлежит сертификат. 
fingerprint | **string**<br>SHA256-хэш сертификата. 
certificate_data | **string**<br>Публичная часть сертификата устройства. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 


## DeleteCertificate {#DeleteCertificate}

Удаляет указанное устройство.

**rpc DeleteCertificate ([DeleteDeviceCertificateRequest](#DeleteDeviceCertificateRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDeviceCertificateMetadata](#DeleteDeviceCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDeviceCertificateRequest {#DeleteDeviceCertificateRequest}

Поле | Описание
--- | ---
device_id | **string**<br>Обязательное поле. Идентификатор устройства для удаления сертификата. <br>Для получения идентификатора устройства используйте запрос [DeviceService.List](#List). Максимальная длина строки в символах — 50.
fingerprint | **string**<br>Обязательное поле. Цифровой отпечаток сертификата для удаления. Максимальная длина строки в символах — 50.


### Operation {#Operation4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDeviceCertificateMetadata](#DeleteDeviceCertificateMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteDeviceCertificateMetadata {#DeleteDeviceCertificateMetadata}

Поле | Описание
--- | ---
device_id | **string**<br>Обязательное поле. Идентификатор удаляемого сертификата. Максимальная длина строки в символах — 50.
fingerprint | **string**<br>Обязательное поле. Цифровой отпечаток удаляемого сертификата. Максимальная длина строки в символах — 50.


## ListPasswords {#ListPasswords}

Возвращает список паролей для указанного устройства.

**rpc ListPasswords ([ListDevicePasswordsRequest](#ListDevicePasswordsRequest)) returns ([ListDevicePasswordsResponse](#ListDevicePasswordsResponse))**

### ListDevicePasswordsRequest {#ListDevicePasswordsRequest}

Поле | Описание
--- | ---
device_id | **string**<br>Обязательное поле. Идентификатор реестра для получения списка паролей. <br>Чтобы получить идентификатор реестра, используйте запрос [RegistryService.List](./registry_service#List). Максимальная длина строки в символах — 50.


### ListDevicePasswordsResponse {#ListDevicePasswordsResponse}

Поле | Описание
--- | ---
passwords[] | **[DevicePassword](#DevicePassword)**<br>Возвращает список паролей для указанного устройства. 


### DevicePassword {#DevicePassword}

Поле | Описание
--- | ---
device_id | **string**<br>Идентификатор устройства, которому принадлежит пароль. 
id | **string**<br>Идентификатор пароля. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 


## AddPassword {#AddPassword}

Добавляет пароль для указанного устройства.

**rpc AddPassword ([AddDevicePasswordRequest](#AddDevicePasswordRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddDevicePasswordMetadata](#AddDevicePasswordMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DevicePassword](#DevicePassword1)<br>

### AddDevicePasswordRequest {#AddDevicePasswordRequest}

Поле | Описание
--- | ---
device_id | **string**<br>Обязательное поле. Идентификатор устройства для добавления пароля. <br>Для получения идентификатора устройства используйте запрос [DeviceService.List](#List). Максимальная длина строки в символах — 50.
password | **string**<br>Пароли для устройства. <br>Пароль должен содержать не менее трех категорий символов: строчные латинские буквы, прописные латинские буквы, цифры, специальные символы. Минимальная длина строки в символах — 14.


### Operation {#Operation5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddDevicePasswordMetadata](#AddDevicePasswordMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DevicePassword](#DevicePassword1)>**<br>в случае успешного выполнения операции. 


### AddDevicePasswordMetadata {#AddDevicePasswordMetadata}

Поле | Описание
--- | ---
device_id | **string**<br>Идентификатор устройства, для которого добавляется пароль. 
password_id | **string**<br>Идентификатор добавляемого пароля. 


### DevicePassword {#DevicePassword1}

Поле | Описание
--- | ---
device_id | **string**<br>Идентификатор устройства, которому принадлежит пароль. 
id | **string**<br>Идентификатор пароля. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 


## DeletePassword {#DeletePassword}

Удаляет указанный пароль.

**rpc DeletePassword ([DeleteDevicePasswordRequest](#DeleteDevicePasswordRequest)) returns ([operation.Operation](#Operation6))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDevicePasswordMetadata](#DeleteDevicePasswordMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDevicePasswordRequest {#DeleteDevicePasswordRequest}

Поле | Описание
--- | ---
device_id | **string**<br>Обязательное поле. Идентификатор устройства для удаления пароля. <br>Для получения идентификатора устройства используйте запрос [DeviceService.List](#List). Максимальная длина строки в символах — 50.
password_id | **string**<br>Обязательное поле. Идентификатор пароля для удаления. <br>Для получения идентификатора пароля используйте запрос [DeviceService.ListPasswords](#ListPasswords). Максимальная длина строки в символах — 50.


### Operation {#Operation6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDevicePasswordMetadata](#DeleteDevicePasswordMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteDevicePasswordMetadata {#DeleteDevicePasswordMetadata}

Поле | Описание
--- | ---
device_id | **string**<br>Обязательное поле. Идентификатор устройства, для которого добавляется пароль. Максимальная длина строки в символах — 50.
password_id | **string**<br>Обязательное поле. Идентификатор удаляемого пароля. Максимальная длина строки в символах — 50.


## ListOperations {#ListOperations}

Возвращает список операций для указанного устройства.

**rpc ListOperations ([ListDeviceOperationsRequest](#ListDeviceOperationsRequest)) returns ([ListDeviceOperationsResponse](#ListDeviceOperationsResponse))**

### ListDeviceOperationsRequest {#ListDeviceOperationsRequest}

Поле | Описание
--- | ---
device_id | **string**<br>Обязательное поле. Идентификатор устройства для получения списка операций. <br>Для получения идентификатора устройства используйте запрос [DeviceService.List](#List). 
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size`, сервис вернет значение [ListDeviceOperationsResponse.next_page_token](#ListDeviceOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListDeviceOperationsResponse.next_page_token](#ListDeviceOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [Device.name](#Device4). Максимальная длина строки в символах — 1000.


### ListDeviceOperationsResponse {#ListDeviceOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>Список операций для указанного сертификата устройства. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListDeviceOperationsRequest.page_size](#ListDeviceOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListDeviceOperationsRequest.page_token](#ListDeviceOperationsRequest) в следующем запросе списка ресурсов. <br>Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


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


