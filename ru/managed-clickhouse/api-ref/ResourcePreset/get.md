# Метод get
Возвращает указанный ресурс ResourcePreset.
 
Чтобы получить список доступных ресурсов ResourcePreset, используйте
запрос [list](/docs/managed-clickhouse/api-ref//ResourcePreset/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/resourcePresets/{resourcePresetId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
resourcePresetId | Обязательное поле. Идентификатор набора ресурсов, данные о котором запрашиваются. Чтобы получить идентификатор набора ресурсов, используйте запрос [list](/docs/managed-clickhouse/api-ref//ResourcePreset/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс ResourcePreset для описания настроек конфигурации ресурсов.
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор ресурса ResourcePreset.</p> 
zoneIds | **string**<br><p>Идентификаторы зон доступности, в которых доступен данный набор ресурсов.</p> 
cores | **string** (int64)<br><p>Количество ядер CPU для хоста ClickHouse, созданного с данным набором ресурсов.</p> 
memory | **string** (int64)<br><p>Объем оперативной памяти для хоста ClickHouse, созданного с данным набором ресурсов.</p> 
