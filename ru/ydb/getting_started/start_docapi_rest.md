# Использование HTTP-интерфейса для работы с базой данных через Document API

## Перед началом работы

1. Установите [{{ yandex-cloud }} CLI](../../cli/quickstart.md).
1. [Создайте serverless базу данных](../quickstart/create-db.md) в {{ yandex-cloud }}.
1. В свойствах созданной базы на вкладке "Обзор" найдите и скопируйте значение `Document API эндпоинт`.
1. Сохраните значение `Document API эндпоинт` в переменной окружения `ENDPOINT`.


## Создайте документную таблицу

1. Задайте конфигурацию таблицы в файле `create.json`:

   ```shell script
   {
     "TableName": "test/pets",
     "AttributeDefinitions":
     [
       {
         "AttributeName": "species",
         "AttributeType": "S"
       },
       {
         "AttributeName": "name",
         "AttributeType": "S"
       }
     ],
     "KeySchema":
     [
       {
         "AttributeName": "species",
         "KeyType": "HASH"
       },
       {
         "AttributeName": "name",
         "KeyType": "RANGE"
       }
     ]
   }
   ```

1. Создайте таблицу с помошью команды:
   
   ```shell script
   curl -H 'X-Amz-Target: DynamoDB_20120810.CreateTable' \
   -H "Authorization: Bearer $(yc iam create-token)" \
   -H "Content-Type: application.json" \
   -d @create.json $ENDPOINT
   ```
   
   Подробнее о методе CreateTable читайте в [справочнике Document API](../docapi/api-ref/actions/createTable.md).

## Добавьте данные в таблицу

1. Подготовьте данные для сохранения в таблицу в файле `put.json`:
   
   ```shell script
   {
     "TableName": "test/pets",
     "Item":
     {
       "species": {"S": "cat"},
       "name":    {"S": "Tom"},
       "color":   {"S": "black"},
       "price":   {"N": "10.5"}
     }
   }
   ```

1. Добавьте данные в таблицу с помощью команды:
   
   ```shell script
   curl -H 'X-Amz-Target: DynamoDB_20120810.PutItem' \
   -H "Authorization: Bearer $(yc iam create-token)" \
   -H "Content-Type: application.json" \
   -d @put.json $ENDPOINT
   ```
   
   Подробнее о методе PutItem читайте в [справочнике Document API](../docapi/api-ref/actions/putItem.md).

## Прочитайте данные из таблицы

1. Чтобы прочитать данные, выполните команду:
   
   ```shell script
   curl -H 'X-Amz-Target: DynamoDB_20120810.GetItem' \
   -H "Authorization: Bearer $(yc iam create-token)" \
   -H "Content-Type: application.json" \
   -d '{"TableName": "test/pets", "Key": {"species":{"S":"cat"}, "name":{"S":"Tom"}}}' \
   $ENDPOINT
   ```

   Результат:
   
   ```shell script
   {"Item":{"name":{"S":"Tom"},"species":{"S":"cat"},"color":{"S":"black"},"price":{"N":"10.5"}}}
   ```

   Подробнее о методе GetItem читайте в [справочнике Document API](../docapi/api-ref/actions/getItem.md).
