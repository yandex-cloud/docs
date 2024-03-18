# Пример использования {{ message-queue-full-name }} на PHP

С помощью [AsyncAws](https://async-aws.com) можно управлять очередями сообщений в {{ message-queue-name }}, отправлять и принимать сообщения.

## Установка {#install}

Установите библиотеку AsyncAws:
```
composer require async-aws/sqs ^1.9
```
## Подготовка к работе {#prepare}

{% include [mq-http-api-preps](../_includes_service/mq-http-api-preps-sdk.md)%}

Задайте переменные окружения:

```
export AWS_ACCESS_KEY_ID="<идентификатор ключа доступа>"
export AWS_SECRET_ACCESS_KEY="<секретный ключ>"
```

## Пример {#sample}

В этом примере:

1. Устанавливается соединение с {{ message-queue-name }}. 
1. Создается очередь сообщений с именем `mq_php_sdk_example`.
1. В очередь передается сообщение с текстом `Test message`.
1. Сообщение считывается из очереди и отображается в терминале.
1. Удаляется созданная очередь сообщений.

```php
<?php

use AsyncAws\Sqs\SqsClient;

require __DIR__ . '/vendor/autoload.php';


$mq = new SqsClient([
    'region' => 'ru-central1',
    'endpoint' => 'https://message-queue.api.cloud.yandex.net',
]);

$result = $mq->createQueue([
    'QueueName' => 'mq_php_sdk_example',
]);

$queueUrl = $result->getQueueUrl();
print('Queue created, URL: ' . $queueUrl . PHP_EOL);

$result = $mq->sendMessage([
    'QueueUrl' => $queueUrl,
    'MessageBody' => 'Test message',
]);

print("Message sent, ID: " . $result->getMessageId() . PHP_EOL);

$result = $mq->receiveMessage([
    'QueueUrl' => $queueUrl,
    'WaitTimeSeconds' => 10,
]);

foreach ($result->getMessages() as $msg) {
    print('Message received:' . PHP_EOL);
    print('ID: ' . $msg->getMessageId() . PHP_EOL);
    print('Body: ' . $msg->getBody() . PHP_EOL);

    $mq->deleteMessage([
        'QueueUrl' => $queueUrl,
        'ReceiptHandle' => $msg->getReceiptHandle(),
    ]);
}

$result = $mq->deleteQueue([
    'QueueUrl' => $queueUrl,
]);

print('Queue deleted' . PHP_EOL);
```
