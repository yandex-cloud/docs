---
editable: false
---

# PayloadService

Набор методов доступа к содержимому секретов.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает содержимое указанного секрета. |

## Вызовы PayloadService {#calls}

## Get {#Get}

Возвращает содержимое указанного секрета. <br>Чтобы получить список доступных секретов, выполните запрос [SecretService.List](./secret_service#List).

**rpc Get ([GetPayloadRequest](#GetPayloadRequest)) returns ([Payload](#Payload))**

### GetPayloadRequest {#GetPayloadRequest}

Поле | Описание
--- | ---
secret_id | **string**<br>Обязательное поле. Идентификатор секрета. Максимальная длина строки в символах — 50.
version_id | **string**<br>(опционально) Идентификатор версии. Если не указан, возвращается содержимое текущей версии. Максимальная длина строки в символах — 50.


### Payload {#Payload}

Поле | Описание
--- | ---
version_id | **string**<br>Идентификатор версии, которой принадлежит содержимое. 
entries[] | **[Entry](#Entry)**<br>Записи содержимого версии. 


### Entry {#Entry}

Поле | Описание
--- | ---
key | **string**<br>Неконфиденциальный ключ содержимого версии. 
value | **oneof:** `text_value` или `binary_value`<br>Конфиденциальная часть содержимого версии.
&nbsp;&nbsp;text_value | **string**<br>Текстовое значение. 
&nbsp;&nbsp;binary_value | **bytes**<br>Двоичное значение. 


