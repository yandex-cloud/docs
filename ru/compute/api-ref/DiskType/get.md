# Метод get
Возвращает указанный ресурс DiskType.
 
Чтобы получить список доступных ресурсов DiskType, используйте
запрос [list](/docs/compute/api-ref/DiskType/list).
 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/diskTypes/{diskTypeId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
diskTypeId | Обязательное поле. Идентификатор возвращаемого ресурса DiskType. Чтобы получить идентификатор типа диска, используйте запрос [list](/docs/compute/api-ref/DiskType/list).
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор типа диска.</p> 
description | **string**<br><p>Описание типа диска. Длина описания должна быть от 0 до 256 символов.</p> 
zoneIds | **string**<br><p>Список зон доступности, в которых доступны диски этого типа.</p> 