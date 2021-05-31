---
editable: false
---

# CertificateService

Набор методов для управления сертификатами.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает информацию об указанном сертификате. |
| [List](#List) | Возвращает список сертификатов в указанном каталоге. |
| [Create](#Create) | Создает пользовательский сертификат в указанном каталоге. |
| [Update](#Update) | Обновляет указанный сертификат. |
| [Delete](#Delete) | Удаляет указанный сертификат. |
| [RequestNew](#RequestNew) | Создает сертификат от Let's Encrypt. |
| [ListOperations](#ListOperations) | Перечисляет операции для указанного сертификата. |
| [ListAccessBindings](#ListAccessBindings) | Возвращает список привязок прав доступа для указанного сертификата. |
| [SetAccessBindings](#SetAccessBindings) | Устанавливает привязки прав доступа для сертификата. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Обновляет привязки прав доступа для указанного сертификата. |

## Вызовы CertificateService {#calls}

## Get {#Get}

Возвращает информацию об указанном сертификате. <br>Чтобы получить список доступных сертификатов, используйте запрос [List](#List).

**rpc Get ([GetCertificateRequest](#GetCertificateRequest)) returns ([Certificate](#Certificate))**

### GetCertificateRequest {#GetCertificateRequest}

Поле | Описание
--- | ---
certificate_id | **string**<br>Обязательное поле. Идентификатор возвращаемого сертификата. <br>Чтобы получить идентификатор сертификата, используйте запрос [CertificateService.List](#List). Максимальная длина строки в символах — 50.
view | enum **CertificateView**<br>Тип вывода сертификата. <ul><li>`BASIC`: Вывод основной информации о сертификате.</li><li>`FULL`: Вывод полной информации о сертификате, включающей данные для прохождения процедуры проверки прав владения доменом.</li><ul/>


### Certificate {#Certificate}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор сертификата. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит сертификат. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя сертификата. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание сертификата. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
type | enum **CertificateType**<br>Тип сертификата. <ul><li>`IMPORTED`: Сертификат импортирован пользователем.</li><li>`MANAGED`: Сертификат создан сервисом.</li><ul/>
domains[] | **string**<br>Полные доменные имена сертификата. 
status | enum **Status**<br>Статус сертификата. <ul><li>`VALIDATING`: Требуется проверка доменов сертификатов. Используется только для сертификатов от Let's Encrypt®.</li><li>`INVALID`: Выдача сертификата не удалась. Используется только для сертификатов от Let's Encrypt®.</li><li>`ISSUED`: Сертификат выдан.</li><li>`REVOKED`: Сертификат отозван или аннулирован.</li><li>`RENEWING`: Сертификат обновляется. Используется только для сертификатов от Let's Encrypt®.</li><li>`RENEWAL_FAILED`: Обновление сертификата не удалось. Используется только для сертификатов от Let's Encrypt®.</li><ul/>
issuer | **string**<br>Уникальное имя [Distinguished Name](https://tools.ietf.org/html/rfc1779) центра сертификации, выпустившего сертификат. 
subject | **string**<br>Уникальное имя [Distinguished Name](https://tools.ietf.org/html/rfc1779) сущности, связанной с открытым ключом, содержащимся в сертификате. 
serial | **string**<br>Серийный номер сертификата. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последнего изменения сертификата. 
issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время выдачи сертификата. 
not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, по истечении которого сертификат считается недействительным. 
not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, после наступления которого сертификат считается действительным. 
challenges[] | **[Challenge](#Challenge)**<br>Данные, используемые при прохождении процедуры проверки прав на владение доменами сертификата. 


### Challenge {#Challenge}

Поле | Описание
--- | ---
domain | **string**<br>Домен, права на владение которым проверяются. 
type | enum **ChallengeType**<br>Тип процедуры проверки. <ul><li>`DNS`: Тип проверки домена, использующий DNS-записи.</li><li>`HTTP`: Тип проверки домена, использующий HTTP-файлы.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда была начата процедура проверки. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последней проверки. 
status | enum **Status**<br>Статус процедуры проверки. <ul><li>`PENDING`: Процедура проверки ждет, пока пользователь выполнит действия, необходимые для прохождения проверки.</li><li>`PROCESSING`: Процедура проверки ожидает одобрения от Let's Encrypt®.</li><li>`VALID`: Процедура проверки пройдена.</li><li>`INVALID`: Проверка прав для определенного домена завершилась неудачно или истек недельный период, выделенный для проверки.</li><ul/>
message | **string**<br>Описание процедуры проверки. 
error | **string**<br>Ошибка процедуры проверки. 
challenge | **oneof:** `dns_challenge` или `http_challenge`<br>Данные о процедуре проверки.
&nbsp;&nbsp;dns_challenge | **[DnsRecord](#DnsRecord)**<br>DNS-запись. 
&nbsp;&nbsp;http_challenge | **[HttpFile](#HttpFile)**<br>HTTP-файл. 


### DnsRecord {#DnsRecord}

Поле | Описание
--- | ---
name | **string**<br>Имя DNS-записи. 
type | **string**<br>Тип DNS-записи. 
value | **string**<br>Значение DNS-записи. 


### HttpFile {#HttpFile}

Поле | Описание
--- | ---
url | **string**<br>Расположение HTTP-файла. 
content | **string**<br>Содержимое HTTP-файла. 


## List {#List}

Возвращает список сертификатов в указанном каталоге.

**rpc List ([ListCertificatesRequest](#ListCertificatesRequest)) returns ([ListCertificatesResponse](#ListCertificatesResponse))**

### ListCertificatesRequest {#ListCertificatesRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка сертификатов. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListCertificatesResponse.next_page_token](#ListCertificatesResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListCertificatesResponse.next_page_token](#ListCertificatesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
view | enum **CertificateView**<br>Тип вывода сертификата. <ul><li>`BASIC`: Вывод основной информации о сертификате.</li><li>`FULL`: Вывод полной информации о сертификате, включающей данные для прохождения процедуры проверки прав владения доменом.</li><ul/>


### ListCertificatesResponse {#ListCertificatesResponse}

Поле | Описание
--- | ---
certificates[] | **[Certificate](#Certificate1)**<br>Список сертификатов в указанном каталоге. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListCertificatesRequest.page_size](#ListCertificatesRequest), используйте `next_page_token` в качестве значения параметра [ListCertificatesRequest.page_token](#ListCertificatesRequest) в следующем запросе списка ресурсов. Каждый следующий запрос списка будет иметь свой `next_page_token` для продолжения перебора страниц результатов. 


### Certificate {#Certificate1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор сертификата. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит сертификат. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя сертификата. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание сертификата. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
type | enum **CertificateType**<br>Тип сертификата. <ul><li>`IMPORTED`: Сертификат импортирован пользователем.</li><li>`MANAGED`: Сертификат создан сервисом.</li><ul/>
domains[] | **string**<br>Полные доменные имена сертификата. 
status | enum **Status**<br>Статус сертификата. <ul><li>`VALIDATING`: Требуется проверка доменов сертификатов. Используется только для сертификатов от Let's Encrypt®.</li><li>`INVALID`: Выдача сертификата не удалась. Используется только для сертификатов от Let's Encrypt®.</li><li>`ISSUED`: Сертификат выдан.</li><li>`REVOKED`: Сертификат отозван или аннулирован.</li><li>`RENEWING`: Сертификат обновляется. Используется только для сертификатов от Let's Encrypt®.</li><li>`RENEWAL_FAILED`: Обновление сертификата не удалось. Используется только для сертификатов от Let's Encrypt®.</li><ul/>
issuer | **string**<br>Уникальное имя [Distinguished Name](https://tools.ietf.org/html/rfc1779) центра сертификации, выпустившего сертификат. 
subject | **string**<br>Уникальное имя [Distinguished Name](https://tools.ietf.org/html/rfc1779) сущности, связанной с открытым ключом, содержащимся в сертификате. 
serial | **string**<br>Серийный номер сертификата. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последнего изменения сертификата. 
issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время выдачи сертификата. 
not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, по истечении которого сертификат считается недействительным. 
not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, после наступления которого сертификат считается действительным. 
challenges[] | **[Challenge](#Challenge1)**<br>Данные, используемые при прохождении процедуры проверки прав на владение доменами сертификата. 


### Challenge {#Challenge1}

Поле | Описание
--- | ---
domain | **string**<br>Домен, права на владение которым проверяются. 
type | enum **ChallengeType**<br>Тип процедуры проверки. <ul><li>`DNS`: Тип проверки домена, использующий DNS-записи.</li><li>`HTTP`: Тип проверки домена, использующий HTTP-файлы.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда была начата процедура проверки. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последней проверки. 
status | enum **Status**<br>Статус процедуры проверки. <ul><li>`PENDING`: Процедура проверки ждет, пока пользователь выполнит действия, необходимые для прохождения проверки.</li><li>`PROCESSING`: Процедура проверки ожидает одобрения от Let's Encrypt®.</li><li>`VALID`: Процедура проверки пройдена.</li><li>`INVALID`: Проверка прав для определенного домена завершилась неудачно или истек недельный период, выделенный для проверки.</li><ul/>
message | **string**<br>Описание процедуры проверки. 
error | **string**<br>Ошибка процедуры проверки. 
challenge | **oneof:** `dns_challenge` или `http_challenge`<br>Данные о процедуре проверки.
&nbsp;&nbsp;dns_challenge | **[DnsRecord](#DnsRecord1)**<br>DNS-запись. 
&nbsp;&nbsp;http_challenge | **[HttpFile](#HttpFile1)**<br>HTTP-файл. 


### DnsRecord {#DnsRecord1}

Поле | Описание
--- | ---
name | **string**<br>Имя DNS-записи. 
type | **string**<br>Тип DNS-записи. 
value | **string**<br>Значение DNS-записи. 


### HttpFile {#HttpFile1}

Поле | Описание
--- | ---
url | **string**<br>Расположение HTTP-файла. 
content | **string**<br>Содержимое HTTP-файла. 


## Create {#Create}

Создает пользовательский сертификат в указанном каталоге.

**rpc Create ([CreateCertificateRequest](#CreateCertificateRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateCertificateMetadata](#CreateCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Certificate](#Certificate2)<br>

### CreateCertificateRequest {#CreateCertificateRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается сертификат. Максимальная длина строки в символах — 50.
name | **string**<br>Имя сертификата. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Описание сертификата. Максимальная длина строки в символах — 1024.
labels | **map<string,string>**<br>Метки сертификата в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
certificate | **string**<br>Содержимое сертификата в PEM-encoded формате. Можно пропустить, если сертификат включен в цепочку доверия. Максимальная длина строки в символах — 32768.
chain | **string**<br>Содержимое цепочки сертификатов доверия сертификата в PEM-encoded формате. Максимальная длина строки в символах — 2097152.
private_key | **string**<br>Обязательное поле. Содержимое закрытого ключа сертификата в PEM-encoded формате. Длина строки в символах должна быть от 1 до 524288.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateCertificateMetadata](#CreateCertificateMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Certificate](#Certificate2)>**<br>в случае успешного выполнения операции. 


### CreateCertificateMetadata {#CreateCertificateMetadata}

Поле | Описание
--- | ---
certificate_id | **string**<br>Идентификатор создаваемого сертификата. 


### Certificate {#Certificate2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор сертификата. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит сертификат. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя сертификата. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание сертификата. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
type | enum **CertificateType**<br>Тип сертификата. <ul><li>`IMPORTED`: Сертификат импортирован пользователем.</li><li>`MANAGED`: Сертификат создан сервисом.</li><ul/>
domains[] | **string**<br>Полные доменные имена сертификата. 
status | enum **Status**<br>Статус сертификата. <ul><li>`VALIDATING`: Требуется проверка доменов сертификатов. Используется только для сертификатов от Let's Encrypt®.</li><li>`INVALID`: Выдача сертификата не удалась. Используется только для сертификатов от Let's Encrypt®.</li><li>`ISSUED`: Сертификат выдан.</li><li>`REVOKED`: Сертификат отозван или аннулирован.</li><li>`RENEWING`: Сертификат обновляется. Используется только для сертификатов от Let's Encrypt®.</li><li>`RENEWAL_FAILED`: Обновление сертификата не удалось. Используется только для сертификатов от Let's Encrypt®.</li><ul/>
issuer | **string**<br>Уникальное имя [Distinguished Name](https://tools.ietf.org/html/rfc1779) центра сертификации, выпустившего сертификат. 
subject | **string**<br>Уникальное имя [Distinguished Name](https://tools.ietf.org/html/rfc1779) сущности, связанной с открытым ключом, содержащимся в сертификате. 
serial | **string**<br>Серийный номер сертификата. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последнего изменения сертификата. 
issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время выдачи сертификата. 
not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, по истечении которого сертификат считается недействительным. 
not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, после наступления которого сертификат считается действительным. 
challenges[] | **[Challenge](#Challenge2)**<br>Данные, используемые при прохождении процедуры проверки прав на владение доменами сертификата. 


### Challenge {#Challenge2}

Поле | Описание
--- | ---
domain | **string**<br>Домен, права на владение которым проверяются. 
type | enum **ChallengeType**<br>Тип процедуры проверки. <ul><li>`DNS`: Тип проверки домена, использующий DNS-записи.</li><li>`HTTP`: Тип проверки домена, использующий HTTP-файлы.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда была начата процедура проверки. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последней проверки. 
status | enum **Status**<br>Статус процедуры проверки. <ul><li>`PENDING`: Процедура проверки ждет, пока пользователь выполнит действия, необходимые для прохождения проверки.</li><li>`PROCESSING`: Процедура проверки ожидает одобрения от Let's Encrypt®.</li><li>`VALID`: Процедура проверки пройдена.</li><li>`INVALID`: Проверка прав для определенного домена завершилась неудачно или истек недельный период, выделенный для проверки.</li><ul/>
message | **string**<br>Описание процедуры проверки. 
error | **string**<br>Ошибка процедуры проверки. 
challenge | **oneof:** `dns_challenge` или `http_challenge`<br>Данные о процедуре проверки.
&nbsp;&nbsp;dns_challenge | **[DnsRecord](#DnsRecord2)**<br>DNS-запись. 
&nbsp;&nbsp;http_challenge | **[HttpFile](#HttpFile2)**<br>HTTP-файл. 


### DnsRecord {#DnsRecord2}

Поле | Описание
--- | ---
name | **string**<br>Имя DNS-записи. 
type | **string**<br>Тип DNS-записи. 
value | **string**<br>Значение DNS-записи. 


### HttpFile {#HttpFile2}

Поле | Описание
--- | ---
url | **string**<br>Расположение HTTP-файла. 
content | **string**<br>Содержимое HTTP-файла. 


## Update {#Update}

Обновляет указанный сертификат.

**rpc Update ([UpdateCertificateRequest](#UpdateCertificateRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateCertificateMetadata](#UpdateCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Certificate](#Certificate3)<br>

### UpdateCertificateRequest {#UpdateCertificateRequest}

Поле | Описание
--- | ---
certificate_id | **string**<br>Обязательное поле. Идентификатор сертификата для обновления. Чтобы получить идентификатор сертификата, используйте запрос [CertificateService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля указанного сертификата будут обновлены. 
name | **string**<br>Новое имя сертификата. Значение должно соответствовать регулярному выражению ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Новое описание сертификата. Максимальная длина строки в символах — 1024.
labels | **map<string,string>**<br>Метки сертификата в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
certificate | **string**<br>Новое содержимое сертификата в PEM-encoded формате. Используется только для пользовательских сертификатов. Максимальная длина строки в символах — 32768.
chain | **string**<br>Новое содержимое цепочки сертификатов доверия сертификата в PEM-encoded формате. Используется только для пользовательских сертификатов. Максимальная длина строки в символах — 2097152.
private_key | **string**<br>Новое содержимое закрытого ключа сертификата в PEM-encoded формате. Используется только для пользовательских сертификатов. Максимальная длина строки в символах — 524288.


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateCertificateMetadata](#UpdateCertificateMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Certificate](#Certificate3)>**<br>в случае успешного выполнения операции. 


### UpdateCertificateMetadata {#UpdateCertificateMetadata}

Поле | Описание
--- | ---
certificate_id | **string**<br>Идентификатор обновляемого сертификата. 


### Certificate {#Certificate3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор сертификата. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит сертификат. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя сертификата. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание сертификата. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
type | enum **CertificateType**<br>Тип сертификата. <ul><li>`IMPORTED`: Сертификат импортирован пользователем.</li><li>`MANAGED`: Сертификат создан сервисом.</li><ul/>
domains[] | **string**<br>Полные доменные имена сертификата. 
status | enum **Status**<br>Статус сертификата. <ul><li>`VALIDATING`: Требуется проверка доменов сертификатов. Используется только для сертификатов от Let's Encrypt®.</li><li>`INVALID`: Выдача сертификата не удалась. Используется только для сертификатов от Let's Encrypt®.</li><li>`ISSUED`: Сертификат выдан.</li><li>`REVOKED`: Сертификат отозван или аннулирован.</li><li>`RENEWING`: Сертификат обновляется. Используется только для сертификатов от Let's Encrypt®.</li><li>`RENEWAL_FAILED`: Обновление сертификата не удалось. Используется только для сертификатов от Let's Encrypt®.</li><ul/>
issuer | **string**<br>Уникальное имя [Distinguished Name](https://tools.ietf.org/html/rfc1779) центра сертификации, выпустившего сертификат. 
subject | **string**<br>Уникальное имя [Distinguished Name](https://tools.ietf.org/html/rfc1779) сущности, связанной с открытым ключом, содержащимся в сертификате. 
serial | **string**<br>Серийный номер сертификата. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последнего изменения сертификата. 
issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время выдачи сертификата. 
not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, по истечении которого сертификат считается недействительным. 
not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, после наступления которого сертификат считается действительным. 
challenges[] | **[Challenge](#Challenge3)**<br>Данные, используемые при прохождении процедуры проверки прав на владение доменами сертификата. 


### Challenge {#Challenge3}

Поле | Описание
--- | ---
domain | **string**<br>Домен, права на владение которым проверяются. 
type | enum **ChallengeType**<br>Тип процедуры проверки. <ul><li>`DNS`: Тип проверки домена, использующий DNS-записи.</li><li>`HTTP`: Тип проверки домена, использующий HTTP-файлы.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда была начата процедура проверки. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последней проверки. 
status | enum **Status**<br>Статус процедуры проверки. <ul><li>`PENDING`: Процедура проверки ждет, пока пользователь выполнит действия, необходимые для прохождения проверки.</li><li>`PROCESSING`: Процедура проверки ожидает одобрения от Let's Encrypt®.</li><li>`VALID`: Процедура проверки пройдена.</li><li>`INVALID`: Проверка прав для определенного домена завершилась неудачно или истек недельный период, выделенный для проверки.</li><ul/>
message | **string**<br>Описание процедуры проверки. 
error | **string**<br>Ошибка процедуры проверки. 
challenge | **oneof:** `dns_challenge` или `http_challenge`<br>Данные о процедуре проверки.
&nbsp;&nbsp;dns_challenge | **[DnsRecord](#DnsRecord3)**<br>DNS-запись. 
&nbsp;&nbsp;http_challenge | **[HttpFile](#HttpFile3)**<br>HTTP-файл. 


### DnsRecord {#DnsRecord3}

Поле | Описание
--- | ---
name | **string**<br>Имя DNS-записи. 
type | **string**<br>Тип DNS-записи. 
value | **string**<br>Значение DNS-записи. 


### HttpFile {#HttpFile3}

Поле | Описание
--- | ---
url | **string**<br>Расположение HTTP-файла. 
content | **string**<br>Содержимое HTTP-файла. 


## Delete {#Delete}

Удаляет указанный сертификат.

**rpc Delete ([DeleteCertificateRequest](#DeleteCertificateRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteCertificateMetadata](#DeleteCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Certificate](#Certificate4)<br>

### DeleteCertificateRequest {#DeleteCertificateRequest}

Поле | Описание
--- | ---
certificate_id | **string**<br>Обязательное поле. Идентификатор сертификата, который следует удалить. Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteCertificateMetadata](#DeleteCertificateMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Certificate](#Certificate4)>**<br>в случае успешного выполнения операции. 


### DeleteCertificateMetadata {#DeleteCertificateMetadata}

Поле | Описание
--- | ---
certificate_id | **string**<br>Идентификатор удаляемого сертификата. 


### Certificate {#Certificate4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор сертификата. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит сертификат. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя сертификата. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание сертификата. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
type | enum **CertificateType**<br>Тип сертификата. <ul><li>`IMPORTED`: Сертификат импортирован пользователем.</li><li>`MANAGED`: Сертификат создан сервисом.</li><ul/>
domains[] | **string**<br>Полные доменные имена сертификата. 
status | enum **Status**<br>Статус сертификата. <ul><li>`VALIDATING`: Требуется проверка доменов сертификатов. Используется только для сертификатов от Let's Encrypt®.</li><li>`INVALID`: Выдача сертификата не удалась. Используется только для сертификатов от Let's Encrypt®.</li><li>`ISSUED`: Сертификат выдан.</li><li>`REVOKED`: Сертификат отозван или аннулирован.</li><li>`RENEWING`: Сертификат обновляется. Используется только для сертификатов от Let's Encrypt®.</li><li>`RENEWAL_FAILED`: Обновление сертификата не удалось. Используется только для сертификатов от Let's Encrypt®.</li><ul/>
issuer | **string**<br>Уникальное имя [Distinguished Name](https://tools.ietf.org/html/rfc1779) центра сертификации, выпустившего сертификат. 
subject | **string**<br>Уникальное имя [Distinguished Name](https://tools.ietf.org/html/rfc1779) сущности, связанной с открытым ключом, содержащимся в сертификате. 
serial | **string**<br>Серийный номер сертификата. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последнего изменения сертификата. 
issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время выдачи сертификата. 
not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, по истечении которого сертификат считается недействительным. 
not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, после наступления которого сертификат считается действительным. 
challenges[] | **[Challenge](#Challenge4)**<br>Данные, используемые при прохождении процедуры проверки прав на владение доменами сертификата. 


### Challenge {#Challenge4}

Поле | Описание
--- | ---
domain | **string**<br>Домен, права на владение которым проверяются. 
type | enum **ChallengeType**<br>Тип процедуры проверки. <ul><li>`DNS`: Тип проверки домена, использующий DNS-записи.</li><li>`HTTP`: Тип проверки домена, использующий HTTP-файлы.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда была начата процедура проверки. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последней проверки. 
status | enum **Status**<br>Статус процедуры проверки. <ul><li>`PENDING`: Процедура проверки ждет, пока пользователь выполнит действия, необходимые для прохождения проверки.</li><li>`PROCESSING`: Процедура проверки ожидает одобрения от Let's Encrypt®.</li><li>`VALID`: Процедура проверки пройдена.</li><li>`INVALID`: Проверка прав для определенного домена завершилась неудачно или истек недельный период, выделенный для проверки.</li><ul/>
message | **string**<br>Описание процедуры проверки. 
error | **string**<br>Ошибка процедуры проверки. 
challenge | **oneof:** `dns_challenge` или `http_challenge`<br>Данные о процедуре проверки.
&nbsp;&nbsp;dns_challenge | **[DnsRecord](#DnsRecord4)**<br>DNS-запись. 
&nbsp;&nbsp;http_challenge | **[HttpFile](#HttpFile4)**<br>HTTP-файл. 


### DnsRecord {#DnsRecord4}

Поле | Описание
--- | ---
name | **string**<br>Имя DNS-записи. 
type | **string**<br>Тип DNS-записи. 
value | **string**<br>Значение DNS-записи. 


### HttpFile {#HttpFile4}

Поле | Описание
--- | ---
url | **string**<br>Расположение HTTP-файла. 
content | **string**<br>Содержимое HTTP-файла. 


## RequestNew {#RequestNew}

Создает сертификат от Let's Encrypt.

**rpc RequestNew ([RequestNewCertificateRequest](#RequestNewCertificateRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RequestNewCertificateMetadata](#RequestNewCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Certificate](#Certificate5)<br>

### RequestNewCertificateRequest {#RequestNewCertificateRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается сертификат. Максимальная длина строки в символах — 50.
name | **string**<br>Имя сертификата. Значение должно соответствовать регулярному выражению ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Описание сертификата. Максимальная длина строки в символах — 1024.
labels | **map<string,string>**<br>Метки сертификата в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
domains[] | **string**<br>Полные доменные имена сертификата. 
challenge_type | enum **ChallengeType**<br>Тип процедуры проверки домена. <ul><li>`DNS`: Тип проверки домена, использующий DNS-записи.</li><li>`HTTP`: Тип проверки домена, использующий HTTP-файлы.</li><ul/>


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RequestNewCertificateMetadata](#RequestNewCertificateMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Certificate](#Certificate5)>**<br>в случае успешного выполнения операции. 


### RequestNewCertificateMetadata {#RequestNewCertificateMetadata}

Поле | Описание
--- | ---
certificate_id | **string**<br>Идентификатор запрашиваемого сертификата. 


### Certificate {#Certificate5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор сертификата. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит сертификат. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса. 
name | **string**<br>Имя сертификата. Имя должно быть уникальным в каталоге. 
description | **string**<br>Описание сертификата. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. 
type | enum **CertificateType**<br>Тип сертификата. <ul><li>`IMPORTED`: Сертификат импортирован пользователем.</li><li>`MANAGED`: Сертификат создан сервисом.</li><ul/>
domains[] | **string**<br>Полные доменные имена сертификата. 
status | enum **Status**<br>Статус сертификата. <ul><li>`VALIDATING`: Требуется проверка доменов сертификатов. Используется только для сертификатов от Let's Encrypt®.</li><li>`INVALID`: Выдача сертификата не удалась. Используется только для сертификатов от Let's Encrypt®.</li><li>`ISSUED`: Сертификат выдан.</li><li>`REVOKED`: Сертификат отозван или аннулирован.</li><li>`RENEWING`: Сертификат обновляется. Используется только для сертификатов от Let's Encrypt®.</li><li>`RENEWAL_FAILED`: Обновление сертификата не удалось. Используется только для сертификатов от Let's Encrypt®.</li><ul/>
issuer | **string**<br>Уникальное имя [Distinguished Name](https://tools.ietf.org/html/rfc1779) центра сертификации, выпустившего сертификат. 
subject | **string**<br>Уникальное имя [Distinguished Name](https://tools.ietf.org/html/rfc1779) сущности, связанной с открытым ключом, содержащимся в сертификате. 
serial | **string**<br>Серийный номер сертификата. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последнего изменения сертификата. 
issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время выдачи сертификата. 
not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, по истечении которого сертификат считается недействительным. 
not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, после наступления которого сертификат считается действительным. 
challenges[] | **[Challenge](#Challenge5)**<br>Данные, используемые при прохождении процедуры проверки прав на владение доменами сертификата. 


### Challenge {#Challenge5}

Поле | Описание
--- | ---
domain | **string**<br>Домен, права на владение которым проверяются. 
type | enum **ChallengeType**<br>Тип процедуры проверки. <ul><li>`DNS`: Тип проверки домена, использующий DNS-записи.</li><li>`HTTP`: Тип проверки домена, использующий HTTP-файлы.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда была начата процедура проверки. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последней проверки. 
status | enum **Status**<br>Статус процедуры проверки. <ul><li>`PENDING`: Процедура проверки ждет, пока пользователь выполнит действия, необходимые для прохождения проверки.</li><li>`PROCESSING`: Процедура проверки ожидает одобрения от Let's Encrypt®.</li><li>`VALID`: Процедура проверки пройдена.</li><li>`INVALID`: Проверка прав для определенного домена завершилась неудачно или истек недельный период, выделенный для проверки.</li><ul/>
message | **string**<br>Описание процедуры проверки. 
error | **string**<br>Ошибка процедуры проверки. 
challenge | **oneof:** `dns_challenge` или `http_challenge`<br>Данные о процедуре проверки.
&nbsp;&nbsp;dns_challenge | **[DnsRecord](#DnsRecord5)**<br>DNS-запись. 
&nbsp;&nbsp;http_challenge | **[HttpFile](#HttpFile5)**<br>HTTP-файл. 


### DnsRecord {#DnsRecord5}

Поле | Описание
--- | ---
name | **string**<br>Имя DNS-записи. 
type | **string**<br>Тип DNS-записи. 
value | **string**<br>Значение DNS-записи. 


### HttpFile {#HttpFile5}

Поле | Описание
--- | ---
url | **string**<br>Расположение HTTP-файла. 
content | **string**<br>Содержимое HTTP-файла. 


## ListOperations {#ListOperations}

Перечисляет операции для указанного сертификата.

**rpc ListOperations ([ListCertificateOperationsRequest](#ListCertificateOperationsRequest)) returns ([ListCertificateOperationsResponse](#ListCertificateOperationsResponse))**

### ListCertificateOperationsRequest {#ListCertificateOperationsRequest}

Поле | Описание
--- | ---
certificate_id | **string**<br>Обязательное поле. Идентификатор сертификата для перечисления операций. <br>Чтобы получить идентификатор сертификата, используйте запрос [CertificateService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size`, сервис вернет значение [ListCertificateOperationsResponse.next_page_token](#ListCertificateOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListCertificateOperationsResponse.next_page_token](#ListCertificateOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListCertificateOperationsResponse {#ListCertificateOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation4)**<br>Список операций для указанного сертификата. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListCertificateOperationsRequest.page_size](#ListCertificateOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListCertificateOperationsRequest.page_token](#ListCertificateOperationsRequest) в следующем запросе списка ресурсов. Каждая следующий запрос будет иметь свой `next_page_token` для продолжения перебора страниц результатов. 


### Operation {#Operation4}

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

Возвращает список привязок прав доступа для указанного сертификата.

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

Устанавливает привязки прав доступа для сертификата.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation5))**

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


### Operation {#Operation5}

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

Обновляет привязки прав доступа для указанного сертификата.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation6))**

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


### Operation {#Operation6}

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


