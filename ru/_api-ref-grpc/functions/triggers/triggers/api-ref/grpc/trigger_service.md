---
editable: false
---

# TriggerService

Набор методов управления триггерами для бессерверных функций.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный триггер. |
| [List](#List) | Возвращает список триггеров в указанном каталоге. |
| [Create](#Create) | Создает триггер в указанном каталоге. |
| [Update](#Update) | Обновляет указанный триггер. |
| [Delete](#Delete) | Удаляет указанный триггер. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанного триггера. |

## Вызовы TriggerService {#calls}

## Get {#Get}

Возвращает указанный триггер. <br>Чтобы получить список доступных триггеров, используйте запрос [List](#List) .

**rpc Get ([GetTriggerRequest](#GetTriggerRequest)) returns ([Trigger](#Trigger))**

### GetTriggerRequest {#GetTriggerRequest}

Поле | Описание
--- | ---
trigger_id | **string**<br>Обязательное поле. Идентификатор возвращаемого триггера. <br>Чтобы получить идентификатор триггера, используйте запрос [TriggerService.List](#List) . 


### Trigger {#Trigger}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор триггера. Генерируется при создании. 
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается триггер. Максимальная длина строки в символах — 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания триггера. 
name | **string**<br>Имя триггера. Длина строки в символах должна быть от 3 до 63.
description | **string**<br>Описание триггера. Длина строки в символах должна быть от 0 до 256.
labels | **map<string,string>**<br>Метки триггеров в виде пар `key:value` . 
rule | **[Rule](#Rule)**<br>Обязательное поле. Правило активации триггера (всегда соответствует типу триггера). 
status | enum **Status**<br>Состояние триггера <ul><ul/>


### Rule {#Rule}

Поле | Описание
--- | ---
rule | **oneof:** `timer`, `message_queue`, `iot_message`, `object_storage`, `container_registry` или `cloud_logs`<br>
&nbsp;&nbsp;timer | **[Timer](#Timer)**<br>Правило для таймера. 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue)**<br>Правило для триггера очереди сообщений. 
&nbsp;&nbsp;iot_message | **[IoTMessage](#IoTMessage)**<br>Правило для триггера Yandex IoT Core. 
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage)**<br> 
&nbsp;&nbsp;container_registry | **[ContainerRegistry](#ContainerRegistry)**<br> 
&nbsp;&nbsp;cloud_logs | **[CloudLogs](#CloudLogs)**<br> 


### Timer {#Timer}

Поле | Описание
--- | ---
cron_expression | **string**<br>Обязательное поле. Описание расписания в виде [cron expression](/docs/functions/concepts/trigger/timer). Максимальная длина строки в символах — 100.
action | **oneof:** `invoke_function` или `invoke_function_with_retry`<br>Действие, которое будет выполнено, когда текущее время совпадает с `cron_expression`.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Инструкции для единичного вызова функции. 
&nbsp;&nbsp;invoke_function_with_retry | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Действие, которое будет выполнено, когда текущее время совпадает с `cron_expression`. 


### MessageQueue {#MessageQueue}

Поле | Описание
--- | ---
queue_id | **string**<br>Обязательное поле. Идентификатор очереди сообщений в Yandex Message Queue. 
service_account_id | **string**<br>Обязательное поле. Идентификатор сервисного аккаунта с ролью на чтение очереди сообщений. Максимальная длина строки в символах — 50.
batch_settings | **[BatchSettings](#BatchSettings)**<br>Обязательное поле. Настройки группы сообщений для обработки сообщений в очереди. 
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Переопределение таймаута видимости очереди. Максимальное значение — 12h.
action | **oneof:** `invoke_function`<br>Действие, которое будет выполнено, когда в очереди появится новое сообщение.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Инструкции для единичного вызова функции. 


### IoTMessage {#IoTMessage}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра Yandex IoT Core. 
device_id | **string**<br>Идентификатор устройства в реестре Yandex IoT. 
mqtt_topic | **string**<br>MQTT-топик, сообщения котрого активируют триггер. 
action | **oneof:** `invoke_function`<br>Действие, которое будет выполнено, когда в MQTT-топике появится новое сообщение.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Инструкции для вызова функции с повторными попытками по мере необходимости. 


### ObjectStorage {#ObjectStorage}

Поле | Описание
--- | ---
event_type[] | **ObjectStorageEventType**<br>Тип (имя) событий, требуется хотя бы одно значение. Количество элементов должно быть больше 0.
bucket_id | **string**<br>Идентификатор бакета. 
prefix | **string**<br>Префикс ключа объекта. Фильтр, опционально. 
suffix | **string**<br>Суффикс ключа объекта. Фильтр, опционально. 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


### ContainerRegistry {#ContainerRegistry}

Поле | Описание
--- | ---
event_type[] | **ContainerRegistryEventType**<br>Тип (имя) событий, требуется хотя бы одно значение. Количество элементов должно быть больше 0.
registry_id | **string**<br>Идентификатор реестра. 
image_name | **string**<br>Имя Docker-образа. Фильтр, опционально. 
tag | **string**<br>Тег Docker-образа. Фильтр, опционально. 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


### CloudLogs {#CloudLogs}

Поле | Описание
--- | ---
log_group_id[] | **string**<br>Идентификаторы групп журналов, по крайней мере, одно значение обязательно. 
batch_settings | **[CloudLogsBatchSettings](#CloudLogsBatchSettings)**<br>Обязательное поле. Пакетные настройки для обработки событий журнала. 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


## List {#List}

Возвращает список триггеров в указанном каталоге.

**rpc List ([ListTriggersRequest](#ListTriggersRequest)) returns ([ListTriggersResponse](#ListTriggersResponse))**

### ListTriggersRequest {#ListTriggersRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка триггеров. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `pageSize`, сервис вернет значение [ListTriggersResponse.next_page_token](#ListTriggersResponse), которое можно использовать для получения следующей страницы. <br>Значение по умолчанию: 100. 
page_token | **string**<br>Токен страницы. Установите значение `pageToken` равным значению поля [ListTriggersResponse.next_page_token](#ListTriggersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. 
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Trigger.name](#Trigger1). </li><li>Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Пример фильтра: `name=my-trigger`.</li></ol> 


### ListTriggersResponse {#ListTriggersResponse}

Поле | Описание
--- | ---
triggers[] | **[Trigger](#Trigger1)**<br>Возвращает список триггеров в указанном каталоге. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListTriggersRequest.page_size](#ListTriggersRequest), используйте `nextPageToken` в качестве значения параметра [ListTriggersRequest.page_token](#ListTriggersRequest) в следующем запросе списка ресурсов. <br>Все последующие запросы будут получать свои значения `nextPageToken` для перебора страниц результатов. 


### Trigger {#Trigger1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор триггера. Генерируется при создании. 
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается триггер. Максимальная длина строки в символах — 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания триггера. 
name | **string**<br>Имя триггера. Длина строки в символах должна быть от 3 до 63.
description | **string**<br>Описание триггера. Длина строки в символах должна быть от 0 до 256.
labels | **map<string,string>**<br>Метки триггеров в виде пар `key:value` . 
rule | **[Rule](#Rule1)**<br>Обязательное поле. Правило активации триггера (всегда соответствует типу триггера). 
status | enum **Status**<br>Состояние триггера <ul><ul/>


### Rule {#Rule1}

Поле | Описание
--- | ---
rule | **oneof:** `timer`, `message_queue`, `iot_message`, `object_storage`, `container_registry` или `cloud_logs`<br>
&nbsp;&nbsp;timer | **[Timer](#Timer1)**<br>Правило для таймера. 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue1)**<br>Правило для триггера очереди сообщений. 
&nbsp;&nbsp;iot_message | **[IoTMessage](#IoTMessage1)**<br>Правило для триггера Yandex IoT Core. 
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage1)**<br> 
&nbsp;&nbsp;container_registry | **[ContainerRegistry](#ContainerRegistry1)**<br> 
&nbsp;&nbsp;cloud_logs | **[CloudLogs](#CloudLogs1)**<br> 


### Timer {#Timer1}

Поле | Описание
--- | ---
cron_expression | **string**<br>Обязательное поле. Описание расписания в виде [cron expression](/docs/functions/concepts/trigger/timer). Максимальная длина строки в символах — 100.
action | **oneof:** `invoke_function` или `invoke_function_with_retry`<br>Действие, которое будет выполнено, когда текущее время совпадает с `cron_expression`.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Инструкции для единичного вызова функции. 
&nbsp;&nbsp;invoke_function_with_retry | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Действие, которое будет выполнено, когда текущее время совпадает с `cron_expression`. 


### MessageQueue {#MessageQueue1}

Поле | Описание
--- | ---
queue_id | **string**<br>Обязательное поле. Идентификатор очереди сообщений в Yandex Message Queue. 
service_account_id | **string**<br>Обязательное поле. Идентификатор сервисного аккаунта с ролью на чтение очереди сообщений. Максимальная длина строки в символах — 50.
batch_settings | **[BatchSettings](#BatchSettings)**<br>Обязательное поле. Настройки группы сообщений для обработки сообщений в очереди. 
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Переопределение таймаута видимости очереди. Максимальное значение — 12h.
action | **oneof:** `invoke_function`<br>Действие, которое будет выполнено, когда в очереди появится новое сообщение.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Инструкции для единичного вызова функции. 


### IoTMessage {#IoTMessage1}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра Yandex IoT Core. 
device_id | **string**<br>Идентификатор устройства в реестре Yandex IoT. 
mqtt_topic | **string**<br>MQTT-топик, сообщения котрого активируют триггер. 
action | **oneof:** `invoke_function`<br>Действие, которое будет выполнено, когда в MQTT-топике появится новое сообщение.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Инструкции для вызова функции с повторными попытками по мере необходимости. 


### ObjectStorage {#ObjectStorage1}

Поле | Описание
--- | ---
event_type[] | **ObjectStorageEventType**<br>Тип (имя) событий, требуется хотя бы одно значение. Количество элементов должно быть больше 0.
bucket_id | **string**<br>Идентификатор бакета. 
prefix | **string**<br>Префикс ключа объекта. Фильтр, опционально. 
suffix | **string**<br>Суффикс ключа объекта. Фильтр, опционально. 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


### ContainerRegistry {#ContainerRegistry1}

Поле | Описание
--- | ---
event_type[] | **ContainerRegistryEventType**<br>Тип (имя) событий, требуется хотя бы одно значение. Количество элементов должно быть больше 0.
registry_id | **string**<br>Идентификатор реестра. 
image_name | **string**<br>Имя Docker-образа. Фильтр, опционально. 
tag | **string**<br>Тег Docker-образа. Фильтр, опционально. 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


### CloudLogs {#CloudLogs1}

Поле | Описание
--- | ---
log_group_id[] | **string**<br>Идентификаторы групп журналов, по крайней мере, одно значение обязательно. 
batch_settings | **[CloudLogsBatchSettings](#CloudLogsBatchSettings)**<br>Обязательное поле. Пакетные настройки для обработки событий журнала. 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


## Create {#Create}

Создает триггер в указанном каталоге.

**rpc Create ([CreateTriggerRequest](#CreateTriggerRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTriggerMetadata](#CreateTriggerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Trigger](#Trigger2)<br>

### CreateTriggerRequest {#CreateTriggerRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается триггер. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
name | **string**<br>Имя триггера. Имя должно быть уникальным в рамках каталога. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание триггера. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
rule | **[Trigger.Rule](#Trigger2)**<br>Обязательное поле. Тип триггера. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateTriggerMetadata](#CreateTriggerMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Trigger](#Trigger2)>**<br>в случае успешного выполнения операции. 


### CreateTriggerMetadata {#CreateTriggerMetadata}

Поле | Описание
--- | ---
trigger_id | **string**<br>Идентификатор создаваемого триггера. 


### Trigger {#Trigger2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор триггера. Генерируется при создании. 
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается триггер. Максимальная длина строки в символах — 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания триггера. 
name | **string**<br>Имя триггера. Длина строки в символах должна быть от 3 до 63.
description | **string**<br>Описание триггера. Длина строки в символах должна быть от 0 до 256.
labels | **map<string,string>**<br>Метки триггеров в виде пар `key:value` . 
rule | **[Rule](#Rule2)**<br>Обязательное поле. Правило активации триггера (всегда соответствует типу триггера). 
status | enum **Status**<br>Состояние триггера <ul><ul/>


### Rule {#Rule2}

Поле | Описание
--- | ---
rule | **oneof:** `timer`, `message_queue`, `iot_message`, `object_storage`, `container_registry` или `cloud_logs`<br>
&nbsp;&nbsp;timer | **[Timer](#Timer2)**<br>Правило для таймера. 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue2)**<br>Правило для триггера очереди сообщений. 
&nbsp;&nbsp;iot_message | **[IoTMessage](#IoTMessage2)**<br>Правило для триггера Yandex IoT Core. 
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage2)**<br> 
&nbsp;&nbsp;container_registry | **[ContainerRegistry](#ContainerRegistry2)**<br> 
&nbsp;&nbsp;cloud_logs | **[CloudLogs](#CloudLogs2)**<br> 


### Timer {#Timer2}

Поле | Описание
--- | ---
cron_expression | **string**<br>Обязательное поле. Описание расписания в виде [cron expression](/docs/functions/concepts/trigger/timer). Максимальная длина строки в символах — 100.
action | **oneof:** `invoke_function` или `invoke_function_with_retry`<br>Действие, которое будет выполнено, когда текущее время совпадает с `cron_expression`.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Инструкции для единичного вызова функции. 
&nbsp;&nbsp;invoke_function_with_retry | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Действие, которое будет выполнено, когда текущее время совпадает с `cron_expression`. 


### MessageQueue {#MessageQueue2}

Поле | Описание
--- | ---
queue_id | **string**<br>Обязательное поле. Идентификатор очереди сообщений в Yandex Message Queue. 
service_account_id | **string**<br>Обязательное поле. Идентификатор сервисного аккаунта с ролью на чтение очереди сообщений. Максимальная длина строки в символах — 50.
batch_settings | **[BatchSettings](#BatchSettings)**<br>Обязательное поле. Настройки группы сообщений для обработки сообщений в очереди. 
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Переопределение таймаута видимости очереди. Максимальное значение — 12h.
action | **oneof:** `invoke_function`<br>Действие, которое будет выполнено, когда в очереди появится новое сообщение.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Инструкции для единичного вызова функции. 


### IoTMessage {#IoTMessage2}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра Yandex IoT Core. 
device_id | **string**<br>Идентификатор устройства в реестре Yandex IoT. 
mqtt_topic | **string**<br>MQTT-топик, сообщения котрого активируют триггер. 
action | **oneof:** `invoke_function`<br>Действие, которое будет выполнено, когда в MQTT-топике появится новое сообщение.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Инструкции для вызова функции с повторными попытками по мере необходимости. 


### ObjectStorage {#ObjectStorage2}

Поле | Описание
--- | ---
event_type[] | **ObjectStorageEventType**<br>Тип (имя) событий, требуется хотя бы одно значение. Количество элементов должно быть больше 0.
bucket_id | **string**<br>Идентификатор бакета. 
prefix | **string**<br>Префикс ключа объекта. Фильтр, опционально. 
suffix | **string**<br>Суффикс ключа объекта. Фильтр, опционально. 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


### ContainerRegistry {#ContainerRegistry2}

Поле | Описание
--- | ---
event_type[] | **ContainerRegistryEventType**<br>Тип (имя) событий, требуется хотя бы одно значение. Количество элементов должно быть больше 0.
registry_id | **string**<br>Идентификатор реестра. 
image_name | **string**<br>Имя Docker-образа. Фильтр, опционально. 
tag | **string**<br>Тег Docker-образа. Фильтр, опционально. 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


### CloudLogs {#CloudLogs2}

Поле | Описание
--- | ---
log_group_id[] | **string**<br>Идентификаторы групп журналов, по крайней мере, одно значение обязательно. 
batch_settings | **[CloudLogsBatchSettings](#CloudLogsBatchSettings)**<br>Обязательное поле. Пакетные настройки для обработки событий журнала. 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


## Update {#Update}

Обновляет указанный триггер.

**rpc Update ([UpdateTriggerRequest](#UpdateTriggerRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateTriggerMetadata](#UpdateTriggerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Trigger](#Trigger3)<br>

### UpdateTriggerRequest {#UpdateTriggerRequest}

Поле | Описание
--- | ---
trigger_id | **string**<br>Обязательное поле. Идентификатор триггера для обновления. <br>Чтобы получить идентификатор триггера, используйте запрос [TriggerService.List](#List) . 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска поля, которая указывает, какие атрибуты триггера должны быть обновлены. 
name | **string**<br>Новое имя триггера. Имя должно быть уникальным в рамках каталога. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание триггера. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки триггеров в виде пар `key:value` . <br>Существующий набор меток полностью заменяется предоставленным набором, поэтому, если вы просто хотите добавить или удалить метку, запросите текущий набор меток, используя запрос [TriggerService.Get](#Get) . Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateTriggerMetadata](#UpdateTriggerMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Trigger](#Trigger3)>**<br>в случае успешного выполнения операции. 


### UpdateTriggerMetadata {#UpdateTriggerMetadata}

Поле | Описание
--- | ---
trigger_id | **string**<br>Обязательное поле. Идентификатор обновляемого триггера. 


### Trigger {#Trigger3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор триггера. Генерируется при создании. 
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается триггер. Максимальная длина строки в символах — 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания триггера. 
name | **string**<br>Имя триггера. Длина строки в символах должна быть от 3 до 63.
description | **string**<br>Описание триггера. Длина строки в символах должна быть от 0 до 256.
labels | **map<string,string>**<br>Метки триггеров в виде пар `key:value` . 
rule | **[Rule](#Rule3)**<br>Обязательное поле. Правило активации триггера (всегда соответствует типу триггера). 
status | enum **Status**<br>Состояние триггера <ul><ul/>


### Rule {#Rule3}

Поле | Описание
--- | ---
rule | **oneof:** `timer`, `message_queue`, `iot_message`, `object_storage`, `container_registry` или `cloud_logs`<br>
&nbsp;&nbsp;timer | **[Timer](#Timer3)**<br>Правило для таймера. 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue3)**<br>Правило для триггера очереди сообщений. 
&nbsp;&nbsp;iot_message | **[IoTMessage](#IoTMessage3)**<br>Правило для триггера Yandex IoT Core. 
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage3)**<br> 
&nbsp;&nbsp;container_registry | **[ContainerRegistry](#ContainerRegistry3)**<br> 
&nbsp;&nbsp;cloud_logs | **[CloudLogs](#CloudLogs3)**<br> 


### Timer {#Timer3}

Поле | Описание
--- | ---
cron_expression | **string**<br>Обязательное поле. Описание расписания в виде [cron expression](/docs/functions/concepts/trigger/timer). Максимальная длина строки в символах — 100.
action | **oneof:** `invoke_function` или `invoke_function_with_retry`<br>Действие, которое будет выполнено, когда текущее время совпадает с `cron_expression`.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Инструкции для единичного вызова функции. 
&nbsp;&nbsp;invoke_function_with_retry | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Действие, которое будет выполнено, когда текущее время совпадает с `cron_expression`. 


### MessageQueue {#MessageQueue3}

Поле | Описание
--- | ---
queue_id | **string**<br>Обязательное поле. Идентификатор очереди сообщений в Yandex Message Queue. 
service_account_id | **string**<br>Обязательное поле. Идентификатор сервисного аккаунта с ролью на чтение очереди сообщений. Максимальная длина строки в символах — 50.
batch_settings | **[BatchSettings](#BatchSettings)**<br>Обязательное поле. Настройки группы сообщений для обработки сообщений в очереди. 
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Переопределение таймаута видимости очереди. Максимальное значение — 12h.
action | **oneof:** `invoke_function`<br>Действие, которое будет выполнено, когда в очереди появится новое сообщение.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Инструкции для единичного вызова функции. 


### IoTMessage {#IoTMessage3}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра Yandex IoT Core. 
device_id | **string**<br>Идентификатор устройства в реестре Yandex IoT. 
mqtt_topic | **string**<br>MQTT-топик, сообщения котрого активируют триггер. 
action | **oneof:** `invoke_function`<br>Действие, которое будет выполнено, когда в MQTT-топике появится новое сообщение.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Инструкции для вызова функции с повторными попытками по мере необходимости. 


### ObjectStorage {#ObjectStorage3}

Поле | Описание
--- | ---
event_type[] | **ObjectStorageEventType**<br>Тип (имя) событий, требуется хотя бы одно значение. Количество элементов должно быть больше 0.
bucket_id | **string**<br>Идентификатор бакета. 
prefix | **string**<br>Префикс ключа объекта. Фильтр, опционально. 
suffix | **string**<br>Суффикс ключа объекта. Фильтр, опционально. 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


### ContainerRegistry {#ContainerRegistry3}

Поле | Описание
--- | ---
event_type[] | **ContainerRegistryEventType**<br>Тип (имя) событий, требуется хотя бы одно значение. Количество элементов должно быть больше 0.
registry_id | **string**<br>Идентификатор реестра. 
image_name | **string**<br>Имя Docker-образа. Фильтр, опционально. 
tag | **string**<br>Тег Docker-образа. Фильтр, опционально. 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


### CloudLogs {#CloudLogs3}

Поле | Описание
--- | ---
log_group_id[] | **string**<br>Идентификаторы групп журналов, по крайней мере, одно значение обязательно. 
batch_settings | **[CloudLogsBatchSettings](#CloudLogsBatchSettings)**<br>Обязательное поле. Пакетные настройки для обработки событий журнала. 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


## Delete {#Delete}

Удаляет указанный триггер.

**rpc Delete ([DeleteTriggerRequest](#DeleteTriggerRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteTriggerMetadata](#DeleteTriggerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteTriggerRequest {#DeleteTriggerRequest}

Поле | Описание
--- | ---
trigger_id | **string**<br>Обязательное поле. Идентификатор триггера для удаления. <br>Чтобы получить идентификатор триггера, используйте запрос [TriggerService.List](#List) . 


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteTriggerMetadata](#DeleteTriggerMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteTriggerMetadata {#DeleteTriggerMetadata}

Поле | Описание
--- | ---
trigger_id | **string**<br>Обязательное поле. Идентификатор удаляемого триггера. 


## ListOperations {#ListOperations}

Возвращает список операций для указанного триггера.

**rpc ListOperations ([ListTriggerOperationsRequest](#ListTriggerOperationsRequest)) returns ([ListTriggerOperationsResponse](#ListTriggerOperationsResponse))**

### ListTriggerOperationsRequest {#ListTriggerOperationsRequest}

Поле | Описание
--- | ---
trigger_id | **string**<br>Обязательное поле. Идентификатор триггера, для котрого запрашивается список операций. 
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `pageSize`, сервис вернет значение [ListTriggerOperationsResponse.next_page_token](#ListTriggerOperationsResponse), которое можно использовать для получения следующей страницы. <br>Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `pageToken` равным значению поля [ListTriggerOperationsResponse.next_page_token](#ListTriggerOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Trigger.name](#Trigger4). </li><li>Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Пример фильтра: `name=my-function`.</li></ol> Максимальная длина строки в символах — 1000.


### ListTriggerOperationsResponse {#ListTriggerOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>Список операций для указанного триггера. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListTriggerOperationsRequest.page_size](#ListTriggerOperationsRequest), используйте `nextPageToken` в качестве значения параметра [ListTriggerOperationsRequest.page_token](#ListTriggerOperationsRequest) в следующем запросе списка ресурсов. <br>Все последующие запросы будут получать свои значения `nextPageToken` для перебора страниц результатов. 


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


