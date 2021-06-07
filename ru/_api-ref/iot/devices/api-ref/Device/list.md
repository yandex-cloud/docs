---
editable: false
---

# Метод list
Возвращает список устройств в указанном реестре.
 

 
## HTTP-запрос {#https-request}
```
GET https://iot-devices.api.cloud.yandex.net/iot-devices/v1/devices
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
registryId | Идентификатор реестра для получения списка устройств.  Чтобы получить идентификатор реестра, используйте запрос [list](/docs/iot-core/api-ref/Registry/list).  Максимальная длина строки в символах — 50.
folderId | Идентификатор каталога для получения списка устройств.  Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size` , сервис вернет значение [nextPageToken](/docs/iot-core/api-ref/Device/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/iot-core/api-ref/Device/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "devices": [
    {
      "id": "string",
      "registryId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "topicAliases": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
devices[] | **object**<br><p>Устройство. Дополнительные сведения см. в разделе <a href="/docs/iot-core/concepts/index#device">Устройство</a>.</p> 
devices[].<br>id | **string**<br><p>Идентификатор устройства.</p> 
devices[].<br>registryId | **string**<br><p>Идентификатор реестра, к которому принадлежит устройство.</p> 
devices[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
devices[].<br>name | **string**<br><p>Имя устройства. Имя является уникальным в рамках реестра.</p> 
devices[].<br>description | **string**<br><p>Описание устройства. Длина описания должна быть от 0 до 256 символов.</p> 
devices[].<br>topicAliases | **object**<br><p>Алиас топика устройства.</p> <p>Алиас — это альтернативное имя топика устройства, назначенное пользователем. Алиас сопоставляется со стандартным топиком, например ``my/custom/alias`` эквивалентен ``$device/abcdef/events``.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы списка. Если количество результатов больше чем <a href="/docs/iot-core/api-ref/Device/list#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/iot-core/api-ref/Device/list#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>Все последующие запросы будут получать свои значения ``next_page_token`` для перебора страниц результатов.</p> 