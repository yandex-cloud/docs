# Использование HTTP-интерфейса для работы с базой данных через Document API

Используйте HTTP-интерфейс для работы с базой данных через [Document API](../docapi/api-ref/index.md). Создайте документную таблицу в базе данных, добавьте данные и прочитайте их с помощью `curl`.

## Перед началом работы

1. {% if deploy != "arc" %} {% include [cli-install](../../_includes/cli-install.md) %} {% else%}Установите CLI.{% endif %}
1. В [консоли управления]({{ link-console-main }}) перейдите в каталог для создания базы данных.
1. Выберите сервис **Yandex Database**.
1. [Создайте serverless базу данных](../quickstart/create-db.md) в {{ yandex-cloud }}.
1. В свойствах созданной базы на вкладке **Обзор** найдите и скопируйте значение `Document API эндпоинт` вашей базы.
1. Установите для переменной окружения `ENDPOINT` скопированное ранее значение:

   ```bash
   export ENDPOINT=<Document API эндпоинт>
   ```

## Создайте документную таблицу

Чтобы создать документную таблицу в базе данных:

1. Задайте конфигурацию таблицы в файле `create.json`:

   ```json
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

1. Создайте документную таблицу в базе с помощью команды:
   
   ```bash
   curl -H 'X-Amz-Target: DynamoDB_20120810.CreateTable' \
   -H "Authorization: Bearer $(yc iam create-token)" \
   -H "Content-Type: application.json" \
   -d @create.json $ENDPOINT
   ```
   
   Подробнее о методе `CreateTable` читайте в [справочнике Document API](../docapi/api-ref/actions/createTable.md).

## Добавьте данные в таблицу

Чтобы добавить данные в документную таблицу:

1. Подготовьте данные для сохранения в документную таблицу, создав файл `put.json`:
   
   ```json
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
   
   ```bash
   curl -H 'X-Amz-Target: DynamoDB_20120810.PutItem' \
   -H "Authorization: Bearer $(yc iam create-token)" \
   -H "Content-Type: application.json" \
   -d @put.json $ENDPOINT
   ```

   Подробнее о методе `PutItem` читайте в [справочнике Document API](../docapi/api-ref/actions/putItem.md).

## Прочитайте данные из таблицы

Чтобы прочитать данные из документной таблицы:

1. Выполните команду:
   
   ```bash
   curl -H 'X-Amz-Target: DynamoDB_20120810.GetItem' \
   -H "Authorization: Bearer $(yc iam create-token)" \
   -H "Content-Type: application.json" \
   -d '{"TableName": "test/pets", "Key": {"species":{"S":"cat"}, "name":{"S":"Tom"}}}' \
   $ENDPOINT
   ```

   Результат:

   ```
   {"Item":{"name":{"S":"Tom"},"species":{"S":"cat"},"color":{"S":"black"},"price":{"N":"10.5"}}}
   ```

   Подробнее о методе `GetItem` читайте в [справочнике Document API](../docapi/api-ref/actions/getItem.md).