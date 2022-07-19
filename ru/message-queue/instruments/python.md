# Пример использования {{ message-queue-full-name }} на Python

Для работы с {{ message-queue-full-name }} из Python используется [boto3](https://aws.amazon.com/ru/sdk-for-python/) — комплект средств разработки для языка Python.

## Установка {#install}

Для установки воспользуйтесь инструкциями в репозитории разработчика: [boto3](https://github.com/boto/boto3/blob/develop/README.rst#quick-start), [boto](https://github.com/boto/boto#installation).

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
1. Создается очередь с именем `mq_example_boto3`. 
1. В очередь передается сообщение с текстом `boto3 sample message`. 
1. Сообщение считывается из очереди и отображается в терминале.
1. Полученное сообщение удаляется из очереди.
1. Удаляется созданная очередь сообщений.

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