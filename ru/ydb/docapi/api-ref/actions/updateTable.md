---
sourcePath: overlay/docapi/api-ref/actions/updateTable.md
---
# Метод UpdateTable

Обновляет глобальные вторичные индексы и настройки стриминга указанной таблицы.

Вы можете выполнить только одну из этих операций за один запрос:
- Добавить глобальный вторичный индекс в таблицу.
- Удалить глобальный вторичный индекс из таблицы.
- включить/выключить стриминг изменений.

## Запрос

Запрос содержит данные в формате JSON.

```json
{
   "AttributeDefinitions": [ 
      { 
         "AttributeName": "string",
         "AttributeType": "string"
      }
   ],
   "BillingMode": "string",
   "GlobalSecondaryIndexUpdates": [ 
      { 
         "Create": { 
            "IndexName": "string",
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
         },
         "Delete": { 
            "IndexName": "string"
         }
      }
   ],
   "StreamSpecification": { 
      "StreamEnabled": boolean,
      "StreamViewType": "string"
   },
   "TableName": "string"
}
```

### Параметры


Параметр | Описание
----- | -----
`TableName` | Имя обновляемой таблицы.<br/>Может содержать путь в иерархии каталогов вида path/to/table.<br/><br/>**Тип**: Строка<br/>**Длина**: 3 - 255 символов.<br/>**Шаблон**: [a-zA-Z0-9_.-]+<br/>**Обязательно**: Да
`AttributeDefinitions` | Массив атрибутов, описывающих схему ключей для таблицы и индексов.<br/><br/>**Тип**: Массив объектов типа `AttributeDefinition`.<br/>**Обязательно**: Нет
`GlobalSecondaryIndexUpdates` | Массив операций, описывающий действия над глобальными вторичными индексами: <ul><li>`Create` добавляет новый глобальный вторичный индекс в таблицу.<br>**Тип**: Массив объектов `GlobalSecondaryIndexUpdate`.<br>**Обязательно**: Нет </li> <li>`Delete` удаляет глобальный вторичный индекс из таблицы.</li></ul>За один запрос вы можете добавить или удалить только один индекс.<br>При создании индекса нужно указывать следующие параметры:<ul><li>`IndexName` — имя индекса. Имя должно быть уникально, длина — не менее трех символов. Обязательный параметр.</li><li>`KeySchema` — это атрибуты, составляющие первичный ключ индекса.</li><li>`Projection` — указывает атрибуты, которые копируются из таблицы в индекс. В настоящее время поддерживается только `ProjectionType` — `ALL`.</li><li>`NonKeyAttributes` — список одного или нескольких неключевых имен атрибутов, которые проецируются во вторичный индекс.</li><br/>**Обязательно**: Нет</ul><br>При удалении таблицы достаточно указать только `IndexName`.
`StreamSpecification` | Описание настроек стрима изменений для таблицы:<br/><ul><li>`StreamEnabled` определяет, включен ли стриминг изменений для этой таблицы.</li><li>`StreamViewType` Определяет тип стриминга:<ul><li>`KEYS_ONLY` — будут записаны только компоненты первичного ключа и признак изменения.</li><li>`NEW_IMAGE` — будут записаны значения всех столбцов, получившиеся в результате изменения.</li><li>`OLD_IMAGE` — будут записаны значения всех столбцов, предшествующие изменению.</li><li>`NEW_AND_OLD_IMAGES` — комбинация режимов NEW_IMAGE и OLD_IMAGE. Будут записаны значения всех столбцов до и в результате изменения.</li></ul></li><br/>**Тип**: объект типа  `StreamSpecification`.<br/>**Обязательно**: Нет

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
      "Replicas": [ 
         {             
            "KMSMainKeyId": "string",            
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
`TableDescription` | Свойства созданной таблицы.<br/><br/>**Тип**: объект типа `TableDescription`

## Ошибки

Параметр | Описание
----- | -----
`InternalServerError` | Произошла внутренняя ошибка на стороне сервера.<br/><br/>**Код состояния HTTP**: 500
`LimitExceededException` | Превышен лимит операций над таблицами.<br/>Одновременно допускается до 50 операций над таблицами, включая `CreateTable`, `UpdateTable`, `DeleteTable`, `UpdateTimeToLive`, `RestoreTableFromBackup`, и `RestoreTableToPointInTime`.<br/><br/>**Код состояния HTTP**: 400
`ResourceInUseException` | Попытка создать таблицу с уже существующим именем.<br/><br/>**Код состояния HTTP**: 400<br/>
`ResourceNotFoundException` | Указанная таблица не существует, или она еще создается методом [createTable](./createTable.md)<br/><br/>**Код состояния HTTP**: 400<br/>
`ValidationException` | Попытка включить стриминг изменений, если он уже включен. Попытка выключить стриминг изменений, если он выключен. Попытка добавить индекс с уже занятым именем.

Также могут возникать [Общие ошибки](../../common-errors.md), одинаковые для всех методов.