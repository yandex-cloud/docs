# DescribeStream

Возвращает информацию о [потоке данных](../../concepts/glossary.md#stream-concepts).

Вы можете ограничить количество описаний сегментов, возвращаемых каждым вызовом метода, с помощью параметра `Limit`.

## Запрос {#request}

Запрос содержит данные в формате JSON.

```json
{
  "ExclusiveStartShardId": "string",
  "Limit": number,
  "StreamName": "string"
}
```

### Параметры запроса {#request-options}

Параметр | Описание
----- | -----
`ExclusiveStartShardId` | Идентификатор сегмента. Информация о сегментах потока выводится, начиная с сегмента, который следует за указанным. По умолчанию выводится информация, начиная с первого сегмента в потоке.<br/><br/>**Тип**: Целое число<br/>**Возможные значения**: `[a-zA-Z0-9_.-]+`<br/>**Обязательный**: Нет
`Limit` | Максимальное количество описаний сегментов, возвращаемых за один вызов. Если вы укажете значение больше `100`, то будет возвращено не более `100` описаний.<br/><br/>**Тип**: Целое число<br/>**Возможные значения**: `1`-`10000`.<br/>**Значение по умолчанию**: `100`<br/>**Обязательный**: Нет
`StreamName` | Имя потока данных.<br/><br/>**Тип**: Строка<br/>**Размер**: `1`-`128` символов.<br/>**Возможные значения**: `[a-zA-Z0-9_.-]+`<br/>**Обязательный**: Да

## Ответ {#response}

В случае успеха возвращаются HTTP-ответ с кодом 200 и данные в формате JSON.

```json
{
  "StreamDescription": {
    "EncryptionType": "string",
    "EnhancedMonitoring": [{
      "ShardLevelMetrics": ["string"]
    }],
    "HasMoreShards": boolean,
    "KeyId": "string",
    "RetentionPeriodHours": number,
    "Shards": [{
      "AdjacentParentShardId": "string",
      "HashKeyRange": {
        "EndingHashKey": "string",
        "StartingHashKey": "string"
      },
      "ParentShardId": "string",
      "SequenceNumberRange": {
        "EndingSequenceNumber": "string",
        "StartingSequenceNumber": "string"
      },
      "ShardId": "string"
    }],
    "StreamCreationTimestamp": number,
    "StreamName": "string",
    "StreamStatus": "string"
  }
}
```

### Параметры ответа {#response-options}

Параметр | Описание
----- | -----
`StreamDescription` | Состояние потока.<br/><br/>**Тип**: Объект `StreamDescription`

## Ошибки {#errors}

Параметр | Описание | Код HTTP
----- | ----- | -----
`LimitExceededException` | Превышено максимальное число запросов. | 400
`ResourceNotFoundException` | Запрошенный ресурс не найден. | 400

Могут возникать [ошибки](../common-errors.md), общие для всех методов.
