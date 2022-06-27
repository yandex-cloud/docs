---
editable: false
---

# FunctionService

Набор методов управления бессерверными функциями.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанную функцию. |
| [List](#List) | Возвращает список функций в указанном каталоге. |
| [Create](#Create) | Создает функцию в указанном каталоге. |
| [Update](#Update) | Обновляет указанную функцию. |
| [Delete](#Delete) | Удаляет указанную функцию. |
| [GetVersion](#GetVersion) | Возвращает указанную версию функции. |
| [GetFunctionVersion](#GetFunctionVersion) | Устарел. |
| [GetVersionByTag](#GetVersionByTag) | Возвращает все версии с указанным тегом. |
| [GetFunctionVersionByTag](#GetFunctionVersionByTag) | Устарел. |
| [ListVersions](#ListVersions) | Извлекает список версий для указанной функции или всех версий функции в указанном каталоге |
| [ListFunctionVersions](#ListFunctionVersions) | Устарел. |
| [SetTag](#SetTag) | Устанавливает тег для указанной версии функции. |
| [RemoveTag](#RemoveTag) | Удаляет тег из указанной версии функции. |
| [ListTagHistory](#ListTagHistory) | Возвращает журнал тегов, назначенных версиям указанной функции. |
| [ListFunctionTagHistory](#ListFunctionTagHistory) | Устарел. |
| [CreateVersion](#CreateVersion) | Создает версию для указанной функции. |
| [CreateFunctionVersion](#CreateFunctionVersion) | Устарел. |
| [ListRuntimes](#ListRuntimes) | Список доступных сред выполнения для указанной функции. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанной функции. |
| [ListAccessBindings](#ListAccessBindings) | Возвращает список привязок прав доступа для указанной функции. |
| [SetAccessBindings](#SetAccessBindings) | Устанавливает привязки прав доступа для указанной функции. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Обновляет привязки прав доступа для указанной функции. |

## Вызовы FunctionService {#calls}

## Get {#Get}

Возвращает указанную функцию. <br>Чтобы получить список доступных функций, используйте запрос [List](#List) .

**rpc Get ([GetFunctionRequest](#GetFunctionRequest)) returns ([Function](#Function))**

### GetFunctionRequest {#GetFunctionRequest}

Поле | Описание
--- | ---
function_id | **string**<br>Обязательное поле. Идентификатор возвращаемой функции. <br>Чтобы получить идентификатор функции, используйте запрос [FunctionService.List](#List) . 


### Function {#Function}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор функции. Генерируется во время создания. 
folder_id | **string**<br>Идентификатор каталога, к которому принадлежит функция. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания функции. 
name | **string**<br>Имя функции. Имя уникально в рамках каталога. Длина строки в символах должна быть от 3 до 63.
description | **string**<br>Описание функции. Длина строки в символах должна быть от 0 до 256.
labels | **map<string,string>**<br>Метки функций в виде пар `key:value` . Не более 64 на ресурс.
log_group_id | **string**<br>Идентификатор группы журналов выполнения функции. 
http_invoke_url | **string**<br>URL-адрес, который нужнозапросить для вызова функции. 
status | enum **Status**<br>Состояние функции. <ul><li>`CREATING`: Функция создается.</li><li>`ACTIVE`: Функция готова к вызову.</li><li>`DELETING`: Функция удаляется.</li><li>`ERROR`: Сбой функции.</li><ul/>


## List {#List}

Возвращает список функций в указанном каталоге.

**rpc List ([ListFunctionsRequest](#ListFunctionsRequest)) returns ([ListFunctionsResponse](#ListFunctionsResponse))**

### ListFunctionsRequest {#ListFunctionsRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка функций. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `pageSize`, сервис вернет значение [ListFunctionsResponse.next_page_token](#ListFunctionsResponse), которое можно использовать для получения следующей страницы. <br>Значение по умолчанию: 100. 
page_token | **string**<br>Токен страницы. Установите значение `pageToken` равным значению поля [ListFunctionsResponse.next_page_token](#ListFunctionsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. 
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Function.name](#Function1). </li><li>Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Пример фильтра: `name=my-function`.</li></ol> 


### ListFunctionsResponse {#ListFunctionsResponse}

Поле | Описание
--- | ---
functions[] | **[Function](#Function1)**<br>Возвращает список функций в указанном каталоге. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListFunctionsRequest.page_size](#ListFunctionsRequest), используйте `nextPageToken` в качестве значения параметра [ListFunctionsRequest.page_token](#ListFunctionsRequest) в следующем запросе списка ресурсов. <br>Все последующие запросы будут получать свои значения `nextPageToken` для перебора страниц результатов. 


### Function {#Function1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор функции. Генерируется во время создания. 
folder_id | **string**<br>Идентификатор каталога, к которому принадлежит функция. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания функции. 
name | **string**<br>Имя функции. Имя уникально в рамках каталога. Длина строки в символах должна быть от 3 до 63.
description | **string**<br>Описание функции. Длина строки в символах должна быть от 0 до 256.
labels | **map<string,string>**<br>Метки функций в виде пар `key:value` . Не более 64 на ресурс.
log_group_id | **string**<br>Идентификатор группы журналов выполнения функции. 
http_invoke_url | **string**<br>URL-адрес, который нужнозапросить для вызова функции. 
status | enum **Status**<br>Состояние функции. <ul><li>`CREATING`: Функция создается.</li><li>`ACTIVE`: Функция готова к вызову.</li><li>`DELETING`: Функция удаляется.</li><li>`ERROR`: Сбой функции.</li><ul/>


## Create {#Create}

Создает функцию в указанном каталоге.

**rpc Create ([CreateFunctionRequest](#CreateFunctionRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateFunctionMetadata](#CreateFunctionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Function](#Function2)<br>

### CreateFunctionRequest {#CreateFunctionRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается функция. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
name | **string**<br>Имя функции. Имя должно быть уникальным в рамках каталога. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание функции. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateFunctionMetadata](#CreateFunctionMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Function](#Function2)>**<br>в случае успешного выполнения операции. 


### CreateFunctionMetadata {#CreateFunctionMetadata}

Поле | Описание
--- | ---
function_id | **string**<br>Идентификатор создаваемой функции. 


### Function {#Function2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор функции. Генерируется во время создания. 
folder_id | **string**<br>Идентификатор каталога, к которому принадлежит функция. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания функции. 
name | **string**<br>Имя функции. Имя уникально в рамках каталога. Длина строки в символах должна быть от 3 до 63.
description | **string**<br>Описание функции. Длина строки в символах должна быть от 0 до 256.
labels | **map<string,string>**<br>Метки функций в виде пар `key:value` . Не более 64 на ресурс.
log_group_id | **string**<br>Идентификатор группы журналов выполнения функции. 
http_invoke_url | **string**<br>URL-адрес, который нужнозапросить для вызова функции. 
status | enum **Status**<br>Состояние функции. <ul><li>`CREATING`: Функция создается.</li><li>`ACTIVE`: Функция готова к вызову.</li><li>`DELETING`: Функция удаляется.</li><li>`ERROR`: Сбой функции.</li><ul/>


## Update {#Update}

Обновляет указанную функцию.

**rpc Update ([UpdateFunctionRequest](#UpdateFunctionRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateFunctionMetadata](#UpdateFunctionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Function](#Function3)<br>

### UpdateFunctionRequest {#UpdateFunctionRequest}

Поле | Описание
--- | ---
function_id | **string**<br>Обязательное поле. Идентификатор функции для обновления. <br>Чтобы получить идентификатор функции, используйте запрос [FunctionService.List](#List) . 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска поля, которая указывает, какие атрибуты функции должны быть обновлены. 
name | **string**<br>Новое имя функции. Имя должно быть уникальным в рамках каталога. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Новое описание функции. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки функций в виде пар `key:value` . <br>Существующий набор меток полностью заменяется предоставленным набором, поэтому, если вы просто хотите добавить или удалить метку, запросите текущий набор меток, используя запрос [FunctionService.Get](#Get) . Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateFunctionMetadata](#UpdateFunctionMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Function](#Function3)>**<br>в случае успешного выполнения операции. 


### UpdateFunctionMetadata {#UpdateFunctionMetadata}

Поле | Описание
--- | ---
function_id | **string**<br>Идентификатор обновляемой функции. 


### Function {#Function3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор функции. Генерируется во время создания. 
folder_id | **string**<br>Идентификатор каталога, к которому принадлежит функция. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания функции. 
name | **string**<br>Имя функции. Имя уникально в рамках каталога. Длина строки в символах должна быть от 3 до 63.
description | **string**<br>Описание функции. Длина строки в символах должна быть от 0 до 256.
labels | **map<string,string>**<br>Метки функций в виде пар `key:value` . Не более 64 на ресурс.
log_group_id | **string**<br>Идентификатор группы журналов выполнения функции. 
http_invoke_url | **string**<br>URL-адрес, который нужнозапросить для вызова функции. 
status | enum **Status**<br>Состояние функции. <ul><li>`CREATING`: Функция создается.</li><li>`ACTIVE`: Функция готова к вызову.</li><li>`DELETING`: Функция удаляется.</li><li>`ERROR`: Сбой функции.</li><ul/>


## Delete {#Delete}

Удаляет указанную функцию.

**rpc Delete ([DeleteFunctionRequest](#DeleteFunctionRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteFunctionMetadata](#DeleteFunctionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteFunctionRequest {#DeleteFunctionRequest}

Поле | Описание
--- | ---
function_id | **string**<br>Обязательное поле. Идентификатор удаляемой функции. Чтобы получить идентификатор функции, используйте запрос [FunctionService.List](#List) . 


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteFunctionMetadata](#DeleteFunctionMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteFunctionMetadata {#DeleteFunctionMetadata}

Поле | Описание
--- | ---
function_id | **string**<br>Идентификатор удаляемой функции. 


## GetVersion {#GetVersion}

Возвращает указанную версию функции. <br>Чтобы получить список доступных версий, используйте запрос [ListVersions](#ListVersions) .

**rpc GetVersion ([GetFunctionVersionRequest](#GetFunctionVersionRequest)) returns ([Version](#Version))**

### GetFunctionVersionRequest {#GetFunctionVersionRequest}

Поле | Описание
--- | ---
function_version_id | **string**<br>Обязательное поле. Идентификатор возвращаемой версии. <br>Чтобы получить идентификатор версии, используйте запрос [FunctionService.ListVersions](#ListVersions) . 


### Version {#Version}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
function_id | **string**<br>Идентификатор функции, которой принадлежит версия. 
description | **string**<br>Описание версии. Длина строки в символах должна быть от 0 до 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии. 
runtime | **string**<br>Идентификатор среды выполнения для функции. <br>Поддерживаемые среды и их идентификаторы перечислены в списке [Среда выполнения](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Точка входа для функции: имя функции, вызываемой в качестве обработчика. <br>Указывается в формате `<function file name>.<handler name>`, например, `index.myFunction`. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные для версии. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Таймаут для выполнения версии. <br>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, который связан с версией. 
image_size | **int64**<br>Окончательный размер пакета развертывания после распаковки. 
status | enum **Status**<br>Состояние версии. <ul><li>`CREATING`: Версия создается.</li><li>`ACTIVE`: Версия готова к использованию.</li><ul/>
tags[] | **string**<br>Теги версий. Подробнее см. в [Тег версии](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>Идентификатор группы журналов выполнения для версии. 
environment | **map<string,string>**<br>Параметры среды выполнения для версии. 


### Resources {#Resources}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный для версии. Допустимые значения — от 33554432 до 1073741824 включительно.


## GetFunctionVersion {#GetFunctionVersion}

Устарел. Используйте [GetVersion](#GetVersion).

**rpc GetFunctionVersion ([GetFunctionVersionRequest](#GetFunctionVersionRequest)) returns ([Version](#Version1))**

### GetFunctionVersionRequest {#GetFunctionVersionRequest1}

Поле | Описание
--- | ---
function_version_id | **string**<br>Обязательное поле. Идентификатор возвращаемой версии. <br>Чтобы получить идентификатор версии, используйте запрос [FunctionService.ListVersions](#ListVersions) . 


### Version {#Version1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
function_id | **string**<br>Идентификатор функции, которой принадлежит версия. 
description | **string**<br>Описание версии. Длина строки в символах должна быть от 0 до 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии. 
runtime | **string**<br>Идентификатор среды выполнения для функции. <br>Поддерживаемые среды и их идентификаторы перечислены в списке [Среда выполнения](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Точка входа для функции: имя функции, вызываемой в качестве обработчика. <br>Указывается в формате `<function file name>.<handler name>`, например, `index.myFunction`. 
resources | **[Resources](#Resources1)**<br>Ресурсы, выделенные для версии. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Таймаут для выполнения версии. <br>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, который связан с версией. 
image_size | **int64**<br>Окончательный размер пакета развертывания после распаковки. 
status | enum **Status**<br>Состояние версии. <ul><li>`CREATING`: Версия создается.</li><li>`ACTIVE`: Версия готова к использованию.</li><ul/>
tags[] | **string**<br>Теги версий. Подробнее см. в [Тег версии](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>Идентификатор группы журналов выполнения для версии. 
environment | **map<string,string>**<br>Параметры среды выполнения для версии. 


### Resources {#Resources1}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный для версии. Допустимые значения — от 33554432 до 1073741824 включительно.


## GetVersionByTag {#GetVersionByTag}

Возвращает все версии с указанным тегом. <br>Чтобы получить список доступных версий, используйте запрос [ListVersions](#ListVersions) .

**rpc GetVersionByTag ([GetFunctionVersionByTagRequest](#GetFunctionVersionByTagRequest)) returns ([Version](#Version2))**

### GetFunctionVersionByTagRequest {#GetFunctionVersionByTagRequest}

Поле | Описание
--- | ---
function_id | **string**<br>Обязательное поле. Идентификатор функции, для которой нужно вернуть список версий. <br>Чтобы получить идентификатор функции, используйте запрос [FunctionService.List](#List) . 
tag | **string**<br>Тег версии. <br>Чтобы получить историю тегов версий, используйте запрос [FunctionService.ListTagHistory](#ListTagHistory) . Значение должно соответствовать регулярному выражению ` [a-z][-_0-9a-z]*|[$]latest `.


### Version {#Version2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
function_id | **string**<br>Идентификатор функции, которой принадлежит версия. 
description | **string**<br>Описание версии. Длина строки в символах должна быть от 0 до 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии. 
runtime | **string**<br>Идентификатор среды выполнения для функции. <br>Поддерживаемые среды и их идентификаторы перечислены в списке [Среда выполнения](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Точка входа для функции: имя функции, вызываемой в качестве обработчика. <br>Указывается в формате `<function file name>.<handler name>`, например, `index.myFunction`. 
resources | **[Resources](#Resources2)**<br>Ресурсы, выделенные для версии. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Таймаут для выполнения версии. <br>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, который связан с версией. 
image_size | **int64**<br>Окончательный размер пакета развертывания после распаковки. 
status | enum **Status**<br>Состояние версии. <ul><li>`CREATING`: Версия создается.</li><li>`ACTIVE`: Версия готова к использованию.</li><ul/>
tags[] | **string**<br>Теги версий. Подробнее см. в [Тег версии](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>Идентификатор группы журналов выполнения для версии. 
environment | **map<string,string>**<br>Параметры среды выполнения для версии. 


### Resources {#Resources2}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный для версии. Допустимые значения — от 33554432 до 1073741824 включительно.


## GetFunctionVersionByTag {#GetFunctionVersionByTag}

Устарел. Используйте [GetVersionByTag](#GetVersionByTag).

**rpc GetFunctionVersionByTag ([GetFunctionVersionByTagRequest](#GetFunctionVersionByTagRequest)) returns ([Version](#Version3))**

### GetFunctionVersionByTagRequest {#GetFunctionVersionByTagRequest1}

Поле | Описание
--- | ---
function_id | **string**<br>Обязательное поле. Идентификатор функции, для которой нужно вернуть список версий. <br>Чтобы получить идентификатор функции, используйте запрос [FunctionService.List](#List) . 
tag | **string**<br>Тег версии. <br>Чтобы получить историю тегов версий, используйте запрос [FunctionService.ListTagHistory](#ListTagHistory) . Значение должно соответствовать регулярному выражению ` [a-z][-_0-9a-z]*|[$]latest `.


### Version {#Version3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
function_id | **string**<br>Идентификатор функции, которой принадлежит версия. 
description | **string**<br>Описание версии. Длина строки в символах должна быть от 0 до 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии. 
runtime | **string**<br>Идентификатор среды выполнения для функции. <br>Поддерживаемые среды и их идентификаторы перечислены в списке [Среда выполнения](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Точка входа для функции: имя функции, вызываемой в качестве обработчика. <br>Указывается в формате `<function file name>.<handler name>`, например, `index.myFunction`. 
resources | **[Resources](#Resources3)**<br>Ресурсы, выделенные для версии. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Таймаут для выполнения версии. <br>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, который связан с версией. 
image_size | **int64**<br>Окончательный размер пакета развертывания после распаковки. 
status | enum **Status**<br>Состояние версии. <ul><li>`CREATING`: Версия создается.</li><li>`ACTIVE`: Версия готова к использованию.</li><ul/>
tags[] | **string**<br>Теги версий. Подробнее см. в [Тег версии](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>Идентификатор группы журналов выполнения для версии. 
environment | **map<string,string>**<br>Параметры среды выполнения для версии. 


### Resources {#Resources3}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный для версии. Допустимые значения — от 33554432 до 1073741824 включительно.


## ListVersions {#ListVersions}

Извлекает список версий для указанной функции или всех версий функции в указанном каталоге

**rpc ListVersions ([ListFunctionsVersionsRequest](#ListFunctionsVersionsRequest)) returns ([ListFunctionsVersionsResponse](#ListFunctionsVersionsResponse))**

### ListFunctionsVersionsRequest {#ListFunctionsVersionsRequest}

Поле | Описание
--- | ---
id | **oneof:** `folder_id` или `function_id`<br>
&nbsp;&nbsp;folder_id | **string**<br>Идентификатор каталога, для которого нужно вернуть список версий функции. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
&nbsp;&nbsp;function_id | **string**<br>Идентификатор функции, для которой нужно вернуть список версий. Чтобы получить идентификатор функции, используйте запрос [FunctionService.List](#List) . 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `pageSize`, сервис вернет значение [ListFunctionsVersionsResponse.next_page_token](#ListFunctionsVersionsResponse), которое можно использовать для получения следующей страницы. <br>Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `pageToken` равным значению поля [ListFunctionsVersionsResponse.next_page_token](#ListFunctionsVersionsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Function.name](#Function4). </li><li>Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Пример фильтра: `name=my-function`.</li></ol> Максимальная длина строки в символах — 1000.


### ListFunctionsVersionsResponse {#ListFunctionsVersionsResponse}

Поле | Описание
--- | ---
versions[] | **[Version](#Version4)**<br>Список версий для указанного каталога или функции. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListFunctionsVersionsRequest.page_size](#ListFunctionsVersionsRequest), используйте `nextPageToken` в качестве значения параметра [ListFunctionsVersionsRequest.page_token](#ListFunctionsVersionsRequest) в следующем запросе списка ресурсов. <br>Все последующие запросы будут получать свои значения `nextPageToken` для перебора страниц результатов. 


### Version {#Version4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
function_id | **string**<br>Идентификатор функции, которой принадлежит версия. 
description | **string**<br>Описание версии. Длина строки в символах должна быть от 0 до 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии. 
runtime | **string**<br>Идентификатор среды выполнения для функции. <br>Поддерживаемые среды и их идентификаторы перечислены в списке [Среда выполнения](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Точка входа для функции: имя функции, вызываемой в качестве обработчика. <br>Указывается в формате `<function file name>.<handler name>`, например, `index.myFunction`. 
resources | **[Resources](#Resources4)**<br>Ресурсы, выделенные для версии. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Таймаут для выполнения версии. <br>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, который связан с версией. 
image_size | **int64**<br>Окончательный размер пакета развертывания после распаковки. 
status | enum **Status**<br>Состояние версии. <ul><li>`CREATING`: Версия создается.</li><li>`ACTIVE`: Версия готова к использованию.</li><ul/>
tags[] | **string**<br>Теги версий. Подробнее см. в [Тег версии](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>Идентификатор группы журналов выполнения для версии. 
environment | **map<string,string>**<br>Параметры среды выполнения для версии. 


### Resources {#Resources4}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный для версии. Допустимые значения — от 33554432 до 1073741824 включительно.


## ListFunctionVersions {#ListFunctionVersions}

Устарел. Используйте [ListVersions](#ListVersions).

**rpc ListFunctionVersions ([ListFunctionsVersionsRequest](#ListFunctionsVersionsRequest)) returns ([ListFunctionsVersionsResponse](#ListFunctionsVersionsResponse))**

### ListFunctionsVersionsRequest {#ListFunctionsVersionsRequest1}

Поле | Описание
--- | ---
id | **oneof:** `folder_id` или `function_id`<br>
&nbsp;&nbsp;folder_id | **string**<br>Идентификатор каталога, для которого нужно вернуть список версий функции. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
&nbsp;&nbsp;function_id | **string**<br>Идентификатор функции, для которой нужно вернуть список версий. Чтобы получить идентификатор функции, используйте запрос [FunctionService.List](#List) . 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `pageSize`, сервис вернет значение [ListFunctionsVersionsResponse.next_page_token](#ListFunctionsVersionsResponse), которое можно использовать для получения следующей страницы. <br>Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `pageToken` равным значению поля [ListFunctionsVersionsResponse.next_page_token](#ListFunctionsVersionsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Function.name](#Function4). </li><li>Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Пример фильтра: `name=my-function`.</li></ol> Максимальная длина строки в символах — 1000.


### ListFunctionsVersionsResponse {#ListFunctionsVersionsResponse1}

Поле | Описание
--- | ---
versions[] | **[Version](#Version5)**<br>Список версий для указанного каталога или функции. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListFunctionsVersionsRequest.page_size](#ListFunctionsVersionsRequest), используйте `nextPageToken` в качестве значения параметра [ListFunctionsVersionsRequest.page_token](#ListFunctionsVersionsRequest) в следующем запросе списка ресурсов. <br>Все последующие запросы будут получать свои значения `nextPageToken` для перебора страниц результатов. 


### Version {#Version5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
function_id | **string**<br>Идентификатор функции, которой принадлежит версия. 
description | **string**<br>Описание версии. Длина строки в символах должна быть от 0 до 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии. 
runtime | **string**<br>Идентификатор среды выполнения для функции. <br>Поддерживаемые среды и их идентификаторы перечислены в списке [Среда выполнения](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Точка входа для функции: имя функции, вызываемой в качестве обработчика. <br>Указывается в формате `<function file name>.<handler name>`, например, `index.myFunction`. 
resources | **[Resources](#Resources5)**<br>Ресурсы, выделенные для версии. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Таймаут для выполнения версии. <br>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, который связан с версией. 
image_size | **int64**<br>Окончательный размер пакета развертывания после распаковки. 
status | enum **Status**<br>Состояние версии. <ul><li>`CREATING`: Версия создается.</li><li>`ACTIVE`: Версия готова к использованию.</li><ul/>
tags[] | **string**<br>Теги версий. Подробнее см. в [Тег версии](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>Идентификатор группы журналов выполнения для версии. 
environment | **map<string,string>**<br>Параметры среды выполнения для версии. 


### Resources {#Resources5}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный для версии. Допустимые значения — от 33554432 до 1073741824 включительно.


## SetTag {#SetTag}

Устанавливает тег для указанной версии функции.

**rpc SetTag ([SetFunctionTagRequest](#SetFunctionTagRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetFunctionTagMetadata](#SetFunctionTagMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version6)<br>

### SetFunctionTagRequest {#SetFunctionTagRequest}

Поле | Описание
--- | ---
function_version_id | **string**<br>Обязательное поле. Идентификатор версии для установки тега. <br>Чтобы получить идентификатор версии, используйте запрос [FunctionService.ListVersions](#ListVersions) . 
tag | **string**<br>Тег для установки версии. Значение должно соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetFunctionTagMetadata](#SetFunctionTagMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Version](#Version6)>**<br>в случае успешного выполнения операции. 


### SetFunctionTagMetadata {#SetFunctionTagMetadata}

Поле | Описание
--- | ---
function_version_id | **string**<br>Идентификатор версии функции, для которой добавляется тег. 


### Version {#Version6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
function_id | **string**<br>Идентификатор функции, которой принадлежит версия. 
description | **string**<br>Описание версии. Длина строки в символах должна быть от 0 до 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии. 
runtime | **string**<br>Идентификатор среды выполнения для функции. <br>Поддерживаемые среды и их идентификаторы перечислены в списке [Среда выполнения](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Точка входа для функции: имя функции, вызываемой в качестве обработчика. <br>Указывается в формате `<function file name>.<handler name>`, например, `index.myFunction`. 
resources | **[Resources](#Resources6)**<br>Ресурсы, выделенные для версии. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Таймаут для выполнения версии. <br>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, который связан с версией. 
image_size | **int64**<br>Окончательный размер пакета развертывания после распаковки. 
status | enum **Status**<br>Состояние версии. <ul><li>`CREATING`: Версия создается.</li><li>`ACTIVE`: Версия готова к использованию.</li><ul/>
tags[] | **string**<br>Теги версий. Подробнее см. в [Тег версии](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>Идентификатор группы журналов выполнения для версии. 
environment | **map<string,string>**<br>Параметры среды выполнения для версии. 


### Resources {#Resources6}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный для версии. Допустимые значения — от 33554432 до 1073741824 включительно.


## RemoveTag {#RemoveTag}

Удаляет тег из указанной версии функции.

**rpc RemoveTag ([RemoveFunctionTagRequest](#RemoveFunctionTagRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveFunctionTagMetadata](#RemoveFunctionTagMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version7)<br>

### RemoveFunctionTagRequest {#RemoveFunctionTagRequest}

Поле | Описание
--- | ---
function_version_id | **string**<br>Обязательное поле. Идентификатор версии, из которой нужно удалить тег. <br>Чтобы получить идентификатор версии, используйте запрос [FunctionService.ListVersions](#ListVersions) . 
tag | **string**<br>Тег, который нужно удалить из указанной версии. Значение должно соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### Operation {#Operation4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RemoveFunctionTagMetadata](#RemoveFunctionTagMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Version](#Version7)>**<br>в случае успешного выполнения операции. 


### RemoveFunctionTagMetadata {#RemoveFunctionTagMetadata}

Поле | Описание
--- | ---
function_version_id | **string**<br>Идентификатор версии функции, для которой удаляется тег. 


### Version {#Version7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
function_id | **string**<br>Идентификатор функции, которой принадлежит версия. 
description | **string**<br>Описание версии. Длина строки в символах должна быть от 0 до 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии. 
runtime | **string**<br>Идентификатор среды выполнения для функции. <br>Поддерживаемые среды и их идентификаторы перечислены в списке [Среда выполнения](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Точка входа для функции: имя функции, вызываемой в качестве обработчика. <br>Указывается в формате `<function file name>.<handler name>`, например, `index.myFunction`. 
resources | **[Resources](#Resources7)**<br>Ресурсы, выделенные для версии. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Таймаут для выполнения версии. <br>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, который связан с версией. 
image_size | **int64**<br>Окончательный размер пакета развертывания после распаковки. 
status | enum **Status**<br>Состояние версии. <ul><li>`CREATING`: Версия создается.</li><li>`ACTIVE`: Версия готова к использованию.</li><ul/>
tags[] | **string**<br>Теги версий. Подробнее см. в [Тег версии](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>Идентификатор группы журналов выполнения для версии. 
environment | **map<string,string>**<br>Параметры среды выполнения для версии. 


### Resources {#Resources7}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный для версии. Допустимые значения — от 33554432 до 1073741824 включительно.


## ListTagHistory {#ListTagHistory}

Возвращает журнал тегов, назначенных версиям указанной функции.

**rpc ListTagHistory ([ListFunctionTagHistoryRequest](#ListFunctionTagHistoryRequest)) returns ([ListFunctionTagHistoryResponse](#ListFunctionTagHistoryResponse))**

### ListFunctionTagHistoryRequest {#ListFunctionTagHistoryRequest}

Поле | Описание
--- | ---
function_id | **string**<br>Обязательное поле. Идентификатор функции для получения истории тегов. <br>Чтобы получить идентификатор функции, используйте запрос [FunctionService.List](#List) . 
tag | **string**<br>Конкретный тег, которым должна быть ограничена история. Значение должно соответствовать регулярному выражению ` [a-z][-_0-9a-z]*|[$]latest `.
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `pageSize`, сервис вернет значение [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `pageToken` равным значению поля [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Function.name](#Function4). </li><li>Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Например, `name=my-function`.</li></ol> Максимальная длина строки в символах — 1000.


### ListFunctionTagHistoryResponse {#ListFunctionTagHistoryResponse}

Поле | Описание
--- | ---
function_tag_history_record[] | **FunctionTagHistoryRecord**<br>Набор соответствующих записей истории тегов. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListFunctionTagHistoryRequest.page_size](#ListFunctionTagHistoryRequest), используйте `nextPageToken` в качестве значения параметра [ListFunctionTagHistoryRequest.page_token](#ListFunctionTagHistoryRequest) в следующем запросе списка ресурсов. <br>Все последующие запросы будут получать свои значения `nextPageToken` для перебора страниц результатов. 


### FunctionTagHistoryRecord {#FunctionTagHistoryRecord}

Поле | Описание
--- | ---
function_id | **string**<br>Идентификатор функции, для которой идет запись. 
function_version_id | **string**<br>Идентификатор версии функции, для которой идет запись. 
tag | **string**<br>Тег, который был установлен для версии в какой-то момент. 
effective_from | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Отметка времени, когда тег начал быть активным для функции. 
effective_to | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Отметка времени, когда тег перестал быть активным для функции. 


## ListFunctionTagHistory {#ListFunctionTagHistory}

Устарел. Используйте [ListTagHistory](#ListTagHistory).

**rpc ListFunctionTagHistory ([ListFunctionTagHistoryRequest](#ListFunctionTagHistoryRequest)) returns ([ListFunctionTagHistoryResponse](#ListFunctionTagHistoryResponse))**

### ListFunctionTagHistoryRequest {#ListFunctionTagHistoryRequest1}

Поле | Описание
--- | ---
function_id | **string**<br>Обязательное поле. Идентификатор функции для получения истории тегов. <br>Чтобы получить идентификатор функции, используйте запрос [FunctionService.List](#List) . 
tag | **string**<br>Конкретный тег, которым должна быть ограничена история. Значение должно соответствовать регулярному выражению ` [a-z][-_0-9a-z]*|[$]latest `.
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `pageSize`, сервис вернет значение [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `pageToken` равным значению поля [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Function.name](#Function4). </li><li>Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Например, `name=my-function`.</li></ol> Максимальная длина строки в символах — 1000.


### ListFunctionTagHistoryResponse {#ListFunctionTagHistoryResponse1}

Поле | Описание
--- | ---
function_tag_history_record[] | **FunctionTagHistoryRecord**<br>Набор соответствующих записей истории тегов. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListFunctionTagHistoryRequest.page_size](#ListFunctionTagHistoryRequest), используйте `nextPageToken` в качестве значения параметра [ListFunctionTagHistoryRequest.page_token](#ListFunctionTagHistoryRequest) в следующем запросе списка ресурсов. <br>Все последующие запросы будут получать свои значения `nextPageToken` для перебора страниц результатов. 


### FunctionTagHistoryRecord {#FunctionTagHistoryRecord1}

Поле | Описание
--- | ---
function_id | **string**<br>Идентификатор функции, для которой идет запись. 
function_version_id | **string**<br>Идентификатор версии функции, для которой идет запись. 
tag | **string**<br>Тег, который был установлен для версии в какой-то момент. 
effective_from | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Отметка времени, когда тег начал быть активным для функции. 
effective_to | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Отметка времени, когда тег перестал быть активным для функции. 


## CreateVersion {#CreateVersion}

Создает версию для указанной функции.

**rpc CreateVersion ([CreateFunctionVersionRequest](#CreateFunctionVersionRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateFunctionVersionMetadata](#CreateFunctionVersionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version8)<br>

### CreateFunctionVersionRequest {#CreateFunctionVersionRequest}

Поле | Описание
--- | ---
function_id | **string**<br>Обязательное поле. Идентификатор функции для создания версии. <br>Чтобы получить идентификатор функции, используйте запрос [FunctionService.List](#List) . 
runtime | **string**<br>Обязательное поле. Среда выполнения для версии. 
description | **string**<br>Описание версии. Длина строки в символах должна быть от 0 до 256.
entrypoint | **string**<br>Обязательное поле. Точка входа для версии. 
resources | **[Resources](#Resources8)**<br>Обязательное поле. Ресурсы, выделенные для версии. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Таймаут для выполнения версии. <br>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, который нужно связать с версией. 
package_source | **oneof:** `package` или `content`<br>Источник пакета развертывания для версии.
&nbsp;&nbsp;package | **[Package](#Package)**<br>Пакет развертывания функций. 
&nbsp;&nbsp;content | **bytes**<br>Содержимое пакета развертывания. Максимальная длина строки в символах — 52428800.
environment | **map<string,string>**<br>Параметры среды выполнения для версии. Максимальная длина строки в символах для каждого значения — 4096. Каждый ключ должен соответствовать регулярному выражению ` [a-zA-Z][a-zA-Z0-9_]* `.


### Resources {#Resources8}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный для версии. Допустимые значения — от 33554432 до 1073741824 включительно.


### Package {#Package}

Поле | Описание
--- | ---
bucket_name | **string**<br>Обязательное поле. Имя бакета, в котором хранится код версии. 
object_name | **string**<br>Обязательное поле. Имя объекта в корзине, в которой хранится код версии. 
sha256 | **string**<br>SHA256-хэш пакета развертывания для версии. 


### Operation {#Operation5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateFunctionVersionMetadata](#CreateFunctionVersionMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Version](#Version8)>**<br>в случае успешного выполнения операции. 


### CreateFunctionVersionMetadata {#CreateFunctionVersionMetadata}

Поле | Описание
--- | ---
function_version_id | **string**<br>Идентификатор создаваемой версии. 


### Version {#Version8}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
function_id | **string**<br>Идентификатор функции, которой принадлежит версия. 
description | **string**<br>Описание версии. Длина строки в символах должна быть от 0 до 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии. 
runtime | **string**<br>Идентификатор среды выполнения для функции. <br>Поддерживаемые среды и их идентификаторы перечислены в списке [Среда выполнения](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Точка входа для функции: имя функции, вызываемой в качестве обработчика. <br>Указывается в формате `<function file name>.<handler name>`, например, `index.myFunction`. 
resources | **[Resources](#Resources9)**<br>Ресурсы, выделенные для версии. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Таймаут для выполнения версии. <br>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, который связан с версией. 
image_size | **int64**<br>Окончательный размер пакета развертывания после распаковки. 
status | enum **Status**<br>Состояние версии. <ul><li>`CREATING`: Версия создается.</li><li>`ACTIVE`: Версия готова к использованию.</li><ul/>
tags[] | **string**<br>Теги версий. Подробнее см. в [Тег версии](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>Идентификатор группы журналов выполнения для версии. 
environment | **map<string,string>**<br>Параметры среды выполнения для версии. 


### Resources {#Resources9}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный для версии. Допустимые значения — от 33554432 до 1073741824 включительно.


## CreateFunctionVersion {#CreateFunctionVersion}

Устарел. Используйте [CreateVersion](#CreateVersion).

**rpc CreateFunctionVersion ([CreateFunctionVersionRequest](#CreateFunctionVersionRequest)) returns ([operation.Operation](#Operation6))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateFunctionVersionMetadata](#CreateFunctionVersionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version9)<br>

### CreateFunctionVersionRequest {#CreateFunctionVersionRequest1}

Поле | Описание
--- | ---
function_id | **string**<br>Обязательное поле. Идентификатор функции для создания версии. <br>Чтобы получить идентификатор функции, используйте запрос [FunctionService.List](#List) . 
runtime | **string**<br>Обязательное поле. Среда выполнения для версии. 
description | **string**<br>Описание версии. Длина строки в символах должна быть от 0 до 256.
entrypoint | **string**<br>Обязательное поле. Точка входа для версии. 
resources | **[Resources](#Resources10)**<br>Обязательное поле. Ресурсы, выделенные для версии. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Обязательное поле. Таймаут для выполнения версии. <br>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, который нужно связать с версией. 
package_source | **oneof:** `package` или `content`<br>Источник пакета развертывания для версии.
&nbsp;&nbsp;package | **[Package](#Package1)**<br>Пакет развертывания функций. 
&nbsp;&nbsp;content | **bytes**<br>Содержимое пакета развертывания. Максимальная длина строки в символах — 52428800.
environment | **map<string,string>**<br>Параметры среды выполнения для версии. Максимальная длина строки в символах для каждого значения — 4096. Каждый ключ должен соответствовать регулярному выражению ` [a-zA-Z][a-zA-Z0-9_]* `.


### Resources {#Resources10}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный для версии. Допустимые значения — от 33554432 до 1073741824 включительно.


### Package {#Package1}

Поле | Описание
--- | ---
bucket_name | **string**<br>Обязательное поле. Имя бакета, в котором хранится код версии. 
object_name | **string**<br>Обязательное поле. Имя объекта в корзине, в которой хранится код версии. 
sha256 | **string**<br>SHA256-хэш пакета развертывания для версии. 


### Operation {#Operation6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateFunctionVersionMetadata](#CreateFunctionVersionMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Version](#Version9)>**<br>в случае успешного выполнения операции. 


### CreateFunctionVersionMetadata {#CreateFunctionVersionMetadata1}

Поле | Описание
--- | ---
function_version_id | **string**<br>Идентификатор создаваемой версии. 


### Version {#Version9}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
function_id | **string**<br>Идентификатор функции, которой принадлежит версия. 
description | **string**<br>Описание версии. Длина строки в символах должна быть от 0 до 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии. 
runtime | **string**<br>Идентификатор среды выполнения для функции. <br>Поддерживаемые среды и их идентификаторы перечислены в списке [Среда выполнения](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Точка входа для функции: имя функции, вызываемой в качестве обработчика. <br>Указывается в формате `<function file name>.<handler name>`, например, `index.myFunction`. 
resources | **[Resources](#Resources11)**<br>Ресурсы, выделенные для версии. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Таймаут для выполнения версии. <br>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, который связан с версией. 
image_size | **int64**<br>Окончательный размер пакета развертывания после распаковки. 
status | enum **Status**<br>Состояние версии. <ul><li>`CREATING`: Версия создается.</li><li>`ACTIVE`: Версия готова к использованию.</li><ul/>
tags[] | **string**<br>Теги версий. Подробнее см. в [Тег версии](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>Идентификатор группы журналов выполнения для версии. 
environment | **map<string,string>**<br>Параметры среды выполнения для версии. 


### Resources {#Resources11}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный для версии. Допустимые значения — от 33554432 до 1073741824 включительно.


## ListRuntimes {#ListRuntimes}

Список доступных сред выполнения для указанной функции.

**rpc ListRuntimes ([ListRuntimesRequest](#ListRuntimesRequest)) returns ([ListRuntimesResponse](#ListRuntimesResponse))**

### ListRuntimesRequest {#ListRuntimesRequest}



### ListRuntimesResponse {#ListRuntimesResponse}

Поле | Описание
--- | ---
runtimes[] | **string**<br>Среды выполнения, доступные для указанной функции. 


## ListOperations {#ListOperations}

Возвращает список операций для указанной функции.

**rpc ListOperations ([ListFunctionOperationsRequest](#ListFunctionOperationsRequest)) returns ([ListFunctionOperationsResponse](#ListFunctionOperationsResponse))**

### ListFunctionOperationsRequest {#ListFunctionOperationsRequest}

Поле | Описание
--- | ---
function_id | **string**<br>Обязательное поле. Идентификатор функции, для которой нужно вернуть список версий. 
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `pageSize`, сервис вернет значение [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse), которое можно использовать для получения следующей страницы. <br>Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `pageToken` равным значению поля [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Function.name](#Function4). </li><li>Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Пример фильтра: `name=my-function`.</li></ol> Максимальная длина строки в символах — 1000.


### ListFunctionOperationsResponse {#ListFunctionOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>Список операций для указанной функции. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListFunctionOperationsRequest.page_size](#ListFunctionOperationsRequest), используйте `nextPageToken` в качестве значения параметра [ListFunctionOperationsRequest.page_token](#ListFunctionOperationsRequest) в следующем запросе списка ресурсов. <br>Все последующие запросы будут получать свои значения `nextPageToken` для перебора страниц результатов. 


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


## ListAccessBindings {#ListAccessBindings}

Возвращает список привязок прав доступа для указанной функции.

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
type | **string**<br>Обязательное поле. <ul><li>`userAccount` — аккаунт на Яндексе или Яндекс.Коннекте, добавленный в {{ yandex-cloud }}. </li><li>`serviceAccount` — сервисный аккаунт. Этот тип представляет ресурс `yandex.cloud.iam.v1.ServiceAccount`. </li><li>`federatedUser` — федеративный аккаунт. Этот тип представляет пользователя из федерации удостоверений, например Active Directory. </li><li>`system` — системная группа. Представляет набор аккаунтов, который описывается общим системным идентификатором. </li></ul> Максимальная длина строки в символах — 100.


## SetAccessBindings {#SetAccessBindings}

Устанавливает привязки прав доступа для указанной функции.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation8))**

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
type | **string**<br>Обязательное поле. <ul><li>`userAccount` — аккаунт на Яндексе или Яндекс.Коннекте, добавленный в {{ yandex-cloud }}. </li><li>`serviceAccount` — сервисный аккаунт. Этот тип представляет ресурс `yandex.cloud.iam.v1.ServiceAccount`. </li><li>`federatedUser` — федеративный аккаунт. Этот тип представляет пользователя из федерации удостоверений, например Active Directory. </li><li>`system` — системная группа. Представляет набор аккаунтов, который описывается общим системным идентификатором. </li></ul> Максимальная длина строки в символах — 100.


### Operation {#Operation8}

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

Обновляет привязки прав доступа для указанной функции.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation9))**

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
type | **string**<br>Обязательное поле. <ul><li>`userAccount` — аккаунт на Яндексе или Яндекс.Коннекте, добавленный в {{ yandex-cloud }}. </li><li>`serviceAccount` — сервисный аккаунт. Этот тип представляет ресурс `yandex.cloud.iam.v1.ServiceAccount`. </li><li>`federatedUser` — федеративный аккаунт. Этот тип представляет пользователя из федерации удостоверений, например Active Directory. </li><li>`system` — системная группа. Представляет набор аккаунтов, который описывается общим системным идентификатором. </li></ul> Максимальная длина строки в символах — 100.


### Operation {#Operation9}

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


