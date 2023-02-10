# Example of using {{ message-queue-full-name }} in Golang

Using the [AWS SDK for Golang]{% if lang == "ru" %}(https://aws.amazon.com/ru/sdk-for-go/){% endif %}{% if lang == "en" %}(https://aws.amazon.com/sdk-for-go/){% endif %}, you can manage {{ message-queue-name }} message queues and send and receive messages.

## Installation {#install}

Install the AWS SDK for Golang by [following the instructions]{% if lang == "ru" %}(https://aws.amazon.com/ru/sdk-for-go/){% endif %}{% if lang == "en" %}(https://aws.amazon.com/sdk-for-go/){% endif %} on the official website.

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
1. A message queue is created with the name `mq_example_golang_sdk`.
1. A message with the text `test-message` is sent to the queue.
1. The message is read from the queue and displayed in the terminal.
1. The message queue is deleted.

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
