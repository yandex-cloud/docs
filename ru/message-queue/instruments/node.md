# Пример использования {{ message-queue-full-name }} на Node.js

[Node.js](https://nodejs.org/en/) – среда для запуска JavaScript-приложений. С помощью AWS SDK для JavaScript в Node.js можно управлять очередями сообщений в {{ message-queue-name }}, отправлять и принимать сообщения.

## Установка {#install}

Установите AWS SDK для JavaScript в Node.js [по инструкции](https://aws.amazon.com/ru/sdk-for-node-js/) на официальном сайте.

## Подготовка к работе {#prepare}

{% include [mq-http-api-preps](../_includes_service/mq-http-api-preps-sdk.md)%}

Задайте переменные окружения:

```
$ export AWS_ACCESS_KEY_ID="<идентификатор ключа доступа>"
$ export AWS_SECRET_ACCESS_KEY="<секретный ключ>"
```

## Пример {#sample}

В этом примере:

1. Устанавливается соединение с {{ message-queue-name }}. 
1. Создается очередь сообщений с именем `ymq_example_nodejs_sdk`.
1. В очередь передается сообщение с текстом `test-message`.
1. Сообщение считывается из очереди и отображается в терминале.
1. Удаляется созданная очередь сообщений.

```javascript
var AWS = require('aws-sdk');

var ymq = new AWS.SQS({
    'region': 'ru-central1',
    'endpoint': 'https://message-queue.api.cloud.yandex.net',
});

async function createQueue() {
    params = {
        'QueueName': 'ymq_example_nodejs_sdk',
    }

    result = await ymq.createQueue(params).promise();
    queueUrl = result['QueueUrl'];

    console.log('Queue created, URL: ' + queueUrl);

    return queueUrl;
}

async function sendMessage(queueUrl) {
    params = {
        'QueueUrl': queueUrl,
        'MessageBody': 'test message',
    }

    result = await ymq.sendMessage(params).promise();

    console.log('Message sent, ID: ' + result['MessageId']);
}

async function receiveMessage() {
    params = {
        'QueueUrl': queueUrl,
        'WaitTimeSeconds': 10,
    }

    result = await ymq.receiveMessage(params).promise();

    result['Messages'].forEach(async function(msg) {
        console.log('Message received')
        console.log('ID: ' + msg['MessageId'])
        console.log('Body: ' + msg['Body'])

        deleteParams = {
            'QueueUrl': queueUrl,
            'ReceiptHandle': msg['ReceiptHandle'],
        }

        await ymq.deleteMessage(deleteParams).promise()
    })
}

async function deleteQueue() {
    params = {
        'QueueUrl': queueUrl,
    }

    result = await ymq.deleteQueue(params).promise();

    console.log('Queue deleted')
}

async function main() {
    queueUrl = await createQueue();
    await sendMessage(queueUrl);
    await receiveMessage(queueUrl);
    await deleteQueue(queueUrl);
}

main()
```