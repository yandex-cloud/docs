---
editable: false
---

# Метод read
Возвращает данные метрик.
 

 
## HTTP-запрос {#https-request}
```
POST https://monitoring.api.cloud.yandex.net/monitoring/v1/data/read
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
cloudId | Обязательное поле. Идентификатор облака, которому принадлежит метрика.  Максимальная длина строки в символах — 50.
folderId | Обязательное поле. Идентификатор каталога, которому принадлежит метрика.  Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "program": "string",
  "fromTime": "string",
  "toTime": "string",
  "downsampling": {
    "maxPoints": "string",
    "gridMillis": "string",
    "aggregation": "string",
    "fill": "string"
  }
}
```

 
Поле | Описание
--- | ---
program | **string**<br><p>Обязательное поле. Текст запроса.</p> 
fromTime | **string** (int64)<br><p>Обязательное поле. Начальная точка интервала. Строка в формате <a href="https://ru.wikipedia.org/wiki/ISO_8601">ISO8601</a>.</p> 
toTime | **string** (int64)<br><p>Обязательное поле. Конечная точка интервала. Строка в формате <a href="https://ru.wikipedia.org/wiki/ISO_8601">ISO8601</a>.</p> 
downsampling | **object**<br><p>Параметры прореживания.</p> 
downsampling.<br>maxPoints | **string** (int64)<br><p>Максимальное количество точек, которое будет получено в ответе на запрос.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
downsampling.<br>gridMillis | **string** (int64)<br><p>Ширина временного окна (сетка) в миллисекундах. Используется для прореживания. Точки внутри окна объединяются в одну при помощи функции агрегации.</p> <p>Значение должно быть больше 0.</p> 
downsampling.<br>aggregation | **string**<br><p>Функция агрегации, которая используется для прореживания.</p> <p>Список доступных агрегирующий функций, используемых при прореживании.</p> <ul> <li>MAX: Максимум.</li> <li>MIN: Минимум.</li> <li>SUM: Сумма.</li> <li>AVG: Среднее значение. Значение по умолчанию.</li> <li>LAST: Последнее значение.</li> <li>COUNT: Количество точек.</li> </ul> 
downsampling.<br>fill | **string**<br><p>Параметры заполнения пропусков в данных.</p> <ul> <li>NULL: Возвращает ``null`` в качестве значения метрики и ``timestamp`` в качестве временной метки. Значение по умолчанию.</li> <li>NONE: Не возвращает значений.</li> <li>PREVIOUS: Возвращает значение из предыдущей временной точки.</li> </ul> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "vector": [
    {
      "kind": "string",
      "name": "string",
      "labels": "object",
      "timestamps": [
        "string"
      ],
      "values": [
        "number"
      ]
    }
  ]
}
```

 
Поле | Описание
--- | ---
vector[] | **object**<br><p>Список метрик.</p> 
vector[].<br>kind | **string**<br><p>Тип метрики.</p> <ul> <li>DGAUGE: Числовой показатель. Задается дробным числом.</li> <li>IGAUGE: Числовой показатель. Задается целым числом.</li> <li>COUNTER: Счетчик.</li> <li>RATE: Производная.</li> </ul> 
vector[].<br>name | **string**<br><p>Имя метрики.</p> 
vector[].<br>labels | **object**<br><p>Список меток метрики в формате ``ключ:значение``.</p> 
vector[].<br>timestamps[] | **string** (int64)<br><p>Список временных точек метрики в формате ``timestamp``.</p> 
vector[].<br>values[] | **number** (double)<br><p>Список значений метрики.</p> 