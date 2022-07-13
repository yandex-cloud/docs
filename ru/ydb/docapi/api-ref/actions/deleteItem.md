---
sourcePath: overlay/docapi/api-ref/actions/deleteItem.md
---
# Метод DeleteItem

Удаляет элемент в таблице по указанному первичному ключу.

Можно задать условие. Тогда запись удалится только в том случае, если условие выполнится.

В ответе можно получить значения атрибутов, какими были до удаления элемента.

## Запрос

Запрос содержит данные в формате JSON.

```json
{
   "ConditionalOperator": "string",
   "ConditionExpression": "string",
   "Expected": { 
      "string" : { 
         "AttributeValueList": [ 
            { 
               "B": blob,
               "BOOL": boolean,
               "BS": [ blob ],
               "L": [ 
                  "AttributeValue"
               ],
               "M": { 
                  "string" : "AttributeValue"
               },
               "N": "string",
               "NS": [ "string" ],
               "NULL": boolean,
               "S": "string",
               "SS": [ "string" ]
            }
         ],
         "ComparisonOperator": "string",
         "Exists": boolean,
         "Value": { 
            "B": blob,
            "BOOL": boolean,
            "BS": [ blob ],
            "L": [ 
               "AttributeValue"
            ],
            "M": { 
               "string" : "AttributeValue"
            },
            "N": "string",
            "NS": [ "string" ],
            "NULL": boolean,
            "S": "string",
            "SS": [ "string" ]
         }
      }
   },
   "ExpressionAttributeNames": { 
      "string" : "string" 
   },
   "ExpressionAttributeValues": { 
      "string" : { 
         "B": blob,
         "BOOL": boolean,
         "BS": [ blob ],
         "L": [ 
            "AttributeValue"
         ],
         "M": { 
            "string" : "AttributeValue"
         },
         "N": "string",
         "NS": [ "string" ],
         "NULL": boolean,
         "S": "string",
         "SS": [ "string" ]
      }
   },
   "Key": { 
      "string" : { 
         "B": blob,
         "BOOL": boolean,
         "BS": [ blob ],
         "L": [ 
            "AttributeValue"
         ],
         "M": { 
            "string" : "AttributeValue"
         },
         "N": "string",
         "NS": [ "string" ],
         "NULL": boolean,
         "S": "string",
         "SS": [ "string" ]
      }
   },
   "ReturnConsumedCapacity": "string"
   "ReturnValues": "string",
   "TableName": "string"
}
```

### Параметры

Параметр | Описание
----- | -----
`Key` | Ассоциативный массив имен атрибутов для объектов `AttributeValue`, представляющий первичный ключ удаляемого элемента.<br/>Для простого первичного ключа нужно указать только его значение.<br/>Для составного первичного ключа нужно указать значение ключа раздела и ключа сортировки.<br/><br/>**Тип**: Строка<br/>**Длина**: 1 - 65535 символов.<br/>**Обязательно**: Да
`TableName` | Имя таблицы, из которой нужно удалить элемент.</br>Может содержать путь в иерархии каталогов вида path/to/table<br/><br/>**Тип**: Строка<br/>**Длина**: 3 - 255 символов<br/>**Шаблон**: [a-zA-Z0-9_.-]+<br/>**Обязательно**: Да
`ConditionExpression` | Условие для удаления. Запись будет удалена только в том случае, если условие выполнится.<br/>Условие состоит из:<ul><li>Функции: `attribute_exists` \| `attribute_not_exists` \| `attribute_type` \| `contains` \| `begins_with` \| `size`. Имена чувствительны к регистру.<br/><li>Оператора сравнения: `=` \| `<>` \| `<` \| `>` \| `<=` \| `>=` \| `BETWEEN` \| `IN`<br/><li>Логического оператора: `AND` \| `OR` \| `NOT`</ul><br/>**Тип**: Строка<br/>**Обязательно**: Нет
`ExpressionAttributeNames` | Заполнитель (placeholder), который можно использовать в выражении вместо имени атрибута. Заполнитель должен начинаться с символа решетки `#`.<br/> В каких случаях это может пригодиться:<ul><li>Если нужно указать атрибут, имя которого конфликтует с зарезервированным словом.<li>В качестве переменной, если имя атрибута используется в выражении несколько раз.<li>Для предотвращения неправильной интерпретации специальных символов в имени атрибута.</ul>Например, имя атрибута `Percentile` конфликтует с зарезервированным словом, и его нельзя в явном виде использовать в выражении. Чтобы обойти эту проблему, нужно в параметре `ExpressionAttributeNames` указать заполнитель: `{"#P":"Percentile"}`. И затем вместо настоящего имени атрибута использовать `#P`.<br/><br/>**Тип**: Строка<br/>**Длина**: 1 - 65535 символов.<br/>**Обязательно**: Нет
`ExpressionAttributeValues` | Заполнитель (placeholder), который можно использовать в выражении вместо значения атрибута, аналогично `ExpressionAttributeNames`. Заполнитель должен начинаться с символа двоеточия `:`.<br/>Например, нужно проверить, было ли значение атрибута `ProductStatus` одним из следующих: `Available` \| `Backordered` \| `Discontinued`. Для этого сначала объявить заполнители : `{ ":avail":{"S":"Available"}, ":back":{"S":"Backordered"}, ":disc":{"S":"Discontinued"} }`. А потом их можно использовать в выражении: `ProductStatus IN (:avail, :back, :disc)`<br/><br/>**Тип**: Строка типа `AttributeValue`<br/>**Обязательно**: Нет
`ReturnConsumedCapacity` | Нужно ли возвращать информацию о потребляемой мощности.<ul><li>`TOTAL` — вернуть информацию.<li>`NONE` — не возвращать информацию.</ul><br/>**Тип**: Строка<br/>**Возможные значения**: `TOTAL` \| `NONE`<br/>**Обязательно**: Нет
`ReturnValues` | Используется, если нужно получить атрибуты удаляемого элемента.<br/>Возможные значения:<ul><li>`ALL_OLD` — возвращать содержимое удаленного элемента<li>`NONE` — не возвращать содержимое удаленного элемента (по умолчанию)</ul><br/>**Тип**: Строка<br/>**Обязательно**: Нет

