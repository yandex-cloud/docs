---
editable: false
---

# Метод listDeviceTopicAliases
Возвращает список алиасов устройств для указанного реестра.
 

 
## HTTP-запрос {#https-request}
```
GET https://iot-devices.api.cloud.yandex.net/iot-devices/v1/registries/{registryId}:listDeviceTopicAliases
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
registryId | Обязательное поле. Идентификатор реестра для получения списка алиасов для топика устройства.  Чтобы получить идентификатор реестра, используйте запрос [list](/docs/iot-core/api-ref/Registry/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size` , сервис вернет значение [nextPageToken](/docs/iot-core/api-ref/Registry/listDeviceTopicAliases#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/iot-core/api-ref/Registry/listDeviceTopicAliases#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "aliases": [
    {
      "deviceId": "string",
      "topicPrefix": "string",
      "alias": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
aliases[] | **object**<br><p>Алиас топика устройства.</p> <p>Алиас — это альтернативное имя топика устройства, назначенное пользователем. Алиас сопоставляется со стандартным топиком, например ``my/custom/alias`` эквивалентен ``$device/abcdef/events``. Дополнительные сведения см. в разделе <a href="/docs/iot-core/concepts/topic#aliases">Использование алиасов для топиков</a>.</p> 
aliases[].<br>deviceId | **string**<br><p>Идентификатор устройства, которому принадлежит алиас.</p> 
aliases[].<br>topicPrefix | **string**<br><p>Префикс алиаса стандартного топика устройства, например ``$devices/abcdef``.</p> 
aliases[].<br>alias | **string**<br><p>Алиас топика устройства.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы списка. Если количество результатов больше чем <a href="/docs/iot-core/api-ref/Registry/listDeviceTopicAliases#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/iot-core/api-ref/Registry/listDeviceTopicAliases#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>Все последующие запросы будут получать свои значения ``next_page_token`` для перебора страниц результатов.</p> 