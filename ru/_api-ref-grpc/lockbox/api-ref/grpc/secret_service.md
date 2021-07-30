---
editable: false
---

# SecretService

Набор методов для управления секретами.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный секрет. |
| [List](#List) | Возвращает список секретов в указанном каталоге. |
| [Create](#Create) | Создает секрет в указанном каталоге. |
| [Update](#Update) | Обновляет указанный секрет. |
| [Delete](#Delete) | Удаляет указанный секрет. |
| [Activate](#Activate) | Активирует указанный секрет. |
| [Deactivate](#Deactivate) | Деактивирует указанный секрет. |
| [ListVersions](#ListVersions) | Возвращает список версий указанного секрета. |
| [AddVersion](#AddVersion) | Добавляет новую версию на основе предыдущей. |
| [ScheduleVersionDestruction](#ScheduleVersionDestruction) | Планирует уничтожение указанной версии ключа. |
| [CancelVersionDestruction](#CancelVersionDestruction) | Отменяет запланированное уничтожение версии, если версия еще не была уничтожена. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанного секрета. |
| [ListAccessBindings](#ListAccessBindings) | Возвращает список привязок прав доступа для указанного сертификата. |
| [SetAccessBindings](#SetAccessBindings) | Устанавливает привязки прав доступа для секрета. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Обновляет привязки прав доступа для секрета. |

## Вызовы SecretService {#calls}

## Get {#Get}

Возвращает указанный секрет. <br>Чтобы получить список доступных секретов, выполните запрос [List](#List). Чтобы получить содержимое версии, используйте запрос [PayloadService.Get](./payload_service#Get).

**rpc Get ([GetSecretRequest](#GetSecretRequest)) returns ([Secret](#Secret))**

### GetSecretRequest {#GetSecretRequest}

Поле | Описание
--- | ---
secret_id | **string**<br>Обязательное поле. Идентификатор возвращаемого секрета. <br>Чтобы получить идентификатор секрета, выполните запрос [List](#List). Максимальная длина строки в символах — 50.


### Secret {#Secret}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор секрета. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит секрет. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя секрета. 
description | **string**<br>(опционально) Описание секрета. 
labels | **map<string,string>**<br>Пользовательские метки для секрета в виде пар `key:value`. Максимум 64 на ключ. 
kms_key_id | **string**<br>(опционально) Идентификатор пользовательского ключа KMS. Если пользовательский ключ не указан, для шифрования и расшифровки используется системный ключ. 
status | enum **Status**<br>Статус секрета. <ul><li>`CREATING`: Секрет создается.</li><li>`ACTIVE`: Секрет активен и к нему можно получить доступ. <br>Можно установить в INACTIVE с помощью метода [SecretService.Deactivate](#Deactivate).</li><li>`INACTIVE`: Секрет неактивен и не может быть использован. <br>Можно установить в ACTIVE с помощью метода [SecretService.Activate](#Activate).</li><ul/>
current_version | **[Version](#Version)**<br>Текущая версия секрета. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление секрета. 


### Version {#Version}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
secret_id | **string**<br>Идентификатор секрета, которому принадлежит версия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус `ACTIVE`. 
description | **string**<br>(опционально) Описание версии. 
status | enum **Status**<br>Статус секрета. <ul><li>`ACTIVE`: Секрет активен и к нему можно получить доступ.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению. Время, когда она будет уничтожена, указано в поле [Version.destroy_at](#Version).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
payload_entry_keys[] | **string**<br>Ключи содержимого версии. 


## List {#List}

Возвращает список секретов в указанном каталоге.

**rpc List ([ListSecretsRequest](#ListSecretsRequest)) returns ([ListSecretsResponse](#ListSecretsResponse))**

### ListSecretsRequest {#ListSecretsRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка секретов. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListSecretsRequest.next_page_token](#ListSecretsRequest), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListSecretsRequest.next_page_token](#ListSecretsRequest), прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListSecretsResponse {#ListSecretsResponse}

Поле | Описание
--- | ---
secrets[] | **[Secret](#Secret1)**<br>Возвращает список секретов в указанном каталоге. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListSecretsRequest.page_size](#ListSecretsRequest), используйте `next_page_token` в качестве значения параметра [ListSecretsRequest.page_token](#ListSecretsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token`, для перебора страниц результатов. 


### Secret {#Secret1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор секрета. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит секрет. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя секрета. 
description | **string**<br>(опционально) Описание секрета. 
labels | **map<string,string>**<br>Пользовательские метки для секрета в виде пар `key:value`. Максимум 64 на ключ. 
kms_key_id | **string**<br>(опционально) Идентификатор пользовательского ключа KMS. Если пользовательский ключ не указан, для шифрования и расшифровки используется системный ключ. 
status | enum **Status**<br>Статус секрета. <ul><li>`CREATING`: Секрет создается.</li><li>`ACTIVE`: Секрет активен и к нему можно получить доступ. <br>Можно установить в INACTIVE с помощью метода [SecretService.Deactivate](#Deactivate).</li><li>`INACTIVE`: Секрет неактивен и не может быть использован. <br>Можно установить в ACTIVE с помощью метода [SecretService.Activate](#Activate).</li><ul/>
current_version | **[Version](#Version1)**<br>Текущая версия секрета. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление секрета. 


### Version {#Version1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
secret_id | **string**<br>Идентификатор секрета, которому принадлежит версия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус `ACTIVE`. 
description | **string**<br>(опционально) Описание версии. 
status | enum **Status**<br>Статус секрета. <ul><li>`ACTIVE`: Секрет активен и к нему можно получить доступ.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению. Время, когда она будет уничтожена, указано в поле [Version.destroy_at](#Version1).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
payload_entry_keys[] | **string**<br>Ключи содержимого версии. 


## Create {#Create}

Создает секрет в указанном каталоге.

**rpc Create ([CreateSecretRequest](#CreateSecretRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateSecretMetadata](#CreateSecretMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Secret](#Secret2)<br>

### CreateSecretRequest {#CreateSecretRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается секрет. Максимальная длина строки в символах — 50.
name | **string**<br>Имя секрета. Максимальная длина строки в символах — 100.
description | **string**<br>Описание секрета. Максимальная длина строки в символах — 1024.
labels | **map<string,string>**<br>Пользовательские метки для секрета в виде пар `key:value`. Максимум 64 на ключ. Например, `"project": "mvp"` или `"source": "dictionary"`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
kms_key_id | **string**<br>(опционально) Идентификатор ключа KMS. Используется для шифрования и расшифровки секрета. Максимальная длина строки в символах — 50.
version_description | **string**<br>Описание первой версии. Максимальная длина строки в символах — 256.
version_payload_entries[] | **[PayloadEntryChange](#PayloadEntryChange)**<br>Содержимое первой версии секрета. Максимальное количество элементов — 32.
deletion_protection | **bool**<br>Флаг, запрещающий удаление секрета. 


### PayloadEntryChange {#PayloadEntryChange}

Поле | Описание
--- | ---
key | **string**<br>Обязательное поле. Неконфиденциальный ключ содержимого версии. Максимальная длина строки в символах — 256. Значение должно соответствовать регулярному выражению ` [-_./\\\\@0-9a-zA-Z]+ `.
value | **oneof:** `text_value` или `binary_value`<br>Конфиденциальная часть содержимого версии.
&nbsp;&nbsp;text_value | **string**<br>Используйте это поле для задания текстового значения. Максимальная длина строки в символах — 65536.
&nbsp;&nbsp;binary_value | **bytes**<br>Используйте это поле для установки двоичного значения. Максимальная длина строки в символах — 65536.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateSecretMetadata](#CreateSecretMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Secret](#Secret2)>**<br>в случае успешного выполнения операции. 


### CreateSecretMetadata {#CreateSecretMetadata}

Поле | Описание
--- | ---
secret_id | **string**<br>Идентификатор создаваемого секрета. 
version_id | **string**<br>Идентификатор текущей версии создаваемого секрета. 


### Secret {#Secret2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор секрета. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит секрет. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя секрета. 
description | **string**<br>(опционально) Описание секрета. 
labels | **map<string,string>**<br>Пользовательские метки для секрета в виде пар `key:value`. Максимум 64 на ключ. 
kms_key_id | **string**<br>(опционально) Идентификатор пользовательского ключа KMS. Если пользовательский ключ не указан, для шифрования и расшифровки используется системный ключ. 
status | enum **Status**<br>Статус секрета. <ul><li>`CREATING`: Секрет создается.</li><li>`ACTIVE`: Секрет активен и к нему можно получить доступ. <br>Можно установить в INACTIVE с помощью метода [SecretService.Deactivate](#Deactivate).</li><li>`INACTIVE`: Секрет неактивен и не может быть использован. <br>Можно установить в ACTIVE с помощью метода [SecretService.Activate](#Activate).</li><ul/>
current_version | **[Version](#Version2)**<br>Текущая версия секрета. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление секрета. 


### Version {#Version2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
secret_id | **string**<br>Идентификатор секрета, которому принадлежит версия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус `ACTIVE`. 
description | **string**<br>(опционально) Описание версии. 
status | enum **Status**<br>Статус секрета. <ul><li>`ACTIVE`: Секрет активен и к нему можно получить доступ.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению. Время, когда она будет уничтожена, указано в поле [Version.destroy_at](#Version2).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
payload_entry_keys[] | **string**<br>Ключи содержимого версии. 


## Update {#Update}

Обновляет указанный секрет.

**rpc Update ([UpdateSecretRequest](#UpdateSecretRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSecretMetadata](#UpdateSecretMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Secret](#Secret3)<br>

### UpdateSecretRequest {#UpdateSecretRequest}

Поле | Описание
--- | ---
secret_id | **string**<br>Обязательное поле. Идентификатор секрета для обновления. Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Обязательное поле. Маска, определяющая, какие поля указанного сертификата будут обновлены. 
name | **string**<br>Новое имя секрета. Максимальная длина строки в символах — 100.
description | **string**<br>Новое описание секрета. Максимальная длина строки в символах — 1024.
labels | **map<string,string>**<br>Пользовательские метки для секрета в виде пар @b "key:value". Максимум 64 на ключ. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
deletion_protection | **bool**<br>Флаг, запрещающий удаление секрета. 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSecretMetadata](#UpdateSecretMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Secret](#Secret3)>**<br>в случае успешного выполнения операции. 


### UpdateSecretMetadata {#UpdateSecretMetadata}

Поле | Описание
--- | ---
secret_id | **string**<br>Обязательное поле. Идентификатор обновляемого секрета. Максимальная длина строки в символах — 50.


### Secret {#Secret3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор секрета. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит секрет. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя секрета. 
description | **string**<br>(опционально) Описание секрета. 
labels | **map<string,string>**<br>Пользовательские метки для секрета в виде пар `key:value`. Максимум 64 на ключ. 
kms_key_id | **string**<br>(опционально) Идентификатор пользовательского ключа KMS. Если пользовательский ключ не указан, для шифрования и расшифровки используется системный ключ. 
status | enum **Status**<br>Статус секрета. <ul><li>`CREATING`: Секрет создается.</li><li>`ACTIVE`: Секрет активен и к нему можно получить доступ. <br>Можно установить в INACTIVE с помощью метода [SecretService.Deactivate](#Deactivate).</li><li>`INACTIVE`: Секрет неактивен и не может быть использован. <br>Можно установить в ACTIVE с помощью метода [SecretService.Activate](#Activate).</li><ul/>
current_version | **[Version](#Version3)**<br>Текущая версия секрета. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление секрета. 


### Version {#Version3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
secret_id | **string**<br>Идентификатор секрета, которому принадлежит версия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус `ACTIVE`. 
description | **string**<br>(опционально) Описание версии. 
status | enum **Status**<br>Статус секрета. <ul><li>`ACTIVE`: Секрет активен и к нему можно получить доступ.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению. Время, когда она будет уничтожена, указано в поле [Version.destroy_at](#Version3).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
payload_entry_keys[] | **string**<br>Ключи содержимого версии. 


## Delete {#Delete}

Удаляет указанный секрет.

**rpc Delete ([DeleteSecretRequest](#DeleteSecretRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteSecretMetadata](#DeleteSecretMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Secret](#Secret4)<br>

### DeleteSecretRequest {#DeleteSecretRequest}

Поле | Описание
--- | ---
secret_id | **string**<br>Обязательное поле. Идентификатор секрета, подлежащего удалению. Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteSecretMetadata](#DeleteSecretMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Secret](#Secret4)>**<br>в случае успешного выполнения операции. 


### DeleteSecretMetadata {#DeleteSecretMetadata}

Поле | Описание
--- | ---
secret_id | **string**<br>Идентификатор удаляемого секрета. 


### Secret {#Secret4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор секрета. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит секрет. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя секрета. 
description | **string**<br>(опционально) Описание секрета. 
labels | **map<string,string>**<br>Пользовательские метки для секрета в виде пар `key:value`. Максимум 64 на ключ. 
kms_key_id | **string**<br>(опционально) Идентификатор пользовательского ключа KMS. Если пользовательский ключ не указан, для шифрования и расшифровки используется системный ключ. 
status | enum **Status**<br>Статус секрета. <ul><li>`CREATING`: Секрет создается.</li><li>`ACTIVE`: Секрет активен и к нему можно получить доступ. <br>Можно установить в INACTIVE с помощью метода [SecretService.Deactivate](#Deactivate).</li><li>`INACTIVE`: Секрет неактивен и не может быть использован. <br>Можно установить в ACTIVE с помощью метода [SecretService.Activate](#Activate).</li><ul/>
current_version | **[Version](#Version4)**<br>Текущая версия секрета. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление секрета. 


### Version {#Version4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
secret_id | **string**<br>Идентификатор секрета, которому принадлежит версия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус `ACTIVE`. 
description | **string**<br>(опционально) Описание версии. 
status | enum **Status**<br>Статус секрета. <ul><li>`ACTIVE`: Секрет активен и к нему можно получить доступ.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению. Время, когда она будет уничтожена, указано в поле [Version.destroy_at](#Version4).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
payload_entry_keys[] | **string**<br>Ключи содержимого версии. 


## Activate {#Activate}

Активирует указанный секрет.

**rpc Activate ([ActivateSecretRequest](#ActivateSecretRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ActivateSecretMetadata](#ActivateSecretMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Secret](#Secret5)<br>

### ActivateSecretRequest {#ActivateSecretRequest}

Поле | Описание
--- | ---
secret_id | **string**<br>Обязательное поле. Идентификатор секрета для активации. Максимальная длина строки в символах — 50.


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ActivateSecretMetadata](#ActivateSecretMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Secret](#Secret5)>**<br>в случае успешного выполнения операции. 


### ActivateSecretMetadata {#ActivateSecretMetadata}

Поле | Описание
--- | ---
secret_id | **string**<br>Идентификатор активируемого секрета. 


### Secret {#Secret5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор секрета. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит секрет. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя секрета. 
description | **string**<br>(опционально) Описание секрета. 
labels | **map<string,string>**<br>Пользовательские метки для секрета в виде пар `key:value`. Максимум 64 на ключ. 
kms_key_id | **string**<br>(опционально) Идентификатор пользовательского ключа KMS. Если пользовательский ключ не указан, для шифрования и расшифровки используется системный ключ. 
status | enum **Status**<br>Статус секрета. <ul><li>`CREATING`: Секрет создается.</li><li>`ACTIVE`: Секрет активен и к нему можно получить доступ. <br>Можно установить в INACTIVE с помощью метода [SecretService.Deactivate](#Deactivate).</li><li>`INACTIVE`: Секрет неактивен и не может быть использован. <br>Можно установить в ACTIVE с помощью метода [SecretService.Activate](#Activate).</li><ul/>
current_version | **[Version](#Version5)**<br>Текущая версия секрета. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление секрета. 


### Version {#Version5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
secret_id | **string**<br>Идентификатор секрета, которому принадлежит версия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус `ACTIVE`. 
description | **string**<br>(опционально) Описание версии. 
status | enum **Status**<br>Статус секрета. <ul><li>`ACTIVE`: Секрет активен и к нему можно получить доступ.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению. Время, когда она будет уничтожена, указано в поле [Version.destroy_at](#Version5).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
payload_entry_keys[] | **string**<br>Ключи содержимого версии. 


## Deactivate {#Deactivate}

Деактивирует указанный секрет.

**rpc Deactivate ([DeactivateSecretRequest](#DeactivateSecretRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeactivateSecretMetadata](#DeactivateSecretMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Secret](#Secret6)<br>

### DeactivateSecretRequest {#DeactivateSecretRequest}

Поле | Описание
--- | ---
secret_id | **string**<br>Обязательное поле. Идентификатор секрета для деактивации. Максимальная длина строки в символах — 50.


### Operation {#Operation4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeactivateSecretMetadata](#DeactivateSecretMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Secret](#Secret6)>**<br>в случае успешного выполнения операции. 


### DeactivateSecretMetadata {#DeactivateSecretMetadata}

Поле | Описание
--- | ---
secret_id | **string**<br>Идентификатор деактивируемого секрета. 


### Secret {#Secret6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор секрета. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит секрет. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя секрета. 
description | **string**<br>(опционально) Описание секрета. 
labels | **map<string,string>**<br>Пользовательские метки для секрета в виде пар `key:value`. Максимум 64 на ключ. 
kms_key_id | **string**<br>(опционально) Идентификатор пользовательского ключа KMS. Если пользовательский ключ не указан, для шифрования и расшифровки используется системный ключ. 
status | enum **Status**<br>Статус секрета. <ul><li>`CREATING`: Секрет создается.</li><li>`ACTIVE`: Секрет активен и к нему можно получить доступ. <br>Можно установить в INACTIVE с помощью метода [SecretService.Deactivate](#Deactivate).</li><li>`INACTIVE`: Секрет неактивен и не может быть использован. <br>Можно установить в ACTIVE с помощью метода [SecretService.Activate](#Activate).</li><ul/>
current_version | **[Version](#Version6)**<br>Текущая версия секрета. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление секрета. 


### Version {#Version6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
secret_id | **string**<br>Идентификатор секрета, которому принадлежит версия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус `ACTIVE`. 
description | **string**<br>(опционально) Описание версии. 
status | enum **Status**<br>Статус секрета. <ul><li>`ACTIVE`: Секрет активен и к нему можно получить доступ.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению. Время, когда она будет уничтожена, указано в поле [Version.destroy_at](#Version6).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
payload_entry_keys[] | **string**<br>Ключи содержимого версии. 


## ListVersions {#ListVersions}

Возвращает список версий указанного секрета.

**rpc ListVersions ([ListVersionsRequest](#ListVersionsRequest)) returns ([ListVersionsResponse](#ListVersionsResponse))**

### ListVersionsRequest {#ListVersionsRequest}

Поле | Описание
--- | ---
secret_id | **string**<br>Обязательное поле. Идентификатор секрета для получения списка версий. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListVersionsRequest.next_page_token](#ListVersionsRequest), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListVersionsRequest.next_page_toke](#ListVersionsRequest), прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListVersionsResponse {#ListVersionsResponse}

Поле | Описание
--- | ---
versions[] | **[Version](#Version7)**<br>Список версий для указанного секрета. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListVersionsRequest.page_size](#ListVersionsRequest), используйте `next_page_token` в качестве значения параметра [ListVersionsRequest.page_token](#ListVersionsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token`, для перебора страниц результатов. 


### Version {#Version7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
secret_id | **string**<br>Идентификатор секрета, которому принадлежит версия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус `ACTIVE`. 
description | **string**<br>(опционально) Описание версии. 
status | enum **Status**<br>Статус секрета. <ul><li>`ACTIVE`: Секрет активен и к нему можно получить доступ.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению. Время, когда она будет уничтожена, указано в поле [Version.destroy_at](#Version7).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
payload_entry_keys[] | **string**<br>Ключи содержимого версии. 


## AddVersion {#AddVersion}

Добавляет новую версию на основе предыдущей.

**rpc AddVersion ([AddVersionRequest](#AddVersionRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddVersionMetadata](#AddVersionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version8)<br>

### AddVersionRequest {#AddVersionRequest}

Поле | Описание
--- | ---
secret_id | **string**<br>Обязательное поле. Идентификатор секрета. Максимальная длина строки в символах — 50.
description | **string**<br>Описание версии. Максимальная длина строки в символах — 1024.
payload_entries[] | **[PayloadEntryChange](#PayloadEntryChange)**<br>Описание изменения содержимого базовой версии в новой версии. Максимальное количество элементов — 32.
base_version_id | **string**<br>(опционально) Идентификатор базовой версии. Если параметр не указан, по умолчанию используется текущая версия. Максимальная длина строки в символах — 50.


### PayloadEntryChange {#PayloadEntryChange1}

Поле | Описание
--- | ---
key | **string**<br>Обязательное поле. Неконфиденциальный ключ содержимого версии. Максимальная длина строки в символах — 256. Значение должно соответствовать регулярному выражению ` [-_./\\\\@0-9a-zA-Z]+ `.
value | **oneof:** `text_value` или `binary_value`<br>Конфиденциальная часть содержимого версии.
&nbsp;&nbsp;text_value | **string**<br>Используйте это поле для задания текстового значения. Максимальная длина строки в символах — 65536.
&nbsp;&nbsp;binary_value | **bytes**<br>Используйте это поле для установки двоичного значения. Максимальная длина строки в символах — 65536.


### Operation {#Operation5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddVersionMetadata](#AddVersionMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Version](#Version8)>**<br>в случае успешного выполнения операции. 


### AddVersionMetadata {#AddVersionMetadata}

Поле | Описание
--- | ---
secret_id | **string**<br>Идентификатор секрета. 
version_id | **string**<br>Идентификатор добавленной версии. 


### Version {#Version8}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
secret_id | **string**<br>Идентификатор секрета, которому принадлежит версия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус `ACTIVE`. 
description | **string**<br>(опционально) Описание версии. 
status | enum **Status**<br>Статус секрета. <ul><li>`ACTIVE`: Секрет активен и к нему можно получить доступ.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению. Время, когда она будет уничтожена, указано в поле [Version.destroy_at](#Version8).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
payload_entry_keys[] | **string**<br>Ключи содержимого версии. 


## ScheduleVersionDestruction {#ScheduleVersionDestruction}

Планирует уничтожение указанной версии ключа. <br>Запланированное уничтожение может быть отменено с помощью запроса [SecretService.CancelVersionDestruction](#CancelVersionDestruction).

**rpc ScheduleVersionDestruction ([ScheduleVersionDestructionRequest](#ScheduleVersionDestructionRequest)) returns ([operation.Operation](#Operation6))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ScheduleVersionDestructionMetadata](#ScheduleVersionDestructionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version9)<br>

### ScheduleVersionDestructionRequest {#ScheduleVersionDestructionRequest}

Поле | Описание
--- | ---
secret_id | **string**<br>Обязательное поле. Идентификатор ключа, для которого следует запланировать уничтожение версии. Максимальная длина строки в символах — 50.
version_id | **string**<br>Обязательное поле. Идентификатор версии, которую следует уничтожить. Максимальная длина строки в символах — 50.
pending_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал времени между запросом на уничтожение версии и ее фактическим уничтожением. Значение по умолчанию: 7 дней. 


### Operation {#Operation6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ScheduleVersionDestructionMetadata](#ScheduleVersionDestructionMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Version](#Version9)>**<br>в случае успешного выполнения операции. 


### ScheduleVersionDestructionMetadata {#ScheduleVersionDestructionMetadata}

Поле | Описание
--- | ---
secret_id | **string**<br>Идентификатор ключа, версия которого планируется к уничтожению. 
version_id | **string**<br>Идентификатор версии, которую планируется уничтожить. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время уничтожения. 


### Version {#Version9}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
secret_id | **string**<br>Идентификатор секрета, которому принадлежит версия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус `ACTIVE`. 
description | **string**<br>(опционально) Описание версии. 
status | enum **Status**<br>Статус секрета. <ul><li>`ACTIVE`: Секрет активен и к нему можно получить доступ.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению. Время, когда она будет уничтожена, указано в поле [Version.destroy_at](#Version9).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
payload_entry_keys[] | **string**<br>Ключи содержимого версии. 


## CancelVersionDestruction {#CancelVersionDestruction}

Отменяет запланированное уничтожение версии, если версия еще не была уничтожена.

**rpc CancelVersionDestruction ([CancelVersionDestructionRequest](#CancelVersionDestructionRequest)) returns ([operation.Operation](#Operation7))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CancelVersionDestructionMetadata](#CancelVersionDestructionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version10)<br>

### CancelVersionDestructionRequest {#CancelVersionDestructionRequest}

Поле | Описание
--- | ---
secret_id | **string**<br>Обязательное поле. Идентификатор секрета, для которого следует отменить уничтожение версии. Максимальная длина строки в символах — 50.
version_id | **string**<br>Обязательное поле. Идентификатор версии, запланированное уничтожение которой должно быть отменено. Максимальная длина строки в символах — 50.


### Operation {#Operation7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CancelVersionDestructionMetadata](#CancelVersionDestructionMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Version](#Version10)>**<br>в случае успешного выполнения операции. 


### CancelVersionDestructionMetadata {#CancelVersionDestructionMetadata}

Поле | Описание
--- | ---
secret_id | **string**<br>Идентификатор секрета, уничтожение версии которого отменяется. 
version_id | **string**<br>Идентификатор версии, запланированное уничтожение которой отменяется. 


### Version {#Version10}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
secret_id | **string**<br>Идентификатор секрета, которому принадлежит версия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус `ACTIVE`. 
description | **string**<br>(опционально) Описание версии. 
status | enum **Status**<br>Статус секрета. <ul><li>`ACTIVE`: Секрет активен и к нему можно получить доступ.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению. Время, когда она будет уничтожена, указано в поле [Version.destroy_at](#Version10).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
payload_entry_keys[] | **string**<br>Ключи содержимого версии. 


## ListOperations {#ListOperations}

Возвращает список операций для указанного секрета.

**rpc ListOperations ([ListSecretOperationsRequest](#ListSecretOperationsRequest)) returns ([ListSecretOperationsResponse](#ListSecretOperationsResponse))**

### ListSecretOperationsRequest {#ListSecretOperationsRequest}

Поле | Описание
--- | ---
secret_id | **string**<br>Обязательное поле. Идентификатор секрета для получения операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListSecretOperationsRequest.next_page_token](#ListSecretOperationsRequest), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListSecretOperationsRequest.next_page_token](#ListSecretOperationsRequest), прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListSecretOperationsResponse {#ListSecretOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation8)**<br>Список операций для указанного секрета. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListSecretOperationsResponse.page_size](#ListSecretOperationsResponse), используйте `next_page_token` в качестве значения параметра [ListSecretOperationsResponse.page_token](#ListSecretOperationsResponse) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token`, для перебора страниц результатов. 


### Operation {#Operation8}

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

Устанавливает привязки прав доступа для секрета.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation9))**

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


### Operation {#Operation9}

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

Обновляет привязки прав доступа для секрета.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation10))**

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


### Operation {#Operation10}

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


