# Метод get
Возвращает указанный ресурс ResourcePreset.
 
Чтобы получить список доступных ресурсов ResourcePreset, используйте
запрос [list](/docs/mdb/api-ref/clickhouse/ResourcePreset/list).
 
## HTTP-запрос
`GET /managed-clickhouse/v1/resourcePresets/{resourcePresetId}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
resourcePresetId | Обязательное поле. Идентификатор набора ресурсов, данные о котором запрашиваются. Чтобы получить идентификатор набора ресурсов, используйте запрос[list](/docs/mdb/api-ref/clickhouse/ResourcePreset/list).  Максимальная длина — 50 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс ResourcePreset для описания наборов ресурсов.
 
Поле | Описание
--- | ---
id | **string**<br>Идентификатор ресурса ResourcePreset.
zoneIds | **string**<br>Идентификаторы зон доступности, в которых доступен набор ресурсов.
cores | **string** (int64)<br>Количество ядер CPU для хоста ClickHouse, созданного с данным набором ресурсов.
memory | **string** (int64)<br>Объем оперативной памяти для хоста ClickHouse, созданного с данным набором ресурсов.