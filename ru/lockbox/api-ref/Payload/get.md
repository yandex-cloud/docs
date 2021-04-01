---
editable: false
---

# Метод get
Возвращает содержимое указанного секрета.
 
Чтобы получить список доступных секретов, выполните запрос [list](/docs/lockbox/api-ref/Secret/list).
 
## HTTP-запрос {#https-request}
```
GET https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/{secretId}/payload
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
secretId | Обязательное поле. Идентификатор секрета.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
versionId | (опционально) Идентификатор версии. Если не указан, возвращается содержимое текущей версии.  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "versionId": "string",
  "entries": [
    {
      "key": "string",

      // `entries[]` включает только одно из полей `textValue`, `binaryValue`
      "textValue": "string",
      "binaryValue": "string",
      // конец списка возможных полей`entries[]`

    }
  ]
}
```
Содержимое версии.
 
Поле | Описание
--- | ---
versionId | **string**<br><p>Идентификатор версии, которой принадлежит содержимое.</p> 
entries[] | **object**<br><p>Записи содержимого версии.</p> 
entries[].<br>key | **string**<br><p>Неконфиденциальный ключ содержимого версии.</p> 
entries[].<br>textValue | **string** <br>`entries[]` включает только одно из полей `textValue`, `binaryValue`<br><br><p>Текстовое значение.</p> 
entries[].<br>binaryValue | **string** (byte) <br>`entries[]` включает только одно из полей `textValue`, `binaryValue`<br><br><p>Двоичное значение.</p> 