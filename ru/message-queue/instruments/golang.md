# Пример использования {{ message-queue-full-name }} на Golang

С помощью [AWS SDK для Golang](https://aws.amazon.com/ru/sdk-for-go/) можно управлять очередями сообщений в {{ message-queue-name }}, отправлять и принимать сообщения.

## Установка {#install}

Установите AWS SDK для Golang [по инструкции](https://aws.amazon.com/ru/sdk-for-go/) на официальном сайте.

## Подготовка к работе {#prepare}

{% include [mq-http-api-preps](../_includes_service/mq-http-api-preps-sdk.md)%}

Задайте переменные окружения:

```
export AWS_ACCESS_KEY_ID="<идентификатор_ключа_доступа>"
export AWS_SECRET_ACCESS_KEY="<секретный_ключ>"
```

## Пример {#sample}

В этом примере:

1. Устанавливается соединение с {{ message-queue-name }}.
1. Создается очередь сообщений с именем `mq_example_golang_sdk`.
1. В очередь передается сообщение с текстом `test message`.
1. Сообщение считывается из очереди и отображается в терминале.
1. Удаляется созданная очередь сообщений.

```golang
package main

import (
	"context"
	"fmt"
	"log"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
)

func main() {
	ctx := context.Background()

	customResolver := aws.EndpointResolverWithOptionsFunc(func(service, region string, options ...interface{}) (aws.Endpoint, error) {
		return aws.Endpoint{
			URL:           "https://message-queue.{{ api-host }}",
			SigningRegion: "{{ region-id }}",
		}, nil
	})

	cfg, err := config.LoadDefaultConfig(
		ctx,
		config.WithEndpointResolverWithOptions(customResolver),
	)
	if err != nil {
		log.Fatalln(err)
	}

	client := sqs.NewFromConfig(cfg)

	queueName := "mq_example_golang_sdk"

	queue, err := client.CreateQueue(ctx, &sqs.CreateQueueInput{
		QueueName: &queueName,
	})
	if err != nil {
		log.Fatalln(err)
	}

	fmt.Println("Queue created, URL: " + *queue.QueueUrl)

	msg := "test message"

	send, err := client.SendMessage(ctx, &sqs.SendMessageInput{
		QueueUrl:    queue.QueueUrl,
		MessageBody: &msg,
	})
	if err != nil {
		log.Fatalln(err)
	}

	fmt.Println("Message sent, ID: " + *send.MessageId)

	received, err := client.ReceiveMessage(ctx, &sqs.ReceiveMessageInput{
		QueueUrl: queue.QueueUrl,
	})
	if err != nil {
		log.Fatalln(err)
	}

	for _, v := range received.Messages {
		fmt.Printf("Message received\nID: %s\nBody: %s\n", *v.MessageId, *v.Body)

		if _, err := client.DeleteMessage(
			ctx,
			&sqs.DeleteMessageInput{
				QueueUrl:      queue.QueueUrl,
				ReceiptHandle: v.ReceiptHandle,
			},
		); err != nil {
			log.Fatalln(err)
		}
	}

	if _, err := client.DeleteQueue(ctx, &sqs.DeleteQueueInput{
		QueueUrl: queue.QueueUrl,
	}); err != nil {
		log.Fatalln(err)
	}

	fmt.Println("Queue deleted")
}
```
