---
editable: false
---

# Запись данных в таблицу
Записывает данные в указанную таблицу.
 
## HTTP-запрос {#https-request}
```
POST https://upload.datalens.yandex.net/provider/v1/connection/{connection_id}/{table_name}/data
```

## Path-параметры {#path_params}

Параметр | Описание
--- | ---
connection_id | Идентификатор подключения.
table_name | Имя таблицы.

## Заголовки {#headers}

Заголовок | Описание
--- | ---
X-DL-Client-Id | Идентификатор клиента.
X-DL-Operation-UUID | Уникальный идентификатор операции. <p>Значение генерируется на стороне клиента.</p> Подробнее в разделе [{#T}](../overview.md#operation-uuid).
X-DL-Table-Definition | Описание таблицы в формате JSON.<br/><p>Например:</p><p>```{"partition_key":["FieldName1","FieldName2"],"schema": [{"name": "fieldName1","type": "fieldType1"},{"name":"fieldName2", "type": "fieldType1"}]}```.</p><br/><p>Если переданная схема не совпадает с существующей, тогда {{ datalens-short-name }} учитывает значение заголовка `X-DL-Allow-Alter-Table`.</p>
X-DL-Allow-Alter-Table | Указывает, должна ли таблица изменить схему по записываемым данным.<p>Возможные значения: `true` / `false`.</p><br/><p>Если значение `true`, {{ datalens-short-name}} удаляет существующую таблицу с данными и создает новую с переданной схемой.</p>
X-DL-Data-Format | Формат данных. Возможное значение: `array`.
Content-Type | Тип передаваемого контента в теле.<p>Возможное значение: `application/x-ndjson`.</p>

## Параметры в теле запроса {#body_params}
 
```json
# Данные в виде массивов JSON, например:
["fieldValue11", "fieldValue21"]
["fieldValue12", "fieldValue22"]
["fieldValue13", "fieldValue23"]
```

## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "old_data_was_dropped": true,
  "row_count": 0
}
```

 
Поле | Описание
--- | ---
old_data_was_dropped | **boolean**<br><p>Указывает, была ли удалена старая схема таблицы.</p> 
row_count | **integer**<br><p>Число записанных строк.</p>

**HTTP Code: 400 - Bad Request**

Невалидные входные параметры. Например, схема таблицы не совпадает с передаваемыми данными. 

**HTTP Code: 423 - Locked**

В {{ datalens-short-name }} выполняется другая операция с указанной таблицей.  