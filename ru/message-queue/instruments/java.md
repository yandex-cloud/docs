---
title: Пример использования {{ message-queue-full-name }} на Java
description: Пример работы с очередями сообщений {{ message-queue-name }} на Java с помощью Amazon SQS
---
# Пример использования {{ message-queue-full-name }} на Java

{% note warning %}

Для работы с {{ message-queue-full-name }} из Java используется [Amazon SQS](https://aws.amazon.com/ru/sdk-for-java/) — комплект средств разработки для языка Java.


{% endnote %}

## Внедрение зависимости {#install}
{% list tabs %}

- Maven

  Добавьте в pom.xml
  ```
    <dependency>
    <groupId>software.amazon.awssdk</groupId>
    <artifactId>sqs</artifactId>
    <version>2.29.33</version>
    <scope>compile</scope>
    </dependency>
  ```

- Gradle

  Добавьте в build.gradle
  ```
  implementation("software.amazon.awssdk:sqs:2.29.33")
  ```

{% endlist %}

## Подготовка к работе {#prepare}

{% include [mq-http-api-preps](../_includes_service/mq-http-api-preps-sdk.md)%}

Задайте переменные окружения:

{% list tabs %}

- Intelij Idea

  Run → Edit Configurations.
  В поле Environment variables укажите:
  ```
    AWS_ACCESS_KEY_ID=<Ваш AWS_ACCESS_KEY_ID>
    AWS_SECRET_ACCESS_KEY=<Ваш AWS_SECRET_ACCESS_KEY>
  ```

- Terminal

```
export AWS_ACCESS_KEY_ID="<идентификатор_ключа_доступа>"
export AWS_SECRET_ACCESS_KEY="<секретный_ключ>"
```

{% endlist %}

## Пример {#sample}

В этом примере:

1. Устанавливается соединение с {{ message-queue-name }}.
1. Создается очередь с именем `sample-queue`. 
1. В очередь передается сообщение с текстом `Hello from Java`.
1. Сообщение считывается из очереди и отображается в терминале.
1. Полученное сообщение удаляется из очереди.
1. Удаляется созданная очередь сообщений.

```java
   
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.sqs.model.*;

import java.util.Map;

import java.net.URI;


public class YmqExample {
    public static void main(String[] args) {
        String accessKey = System.getenv("AWS_ACCESS_KEY_ID");
        String secretKey = System.getenv("AWS_SECRET_ACCESS_KEY");
        String regionEnv = System.getenv("AWS_REGION");
        String endpointEnv = System.getenv("S3_ENDPOINT_URL");

        SqsClient sqs = SqsClient.builder()
                .endpointOverride(URI.create(endpointEnv != null ? endpointEnv : "https://message-queue.api.cloud.yandex.net"))
                .region(Region.of(regionEnv != null ? regionEnv : "ru-central1"))
                .credentialsProvider(StaticCredentialsProvider.create(
                        AwsBasicCredentials.create(accessKey, secretKey)
                ))
                .build();

        //Создание очереди

        // Стандартная очередь
        var createRequest = CreateQueueRequest.builder()
                .queueName("sample-queue")
                .attributes(Map.of(
                        QueueAttributeName.VISIBILITY_TIMEOUT, "30",
                        QueueAttributeName.RECEIVE_MESSAGE_WAIT_TIME_SECONDS, "20"
                ))
                .build();

        var createResponse = sqs.createQueue(createRequest);
        String queueUrl = createResponse.queueUrl();
        System.out.println("Queue URL: " + queueUrl);

        // Отправка
        var message = sqs.sendMessage(SendMessageRequest.builder()
                .queueUrl(queueUrl)
                .messageBody("Hello from Java")
                .build());

        System.out.println("Send message : " + message);
        // Получение (long poll, до 10 секунд)
        var messages = sqs.receiveMessage(ReceiveMessageRequest.builder()
                        .queueUrl(queueUrl)
                        .waitTimeSeconds(10)
                        .build())
                .messages();


        for (var m : messages) {
            System.out.println("Received: " + m.body());
            sqs.deleteMessage(DeleteMessageRequest.builder()
                    .queueUrl(queueUrl)
                    .receiptHandle(m.receiptHandle())
                    .build());
        }

        sqs.deleteQueue(DeleteQueueRequest.builder()
                .queueUrl(queueUrl)
                .build());
        System.out.println("Queue deleted: " + queueUrl);

        // Закрытие клиента SQS
        sqs.close();
    }
}

```

