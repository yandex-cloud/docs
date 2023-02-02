---
editable: false
---

# Метод read
Возвращает данные метрик.



## HTTP-запрос {#https-request}
```
POST https://monitoring.api.cloud.yandex.net/monitoring/v2/data/read
```

## Query-параметры {#query_params}

Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, которому принадлежит метрика. Максимальная длина строки в символах — 50.

## Параметры в теле запроса {#body_params}

```json
{
  "query": "string",
  "fromTime": "string",
  "toTime": "string",
  "downsampling": {
    "gridAggregation": "string",
    "gapFilling": "string",

    // `downsampling` включает только одно из полей `maxPoints`, `gridInterval`, `disabled`
    "maxPoints": "string",
    "gridInterval": "string",
    "disabled": true,
    // конец списка возможных полей `downsampling`

  }
}
```


Поле | Описание
--- | ---
query | **string**<br><p>Обязательное поле. Текст запроса. Синтаксис описан в разделе [{#T}](../../concepts/querying.md).</p>
fromTime | **string** (date-time)<br><p>Обязательное поле. Начальная точка интервала в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p>
toTime | **string** (date-time)<br><p>Обязательное поле. Конечная точка интервала в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p>
downsampling | **object**<br><p>Обязательное поле. Параметры прореживания.</p>
downsampling.<br>gridAggregation | **string**<br>Функция агрегации, которая используется для прореживания.<br><br><p>Список доступных агрегирующих функций, которые используются при прореживании.</p> <ul> <li>MAX: Максимум.</li> <li>MIN: Минимум.</li> <li>SUM: Сумма.</li> <li>AVG: Среднее значение. Значение по умолчанию.</li> <li>LAST: Последнее значение.</li> <li>COUNT: Количество точек.</li> </ul>
downsampling.<br>gapFilling | **string**<br>Параметры заполнения пропусков в данных.<br><br><p>Список методов для заполнения пропусков в данных при прореживании.</p> <ul> <li>NULL: Возвращает <code>null</code> в качестве значения метрики и <code>timestamp</code> в качестве временной метки. Значение по умолчанию.</li> <li>NONE: Не возвращает значений.</li> <li>PREVIOUS: Возвращает значение из предыдущей точки.</li> </ul>
downsampling.<br>maxPoints | **string** (int64) <br>`downsampling` включает только одно из полей `maxPoints`, `gridInterval`, `disabled`<br><br><p>Максимальное количество точек, которое будет получено в ответе на запрос.</p> <p>Значение должно быть больше 10.</p>
downsampling.<br>gridInterval | **string** (int64) <br>`downsampling` включает только одно из полей `maxPoints`, `gridInterval`, `disabled`<br><br><p>Ширина временного окна (сетки) в миллисекундах. Используется для прореживания. Точки внутри окна объединяются в одну при помощи функции агрегации.</p> <p>Значение должно быть больше 0.</p>
downsampling.<br>disabled | **boolean** (boolean) <br>`downsampling` включает только одно из полей `maxPoints`, `gridInterval`, `disabled`<br><br><p>Указывает, что данные в ответе на запрос будут получены без прореживания.</p>

## Ответ {#responses}
**HTTP Code: 200 - OK**

```json
{
  "metrics": [
    {
      "name": "string",
      "labels": "object",
      "type": "string",
      "timeseries": {
        "timestamps": [
          "number"
        ],
        "doubleValues": [
          "number"
        ],
        "int64Values": [
          "number"
        ]
      }
    }
  ]
}
```


Поле | Описание
--- | ---
metrics[] | **object**<br><p>Список метрик с временными точками.</p>
metrics[].<br>name | **string**<br><p>Имя метрики.</p>
metrics[].<br>labels | **object**<br><p>Список меток метрики в формате <code>ключ:значение</code>.</p>
metrics[].<br>type | **string**<br><p>Тип метрики.</p> <ul> <li>DGAUGE: Числовой показатель. Задается дробным числом.</li> <li>IGAUGE: Числовой показатель. Задается целым числом.</li> <li>COUNTER: Счетчик.</li> <li>RATE: Производная.</li> </ul>
metrics[].<br>timeseries | **object**<br><p>Значения метрик.</p>
metrics[].<br>timeseries.<br>timestamps[] | **number** (int64)<br><p>Список временных меток в формате миллисекунд Unix.</p>
metrics[].<br>timeseries.<br>doubleValues[] | **number** (double)<br><p>Список дробных значений метрик.</p>
metrics[].<br>timeseries.<br>int64Values[] | **number** (int64)<br><p>Список целых значений метрик. Доступен только для метрик с типом <code>IGAUGE</code>.</p>
