---
editable: false
---

# Метод listMetrics
Возвращает список метрик.
 

 
## HTTP-запрос {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v2/metrics
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, которому принадлежит метрика. Максимальная длина строки в символах — 50.
selectors | Селекторы метрики для поиска по меткам.
pageSize | Максимальное количество результатов на странице ответа на запрос. Значение по умолчанию — 0, на странице будет показано 30 результатов. Максимальное значение — 10000.
pageToken | Токен страницы. Установите значение [pageToken](#query_params) равным значению поля [nextPageToken](#responses) предыдущего запроса, чтобы получить следующую страницу результатов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "metrics": [
    {
      "name": "string",
      "labels": "object",
      "type": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
metrics[] | **object**<br><p>Список метрик.</p> 
metrics[].<br>name | **string**<br><p>Имя метрики.</p> 
metrics[].<br>labels | **object**<br><p>Список меток метрики в формате <code>ключ:значение</code>.</p> 
metrics[].<br>type | **string**<br><p>Тип метрики.</p> <ul> <li>DGAUGE: Числовой показатель. Задается дробным числом.</li> <li>IGAUGE: Числовой показатель. Задается целым числом.</li> <li>COUNTER: Счетчик.</li> <li>RATE: Производная.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе.</p> 