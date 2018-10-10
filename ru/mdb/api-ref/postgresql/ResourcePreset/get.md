# Метод get
Возвращает указанный ресурс ResourcePreset.
 
Чтобы получить список доступных ресурсов ResourcePreset, используйте
запрос [list](/docs/mdb/api-ref/postgresql/ResourcePreset/list).
 
## HTTP-запрос
`GET /managed-postgresql/v1/resourcePresets/{resourcePresetId}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
resourcePresetId | Обязательное поле. Обязательное поле. Идентификатор набора ресурсов, данные о котором запрашиваются. Чтобы получить идентификатор набора ресурсов, используйте запрос[list](/docs/mdb/api-ref/postgresql/ResourcePreset/list).
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс ResourcePreset для описания наборов ресурсов.
 
Поле | Описание
--- | ---
id | **string**<br>Идентификатор ресурса ResourcePreset.
zoneIds | **string**<br>Идентификаторы зон доступности, в которых доступен данный набор ресурсов.
cores | **string** (int64)<br>Количество ядер CPU для хоста PostgreSQL, созданного с данным набором ресурсов.
memory | **string** (int64)<br>Объем оперативной памяти для хоста PostgreSQL, созданного с данным набором ресурсов, в байтах.