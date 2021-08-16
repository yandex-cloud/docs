---
editable: false
---

# Метод listLabelValues
Возвращает список значенений для указанного ключа метки.
 

 
## HTTP-запрос {#https-request}
```
GET https://monitoring.api.cloud.yandex.net/monitoring/v2/metrics/labels/{labelKey}/values
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
labelKey | Обязательное поле. Ключ метки, по которому осуществляется поиск.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, которому принадлежит метрика.  Максимальная длина строки в символах — 50.
selectors | Селекторы метрики для поиска по меткам.
valueFilter | Текст подстроки для фильтрации по значению меток.
pageSize | Максимальное количество результатов на странице ответа на запрос. Значение по умолчанию — 0, на странице будет показано 30 результатов. Максимсальное значение — 10000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/monitoring/api-ref/MetricsMeta/listLabelValues#query_params) равным значению поля [nextPageToken](/docs/monitoring/api-ref/MetricsMeta/listLabelValues#responses) предыдущего запроса, чтобы получить следующую страницу результатов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "values": [
    "string"
  ],
  "metricsCount": "string",
  "absent": true,
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
values[] | **string**<br><p>Список значений меток по заданному ключу.</p> 
metricsCount | **string** (int64)<br><p>Число метрик, которые найдены по заданным селекторам.</p> 
absent | **boolean** (boolean)<br><p>Указывает, что в выборке есть метрики без заданной метки.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе.</p> 