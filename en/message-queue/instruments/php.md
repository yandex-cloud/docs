# Example of using {{ message-queue-full-name }} on PHP

Using the [AWS SDK for PHP]{% if lang == "ru" %}(https://aws.amazon.com/ru/sdk-for-php/){% endif %}{% if lang == "en" %}(https://aws.amazon.com/sdk-for-php/){% endif %}, you can manage message queues and send and receive messages in {{ message-queue-name }}.

## Installation {#install}

Install the AWS SDK for PHP by following the [instructions]{% if lang == "ru" %}(https://aws.amazon.com/ru/sdk-for-php/){% endif %}{% if lang == "en" %}(https://aws.amazon.com/sdk-for-php/){% endif %} on the official site.
```
composer require aws/aws-sdk-php-resources
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

require __DIR__ . '/vendor/autoload.php';

use Aws\Sqs\SqsClient;
use Aws\Exception\AwsException;

$mq = new Aws\Sqs\SqsClient([
    'version' => 'latest',
    'region' => '{{ region-id }}',
    'endpoint' => 'https://message-queue.{{ api-host }}',
]);

$result = $mq->createQueue([
    'QueueName' => 'mq_php_sdk_example',
]);

$queueUrl = $result["QueueUrl"];
print('Queue created, URL: ' . $queueUrl . PHP_EOL);

$result = $mq->sendMessage([
    'QueueUrl' => $queueUrl,
    'MessageBody' => 'Test message',
]);

print("Message sent, ID: " . $result["MessageId"] . PHP_EOL);

$result = $mq->receiveMessage([
    'QueueUrl' => $queueUrl,
    'WaitTimeSeconds' => 10,
]);

foreach ($result["Messages"] as $msg) {
    print('Message received:' . PHP_EOL);
    print('ID: ' . $msg['MessageId'] . PHP_EOL);
    print('Body: ' . $msg['Body'] . PHP_EOL);

    $mq->deleteMessage([
        'QueueUrl' => $queueUrl,
        'ReceiptHandle' => $msg['ReceiptHandle'],
    ]);
}

$result = $mq->deleteQueue([
    'QueueUrl' => $queueUrl,
]);

print('Queue deleted' . PHP_EOL);
```
