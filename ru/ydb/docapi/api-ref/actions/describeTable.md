---
sourcePath: overlay/docapi/api-ref/actions/describeTable.md
---
# Метод DescribeTable

Возвращает информацию о таблице, включая текущее состояние, время создания, схему первичного ключа и индексы.

## Запрос

Запрос содержит данные в формате JSON.

```json
{
   "TableName": "string"
}
```

### Параметры

Параметр | Описание
----- | -----
`TableName` | Имя таблицы, о которой запрашивается информация.<br/>Может содержать путь в иерархии каталогов вида path/to/table.<br/><br/>**Тип**: Строка<br/>**Длина**: 3 - 255 символов<br/>**Шаблон**: [a-zA-Z0-9_.-]+<br/>**Обязательно**: Да

## Ответ

В случае успеха вернется HTTP с кодом 200.
Запрос возвращает данные в формате JSON.

```json
{
   "Table": { 
      "AttributeDefinitions": [ 
         { 
            "AttributeName": "string",
            "AttributeType": "string"
         }
      ],
      "CreationDateTime": number,
      "ItemCount": number,
      "KeySchema": [ 
         { 
            "AttributeName": "string",
            "KeyType": "string"
         }
      ],
      "TableName": "string",
      "TableSizeBytes": number,
      "TableStatus": "string"
   }
}
```

### Параметры

Параметр | Описание
----- | -----
`Table` | Свойства таблицы.<br/><br/>**Тип**: объект типа `TableDescription`.

## Ошибки

Параметр | Описание
----- | -----
`InternalServerError` | Произошла внутренняя ошибка на стороне сервера.<br/><br/>**Код состояния HTTP**: 500<br/>
`ResourceNotFoundException` | Указанная таблица не существует, или она еще создается методом [createTable](./createTable.md)<br/><br/>**Код состояния HTTP**: 400<br/>

Также могут возникать [Общие ошибки](../../common-errors.md), одинаковые для всех методов.