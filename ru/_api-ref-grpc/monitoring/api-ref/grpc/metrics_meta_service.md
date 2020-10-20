---
editable: false
---

# MetricsMetaService

Набор методов для получения информации о метаданных метрик.

| Вызов | Описание |
| --- | --- |
| [ListMetrics](#ListMetrics) | Возвращает список метрик. |

## Вызовы MetricsMetaService {#calls}

## ListMetrics {#ListMetrics}

Возвращает список метрик.

**rpc ListMetrics ([ListMetricsRequest](#ListMetricsRequest)) returns ([ListMetricsResponse](#ListMetricsResponse))**

### ListMetricsRequest {#ListMetricsRequest}

Поле | Описание
--- | ---
cloud_id | **string**<br>Обязательное поле. Идентификатор облака, которому принадлежит метрика. Максимальная длина строки в символах — 50.
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, которому принадлежит метрика. Максимальная длина строки в символах — 50.
page | **int64**<br>metric selectors string selectors = 3; Номер страницы. 
page_size | **int64**<br>Количество метрик в одной странице ответа. 


### ListMetricsResponse {#ListMetricsResponse}

Поле | Описание
--- | ---
result[] | **[MetricMeta](#MetricMeta)**<br>Список метрик. 
page | **[PageOptions](#PageOptions)**<br>Параметры пагинации. 


### MetricMeta {#MetricMeta}

Поле | Описание
--- | ---
name | **string**<br>Имя метрики. 
labels | **map<string,string>**<br>Список меток метрики в формате `ключ:значение`. 
kind | enum **MetricKind**<br>Тип метрики. <ul><li>`DGAUGE`: Числовой показатель. Задается дробным числом.</li><li>`IGAUGE`: Числовой показатель. Задается целым числом.</li><li>`COUNTER`: Счетчик.</li><li>`RATE`: Производная.</li><ul/>
created_at | **int64**<br>Время создания (записи первой точки) метрики. Строка в формате [ISO8601](https://ru.wikipedia.org/wiki/ISO_8601). 


### PageOptions {#PageOptions}

Поле | Описание
--- | ---
pages_count | **int64**<br>Количество страниц в ответе. 
total_count | **int64**<br>Общее количество метрик в ответе. 
page_size | **int64**<br>Количество метрик на одной странице ответа. 
current | **int64**<br>Номер запрошенной страницы. 


