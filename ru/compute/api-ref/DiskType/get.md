---
editable: false
---

# Метод get
Возвращает сведения об указанном типе диска.
 
Чтобы получить список доступных типов дисков, выполните запрос [list](/docs/compute/api-ref/DiskType/list).
 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/diskTypes/{diskTypeId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
diskTypeId | Обязательное поле. Идентификатор типа диска для возврата сведений о диске. Чтобы получить идентификатор типа диска, используйте запрос [list](/docs/compute/api-ref/DiskType/list).
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "zoneIds": [
    "string"
  ]
}
```

 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор типа диска.</p> 
description | **string**<br><p>Описание диска. Длина описания должна быть от 0 до 256 символов.</p> 
zoneIds[] | **string**<br><p>Массив зон доступности, в которых доступен тип диска.</p> 