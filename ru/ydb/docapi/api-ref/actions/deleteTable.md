---
sourcePath: overlay/docapi/api-ref/actions/deleteTable.md
---
# Метод DeleteTable

Удаляет таблицу со всеми записями. Также удаляются ее индексы.

Можно удалять только таблицы, которые находятся в состоянии `ACTIVE`.

Это асинхронный метод.
Это значит, что метод переводит таблицу в состояние `DELETING` и сразу возвращает результат. Но по факту таблица будет удаляться в фоне. Если таблица уже находится в состоянии `DELETING`, то метод не вернет ошибки.
Пока таблица находится в состоянии `DELETING`, {{ ydb-name }} может продолжать принимать запросы на чтение и запись данных, вроде [GetItem](./getItem) и [PutItem](./putItem).

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
`TableName` | Имя удаляемой таблицы.<br/>Может содержать путь в иерархии каталогов вида path/to/table.<br/><br/>**Тип**: Строка<br/>**Длина**: 3 - 255 символов<br/>**Шаблон**: [a-zA-Z0-9_.-]+<br/>**Обязательно**: Да

## Ответ

В случае успеха вернется HTTP с кодом 200.
Запрос возвращает данные в формате JSON.

```json
{
   "TableDescription": { 
      "ArchivalSummary": { 
         "ArchivalBackupArn": "string",
         "ArchivalDateTime": number,
         "ArchivalReason": "string"
      },
      "AttributeDefinitions": [ 
         { 
            "AttributeName": "string",
            "AttributeType": "string"
         }
      ],
      "BillingModeSummary": { 
         "BillingMode": "string",
         "LastUpdateToPayPerRequestDateTime": number
      },
      "CreationDateTime": number,
      "GlobalSecondaryIndexes": [ 
         { 
            "Backfilling": boolean,
            "IndexArn": "string",
            "IndexName": "string",
            "IndexSizeBytes": number,
            "IndexStatus": "string",
            "ItemCount": number,
            "KeySchema": [ 
               { 
                  "AttributeName": "string",
                  "KeyType": "string"
               }
            ],
            "Projection": { 
               "NonKeyAttributes": [ "string" ],
               "ProjectionType": "string"
            },
            "ProvisionedThroughput": { 
               "LastDecreaseDateTime": number,
               "LastIncreaseDateTime": number,
               "NumberOfDecreasesToday": number,
               "ReadCapacityUnits": number,
               "WriteCapacityUnits": number
            }
         }
      ],
      "GlobalTableVersion": "string",
      "ItemCount": number,
      "KeySchema": [ 
         { 
            "AttributeName": "string",
            "KeyType": "string"
         }
      ],
      "LatestStreamArn": "string",
      "LatestStreamLabel": "string",
      "LocalSecondaryIndexes": [ 
         { 
            "IndexArn": "string",
            "IndexName": "string",
            "IndexSizeBytes": number,
            "ItemCount": number,
            "KeySchema": [ 
               { 
                  "AttributeName": "string",
                  "KeyType": "string"
               }
            ],
            "Projection": { 
               "NonKeyAttributes": [ "string" ],
               "ProjectionType": "string"
            }
         }
      ],
      "ProvisionedThroughput": { 
         "LastDecreaseDateTime": number,
         "LastIncreaseDateTime": number,
         "NumberOfDecreasesToday": number,
         "ReadCapacityUnits": number,
         "WriteCapacityUnits": number
      },
      "Replicas": [ 
         { 
            "GlobalSecondaryIndexes": [ 
               { 
                  "IndexName": "string",
                  "ProvisionedThroughputOverride": { 
                     "ReadCapacityUnits": number
                  }
               }
            ],
            "KMSMainKeyId": "string",
            "ProvisionedThroughputOverride": { 
               "ReadCapacityUnits": number
            },
            "RegionName": "string",
            "ReplicaStatus": "string",
            "ReplicaStatusDescription": "string",
            "ReplicaStatusPercentProgress": "string"
         }
      ],
      "RestoreSummary": { 
         "RestoreDateTime": number,
         "RestoreInProgress": boolean,
         "SourceBackupArn": "string",
         "SourceTableArn": "string"
      },
      "SSEDescription": { 
         "InaccessibleEncryptionDateTime": number,
         "KMSMainKeyArn": "string",
         "SSEType": "string",
         "Status": "string"
      },
      "StreamSpecification": { 
         "StreamEnabled": boolean,
         "StreamViewType": "string"
      },
      "TableArn": "string",
      "TableId": "string",
      "TableName": "string",
      "TableSizeBytes": number,
      "TableStatus": "string"
   }
}
```

### Параметры

Параметр | Описание
----- | -----
`TableDescription` | Свойства удаленной таблицы.<br/><br/>**Тип**: JSON-объект

## Ошибки

Параметр | Описание
----- | -----
`InternalServerError` | Произошла внутренняя ошибка на стороне сервера.<br/><br/>**Код состояния HTTP**: 500<br/>
`LimitExceededException` | Превышен лимит операций над таблицами.<br/>Одновременно допускается до 50 операций над таблицами, включая `CreateTable`, `UpdateTable`, `DeleteTable`, `UpdateTimeToLive`, `RestoreTableFromBackup`, и `RestoreTableToPointInTime`.<br/><br/>**Код состояния HTTP**: 400
`ResourceInUseException` | Таблица занята и сейчас ее нельзя удалить.<br/>Эта ошибка возникает, если таблица создается или изменяется ее структура (т.е. если она находится в состояниях `CREATING` или `UPDATING`)<br/><br/>**Код состояния HTTP**: 400<br/>
`ResourceNotFoundException` | Указанная таблица не существует.<br/><br/>**Код состояния HTTP**: 400<br/>

Также могут возникать [Общие ошибки](../common-errors), одинаковые для всех методов.