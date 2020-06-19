---
editable: false
---

# ResourcePreset
Набор методов для управления ресурсами ResourcePreset.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "zoneIds": [
    "string"
  ],
  "cores": "string",
  "memory": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор конфигурации ресурсов.</p> 
zoneIds[] | **string**<br><p>Идентификаторы зон доступности, в которых доступен данный набор ресурсов.</p> 
cores | **string** (int64)<br><p>Количество ядер CPU для хоста MongoDB, созданного с данным набором ресурсов.</p> 
memory | **string** (int64)<br><p>Объем оперативной памяти для хоста MongoDB, созданного с данным набором ресурсов, в байтах.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[get](get.md) | Возвращает указанный ресурс ResourcePreset.
[list](list.md) | Получает список доступных ресурсов ResourcePreset.