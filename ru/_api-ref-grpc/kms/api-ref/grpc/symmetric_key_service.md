---
editable: false
---

# SymmetricKeyService

Набор методов для управления симметричными ключами KMS.

| Вызов | Описание |
| --- | --- |
| [Create](#Create) | --- control plane Создает симметричный ключ KMS в указанном каталоге. |
| [Get](#Get) | Возвращает указанный симметричный ключ KMS. |
| [List](#List) | Возвращает список симметричных ключей KMS в указанном каталоге. |
| [ListVersions](#ListVersions) | Возвращает список версий указанного симметричного ключа KMS. |
| [Update](#Update) | Изменяет указанный симметричный ключ KMS. |
| [Delete](#Delete) | Удаляет указанный симметричный ключ KMS. |
| [SetPrimaryVersion](#SetPrimaryVersion) | Задает основную версию для указанного ключа. |
| [ScheduleVersionDestruction](#ScheduleVersionDestruction) | Планирует уничтожение указанной версии ключа. |
| [CancelVersionDestruction](#CancelVersionDestruction) | Отменяет ранее запланированное уничтожение версии, если версия еще не была уничтожена. |
| [Rotate](#Rotate) | Ротирует указанный ключ: создает новую версию ключа и делает ее основной. |
| [ListOperations](#ListOperations) | Возвращет список операций для указанного симметричного ключа KMS. |
| [ListAccessBindings](#ListAccessBindings) | Возвращает список привязок прав доступа для указанного симметричного ключа KMS. |
| [SetAccessBindings](#SetAccessBindings) | Устанавливает привязки прав доступа для указанного симметричного ключа KMS. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Обновляет привязки прав доступа для указанного симметричного ключа KMS. |

## Вызовы SymmetricKeyService {#calls}

## Create {#Create}

--- control plane Создает симметричный ключ KMS в указанном каталоге.

**rpc Create ([CreateSymmetricKeyRequest](#CreateSymmetricKeyRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateSymmetricKeyMetadata](#CreateSymmetricKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SymmetricKey](#SymmetricKey)<br>

### CreateSymmetricKeyRequest {#CreateSymmetricKeyRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается симметричный ключ KMS. Максимальная длина строки в символах — 50.
name | **string**<br>Имя симметричного ключа. Максимальная длина строки в символах — 100.
description | **string**<br>Описание симметричного ключа. Максимальная длина строки в символах — 1024.
labels | **map<string,string>**<br>Пользовательские метки для ключа в виде пар `key:value`. Максимум 64 на ключ. Например, @b "" project": "mvp"` или @b "" source": "dictionary"`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
default_algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования, который будет использоваться с версией ключа, которая будет сгенерирована при следующей ротации. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал между автоматическими ротациями. Чтобы отключить автоматическую ротацию, не включайте это поле в запрос на создание. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление симметричного ключа 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateSymmetricKeyMetadata](#CreateSymmetricKeyMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SymmetricKey](#SymmetricKey)>**<br>в случае успешного выполнения операции. 


### CreateSymmetricKeyMetadata {#CreateSymmetricKeyMetadata}

Поле | Описание
--- | ---
key_id | **string**<br>Идентификатор создаваемого ключа. 
primary_version_id | **string**<br>Идентификатор основной версии создаваемого ключа. 


### SymmetricKey {#SymmetricKey}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ключа. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит ключ. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ключа. 
name | **string**<br>Имя симметричного ключа. 
description | **string**<br>Описание симметричного ключа. 
labels | **map<string,string>**<br>Пользовательские метки для ключа в виде пар `key:value`. Максимум 64 на ключ. 
status | enum **Status**<br>Текущий статус ключа. <ul><li>`CREATING`: Ключ создается.</li><li>`ACTIVE`: Ключ активен и может использоваться для шифрования и дешифрования. Можно установить в INACTIVE с помощью метода [SymmetricKeyService.Update](#Update).</li><li>`INACTIVE`: Ключ неактивен и не может быть использован. Можно установить в ACTIVE с помощью метода [SymmetricKeyService.Update](#Update).</li><ul/>
primary_version | **[SymmetricKeyVersion](#SymmetricKeyVersion)**<br>Основная версия ключа, используемая по умолчанию для всех операций шифрования, когда идентификатор версии не указан явно. 
default_algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования по умолчанию, который следует использовать с новыми версиями ключа. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
rotated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последней ротации ключа (время, когда была создана последняя версия). Пустое, если у ключа еще нет версий. 
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Период времени между автоматическими ротациями ключа. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление ключа 


### SymmetricKeyVersion {#SymmetricKeyVersion}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии ключа. 
key_id | **string**<br>Идентификатор симметричного ключа KMS, которому принадлежит версия. 
status | enum **Status**<br>Состояние версии ключа. <ul><li>`ACTIVE`: Версия активна и может использоваться для шифрования и дешифрования.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению, время, когда она будет уничтожена, указано в поле [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования, который следует использовать при использовании этой версии ключа для шифрования. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
primary | **bool**<br>Признак основной версии, которая должна использоваться по умолчанию для всех криптографических операций, для которых явно не указана версия ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус не `SCHEDULED_FOR_DESTRUCTION`. 


## Get {#Get}

Возвращает указанный симметричный ключ KMS. <br>Чтобы получить список доступных симметричных ключей KMS, используйте запрос [SymmetricKeyService.List](#List).

**rpc Get ([GetSymmetricKeyRequest](#GetSymmetricKeyRequest)) returns ([SymmetricKey](#SymmetricKey1))**

### GetSymmetricKeyRequest {#GetSymmetricKeyRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор возвращаемого симметричного ключа KMS. Чтобы получить идентификатор симметричного ключа используйте запрос [SymmetricKeyService.List](#List). Максимальная длина строки в символах — 50.


### SymmetricKey {#SymmetricKey1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ключа. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит ключ. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ключа. 
name | **string**<br>Имя симметричного ключа. 
description | **string**<br>Описание симметричного ключа. 
labels | **map<string,string>**<br>Пользовательские метки для ключа в виде пар `key:value`. Максимум 64 на ключ. 
status | enum **Status**<br>Текущий статус ключа. <ul><li>`CREATING`: Ключ создается.</li><li>`ACTIVE`: Ключ активен и может использоваться для шифрования и дешифрования. Можно установить в INACTIVE с помощью метода [SymmetricKeyService.Update](#Update).</li><li>`INACTIVE`: Ключ неактивен и не может быть использован. Можно установить в ACTIVE с помощью метода [SymmetricKeyService.Update](#Update).</li><ul/>
primary_version | **[SymmetricKeyVersion](#SymmetricKeyVersion1)**<br>Основная версия ключа, используемая по умолчанию для всех операций шифрования, когда идентификатор версии не указан явно. 
default_algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования по умолчанию, который следует использовать с новыми версиями ключа. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
rotated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последней ротации ключа (время, когда была создана последняя версия). Пустое, если у ключа еще нет версий. 
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Период времени между автоматическими ротациями ключа. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление ключа 


### SymmetricKeyVersion {#SymmetricKeyVersion1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии ключа. 
key_id | **string**<br>Идентификатор симметричного ключа KMS, которому принадлежит версия. 
status | enum **Status**<br>Состояние версии ключа. <ul><li>`ACTIVE`: Версия активна и может использоваться для шифрования и дешифрования.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению, время, когда она будет уничтожена, указано в поле [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion1).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования, который следует использовать при использовании этой версии ключа для шифрования. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
primary | **bool**<br>Признак основной версии, которая должна использоваться по умолчанию для всех криптографических операций, для которых явно не указана версия ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус не `SCHEDULED_FOR_DESTRUCTION`. 


## List {#List}

Возвращает список симметричных ключей KMS в указанном каталоге.

**rpc List ([ListSymmetricKeysRequest](#ListSymmetricKeysRequest)) returns ([ListSymmetricKeysResponse](#ListSymmetricKeysResponse))**

### ListSymmetricKeysRequest {#ListSymmetricKeysRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка симметричных ключей KMS. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListSymmetricKeysResponse.next_page_token](#ListSymmetricKeysResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListSymmetricKeysResponse.next_page_token](#ListSymmetricKeysResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListSymmetricKeysResponse {#ListSymmetricKeysResponse}

Поле | Описание
--- | ---
keys[] | **[SymmetricKey](#SymmetricKey2)**<br>Список симметричных ключей KMS в указанном каталоге. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListSymmetricKeysRequest.page_size](#ListSymmetricKeysRequest), используйте `next_page_token` в качестве значения параметра [ListSymmetricKeysRequest.page_token](#ListSymmetricKeysRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### SymmetricKey {#SymmetricKey2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ключа. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит ключ. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ключа. 
name | **string**<br>Имя симметричного ключа. 
description | **string**<br>Описание симметричного ключа. 
labels | **map<string,string>**<br>Пользовательские метки для ключа в виде пар `key:value`. Максимум 64 на ключ. 
status | enum **Status**<br>Текущий статус ключа. <ul><li>`CREATING`: Ключ создается.</li><li>`ACTIVE`: Ключ активен и может использоваться для шифрования и дешифрования. Можно установить в INACTIVE с помощью метода [SymmetricKeyService.Update](#Update).</li><li>`INACTIVE`: Ключ неактивен и не может быть использован. Можно установить в ACTIVE с помощью метода [SymmetricKeyService.Update](#Update).</li><ul/>
primary_version | **[SymmetricKeyVersion](#SymmetricKeyVersion2)**<br>Основная версия ключа, используемая по умолчанию для всех операций шифрования, когда идентификатор версии не указан явно. 
default_algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования по умолчанию, который следует использовать с новыми версиями ключа. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
rotated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последней ротации ключа (время, когда была создана последняя версия). Пустое, если у ключа еще нет версий. 
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Период времени между автоматическими ротациями ключа. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление ключа 


### SymmetricKeyVersion {#SymmetricKeyVersion2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии ключа. 
key_id | **string**<br>Идентификатор симметричного ключа KMS, которому принадлежит версия. 
status | enum **Status**<br>Состояние версии ключа. <ul><li>`ACTIVE`: Версия активна и может использоваться для шифрования и дешифрования.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению, время, когда она будет уничтожена, указано в поле [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion2).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования, который следует использовать при использовании этой версии ключа для шифрования. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
primary | **bool**<br>Признак основной версии, которая должна использоваться по умолчанию для всех криптографических операций, для которых явно не указана версия ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус не `SCHEDULED_FOR_DESTRUCTION`. 


## ListVersions {#ListVersions}

Возвращает список версий указанного симметричного ключа KMS.

**rpc ListVersions ([ListSymmetricKeyVersionsRequest](#ListSymmetricKeyVersionsRequest)) returns ([ListSymmetricKeyVersionsResponse](#ListSymmetricKeyVersionsResponse))**

### ListSymmetricKeyVersionsRequest {#ListSymmetricKeyVersionsRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор симметричного ключа KMS, для которого нужно вернуть список версий. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListSymmetricKeyVersionsResponse.next_page_token](#ListSymmetricKeyVersionsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListSymmetricKeyVersionsResponse.next_page_token](#ListSymmetricKeyVersionsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListSymmetricKeyVersionsResponse {#ListSymmetricKeyVersionsResponse}

Поле | Описание
--- | ---
key_versions[] | **[SymmetricKeyVersion](#SymmetricKeyVersion3)**<br>Список версий для указанного симметричного ключа KMS. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListSymmetricKeyVersionsRequest.page_size](#ListSymmetricKeyVersionsRequest), используйте `next_page_token` в качестве значения параметра [ListSymmetricKeyVersionsRequest.page_token](#ListSymmetricKeyVersionsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### SymmetricKeyVersion {#SymmetricKeyVersion3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии ключа. 
key_id | **string**<br>Идентификатор симметричного ключа KMS, которому принадлежит версия. 
status | enum **Status**<br>Состояние версии ключа. <ul><li>`ACTIVE`: Версия активна и может использоваться для шифрования и дешифрования.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению, время, когда она будет уничтожена, указано в поле [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion3).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования, который следует использовать при использовании этой версии ключа для шифрования. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
primary | **bool**<br>Признак основной версии, которая должна использоваться по умолчанию для всех криптографических операций, для которых явно не указана версия ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус не `SCHEDULED_FOR_DESTRUCTION`. 


## Update {#Update}

Изменяет указанный симметричный ключ KMS.

**rpc Update ([UpdateSymmetricKeyRequest](#UpdateSymmetricKeyRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSymmetricKeyMetadata](#UpdateSymmetricKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SymmetricKey](#SymmetricKey3)<br>

### UpdateSymmetricKeyRequest {#UpdateSymmetricKeyRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор симметричного ключа KMS, который следует изменить. Чтобы получить идентификатор симметричного ключа используйте запрос [SymmetricKeyService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Обязательное поле. Маска, определяющая, какие атрибуты указанного симметричного ключа KMS будут обновлены. 
name | **string**<br>Новое имя симметричного ключа KMS. Максимальная длина строки в символах — 100.
description | **string**<br>Новое описание симметричного ключа KMS. Максимальная длина строки в символах — 1024.
status | **[SymmetricKey.Status](#SymmetricKey3)**<br>Новый статус для симметричного ключа KMS. С помощью метода [SymmetricKeyService.Update](#Update) вы можете установить только статус ACTIVE или INACTIVE. 
labels | **map<string,string>**<br>Пользовательские метки для ключа в виде пар `key:value`. Максимум 64 на ключ. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
default_algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования по умолчанию, который следует использовать с новыми версиями симметричного ключа KMS. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Период времени между автоматическими ротациями симметричного ключа KMS. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление симметричного ключа KMS 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSymmetricKeyMetadata](#UpdateSymmetricKeyMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SymmetricKey](#SymmetricKey3)>**<br>в случае успешного выполнения операции. 


### UpdateSymmetricKeyMetadata {#UpdateSymmetricKeyMetadata}

Поле | Описание
--- | ---
key_id | **string**<br>Идентификатор изменяемого ключа. 


### SymmetricKey {#SymmetricKey3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ключа. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит ключ. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ключа. 
name | **string**<br>Имя симметричного ключа. 
description | **string**<br>Описание симметричного ключа. 
labels | **map<string,string>**<br>Пользовательские метки для ключа в виде пар `key:value`. Максимум 64 на ключ. 
status | enum **Status**<br>Текущий статус ключа. <ul><li>`CREATING`: Ключ создается.</li><li>`ACTIVE`: Ключ активен и может использоваться для шифрования и дешифрования. Можно установить в INACTIVE с помощью метода [SymmetricKeyService.Update](#Update).</li><li>`INACTIVE`: Ключ неактивен и не может быть использован. Можно установить в ACTIVE с помощью метода [SymmetricKeyService.Update](#Update).</li><ul/>
primary_version | **[SymmetricKeyVersion](#SymmetricKeyVersion4)**<br>Основная версия ключа, используемая по умолчанию для всех операций шифрования, когда идентификатор версии не указан явно. 
default_algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования по умолчанию, который следует использовать с новыми версиями ключа. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
rotated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последней ротации ключа (время, когда была создана последняя версия). Пустое, если у ключа еще нет версий. 
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Период времени между автоматическими ротациями ключа. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление ключа 


### SymmetricKeyVersion {#SymmetricKeyVersion4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии ключа. 
key_id | **string**<br>Идентификатор симметричного ключа KMS, которому принадлежит версия. 
status | enum **Status**<br>Состояние версии ключа. <ul><li>`ACTIVE`: Версия активна и может использоваться для шифрования и дешифрования.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению, время, когда она будет уничтожена, указано в поле [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion4).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования, который следует использовать при использовании этой версии ключа для шифрования. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
primary | **bool**<br>Признак основной версии, которая должна использоваться по умолчанию для всех криптографических операций, для которых явно не указана версия ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус не `SCHEDULED_FOR_DESTRUCTION`. 


## Delete {#Delete}

Удаляет указанный симметричный ключ KMS. Это действие также автоматически планирует уничтожение всех версий ключа через 72 часа. <br>Ключ и его версии отсутствуют в ответах на запросы [SymmetricKeyService.Get](#Get) и [SymmetricKeyService.List](#List), но могут быть восстановлены в течение 72 часов запросом в техподдержку.

**rpc Delete ([DeleteSymmetricKeyRequest](#DeleteSymmetricKeyRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteSymmetricKeyMetadata](#DeleteSymmetricKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SymmetricKey](#SymmetricKey4)<br>

### DeleteSymmetricKeyRequest {#DeleteSymmetricKeyRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор ключа, который следует удалить. Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteSymmetricKeyMetadata](#DeleteSymmetricKeyMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SymmetricKey](#SymmetricKey4)>**<br>в случае успешного выполнения операции. 


### DeleteSymmetricKeyMetadata {#DeleteSymmetricKeyMetadata}

Поле | Описание
--- | ---
key_id | **string**<br>Идентификатор удаляемого ключа. 


### SymmetricKey {#SymmetricKey4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ключа. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит ключ. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ключа. 
name | **string**<br>Имя симметричного ключа. 
description | **string**<br>Описание симметричного ключа. 
labels | **map<string,string>**<br>Пользовательские метки для ключа в виде пар `key:value`. Максимум 64 на ключ. 
status | enum **Status**<br>Текущий статус ключа. <ul><li>`CREATING`: Ключ создается.</li><li>`ACTIVE`: Ключ активен и может использоваться для шифрования и дешифрования. Можно установить в INACTIVE с помощью метода [SymmetricKeyService.Update](#Update).</li><li>`INACTIVE`: Ключ неактивен и не может быть использован. Можно установить в ACTIVE с помощью метода [SymmetricKeyService.Update](#Update).</li><ul/>
primary_version | **[SymmetricKeyVersion](#SymmetricKeyVersion5)**<br>Основная версия ключа, используемая по умолчанию для всех операций шифрования, когда идентификатор версии не указан явно. 
default_algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования по умолчанию, который следует использовать с новыми версиями ключа. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
rotated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последней ротации ключа (время, когда была создана последняя версия). Пустое, если у ключа еще нет версий. 
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Период времени между автоматическими ротациями ключа. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление ключа 


### SymmetricKeyVersion {#SymmetricKeyVersion5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии ключа. 
key_id | **string**<br>Идентификатор симметричного ключа KMS, которому принадлежит версия. 
status | enum **Status**<br>Состояние версии ключа. <ul><li>`ACTIVE`: Версия активна и может использоваться для шифрования и дешифрования.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению, время, когда она будет уничтожена, указано в поле [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion5).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования, который следует использовать при использовании этой версии ключа для шифрования. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
primary | **bool**<br>Признак основной версии, которая должна использоваться по умолчанию для всех криптографических операций, для которых явно не указана версия ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус не `SCHEDULED_FOR_DESTRUCTION`. 


## SetPrimaryVersion {#SetPrimaryVersion}

Задает основную версию для указанного ключа. Основная версия используется по умолчанию для всех операций шифрования / дешифрования, в которых не указан идентификатор версии.

**rpc SetPrimaryVersion ([SetPrimarySymmetricKeyVersionRequest](#SetPrimarySymmetricKeyVersionRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetPrimarySymmetricKeyVersionMetadata](#SetPrimarySymmetricKeyVersionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SymmetricKey](#SymmetricKey5)<br>

### SetPrimarySymmetricKeyVersionRequest {#SetPrimarySymmetricKeyVersionRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор ключа, для которого нужно установить основную версию. Максимальная длина строки в символах — 50.
version_id | **string**<br>Обязательное поле. Идентификатор версии, которая должна стать основной для указанного ключа. Максимальная длина строки в символах — 50.


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetPrimarySymmetricKeyVersionMetadata](#SetPrimarySymmetricKeyVersionMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SymmetricKey](#SymmetricKey5)>**<br>в случае успешного выполнения операции. 


### SetPrimarySymmetricKeyVersionMetadata {#SetPrimarySymmetricKeyVersionMetadata}

Поле | Описание
--- | ---
key_id | **string**<br>Идентификатор ключа, для которого изменяется основная версия. 
version_id | **string**<br>Идентификатор версии, которая становится основной для ключа. 


### SymmetricKey {#SymmetricKey5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ключа. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит ключ. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ключа. 
name | **string**<br>Имя симметричного ключа. 
description | **string**<br>Описание симметричного ключа. 
labels | **map<string,string>**<br>Пользовательские метки для ключа в виде пар `key:value`. Максимум 64 на ключ. 
status | enum **Status**<br>Текущий статус ключа. <ul><li>`CREATING`: Ключ создается.</li><li>`ACTIVE`: Ключ активен и может использоваться для шифрования и дешифрования. Можно установить в INACTIVE с помощью метода [SymmetricKeyService.Update](#Update).</li><li>`INACTIVE`: Ключ неактивен и не может быть использован. Можно установить в ACTIVE с помощью метода [SymmetricKeyService.Update](#Update).</li><ul/>
primary_version | **[SymmetricKeyVersion](#SymmetricKeyVersion6)**<br>Основная версия ключа, используемая по умолчанию для всех операций шифрования, когда идентификатор версии не указан явно. 
default_algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования по умолчанию, который следует использовать с новыми версиями ключа. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
rotated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последней ротации ключа (время, когда была создана последняя версия). Пустое, если у ключа еще нет версий. 
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Период времени между автоматическими ротациями ключа. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление ключа 


### SymmetricKeyVersion {#SymmetricKeyVersion6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии ключа. 
key_id | **string**<br>Идентификатор симметричного ключа KMS, которому принадлежит версия. 
status | enum **Status**<br>Состояние версии ключа. <ul><li>`ACTIVE`: Версия активна и может использоваться для шифрования и дешифрования.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению, время, когда она будет уничтожена, указано в поле [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion6).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования, который следует использовать при использовании этой версии ключа для шифрования. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
primary | **bool**<br>Признак основной версии, которая должна использоваться по умолчанию для всех криптографических операций, для которых явно не указана версия ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус не `SCHEDULED_FOR_DESTRUCTION`. 


## ScheduleVersionDestruction {#ScheduleVersionDestruction}

Планирует уничтожение указанной версии ключа. <br>Запланированное уничтожение может быть отменено с помощью метода [SymmetricKeyService.CancelVersionDestruction](#CancelVersionDestruction).

**rpc ScheduleVersionDestruction ([ScheduleSymmetricKeyVersionDestructionRequest](#ScheduleSymmetricKeyVersionDestructionRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ScheduleSymmetricKeyVersionDestructionMetadata](#ScheduleSymmetricKeyVersionDestructionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SymmetricKeyVersion](#SymmetricKeyVersion7)<br>

### ScheduleSymmetricKeyVersionDestructionRequest {#ScheduleSymmetricKeyVersionDestructionRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор ключа, для которого следует запланировать уничтожение версии. Максимальная длина строки в символах — 50.
version_id | **string**<br>Обязательное поле. Идентификатор версии, которую следует уничтожить. Максимальная длина строки в символах — 50.
pending_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал времени между запросом на уничтожение версии и ее фактическим уничтожением. Значение по умолчанию: 7 дней. 


### Operation {#Operation4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ScheduleSymmetricKeyVersionDestructionMetadata](#ScheduleSymmetricKeyVersionDestructionMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SymmetricKeyVersion](#SymmetricKeyVersion7)>**<br>в случае успешного выполнения операции. 


### ScheduleSymmetricKeyVersionDestructionMetadata {#ScheduleSymmetricKeyVersionDestructionMetadata}

Поле | Описание
--- | ---
key_id | **string**<br>Идентификатор ключа, версия которого планируется к уничтожению. 
version_id | **string**<br>Идентификатор версии, которую планируется уничтожить. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия будет уничтожена. 


### SymmetricKeyVersion {#SymmetricKeyVersion7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии ключа. 
key_id | **string**<br>Идентификатор симметричного ключа KMS, которому принадлежит версия. 
status | enum **Status**<br>Состояние версии ключа. <ul><li>`ACTIVE`: Версия активна и может использоваться для шифрования и дешифрования.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению, время, когда она будет уничтожена, указано в поле [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion7).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования, который следует использовать при использовании этой версии ключа для шифрования. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
primary | **bool**<br>Признак основной версии, которая должна использоваться по умолчанию для всех криптографических операций, для которых явно не указана версия ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус не `SCHEDULED_FOR_DESTRUCTION`. 


## CancelVersionDestruction {#CancelVersionDestruction}

Отменяет ранее запланированное уничтожение версии, если версия еще не была уничтожена.

**rpc CancelVersionDestruction ([CancelSymmetricKeyVersionDestructionRequest](#CancelSymmetricKeyVersionDestructionRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CancelSymmetricKeyVersionDestructionMetadata](#CancelSymmetricKeyVersionDestructionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SymmetricKeyVersion](#SymmetricKeyVersion8)<br>

### CancelSymmetricKeyVersionDestructionRequest {#CancelSymmetricKeyVersionDestructionRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор ключа, для которого следует отменить уничтожение версии. Максимальная длина строки в символах — 50.
version_id | **string**<br>Обязательное поле. Идентификатор версии, запланированное уничтожение которой должно быть отменено. Максимальная длина строки в символах — 50.


### Operation {#Operation5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CancelSymmetricKeyVersionDestructionMetadata](#CancelSymmetricKeyVersionDestructionMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SymmetricKeyVersion](#SymmetricKeyVersion8)>**<br>в случае успешного выполнения операции. 


### CancelSymmetricKeyVersionDestructionMetadata {#CancelSymmetricKeyVersionDestructionMetadata}

Поле | Описание
--- | ---
key_id | **string**<br>Идентификатор ключа, уничтожение версии которого отменяется. 
version_id | **string**<br>Идентификатор версии, запланированное уничтожение которой отменяется. 


### SymmetricKeyVersion {#SymmetricKeyVersion8}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии ключа. 
key_id | **string**<br>Идентификатор симметричного ключа KMS, которому принадлежит версия. 
status | enum **Status**<br>Состояние версии ключа. <ul><li>`ACTIVE`: Версия активна и может использоваться для шифрования и дешифрования.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению, время, когда она будет уничтожена, указано в поле [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion8).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования, который следует использовать при использовании этой версии ключа для шифрования. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
primary | **bool**<br>Признак основной версии, которая должна использоваться по умолчанию для всех криптографических операций, для которых явно не указана версия ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус не `SCHEDULED_FOR_DESTRUCTION`. 


## Rotate {#Rotate}

Ротирует указанный ключ: создает новую версию ключа и делает ее основной. Старая версия остается доступной для расшифровки зашифрованных с ее помощью данных.

**rpc Rotate ([RotateSymmetricKeyRequest](#RotateSymmetricKeyRequest)) returns ([operation.Operation](#Operation6))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RotateSymmetricKeyMetadata](#RotateSymmetricKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SymmetricKey](#SymmetricKey6)<br>

### RotateSymmetricKeyRequest {#RotateSymmetricKeyRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор ключа, который следует ротировать. Максимальная длина строки в символах — 50.


### Operation {#Operation6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RotateSymmetricKeyMetadata](#RotateSymmetricKeyMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SymmetricKey](#SymmetricKey6)>**<br>в случае успешного выполнения операции. 


### RotateSymmetricKeyMetadata {#RotateSymmetricKeyMetadata}

Поле | Описание
--- | ---
key_id | **string**<br>Идентификатор ротируемого ключа. 
new_primary_version_id | **string**<br>Идентификатор версии, сгенерированной в результате ротации ключа. 


### SymmetricKey {#SymmetricKey6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ключа. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит ключ. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ключа. 
name | **string**<br>Имя симметричного ключа. 
description | **string**<br>Описание симметричного ключа. 
labels | **map<string,string>**<br>Пользовательские метки для ключа в виде пар `key:value`. Максимум 64 на ключ. 
status | enum **Status**<br>Текущий статус ключа. <ul><li>`CREATING`: Ключ создается.</li><li>`ACTIVE`: Ключ активен и может использоваться для шифрования и дешифрования. Можно установить в INACTIVE с помощью метода [SymmetricKeyService.Update](#Update).</li><li>`INACTIVE`: Ключ неактивен и не может быть использован. Можно установить в ACTIVE с помощью метода [SymmetricKeyService.Update](#Update).</li><ul/>
primary_version | **[SymmetricKeyVersion](#SymmetricKeyVersion9)**<br>Основная версия ключа, используемая по умолчанию для всех операций шифрования, когда идентификатор версии не указан явно. 
default_algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования по умолчанию, который следует использовать с новыми версиями ключа. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
rotated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время последней ротации ключа (время, когда была создана последняя версия). Пустое, если у ключа еще нет версий. 
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Период времени между автоматическими ротациями ключа. 
deletion_protection | **bool**<br>Флаг, запрещающий удаление ключа 


### SymmetricKeyVersion {#SymmetricKeyVersion9}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии ключа. 
key_id | **string**<br>Идентификатор симметричного ключа KMS, которому принадлежит версия. 
status | enum **Status**<br>Состояние версии ключа. <ul><li>`ACTIVE`: Версия активна и может использоваться для шифрования и дешифрования.</li><li>`SCHEDULED_FOR_DESTRUCTION`: Версия запланирована к уничтожению, время, когда она будет уничтожена, указано в поле [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion9).</li><li>`DESTROYED`: Версия уничтожена и не может быть восстановлена.</li><ul/>
algorithm | enum **SymmetricAlgorithm**<br>Алгоритм шифрования, который следует использовать при использовании этой версии ключа для шифрования. <ul><li>`AES_128`: Алгоритм AES со 128-битными ключами.</li><li>`AES_192`: Алгоритм AES с 192-битными ключами.</li><li>`AES_256`: Алгоритм AES с 256-битными ключами.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания версии ключа. 
primary | **bool**<br>Признак основной версии, которая должна использоваться по умолчанию для всех криптографических операций, для которых явно не указана версия ключа. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда версия ключа будет уничтожена. Пустой, если статус не `SCHEDULED_FOR_DESTRUCTION`. 


## ListOperations {#ListOperations}

Возвращет список операций для указанного симметричного ключа KMS.

**rpc ListOperations ([ListSymmetricKeyOperationsRequest](#ListSymmetricKeyOperationsRequest)) returns ([ListSymmetricKeyOperationsResponse](#ListSymmetricKeyOperationsResponse))**

### ListSymmetricKeyOperationsRequest {#ListSymmetricKeyOperationsRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор симметричного ключа KMS, для которого нужно вернуть список операций. <br>Чтобы получить идентификатор ключа, используйте запрос [SymmetricKeyService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size`, сервис вернет значение [ListSymmetricKeyOperationsResponse.next_page_token](#ListSymmetricKeyOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListSymmetricKeyOperationsResponse.next_page_token](#ListSymmetricKeyOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListSymmetricKeyOperationsResponse {#ListSymmetricKeyOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>Список операций для указанного ключа. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListSymmetricKeyOperationsRequest.page_size](#ListSymmetricKeyOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListSymmetricKeyOperationsRequest.page_token](#ListSymmetricKeyOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


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

Возвращает список привязок прав доступа для указанного симметричного ключа KMS.

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

Устанавливает привязки прав доступа для указанного симметричного ключа KMS.

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
type | **string**<br>Обязательное поле. <ul><li>`userAccount` — аккаунт на Яндексе или Яндекс.Коннекте, добавленный в Яндекс.Облако. </li><li>`serviceAccount` — сервисный аккаунт. Этот тип представляет ресурс `yandex.cloud.iam.v1.ServiceAccount`. </li><li>`federatedUser` — федеративный аккаунт. Этот тип представляет пользователя из федерации удостоверений, например Active Directory. </li><li>`system` — системная группа. Представляет набор аккаунтов, который описывается общим системным идентификатором. </li></ul> Максимальная длина строки в символах — 100.


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

Обновляет привязки прав доступа для указанного симметричного ключа KMS.

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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### UpdateAccessBindingsMetadata {#UpdateAccessBindingsMetadata}

Поле | Описание
--- | ---
resource_id | **string**<br>Идентификатор ресурса, для которого обновляется список привязок прав доступа. 


