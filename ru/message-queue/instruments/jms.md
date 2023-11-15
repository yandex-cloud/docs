# Пример использования {{ message-queue-full-name }} на JMS

[JMS](https://www.oracle.com/technetwork/java/jms/index.html) — это API для передачи сообщений между компонентами приложений. С помощью AWS SQS Java Messaging Library можно использовать {{ message-queue-name }} для отправки и получения сообщений через JMS. 

## Установка {#install}

Установите SDK для Java [по инструкции](https://docs.aws.amazon.com/en_us/sdk-for-java/v1/developer-guide/setup-install.html) на официальном сайте.

## Подготовка к работе {#prepare}

{% include [mq-http-api-preps](../_includes_service/mq-http-api-preps-sdk.md)%}

Задайте переменные окружения:

```
export AWS_ACCESS_KEY_ID="<идентификатор ключа доступа>"
export AWS_SECRET_ACCESS_KEY="<секретный ключ>"
```

Создайте очередь в сервисе {{ message-queue-name }} и подготовьте ее URL.

## Пример {#sample}
Для работы примера необходимо добавить следующие зависимости:
```java
<dependencies>
    <dependency>
      <groupId>com.amazonaws</groupId>
      <artifactId>amazon-sqs-java-messaging-lib</artifactId>
      <version>1.0.8</version>
    </dependency>
    <dependency>
      <groupId>com.amazonaws</groupId>
      <artifactId>aws-java-sdk-sqs</artifactId>
      <version>1.11.176</version>
    </dependency>
  </dependencies>
```

В этом примере: 

1. Устанавливается соединение с {{ message-queue-name }}. 
1. Создается очередь сообщений.
1. В очередь передается сообщение с текстом `test message`.
1. Сообщение считывается из очереди и отображается в терминале.

О возможностях, не продемонстрированных в примере, читайте в документации на [сайте AWS SQS Java Messaging Library](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-java-message-service-jms-client.html).

```java
package ru.yandex.cloud.message_queue;

import com.amazon.sqs.javamessaging.AmazonSQSMessagingClientWrapper;
import com.amazon.sqs.javamessaging.SQSConnection;
import com.amazon.sqs.javamessaging.SQSConnectionFactory;
import com.amazon.sqs.javamessaging.ProviderConfiguration;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import com.amazonaws.client.builder.AwsClientBuilder.EndpointConfiguration;

import javax.jms.*;

public class App
{
    private static String queueName = "mq_jms_example";

    public static void main( String[] args ) throws JMSException
    {
        SQSConnectionFactory connectionFactory = new SQSConnectionFactory(
                new ProviderConfiguration(),
                AmazonSQSClientBuilder.standard()
                        .withRegion("{{ region-id }}")
                        .withEndpointConfiguration(new EndpointConfiguration(
                            "https://message-queue.{{ api-host }}",
                            "{{ region-id }}"
                        ))
        );

        SQSConnection connection = connectionFactory.createConnection();

        AmazonSQSMessagingClientWrapper client = connection.getWrappedAmazonSQSClient();

        if( !client.queueExists(queueName) ) {
            client.createQueue( queueName );
        }

        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

        Queue queue = session.createQueue(queueName);

        MessageProducer producer = session.createProducer(queue);

        Message message = session.createTextMessage("test message");
        producer.send(message);

        MessageConsumer consumer = session.createConsumer(queue);
        connection.start();
        message = consumer.receive(1000);
        System.out.println(((TextMessage) message).getText());
    }
}
```