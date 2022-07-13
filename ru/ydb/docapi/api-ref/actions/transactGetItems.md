---
sourcePath: overlay/docapi/api-ref/actions/transactGetItems.md
---
# Метод TransactGetItems

Синхронная операция, которая атомарно извлекает несколько элементов из таблиц. 
Записи возвращаются постранично, за один раз можно вернуть до 25 объектов, каждый из которых содержит `Get`-структуру. За один раз можно извлечь до 4 Мб данных.

Метод может быть целиком отклонен, причины отклонения описаны в [ошибке TransactionCanceledException](#errors).

## Запрос

Запрос содержит данные в формате JSON.

```json
{
   "ReturnConsumedCapacity": "string",
   "TransactItems": [ 
      { 
         "Get": { 
            "ExpressionAttributeNames": { 
               "string" : "string" 
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
            "ProjectionExpression": "string",
            "TableName": "string"
         }
      }
   ]
}
```

### Параметры

Параметр | Описание
----- | -----
`TransactItems` | Упорядоченный массив из объектов типа `TransactGetItem`, каждый из которых содержит `Get`-структуру.<br/><br/>**Тип**: массив объектов `TransactGetItem`<br/>**Элементы массива**: 1-25 элементов.<br/>**Обязательно**: Да
`ReturnConsumedCapacity` | Нужно ли возвращать информацию о потребляемой мощности.<ul><li>`TOTAL` - Вернуть информацию.<li>`NONE` - Не возвращать информацию.</ul><br/>**Тип**: Строка<br/>**Возможные значения**: `TOTAL` \| `NONE`<br/>**Обязательно**: Нет

## Ответ

В случае успеха вернется HTTP с кодом 200.
Запрос возвращает данные в формате JSON.

```json
{
   "ConsumedCapacity": [ 
      { 
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
   ],
   "Responses": [ 
      { 
         "Item": { 
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
         }
      }
   ]
}
```

### Параметры

Параметр | Описание
----- | -----
`ConsumedCapacity` | Единицы мощности, потребленные операцией удаления.<br/>Возвращается только в том случае, если в запросе был указан параметр `ReturnConsumedCapacity` со значением `TOTAL`.<br/><br/>**Тип**: объект типа `ConsumedCapacity`
`Responses` | Упорядоченный массив, содержащий объекты типа `ItemResponse`.<br/>Каждый объект содержит ассоциативный массив пар ключ/значения, которые являются атрибутами запрошенного элемента.<br/>Если элемент не может быть получен, то соответствующий объект имеет значение `Null`. Если элемент не имеет атрибутов, то соответствующий объект будет пуст.<br/><br/>**Тип**: Массив объектов `ItemResponse`<br/>**Размер массива**: 1 - 25 элементов.

## Ошибки {#errors}

Параметр | Описание
----- | -----
`InternalServerError` | Произошла внутренняя ошибка на стороне сервера.<br/><br/>**Код состояния HTTP**: 500
`ProvisionedThroughputExceededException` | Вы слишком часто отправляете запросы. Попробуйте увеличить интервалы между запросами.<br/>Если таких запросов будет не слишком много, {{ ydb-name }} постарается обработать их все.<br/><br/>**Код состояния HTTP**: 400
`RequestLimitExceeded` | Пропускная способность превышает квоту.<br/><br/>**Код состояния HTTP**: 400
`ResourceNotFoundException` | Указанная таблица не существует.<br/><br/>**Код состояния HTTP**: 400
`TransactionCanceledException` | Весь запрос целиком был отменен.Это может произойти в следующих случаях:<ul><li>Выполняется другая операция `TransactGetItems`, конфликтующая с параллельным запросом `PutItem`, `UpdateItem`, `DeleteItem` или `TransactWriteItems`.<li>Для завершения транзакции недостаточно выделенной емкости.<li>Ошибка пользователя, например неверный формат данных.</ul><br/><br/>**Код состояния HTTP**: 400

Также могут возникать [Общие ошибки](../../common-errors.md), одинаковые для всех методов.