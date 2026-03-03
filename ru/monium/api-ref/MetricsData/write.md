---
editable: false
---

# Метод write
Записывает данные метрик.
 

## HTTP-запрос {#https-request}
```
POST https://monitoring.{{ api-host }}/monitoring/v2/data/write
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, которому принадлежит метрика. Максимальная длина строки в символах — 50.
service | Обязательное поле. Идентификатор сервиса, которому принадлежит метрика. Используйте `service=custom` для пользовательских метрик. Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "ts": "string",
  "labels": "object",
  "metrics": [
    {
      "name": "string",
      "labels": "object",
      "type": "string",
      "ts": "string",
      "value": "number",
      "timeseries": [
        {
          "ts": "string",
          "value": "number"
        }
      ]
    }
  ]
}
```

 
Поле | Описание
--- | ---
ts | **string** (date-time)<br><p>Общая временная метка для всех метрик в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p><p>Например: `2025-05-15T15:30:00Z`.</p><p>Где:<br><ul><li>`2025-05-15` — дата (год, месяц, день);</li><li>`T` — разделитель между датой и временем;</li><li>`15:30:00` — время (часы, минуты, секунды);</li><li>`Z` — временная зона [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).</li></ul></p>
labels | **object**<br><p>Список меток общих для всех передаваемых метрик в формате <code>ключ:значение</code>.</p> 
metrics[] | **object**<br><p>Список метрик.</p> 
metrics[].<br>name | **string**<br><p>Обязательное поле. Имя метрики.</p> 
metrics[].<br>labels | **object**<br><p>Список меток метрики в формате <code>ключ:значение</code>.</p> 
metrics[].<br>type | **string**<br><p>Тип метрики. Значение по умолчанию — <code>DGAUGE</code>.</p> <ul> <li>DGAUGE: Числовой показатель. Задается дробным числом.</li> <li>IGAUGE: Числовой показатель. Задается целым числом.</li> <li>COUNTER: Счетчик.</li></ul> 
metrics[].<br>ts | **string** (date-time)<br><p>Временная метка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>. Если не указано, будет использовано текущее время.</p> 
metrics[].<br>value | **number** (double)<br><p>Обязательное поле. Значение метрики в указанной точке.</p> 
metrics[].<br>timeseries[] | **object**<br><p>Список из нескольких точек.</p> 
metrics[].<br>timeseries[].<br>ts | **string** (date-time)<br><p>Временная точка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p><p>Например: `2025-05-15T15:30:00Z`.</p><p>Где:<br><ul><li>`2025-05-15` — дата (год, месяц, день);</li><li>`T` — разделитель между датой и временем;</li><li>`15:30:00` — время (часы, минуты, секунды);</li><li>`Z` — временная зона [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).</li></ul></p>
metrics[].<br>timeseries[].<br>value | **number** (double)<br><p>Значение метрики в указанной точке.</p> 

## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "writtenMetricsCount": "string",
  "errorMessage": "string"
}
```

Поле | Описание
--- | ---
writtenMetricsCount | **string** (int64)<br><p>Количество успешно записанных метрик.</p> 
errorMessage | **string**<br><p>Сообщение об ошибке, если запись завершилась неуспешно.</p> 
