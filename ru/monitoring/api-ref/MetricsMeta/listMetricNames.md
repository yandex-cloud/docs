---
editable: false
---

# Метод listMetricNames
Возвращает список имен метрик.
 

 
## HTTP-запрос {#https-request}
```
GET https://monitoring.api.cloud.yandex.net/monitoring/v2/metrics/names
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, которому принадлежит метрика.  Максимальная длина строки в символах — 50.
selectors | Селекторы метрики для поиска по меткам.
nameFilter | Текст подстроки для фильтрации по имени метрик.
pageSize | Максимальное количество результатов на странице ответа на запрос. Значение по умолчанию — 0, на странице будет показано 30 результатов. Максимсальное значение — 10000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/monitoring/api-ref/MetricsMeta/listMetricNames#query_params) равным значению поля [nextPageToken](/docs/monitoring/api-ref/MetricsMeta/listMetricNames#responses) предыдущего запроса, чтобы получить следующую страницу результатов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "names": [
    "string"
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
names[] | **string**<br><p>Список имен метрик.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе.</p> 