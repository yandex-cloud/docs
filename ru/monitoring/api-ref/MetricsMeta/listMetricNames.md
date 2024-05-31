---
editable: false
---

# Метод listMetricNames
Возвращает список имен метрик.
 

 
## HTTP-запрос {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v2/metrics/names
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, которому принадлежит метрика. Максимальная длина строки в символах — 50.
selectors | Селекторы метрики для поиска по меткам.
nameFilter | Текст подстроки для фильтрации по имени метрик.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "names": [
    "string"
  ]
}
```

 
Поле | Описание
--- | ---
names[] | **string**<br><p>Список имен метрик.</p>