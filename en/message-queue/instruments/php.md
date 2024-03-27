# Example of using {{ message-queue-full-name }} on PHP

Using the [AsyncAWS](https://async-aws.com), you can manage message queues and send and receive messages in {{ message-queue-name }}.

## Installation {#install}

Install the AsyncAWS library:
```
composer require async-aws/sqs ^1.9
```
## Before you start {#prepare}

{% include [mq-http-api-preps](../_includes_service/mq-http-api-preps-sdk.md)%}

Set the environment variables:

```
export AWS_ACCESS_KEY_ID="<access key ID>"
export AWS_SECRET_ACCESS_KEY="<secret key>"
```

## Example {#sample}

In this example:

1. A connection with {{ message-queue-name }} is established.
1. A message queue is created with the `mq_php_sdk_example` name.
1. A message with the text `test-message` is sent to the queue.
1. The message is read from the queue and displayed in the terminal.
1. The message queue is deleted.

```php
<?php

use AsyncAws\Sqs\SqsClient;

require __DIR__ . '/vendor/autoload.php';


$mq = new SqsClient([
    'region' => '{{ region-id }}',
    'endpoint' => 'https://message-queue.{{ api-host }}',
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