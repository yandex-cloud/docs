# Разработка на NodeJS с использованием Document API

[Создайте serverless базу данных](../quickstart/create-db.md) в {{ yandex-cloud }}.


1. Для аутентификации в базе данных [создайте сервисный аккаунт](../../iam/operations/sa/create) и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему роли `viewer` и `editor`.
1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm) в {{ yandex-cloud }}. При создании в разделе "Доступ" выберите созданный сервисный аккаунт.

1. Сохраните публичный IP-адрес виртуальной машины. Для этого перейдите в свойства виртуальной машины или [воспользуйтесь интерфейсом командной строки](../../compute/operations/vm-info/get-info#outside-instance) .
1. Подключитесь к виртуальной машине по ssh
1. Выполните `npm install yandex-cloud`

### Создание таблицы

```javascript
const { DocAPIService } = require('yandex-cloud/lib/slydb/docapi/docapi')

// change for your Document API endpoint
const endpoint = 'https://docapi.serverless.yandexcloud.net/ru-central1/b1g11111111111111111/etn22222222222222222';
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

### Сохранение записи

```javascript
const { DocAPIService } = require('yandex-cloud/lib/slydb/docapi/docapi')

// change for your Document API endpoint
const endpoint = 'https://docapi.serverless.yandexcloud.net/ru-central1/b1g11111111111111111/etn22222222222222222';
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

### Чтение записи

```javascript
const { DocAPIService } = require('yandex-cloud/lib/slydb/docapi/docapi')

// change for your Document API endpoint
const endpoint = 'https://docapi.serverless.yandexcloud.net/ru-central1/b1g11111111111111111/etn22222222222222222';
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

