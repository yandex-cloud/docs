---
sourcePath: overlay/docapi/uniqueConstraint.md
---
# Использование транзакций для обеспечения уникальности атрибутов

Часто возникает задача обеспечить уникальность какогo-либо атрибута в таблице - только один ряд может содержать данное значение.
В некоторых СУБД задача может быть решена с помощью ограничения целостности типа "уникальный индекс".
Document API гарантирует только уникальность значений первичного ключа. Для других атрибутов нет встроенного механизма обеспечения уникальности.

Уникальность может быть обеспечена при использовании операции `TransactWriteItems`. 

В разделе приведён простой пример обеспечения уникальности значения атрибута без применения дополнительных таблиц.

Пусть у нас есть таблица для аутентификации пользователей со столбцами

- id - первичный ключ, мы используем случайные последовательности символов для обеспечения уникальности
- login - логин пользователя
- passwordHash - хеш пароля
- email - email пользователя

Для этого мы создаем таблицу, выполняя
```bash
aws --endpoint-url ${DOCAPI_ENDPOINT} dynamodb create-table --table-name User \
--attribute-definitions AttributeName=id,AttributeType=S AttributeName=login,AttributeType=S \
AttributeName=passwordeHash,AttributeType=S AttributeName=email,AttributeType=S \
--key-schema AttributeName=id,KeyType=HASH \
--billing-mode PAY_PER_REQUEST
```

Данные в таблице могут выглядеть так:

id      | login | passwordHash | email
:-------- |:-----:| -------:| -------:
j481969rur7dics3g  | chudinov  | d8578edf8458ce06fbc5bb76a58c5ca4 | victor.chudinov@example.com
olbmrnipjt7p7kf6p     | aplitvinov@example.org    | 827ccb0eea8a706c4c34a16891f84e7b | aplitvinov@example.org

Мы хотим, чтобы login и email были уникальными. Для этого мы добавляем дополнительные записи:

id      | login | passwordHash | email
:-------- |:-----:| -------:| -------:
j481969rur7dics3g  | chudinov  | d8578edf8458ce06fbc5bb76a58c5ca4 | victor.chudinov@example.com
login=chudinov | | |
email=victor.chudinov@example.com | | |
olbmrnipjt7p7kf6p     | aplitvinov@example.org    | 827ccb0eea8a706c4c34a16891f84e7b | aplitvinov@example.org
login=aplitvinov@example.org | | |
email=aplitvinov@example.org | | |

Эти дополнительные записи содержат только первичный ключ. Поскольку первичный ключ уникален, гарантируется, что
запись с ключом "login=chudinov" будет единственной. 

Мы используем префикс в дополнительных записях, чтобы различать login и email. Второй пользователь использует свой 
email в качестве логина, если бы не было префикса, это вызвало бы конфликт, так как его вспомогательные записи стали бы одинаковыми.

При вставке, изменении или удалении записей, мы должны добавлять, изменять и удалять дополнительные записи соответственно, чтобы
обеспечить консистентность данных. На листинге 1 приведён пример реализации вставки новой записи со вспомогательными записями с помощью командной строки:

### Добавление нового пользователя

```bash
aws --endpoint-url ${DOCAPI_ENDPOINT} dynamodb transact-write-items --client-request-token TRANSACTION1 --transact-items '[
  {
    "Put": {
       "TableName" : "User", 
       "ConditionExpression": "attribute_not_exists(id)",
       "Item" : {
          "id":{"S":"5j90a7p58u1ak1ev2"},
          "login":{"S":"dodo"},
          "passwordHash":{"S":"827ccb0eea8a706c4c34a16891f84e7b"},
          "email":{"S":"avmordvinov@example.com"}
       }
    }
  },
  {
    "Put": {
      "TableName" : "User", 
      "ConditionExpression": "attribute_not_exists(id)",
      "Item" : {
        "id":{"S":"login=dodo"}
       }
    }
  },
  {
    "Put": {
      "TableName" : "User", 
      "ConditionExpression": "attribute_not_exists(pk)",
      "Item" : {
        "id":{"S":"email=avmordvinov@example.com"}
       }
    }
  }
]'
```

После выполнения данные в таблице будут выглядеть так:

