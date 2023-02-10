# Example of using {{ message-queue-full-name }} on Node.js

[Node.js](https://nodejs.org/en/) is an environment for running JavaScript applications. Using the AWS SDK for JavaScript, you can manage {{ message-queue-name }} message queues and send and receive messages in Node.js.

## Installation {#install}

Install the AWS SDK for JavaScript in Node.js [by following the instructions]{% if lang == "ru" %}(https://aws.amazon.com/ru/sdk-for-node-js/){% endif %}{% if lang == "en" %}(https://aws.amazon.com/sdk-for-node-js/){% endif %} on the official site.

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
1. A message queue is created with the name `mq_example_nodejs_sdk`.
1. A message with the text `test-message` is sent to the queue.
1. The message is read from the queue and displayed in the terminal.
1. The message queue is deleted.

```javascript
var AWS = require('aws-sdk');

var mq = new AWS.SQS({
    'region': '{{ region-id }}',
    'endpoint': 'https://message-queue.{{ api-host }}',
});

async function createQueue() {
    params = {
        'QueueName': 'mq_example_nodejs_sdk',
    }

    result = await mq.createQueue(params).promise();
    queueUrl = result['QueueUrl'];

    console.log('Queue created, URL: ' + queueUrl);

    return queueUrl;
}

async function sendMessage(queueUrl) {
    params = {
        'QueueUrl': queueUrl,
        'MessageBody': 'test message',
    }

    result = await mq.sendMessage(params).promise();

    console.log('Message sent, ID: ' + result['MessageId']);
}

async function receiveMessage() {
    params = {
        'QueueUrl': queueUrl,
        'WaitTimeSeconds': 10,
    }

    result = await mq.receiveMessage(params).promise();

    result['Messages'].forEach(async function(msg) {
        console.log('Message received')
        console.log('ID: ' + msg['MessageId'])
        console.log('Body: ' + msg['Body'])

        deleteParams = {
            'QueueUrl': queueUrl,
            'ReceiptHandle': msg['ReceiptHandle'],
        }

        await mq.deleteMessage(deleteParams).promise()
    })
}

async function deleteQueue() {
    params = {
        'QueueUrl': queueUrl,
    }

    result = await mq.deleteQueue(params).promise();

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
