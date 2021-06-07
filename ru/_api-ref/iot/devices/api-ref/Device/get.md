---
editable: false
---

# Метод get
Возвращает указанное устройство.
 
Чтобы получить список доступных устройств, используйте запрос [list](/docs/iot-core/api-ref/Device/list).
 
## HTTP-запрос {#https-request}
```
GET https://iot-devices.api.cloud.yandex.net/iot-devices/v1/devices/{deviceId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
deviceId | Обязательное поле. Идентификатор возвращаемого устройства.  Для получения идентификатора устройства используйте запрос [list](/docs/iot-core/api-ref/Device/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "registryId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "topicAliases": "object"
}
```
Устройство. Дополнительные сведения см. в разделе [Устройство](/docs/iot-core/concepts/index#device).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор устройства.</p> 
registryId | **string**<br><p>Идентификатор реестра, к которому принадлежит устройство.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя устройства. Имя является уникальным в рамках реестра.</p> 
description | **string**<br><p>Описание устройства. Длина описания должна быть от 0 до 256 символов.</p> 
topicAliases | **object**<br><p>Алиас топика устройства.</p> <p>Алиас — это альтернативное имя топика устройства, назначенное пользователем. Алиас сопоставляется со стандартным топиком, например ``my/custom/alias`` эквивалентен ``$device/abcdef/events``.</p> 