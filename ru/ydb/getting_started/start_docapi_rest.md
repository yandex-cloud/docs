# Использование http-интерфейса для работы с базой данных через Document API

Создайте serverless базу данных.
Скопируйте значение 'Document API endpoint'. В дальнейшем предполагаем, что это значение
сохранено в переменной окружения ENDPOINT

### Пример создания таблицы

подготовьте исходные данные в файле create.json:
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
Выполните команду
```shell script
curl -H 'X-Amz-Target: DynamoDB_20120810.CreateTable' \
-H "Authorization: Bearer $(yc iam create-token)" \
-H "Content-Type: application.json" \
-d @create.json $ENDPOINT
```

```
Подготовьте данные для сохранения в таблицу в файле put.json:
```shell script
{
  "TableName": "test/pets",
  "Item":
  {
    "species": {"S": "cat"},
    "name":    {"S": "Tom"},
    "color":   {"S": "black"},
    "price":   {"N":  "10.5"}
  }
}
```
Сохраните запись:
```shell script
curl -H 'X-Amz-Target: DynamoDB_20120810.PutItem' \
-H "Authorization: Bearer $(yc iam create-token)" \
-H "Content-Type: application.json" \
-d @put.json $ENDPOINT
```

Прочтите запись:
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

