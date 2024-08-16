# Example of using {{ message-queue-full-name }} in Python

To work with {{ message-queue-full-name }} from Python, use [boto3](https://aws.amazon.com/sdk-for-python/), an SDK designed for Python. `boto3` versions higher than 1.26.0 are not supported.

## Installation {#install}

To install boto, follow the instructions in the developer's repository: [boto3](https://github.com/boto/boto3/blob/develop/README.rst#quick-start), [boto](https://github.com/boto/boto#installation).

To install `boto3` 1.26.0, specify `boto3==1.26.0` in the `requirements.txt` file and run `pip install -r requirements.txt`, or use the `pip install boto3==1.26.0` command. Use the `pip show boto3` command to check which version is installed.

## Getting started {#prepare}

{% include [mq-http-api-preps](../_includes_service/mq-http-api-preps-sdk.md)%}

Set the environment variables:

```
export AWS_ACCESS_KEY_ID="<access_key_ID>"
export AWS_SECRET_ACCESS_KEY="<secret_key>"
```
## Example {#sample}

In this example:

1. A connection with {{ message-queue-name }} is established.
1. A queue named `mq_example_boto3` is created.
1. A message with the text `boto3 sample message` is sent to the queue.
1. The message is read from the queue and displayed in the terminal.
1. The received message is removed from the queue.
1. The message queue is deleted.

```python
import boto3

def main():
    # Create client
    client = boto3.client(
        service_name='sqs',
        endpoint_url='https://message-queue.{{ api-host }}',
        region_name='{{ region-id }}'
    )

    # Create queue and get its url
    queue_url = client.create_queue(QueueName='mq_example_boto3').get('QueueUrl')
    print('Created queue url is "{}"'.format(queue_url))

    # Send message to queue
    client.send_message(
        QueueUrl=queue_url,
        MessageBody='boto3 sample message'
    )
    print('Successfully sent test message to queue')

    # Receive sent message
    messages = client.receive_message(
        QueueUrl=queue_url,
        MaxNumberOfMessages=10,
        VisibilityTimeout=60,
        WaitTimeSeconds=20
    ).get('Messages')
    for msg in messages:
        print('Received message: "{}"'.format(msg.get('Body')))

    # Delete processed messages
    for msg in messages:
        client.delete_message(
            QueueUrl=queue_url,
            ReceiptHandle=msg.get('ReceiptHandle')
        )
        print('Successfully deleted message by receipt handle "{}"'.format(msg.get('ReceiptHandle')))

    # Delete queue
    client.delete_queue(QueueUrl=queue_url)
    print('Successfully deleted queue')

if __name__ == '__main__':
    main()

```
