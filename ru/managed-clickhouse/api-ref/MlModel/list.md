---
editable: false
---

# Метод list
Возвращает список моделей машинного обучения в указанном кластере.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/mlModels
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера, к которому принадлежат модели.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем "page_size" , сервис вернет значение "[nextPageToken](/docs/managed-clickhouse/api-ref/MlModel/list#responses)", которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение "page_token" равным значению поля "[nextPageToken](/docs/managed-clickhouse/api-ref/MlModel/list#responses)" предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "mlModels": [
    {
      "name": "string",
      "clusterId": "string",
      "type": "string",
      "uri": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
mlModels[] | **object**<br><p>Список моделей в указанном кластере.</p> 
mlModels[].<br>name | **string**<br><p>Имя модели.</p> 
mlModels[].<br>clusterId | **string**<br><p>Идентификатор кластера ClickHouse, к которому принадлежит модель.</p> 
mlModels[].<br>type | **string**<br><p>Тип модели.</p> <ul> <li>ML_MODEL_TYPE_CATBOOST: Модель CatBoost.</li> </ul> 
mlModels[].<br>uri | **string**<br><p>URL файла модели. Вы можете использовать только модели, хранящиеся в Yandex Object Storage.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы списка. Если количество результатов больше чем &quot;<a href="/docs/managed-clickhouse/api-ref/MlModel/list#query_params">pageSize</a>&quot;, используйте &quot;next_page_token&quot; в качестве значения параметра &quot;<a href="/docs/managed-clickhouse/api-ref/MlModel/list#query_params">pageToken</a>&quot; в следующем запросе списка ресурсов.</p> <p>Каждая следующая страница будет иметь свой &quot;next_page_token&quot; для продолжения перебора страниц результатов.</p> 