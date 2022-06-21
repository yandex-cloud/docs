---
sourcePath: overlay/docapi/api-ref/actions/updateItem.md
---
# Метод UpdateItem

Обновляет атрибуты существующего элемента или добавляет новый элемент, если он не существует. Можно менять, удалять или добавлять значения атрибутов. 

Можно задать условие для изменения. Тогда метод отработает только в том случае, если условие выполнится.

В ответе можно получить значения атрибутов, которые были до или после изменения.

## Запрос

Запрос содержит данные в формате JSON.

```json
{
   "AttributeUpdates": { 
      "string" : { 
         "Action": "string",
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
   "ReturnConsumedCapacity": "string",
   "ReturnValues": "string",
   "TableName": "string",
   "UpdateExpression": "string"
}
```

### Параметры

Параметр | Описание
----- | -----
`Key` | Первичный ключ изменяемого элемента, необходимо указать все ключевые атрибуты. Для простого первичного ключа нужно указать только его значение. Для составного первичного ключа нужно указать значение ключа раздела и ключа сортировки.<br/><br/>**Тип**: ассоциативный массив типа `AttributeValue`.<br/>**Длина**: 1 - 65535 символов.<br/>**Обязательно**: Да
`TableName` | Имя таблицы, в которой находится изменяемый элемент.</br>Может содержать путь в иерархии каталогов вида path/to/table.<br/><br/>**Тип**: Строка<br/>**Длина**: 3 - 255 символов<br/>**Шаблон**: [a-zA-Z0-9_.-]+<br/>**Обязательно**: Да
`ConditionExpression` | Условие для обновления элемента. Метод обработает только в том случае, если условие выполнится.<br/>Условие состоит из:<ul><li>Функции: `attribute_exists` \| `attribute_not_exists` \| `attribute_type` \| `contains` \| `begins_with` \| `size`. Имена чувствительны к регистру.<li>Оператора сравнения: `=` \| `<>` \| `<` \| `>` \| `<=` \| `>=` \| `BETWEEN` \| `IN`.<li>Логического оператора: `AND` \| `OR` \| `NOT`.</ul><br/>**Тип**: Строка<br/>**Обязательно**: Нет
`ExpressionAttributeNames` | Заполнитель (placeholder), который можно использовать в выражении вместо имени атрибута. Заполнитель должен начинаться с символа решетки `#`.<br/> В каких случаях это может пригодиться:<ul><li>Если нужно указать атрибут, имя которого конфликтует с зарезервированным словом.<li>В качестве переменной, если имя атрибута используется в выражении несколько раз.<li>Для предотвращения неправильной интерпретации специальных символов в имени атрибута.</ul>Например, имя атрибута `Percentile` конфликтует с зарезервированным словом, и его нельзя в явном виде использовать в выражении. Чтобы обойти эту проблему, нужно в параметре `ExpressionAttributeNames` указать заполнитель: `{"#P":"Percentile"}`. И затем вместо настоящего имени атрибута использовать `#P`.<br/><br/>**Тип**: Строка<br/>**Длина**: 1 - 65535 символов.<br/>**Обязательно**: Нет
`ExpressionAttributeValues` | Заполнитель (placeholder), который можно использовать в выражении вместо значения атрибута, аналогично `ExpressionAttributeNames`. Заполнитель должен начинаться с символа двоеточия `:`.<br/>Например, нужно проверить, было ли значение атрибута `ProductStatus` одним из следующих: `Available` \| `Backordered` \| `Discontinued`. Для этого сначала объявить заполнители : `{ ":avail":{"S":"Available"}, ":back":{"S":"Backordered"}, ":disc":{"S":"Discontinued"} }`. А потом их можно использовать в выражении: `ProductStatus IN (:avail, :back, :disc)`<br/><br/>**Тип**: Строка типа `AttributeValue`<br/>**Обязательно**: Нет
`ReturnConsumedCapacity` | Нужно ли возвращать информацию о потребляемой мощности.<ul><li>`TOTAL` — вернуть информацию.<li>`NONE` — не возвращать информацию.</ul><br/>**Тип**: Строка<br/>**Возможные значения**: `TOTAL` \| `NONE`<br/>**Обязательно**: Нет
`ReturnValues` | Используется, если нужно получить атрибуты элемента до или после изменения.<br/>Возможные значения:<ul><li>`NONE` — не возвращать атрибуты (по умолчанию)<li>`ALL_OLD` — вернуть все атрибуты в том виде, в котором они были до изменения<li>`UPDATED_OLD` — Вернуть только обновленные атрибуты в том виде, в котором они были до изменения.<li>`ALL_NEW` — вернуть все атрибуты в том виде, в котором они будут после изменения.<li>`UPDATED_NEW` — вернуть только обновленные атрибуты в том виде, в котором они будут после изменения.</ul>При этом единицы емкости чтения не используются.<br/>Возвращенные значения строго согласованы.<br/><br/>**Тип**: Строка<br/>**Возможные значения**: `NONE` \| `ALL_OLD` \| `UPDATED_OLD` \| `ALL_NEW` \| `UPDATED_NEW`<br/>**Обязательно**: Нет
`UpdateExpression` | Выражение для обновления. Определяет, как и какие атрибуты нужно обновить.<br/>Доступные действия:<ul><li>`SET` — устанавливает атрибуту указанное значение. Если атрибут не существовал, то он будет создан.<br/>Поддерживает функции:<ul><li>`if_not_exists (path, operand)` — проверка, что указанный атрибут не существует. Если по указанному пути (`path`) атрибут не найдется, то функция вычислит указанный операнд.<li>`list_append (operand, operand)` — evaluates to a list with a new element added to it. You can append the new element to the start or the end of the list by reversing the order of the operands.</ul>Имена функций чувствительны к регистру.<li>`REMOVE` — Удаляет атрибуты.<li>`ADD` — Добавляет значение к атрибуту. <br/>Если атрибут существует, то поведение ADD зависит от типа данных атрибута:<ul><li>Если атрибут — **число**, то сработает операция сложения и значение атрибута сложится с указанным значением. Если атрибут или значение не существовали, то за основу берется число `0` и операция сложения работает с ним.<li>Если атрибут — **набор**, то указанное значение добавится к набору. Оба набора (в значении атрибута и указанный) должны иметь одинаковый тип данных.</ul><li>`DELETE` Удаляет элемент из набора. Работает только с наборами, причем только с атрибутами верхнего уровня. Вложенные атрибуты удалить нельзя.<br/>За один раз можно указать несколько элементов.</ul>В одном выражении может быть много действий, например `SET a=:value1, b=:value2 DELETE :value3, :value4, :value5`<br/><br/>**Тип**: Строка<br/>**Обязательно**: Нет

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
`Attributes` | Ассоциативный массив типа `AttributeValue`, который содержит представление элемента до или после его изменения.<br/>Возвращается только в том случае, если в запросе был указан параметр `ReturnValues` со значением ≠ `NONE`.<br/><br/>**Тип**: Ассоциативный массив типа `AttributeValue`<br/>**Длина**: 1 - 65 535 символов.
`ConsumedCapacity` | Единицы мощности, потребленные операцией удаления.<br/>Возвращается только в том случае, если в запросе был указан параметр `ReturnConsumedCapacity` со значением `TOTAL`.<br/><br/>**Тип**: объект типа `ConsumedCapacity`

## Ошибки

Параметр | Описание
----- | -----
`ConditionalCheckFailedException` | Невозможно проверить условие, указанное в операции.<br/><br/> **Код состояния HTTP**: 400
`InternalServerError` | Произошла внутренняя ошибка на стороне сервера.<br/><br/>**Код состояния HTTP**: 500
`ProvisionedThroughputExceededException` | Вы слишком часто отправляете запросы. Попробуйте увеличить интервалы между запросами.<br/>Если таких запросов будет не слишком много, {{ ydb-name }} постарается обработать их все.<br/><br/>**Код состояния HTTP**: 400
`RequestLimitExceeded` | Пропускная способность превышает квоту.<br/><br/>**Код состояния HTTP**: 400
`ResourceNotFoundException` | Указанная таблица не существует, или находится в состоянии не 'ACTIVE'.<br/><br/>**Код состояния HTTP**: 400
`TransactionConflictException` | Операция отклонена, так как для элемента выполняется другая транзакция.<br/><br/>**Код состояния HTTP**: 400

Также могут возникать [Общие ошибки](../common-errors), одинаковые для всех методов.