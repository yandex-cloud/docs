# Разработка на NodeJS с использованием Document API

Используйте виртуальную машину в {{ yandex-cloud }} и выполняйте операции над документными таблицами с помощью [Document API](../docapi/api-ref/index.md) — HTTP API, совместимого с Amazon DynamoDB.

## Перед началом работы


1. Для аутентификации в базе данных {% if deploy != "arc" %} [создайте сервисный аккаунт](../../iam/operations/sa/create) {% else %} создайте сервисный аккаунт {% endif %} и {% if deploy != "arc" %} [назначьте](../../iam/operations/sa/assign-role-for-sa.md) {% else %} назначьте {% endif %} ему роли `viewer` и `editor`.
1. {% if deploy != "arc" %} [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm) {% else %} Создайте виртуальную машину {% endif %} в {{ yandex-cloud }}. При создании в разделе "Доступ" выберите созданный сервисный аккаунт.

1. Сохраните публичный IP-адрес виртуальной машины. Для этого перейдите в свойства виртуальной машины или {% if deploy != "arc" %} [воспользуйтесь интерфейсом командной строки](../../compute/operations/vm-info/get-info#outside-instance) {% else %} воспользуйтесь интерфейсом командной строки {% endif %} .
1. {% if deploy != "arc" %} [Подключитесь к виртуальной машине по SSH](../../compute/operations/vm-connect/ssh.md){% else %} Подключитесь к виртуальной машине по SSH {% endif %}.
1. Подготовьте виртуальную машину к работе:

   {% list tabs %}
   
   - Ubuntu
   
      1. Обновите пакеты в системе командой:
   
         ```bash
         sudo apt-get update
         ```
   
      1. Установите Node.js и npm:
         
         ```bash
         sudo apt-install nodejs npm
         ```
   
      1. Чтобы установить инструменты разработчика, выполните команду:
   
         ```bash
         npm install yandex-cloud
         ``` 
   
   {% endlist %}

### Создание таблицы

Для создания документной таблицы в базе данных:

1. Задайте конфигурацию таблицы в файле `create.js`, заменив `Document API эндпоинт` сохраненным ранее значением:

   ```javascript
   const { DocAPIService } = require('yandex-cloud/lib/slydb/docapi/docapi')
   
   // Укажите Document API эндпоинт вашей базы данных
   const endpoint = '<Document API эндпоинт>';
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

1. Запустите файл с помощью Node.js:
   
   ```bash
   node create.js
   ```

   Результат:

   ```
   { TableDescription:
     { AttributeDefinitions: [ [Object], [Object] ],
       TableName: 'test/pets',
       KeySchema: [ [Object], [Object] ],
       TableStatus: 'ACTIVE',
       CreationDateTime: 2020-11-03T22:39:51.000Z,
       TableSizeBytes: 0,
       ItemCount: 0 } }
   ```

## Добавление записи

Чтобы добавить запись в документную таблицу:

1. Подготовьте данные для сохранения в документную таблицу, создав на виртуальной машине файл `add.js`. Замените `Document API эндпоинт` сохраненным ранее значением:

   ```javascript
   const { DocAPIService } = require('yandex-cloud/lib/slydb/docapi/docapi')
   
   // Укажите Document API эндпоинт вашей базы данных
   const endpoint = '<Document API эндпоинт>';
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
   docapi.putItem(params).then(res => { console.log(res); }).catch(err => {   console.log(err); });
   ```

1. Выполните команду:

   ```bash
   node add.js
   ```

## Чтение записи

Для чтения записи из документной таблицы:

1. Создайте на виртуальной машине файл `read.js`, заменив `Document API эндпоинт` сохраненным ранее значением:

   ```javascript
   const { DocAPIService } = require('yandex-cloud/lib/slydb/docapi/docapi')

   // Укажите Document API эндпоинт вашей базы данных
   const endpoint = '<Document API эндпоинт>';
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
   docapi.getItem(params).then(res => { console.log(res); }).catch(err => console.  log(err));
   ```

1. Выполните команду:
   
   ```bash
   node read.js
   ```

   Результат:

   ```
   { Item:
   { name: 'Tom', species: 'cat', color: 'Black', price: '10.5' } }
   ```