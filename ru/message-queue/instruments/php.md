# Пример использования {{ message-queue-full-name }} на PHP

С помощью [AWS SDK для PHP](https://aws.amazon.com/ru/sdk-for-php/) можно управлять очередями сообщений в {{ message-queue-name }}, отправлять и принимать сообщения.

## Установка {#install}

Установите AWS SDK для PHP [по инструкции](https://aws.amazon.com/ru/sdk-for-php/) на официальном сайте.
```
$ composer require aws/aws-sdk-php-resources
```
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
1. Создается очередь сообщений c именем `ymq_php_sdk_example`.
1. В очередь передается сообщение с текстом `Test message`.
1. Сообщение считывается из очереди и отображается в терминале.
1. Удаляется созданная очередь сообщений.

```php
<?php

require __DIR__ . '/vendor/autoload.php';

use Aws\Sqs\SqsClient;

$ymq = new SqsClient([
    'version' => 'latest',
    'region' => 'ru-central1',
    'endpoint' => 'https://message-queue.api.cloud.yandex.net',
]);

$result = $ymq->createQueue([
    'QueueName' => 'ymq_php_sdk_example',
]);

$queueUrl = $result["QueueUrl"];
print('Queue created, URL: ' . $queueUrl . PHP_EOL);

$result = $ymq->sendMessage([
    'QueueUrl' => $queueUrl,
    'MessageBody' => 'Test message',
]);

print("Message sent, ID: " . $result["MessageId"] . PHP_EOL);

$result = $ymq->receiveMessage([
    'QueueUrl' => $queueUrl,
    'WaitTimeSeconds' => 10,
]);

foreach ($result["Messages"] as $msg) {
    print('Message received:' . PHP_EOL);
    print('ID: ' . $msg['MessageId'] . PHP_EOL);
    print('Body: ' . $msg['Body'] . PHP_EOL);

    $ymq->deleteMessage([
        'QueueUrl' => $queueUrl,
        'ReceiptHandle' => $msg['ReceiptHandle'],
    ]);
}

$result = $ymq->deleteQueue([
    'QueueUrl' => $queueUrl,
]);

print('Queue deleted' . PHP_EOL);
```
