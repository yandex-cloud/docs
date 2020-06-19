---
editable: false
---

# MlModel
Набор методов управления моделями машинного обучения.
## JSON-представление {#representation}
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

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает модель машинного обучения в указанном кластере.
[delete](delete.md) | Удаляет указанную модель машинного обучения.
[get](get.md) | Возвращает указанную модель машинного обучения.
[list](list.md) | Возвращает список моделей машинного обучения в указанном кластере.
[update](update.md) | Обновляет указанную модель машинного обучения.