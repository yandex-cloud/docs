# Работа с данными

В этом разделе вы узнаете как работать с Documentat API, совместимым с AWS DynamoDB. Вы попробуете создать таблицу, сохранить в нее данные, а затем прочитать их. 

## Перед началом работы {#before-you-begin}

Чтобы работать с базой данных через [Document API](../docapi/api-ref/index.md):

{% list tabs %}

- HTTP-интерфейс

     Чтобы создать документную таблицу в базе данных, добавить в нее данные и прочитать их с помощью `curl`:
          
    1. {% include [cli-install](../../_includes/cli-install.md) %}.
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог для создания базы данных.
    1. Выберите сервис **Yandex Database**.
    1. [Создайте serverless базу данных](../quickstart/create-db.md) в {{ yandex-cloud }}.
    1. В свойствах созданной базы на вкладке **Обзор** найдите и скопируйте значение `Document API эндпоинт` вашей базы.
    1. Установите для переменной окружения `ENDPOINT` скопированное ранее значение:
    
       ```bash
       export ENDPOINT=<Document API эндпоинт>
       ```
       
- Node.js
    
    Используйте виртуальную машину в {{ yandex-cloud }} и выполняйте операции над документными таблицами с помощью [Document API](../docapi/api-ref/index.md) — HTTP API, совместимого с Amazon DynamoDB.
    
    1. Для аутентификации в базе данных [создайте сервисный аккаунт](../../iam/operations/sa/create) и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему роли `viewer` и `editor`.
    1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm) в {{ yandex-cloud }}. При создании в разделе "Доступ" выберите созданный сервисный аккаунт.
    1. Сохраните публичный IP-адрес виртуальной машины. Для этого перейдите в свойства виртуальной машины или [воспользуйтесь интерфейсом командной строки](../../compute/operations/vm-info/get-info#outside-instance) .
    1. [Подключитесь к виртуальной машине по SSH](../../compute/operations/vm-connect/ssh.md).
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

{% endlist %}

## Создание таблицы {#create}

{% list tabs %}

- HTTP-интерфейс

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
    
- Node.js

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
 
{% endlist %}

## Добавление записи {#add}

{% list tabs %}

- HTTP-интерфейс

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

- Node.js
    
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
      
{% endlist %}

## Чтение записи {#read}

{% list tabs %}

- HTTP-интерфейс

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

- Node.js

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

{% endlist %}

