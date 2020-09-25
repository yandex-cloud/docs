# Разработка на NodeJS с использованием Document API

## Перед началом работы

1. [Создайте serverless базу данных](../quickstart/create-db.md) в {{ yandex-cloud }}.
1. В свойствах созданной базы на вкладке "Обзор" найдите и скопируйте значение `Document API эндпоинт`.
1. Установите инструменты разработчика командой `npm install yandex-cloud`.

## Создание таблицы

```javascript
const { DocAPIService } = require('yandex-cloud')

// change for your Document API endpoint
const endpoint = '<your Document API endpoint here>';
const docapi = new DocAPIService(endpoint)

var params =
{
  TableName: "test/pets",
  AttributeDefinitions:
  [
    {
      AttributeName: "species",
      AttributeType: "S"
    },
    {
      AttributeName: "name",
      AttributeType: "S"
    }
  ],
  KeySchema:
  [
    {
      AttributeName: "species",
      KeyType: "HASH"
    },
    {
      AttributeName: "name",
      KeyType: "RANGE"
    }
  ]
};
docapi.createTable(params).then(res => { console.log(res); }).catch(err => { console.log(err); });
```

## Сохранение записи

```javascript
const { DocAPIService } = require('yandex-cloud')

// change for your Document API endpoint
const endpoint = '<your Document API endpoint here>';
const docapi = new DocAPIService(endpoint)

var params =
{
  TableName: "test/pets",
  Item:
  {
    "species": "cat",
    "name": "Tom",
    "color": "Black",
    "price": "10.5"
  }
};
docapi.putItem(params).then(res => { console.log(res); }).catch(err => { console.log(err); });
```

## Чтение записи

```javascript
const { DocAPIService } = require('yandex-cloud')

// change for your Document API endpoint
const endpoint = '<your Document API endpoint here>';
const docapi = new DocAPIService(endpoint)

var params =
{
  TableName: "test/pets",
  Key:
  {
    "species": "cat",
    "name": "Tom"
  }
};
docapi.getItem(params).then(res => { console.log(res); }).catch(err => console.log(err));
```

