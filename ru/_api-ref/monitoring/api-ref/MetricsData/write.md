---
editable: false
---

# Метод write
Записывает данные метрик.
 

 
## HTTP-запрос {#https-request}
```
POST https://monitoring.api.cloud.yandex.net/monitoring/v1/data/write
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
cloudId | Обязательное поле. Идентификатор облака, которому принадлежит метрика.  Максимальная длина строки в символах — 50.
folderId | Обязательное поле. Идентификатор каталога, которому принадлежит метрика.  Максимальная длина строки в символах — 50.
service | Обязательное поле. Идентификатор сервиса, которому принадлежит метрика. Для пользовательских метрик `service=custom`.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "ts": "string",
  "labels": "object",
  "metrics": [
    {
      "name": "string",
      "labels": "object",
      "kind": "string",
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
ts | **string** (int64)<br><p>Общая временная метка для всех метрик.</p> 
labels | **object**<br><p>Список меток общих для всех передаваемых метрик в формате ``ключ:значение``.</p> 
metrics[] | **object**<br><p>Список метрик.</p> 
metrics[].<br>name | **string**<br><p>Обязательное поле. Имя метрики.</p> 
metrics[].<br>labels | **object**<br><p>Список меток метрики в формате ``ключ:значение``.</p> 
metrics[].<br>kind | **string**<br><p>Тип метрики. Значение по умолчанию — ``DGAUGE``.</p> <ul> <li>DGAUGE: Числовой показатель. Задается дробным числом.</li> <li>IGAUGE: Числовой показатель. Задается целым числом.</li> <li>COUNTER: Счетчик.</li> <li>RATE: Производная.</li> </ul> 
metrics[].<br>ts | **string** (int64)<br><p>Временная метка в формате ``timestamp``. Если не указано, будет использовано текущее время.</p> 
metrics[].<br>value | **number** (double)<br><p>Обязательное поле. Значение метрики в указанной точке.</p> 
metrics[].<br>timeseries[] | **object**<br><p>Список из нескольких точек.</p> 
metrics[].<br>timeseries[].<br>ts | **string** (int64)<br><p>Временная точка в формате ``timestamp``.</p> 
metrics[].<br>timeseries[].<br>value | **number** (double)<br><p>Значение метрики в указанной точке.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "metricsPushed": "string",
  "errors": "string"
}
```

 
Поле | Описание
--- | ---
metricsPushed | **string** (int64)<br><p>Количество успешно записанных метрик.</p> 
errors | **string**<br><p>Сообщение об ошибке, если запись завершилась неуспешно.</p> 