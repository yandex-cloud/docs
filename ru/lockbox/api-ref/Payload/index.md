---
editable: false
---

# Payload
Набор методов доступа к содержимому секретов.
## JSON-представление {#representation}
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
 
Поле | Описание
--- | ---
versionId | **string**<br><p>Идентификатор версии, которой принадлежит содержимое.</p> 
entries[] | **object**<br><p>Записи содержимого версии.</p> 
entries[].<br>key | **string**<br><p>Неконфиденциальный ключ содержимого версии.</p> 
entries[].<br>textValue | **string** <br>`entries[]` включает только одно из полей `textValue`, `binaryValue`<br><br><p>Текстовое значение.</p> 
entries[].<br>binaryValue | **string** (byte) <br>`entries[]` включает только одно из полей `textValue`, `binaryValue`<br><br><p>Двоичное значение.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[get](get.md) | Возвращает содержимое указанного секрета.