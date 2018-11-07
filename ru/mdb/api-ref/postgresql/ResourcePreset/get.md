# Метод get
Возвращает указанный ресурс ResourcePreset.
 
Чтобы получить список доступных ресурсов ResourcePreset, используйте
запрос [list](/docs/mdb/api-ref/postgresql/ResourcePreset/list).
 
## HTTP-запрос {#https-request}
`GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/resourcePresets/{resourcePresetId}`
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
resourcePresetId | Обязательное поле. Обязательное поле. Идентификатор набора ресурсов, данные о котором запрашиваются. Чтобы получить идентификатор набора ресурсов, используйте запрос[list](/docs/mdb/api-ref/postgresql/ResourcePreset/list).
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс ResourcePreset для описания настроек конфигурации ресурсов.
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор ресурса ResourcePreset.</p> 
zoneIds | **string**<br><p>Идентификаторы зон доступности, в которых доступен данный набор ресурсов.</p> 
cores | **string** (int64)<br><p>Количество ядер CPU для хоста PostgreSQL, созданного с данным набором ресурсов.</p> 
memory | **string** (int64)<br><p>Объем оперативной памяти для хоста PostgreSQL, созданного с данным набором ресурсов, в байтах.</p> 