id      | login | passwordHash | email
:-------- |:-----:| -------:| -------:
j481969rur7dics3g  | chudinov  | d8578edf8458ce06fbc5bb76a58c5ca4 | victor.chudinov@example.com
login=chudinov | | |
email=victor.chudinov@example.com | | |
olbmrnipjt7p7kf6p     | aplitvinov@example.org    | 827ccb0eea8a706c4c34a16891f84e7b | aplitvinov@example.org
login=aplitvinov@example.org | | |
email=aplitvinov@example.org | | |
5j90a7p58u1ak1ev2 | dodo | 827ccb0eea8a706c4c34a16891f84e7b | avmordvinov@example.com
login=dodo | | |
email=avmordvinov@example.com | | |


Операция Put вставляет новую запись или модифицирует имеющуюся запись с данным первичным ключом. Мы добавляем в каждое действие проверку, что данный первичный ключ еще  не существует. Если id "5j90a7p58u1ak1ev2", login "dodo" или email "avmordvinov@gmail.com" уже существует, соответствующее условие будет ложно и вся транзакция откатится, ни одно действие не будет выполнено. Например, если email уже существует, мы получим сообщение

**An error occurred (TransactionCanceledException) when calling the TransactWriteItems operation: Transaction cancelled, please refer cancellation reasons for specific reasons [None, None, ConditionalCheckFailed]**

Мы видим из сообщения, что не прошла проверка в третьем действии

### Модификация уникального атрибута

Рассмотрим задачу смены логина пользователя с id=5j90a7p58u1ak1ev2 со старого значения dodo на новое значение toto. На листинге 2 приведена команда, реализующая такое изменение.

```bash
aws --endpoint ${DOCAPI_ENDPOINT} dynamodb transact-write-items --client-request-token TRANSACTION2 --transact-items '[
  {
    "Update": {
       "TableName" : "User", 
       "Key" : {
          "id":{"S":"5j90a7p58u1ak1ev2"}
       },
       "ConditionExpression": "login = :login",
       "UpdateExpression": "SET login = :newLogin",
       "ExpressionAttributeValues": {":login":{"S":"dodo"}, ":newLogin":{"S":"toto"}}
    }
  },
  {
    "Delete": {
      "TableName" : "User", 
      "Key" : {
        "id":{"S":"login=dodo"}
       }
    }
  },
  {
    "Put": {
      "TableName" : "User", 
      "ConditionExpression": "attribute_not_exists(id)",
      "Item" : {
        "id":{"S":"login=toto"}
       }
    }
  }
]'
```

Мы выполняем 3 действия:

1. Модификация основной записи - заменяем значение login
2. Удаление записи с первичным ключом "login=dodo", так как в основной записи логин сменился, и "dodo" теперь может использоваться другим пользователем.
3. Вставка вспомогательной записи с новым первичным ключом "login=toto"

Мы добавляем проверки условий в первом и третьем действиях. 
Проверка в первом действии гарантирует, что текущий логин действительно "dodo", так что во втором действии мы удаляем именно ту запись, которую нужно удалить: после создания пользователя логин мог быть изменен кем-то, и наше предположение, что текущий логин равен "dodo", может быть неверным. При несовпадении логина с ожидаемым мы получим ошибку. В этом случае нужно перечитать запись (выполнить GetItem), чтобы получить правильное текущее значение логина, и повторить операцию с этим значением.
Проверка в третьем действии гарантирует, чтто новый логин еще не используется другим пользователем.
 
### Удаление пользователя

При удалении пользователя мы должны удалить 3 записи - основную и две вспомогательных. Мы достигаем этого с помощью команды

```bash
aws --endpoint ${DOCAPI_ENDPOINT} dynamodb transact-write-items --client-request-token TRANSACTION3 --transact-items '[
  {
    "Delete": {
       "TableName" : "User", 
       "Key" : {
          "id":{"S":"5j90a7p58u1ak1ev2"}
       },
       "ConditionExpression": "login = :login AND email = :email",
       "ExpressionAttributeValues": {":login":{"S":"toto"}, ":email":{"S":"avmordvinov@example.com"}}
    }
  },
  {
    "Delete": {
      "TableName" : "User", 
      "Key" : {
        "id":{"S":"login=toto"}
       }
    }
  },
  {
    "Delete": {
      "TableName" : "User", 
      "Key" : {
        "id":{"S":"email=avmordvinov@example.com"}
       }
    }
  }
]'
```

Как и в случае модификации, в первом действии необходима проверка login и email на равенство ожидаемым значениям.
 
