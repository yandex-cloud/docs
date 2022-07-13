---
sourcePath: overlay/docapi/api-ref/actions/transactWriteItems.md
---
# Метод TransactWriteItems

Синхронная операция записи, которая группирует до 25 действий. Можно работать с элементами из разных таблиц, но с одним элементом за один запрос можно выполнять только одно действие.

Суммарный объем всех элементов не может превышать 4 Мб.

Метод атомарен, так что либо выполнятся все действия, либо ни одного. Причины отклонения описаны в [ошибке TransactionCanceledException](#errors).

Действия, которые можно выполнить:
- `Put` — запись нового элемента. 
- `Update` — обновление существующего элемента.
- `Delete` — удаление существующего элемента. 
- `ConditionCheck` — условие для проверки существования элемента или состояния его атрибутов.

## Запрос

Запрос содержит данные в формате JSON.

```json
{
   "ReturnConsumedCapacity": "string",
   "TransactItems": [ 
      { 
         "ConditionCheck": { 
            "ConditionExpression": "string",
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
            "ReturnValuesOnConditionCheckFailure": "string",
            "TableName": "string"
         },
         "Delete": { 
            "ConditionExpression": "string",
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
            "ReturnValuesOnConditionCheckFailure": "string",
            "TableName": "string"
         },
         "Put": { 
            "ConditionExpression": "string",
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
            },
            "ReturnValuesOnConditionCheckFailure": "string",
            "TableName": "string"
         },
         "Update": { 
            "ConditionExpression": "string",
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
            "ReturnValuesOnConditionCheckFailure": "string",
            "TableName": "string",
            "UpdateExpression": "string"
         }
      }
   ]
}
```

### Параметры

Параметр | Описание
----- | -----
`TransactItems` | Упорядоченный массив из объектов типа `TransactWriteItem`, каждый из которых содержит операцию `Put`, `Update`, `Delete` или `ConditionCheck`. Можно работать с элементами из разных таблиц, но каждый элемент в одном запросе можно использовать только один раз..<br/><br/>**Тип**: массив объектов `TransactWriteItem`<br/>**Элементы массива**: 1-25 элементов.<br/>**Обязательно**: Да
`ClientRequestToken` | Не поддерживается. Не зависимо от значений ттокена все вызовы метода будут идемпотентным. Это означает, что повторные вызовы метода будут иметь тот же эффект, то и единичный вызов.<br/>Хотя состояние сервера не изменится, но ответы могут быть разными. Если установлен параметр `ReturnConsumedCapacity`, то при первом запросе вернется количество единиц емкости записи. Последующие запросы с тем же токеном будут возвращать количество единиц емкости чтения.<br/>Токен действителен в течение 10 минут после выполнения первого запроса. После этого любой запрос с тем же токеном считается как новый запрос.<br/>Если в течение 10 минут отправить такой же токен, но с другими параметрами, то метод вернет исключение `IdempotentParameterMismatch`.<br/><br/>**Тип**: Строка<br/>**Длина**: 1 - 36 символов.<br/>**Обязательно**: Нет
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
   ]
}
```

### Параметры

Параметр | Описание
----- | -----
`ConsumedCapacity` | Единицы мощности, потребленные операцией удаления.<br/>Возвращается только в том случае, если в запросе был указан параметр `ReturnConsumedCapacity` со значением `TOTAL`.<br/><br/>**Тип**: объект типа `ConsumedCapacity`

## Ошибки {#errors}

Параметр | Описание
----- | -----
`IdempotentParameterMismatchException` | Запрос отклонен, т.к. он содержит идемпотентный токен с другими параметрами.<br/><br/>**Код состояния HTTP**: 400
`InternalServerError` | Произошла внутренняя ошибка на стороне сервера.<br/><br/>**Код состояния HTTP**: 500<br/>
`ProvisionedThroughputExceededException` | Вы слишком часто отправляете запросы. Попробуйте увеличить интервалы между запросами.<br/>Если таких запросов будет не слишком много, {{ ydb-name }} постарается обработать их все.<br/><br/>**Код состояния HTTP**: 400
`RequestLimitExceeded` | Пропускная способность превышает квоту.<br/><br/>**Код состояния HTTP**: 400
`ResourceNotFoundException` | Указанная таблица не существует.<br/><br/>**Код состояния HTTP**: 400
`TransactionCanceledException` | Весь запрос целиком был отменен.<br/>Это может произойти в следующих случаях:<ul><li>Условие в одном из выражений не выполняется.<li>Попытка выполнить несколько действий над одним элементом в одном запросе.<li>Для завершения транзакции недостаточно выделенной емкости.<li>Размер отдельного элемента слишком большой (более 400 Кб). Или возникает аналогичная ошибка из-за изменений, внесенных транзакцией.<li>Общий размер всех элементов превышает 4 Мб.<li>Ошибка пользователя, например неверный формат данных.</ul><br/>**Код состояния HTTP**: 400
`TransactionInProgressException` | Транзакция с указанным токеном запроса уже выполняется.<br/><br/>**Код состояния HTTP**: 400

Также могут возникать [Общие ошибки](../common-errors), одинаковые для всех методов.