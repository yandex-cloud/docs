---
sourcePath: overlay/docapi/api-ref/actions/createTable.md
---
# Метод CreateTable

Создает новую таблицу.

Это асинхронный метод.
Это значит, что метод переводит таблицу в состояние `CREATING` и сразу возвращает результат. Но по факту таблица создается в фоне и работать с ней можно только после того, как она перейдет в состояние `ACTIVE`.

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
   "GlobalSecondaryIndexes": [ 
      { 
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
      }
   ],
   "KeySchema": [ 
      { 
         "AttributeName": "string",
         "KeyType": "string"
      }
   ],
   "TableName": "string"
}
```

### Параметры

Параметр | Описание
----- | -----
`AttributeDefinitions` | Массив атрибутов, описывающих схему ключей для таблицы и индексов.<br/><br/>**Тип**: массив объектов типа `AttributeDefinition`.<br/>**Обязательно**: Да
`GlobalSecondaryIndexes` | Массив атрибутов, описывающий один или несколько глобальных вторичных индексов, которые будут созданы в таблице. Каждый элемент состоит из:<ul><li>`IndexName` — имя индекса. Имя должно быть уникально, длина — не менее трех символов. Обязательный параметр.</li><li>`KeySchema` — это атрибуты, составляющие первичный ключ индекса.</li><li>`Projection` — указывает атрибуты, которые копируются из таблицы в индекс. В настоящее время поддерживается только `ProjectionType` — `ALL`.</li><li>`NonKeyAttributes` — список одного или нескольких неключевых имен атрибутов, которые проецируются во вторичный индекс.</li></ul><br/>**Обязательно**: Нет
`KeySchema` | Атрибуты, составляющие первичный ключ. Эти атрибуты также должны быть указаны в `AttributeDefinitions`.<br/>Каждый элемент состоит из:<ul><li>`AttributeName` - имя атрибута.<li>`KeyType` — роль, которую будет выполнять ключевой атрибут:<ul><li>`HASH` — ключ раздела<li>`RANGE` — ключ сортировки</ul></ul>Для простого первичного ключа (ключ раздела) необходимо указать только один атрибут с ролью `HASH`.<br/>Для составного первичного ключа (ключ раздела + ключ сортировки) необходимо указать два атрибута: первый с ролью HASH, второй с ролью `RANGE`<br/><br/>**Тип**: массив объектов типа  `KeySchemaElement`<br/>**Длина**: 1 - 2 элемента.<br/>**Обязательно**: Да
`TableName` | Имя создаваемой таблицы.<br/>Может содержать путь в иерархии каталогов вида path/to/table.<br/><br/>**Тип**: Строка<br/>**Длина**: 3 - 255 символов.<br/>**Шаблон**: [a-zA-Z0-9_.-]+<br/>**Обязательно**: Да

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

Также могут возникать [Общие ошибки](../common-errors), одинаковые для всех методов.