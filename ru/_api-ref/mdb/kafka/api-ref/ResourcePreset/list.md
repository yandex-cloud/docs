---
editable: false
---

# Метод list
Возвращает список доступных шаблонов ресурсов.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/resourcePresets
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на одной странице в ответе.  Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/managed-kafka/api-ref/ResourcePreset/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы.  Установите значение `page_token` равным значению поля [nextPageToken](/docs/managed-kafka/api-ref/ResourcePreset/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "resourcePresets": [
    {
      "id": "string",
      "zoneIds": [
        "string"
      ],
      "cores": "string",
      "memory": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
resourcePresets[] | **object**<br><p>Описание набора вычислительных ресурсов.</p> 
resourcePresets[].<br>id | **string**<br><p>Идентификатор набора вычислительных ресурсов.</p> 
resourcePresets[].<br>zoneIds[] | **string**<br><p>Идентификаторы зон доступности, в которых доступен этот набор вычислительных ресурсов.</p> 
resourcePresets[].<br>cores | **string** (int64)<br><p>Количество процессорных ядер для брокера Kafka, созданного с помощью набора вычислительных ресурсов.</p> 
resourcePresets[].<br>memory | **string** (int64)<br><p>Объем оперативной памяти для брокера Kafka, созданного с помощью набора вычислительных ресурсов, в байтах.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе.</p> <p>Если количество результатов больше чем <a href="/docs/managed-kafka/api-ref/ResourcePreset/list#query_params">pageSize</a>, используйте <code>next_page_token</code> в качестве значения параметра <a href="/docs/managed-kafka/api-ref/ResourcePreset/list#query_params">pageToken</a> в следующем запросе. Все последующие запросы будут получать свои значения <code>next_page_token</code> для перебора страниц результатов.</p> <p>Максимальная длина строки в символах — 100.</p> 