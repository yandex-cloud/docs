---
editable: false
---

# Метод get
Возвращает указанную модель машинного обучения.
 
Чтобы получить список доступных подкластеров Data Proc, выполните запрос "[list](/docs/managed-clickhouse/api-ref/MlModel/list)".
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/mlModels/{mlModelName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера ClickHouse, к которому принадлежит модель.  Максимальная длина строки в символах — 50.
mlModelName | Обязательное поле. Имя возвращаемой модели.  Чтобы получить имя модели, используйте запрос "[list](/docs/managed-clickhouse/api-ref/MlModel/list)".  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string",
  "type": "string",
  "uri": "string"
}
```

 
Поле | Описание
--- | ---
name | **string**<br><p>Имя модели.</p> 
clusterId | **string**<br><p>Идентификатор кластера ClickHouse, к которому принадлежит модель.</p> 
type | **string**<br><p>Тип модели.</p> <ul> <li>ML_MODEL_TYPE_CATBOOST: Модель CatBoost.</li> </ul> 
uri | **string**<br><p>URL файла модели. Вы можете использовать только модели, хранящиеся в Yandex Object Storage.</p> 