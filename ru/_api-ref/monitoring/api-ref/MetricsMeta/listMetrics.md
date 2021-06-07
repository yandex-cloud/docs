---
editable: false
---

# Метод listMetrics
Возвращает список метрик.
 

 
## HTTP-запрос {#https-request}
```
GET https://monitoring.api.cloud.yandex.net/monitoring/v1/metrics
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
cloudId | Обязательное поле. Идентификатор облака, которому принадлежит метрика.  Максимальная длина строки в символах — 50.
folderId | Обязательное поле. Идентификатор каталога, которому принадлежит метрика.  Максимальная длина строки в символах — 50.
page | Номер страницы.
pageSize | Количество метрик в одной странице ответа.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "result": [
    {
      "name": "string",
      "labels": "object",
      "kind": "string",
      "createdAt": "string"
    }
  ],
  "page": {
    "pagesCount": "string",
    "totalCount": "string",
    "pageSize": "string",
    "current": "string"
  }
}
```

 
Поле | Описание
--- | ---
result[] | **object**<br><p>Список метрик.</p> 
result[].<br>name | **string**<br><p>Имя метрики.</p> 
result[].<br>labels | **object**<br><p>Список меток метрики в формате ``ключ:значение``.</p> 
result[].<br>kind | **string**<br><p>Тип метрики.</p> <ul> <li>DGAUGE: Числовой показатель. Задается дробным числом.</li> <li>IGAUGE: Числовой показатель. Задается целым числом.</li> <li>COUNTER: Счетчик.</li> <li>RATE: Производная.</li> </ul> 
result[].<br>createdAt | **string** (int64)<br><p>Время создания (записи первой точки) метрики. Строка в формате <a href="https://ru.wikipedia.org/wiki/ISO_8601">ISO8601</a>.</p> 
page | **object**<br><p>Параметры пагинации.</p> 
page.<br>pagesCount | **string** (int64)<br><p>Количество страниц в ответе.</p> 
page.<br>totalCount | **string** (int64)<br><p>Общее количество метрик в ответе.</p> 
page.<br>pageSize | **string** (int64)<br><p>Количество метрик на одной странице ответа.</p> 
page.<br>current | **string** (int64)<br><p>Номер запрошенной страницы.</p> 