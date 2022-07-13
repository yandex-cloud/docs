---
sourcePath: overlay/docapi/api-ref/actions/describeTimeToLive.md
---
# Метод DescribeTimeToLive

Возвращает информацию о состоянии TTL в указанной таблице.

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
`TableName` | Имя таблицы, для которой запрашивается состояние TTL.<br/>Может содержать путь в иерархии каталогов вида path/to/table.<br/><br/>**Тип**: Строка<br/>**Длина**: 3 - 255 символов.<br/>**Шаблон**: [a-zA-Z0-9_.-]+<br/>**Обязательно**: Да

## Ответ

В случае успеха вернется HTTP с кодом 200.
Запрос возвращает данные в формате JSON.

```json
{
  "TimeToLiveDescription": {
    "AttributeName": "string",
    "TimeToLiveStatus": "string"
  }
}
```

### Параметры

Параметр | Описание
----- | -----
`TimeToLiveSpecification` | Состояние TTL.<br/><br/>**Тип**: Объект типа `TimeToLiveSpecification`.

## Ошибки

Параметр | Описание
----- | -----
`InternalServerError` | Произошла внутренняя ошибка на стороне сервера.<br/><br/>**Код состояния HTTP**: 500
`ResourceNotFoundException` | Указанная таблица не существует, или находится в состоянии не `ACTIVE`.<br/><br/>**Код состояния HTTP**: 400<br/>

Также могут возникать [Общие ошибки](../../common-errors.md), одинаковые для всех методов.
