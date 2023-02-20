---
editable: false
---

# Метод listLabelKeys
Возвращает список ключей меток.
 

 
## HTTP-запрос {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v2/metrics/labels
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, которому принадлежит метрика. Максимальная длина строки в символах — 50.
selectors | Селекторы метрики для поиска по меткам.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keys": [
    "string"
  ]
}
```

 
Поле | Описание
--- | ---
keys[] | **string**<br><p>Список ключей.</p> 