## Ответ

В случае успеха вернется HTTP с кодом 200.
Запрос возвращает данные в формате JSON.

```json
{
   "Attributes": { 
      "string" : { 
         "B": blob,
         "BOOL": boolean,
         "BS": [ blob ],
         "L": [ 
            "AttributeValue"
         ],
         "M": { 
            "string" : "AttributeValue"
         },
         "N": "string",
         "NS": [ "string" ],
         "NULL": boolean,
         "S": "string",
         "SS": [ "string" ]
      }
   },
   "ConsumedCapacity": { 
      "CapacityUnits": number,
      "GlobalSecondaryIndexes": { 
         "string" : { 
            "CapacityUnits": number,
            "ReadCapacityUnits": number,
            "WriteCapacityUnits": number
         }
      },
      "LocalSecondaryIndexes": { 
         "string" : { 
            "CapacityUnits": number,
            "ReadCapacityUnits": number,
            "WriteCapacityUnits": number
         }
      },
      "ReadCapacityUnits": number,
      "Table": { 
         "CapacityUnits": number,
         "ReadCapacityUnits": number,
         "WriteCapacityUnits": number
      },
      "TableName": "string",
      "WriteCapacityUnits": number
   }
}
```

### Параметры

Параметр | Описание
----- | -----
`Attributes` | Ассоциативный массив типа `AttributeValue`, который содержит представление элемента до его удаления.<br/>Возвращается только в том случае, если в запросе был указан параметр `ReturnValues` со значением `ALL_OLD`.<br/><br/>**Тип**: Ассоциативный массив типа `AttributeValue`<br/>**Длина**: 1 - 65 535 символов.
`ConsumedCapacity` | Единицы мощности, потребленные операцией удаления.<br/>Возвращается только в том случае, если в запросе был указан параметр `ReturnConsumedCapacity` со значением `TOTAL`.<br/><br/>**Тип**: объект типа `ConsumedCapacity`

## Ошибки

Параметр | Описание
----- | ----- 
`ConditionalCheckFailedException` | Невозможно оценить условие, указанное в операции.<br/><br/>**Код состояния HTTP**: 400
`InternalServerError` | Произошла внутренняя ошибка на стороне сервера.<br/><br/>**Код состояния HTTP**: 500
`ItemCollectionSizeLimitExceededException` | Коллекция элементов слишком велика. Это исключение возвращается только для таблиц с одним или несколькими локальными вторичными индексами.<br/><br/>**Код состояния HTTP**: 400
`ProvisionedThroughputExceededException` | Вы слишком часто отправляете запросы. Попробуйте увеличить интервалы между запросами.<br/>Если таких запросов будет не слишком много, {{ ydb-name }} постарается обработать их все.<br/><br/>**Код состояния HTTP**: 400
`RequestLimitExceeded` | Пропускная способность превышает квоту.<br/><br/>**Код состояния HTTP**: 400
`ResourceNotFoundException` | Указанная таблица не существует.<br/><br/>**Код состояния HTTP**: 400
`TransactionConflictException` | Операция отклонена, так как для элемента выполняется другая транзакция.<br/><br/>**Код состояния HTTP**: 400

Также могут возникать [Общие ошибки](../common-errors), одинаковые для всех методов.