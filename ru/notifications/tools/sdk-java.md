# Как начать работать с AWS SDK для Java в {{ cns-full-name }}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

Чтобы начать работу с AWS SDK для Java:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Получите статический ключ доступа](#static-key).
1. [Настройте AWS SDK](#aws-sdk).
1. [Создайте канал уведомлений](#create-channel).
1. [Получите список каналов](#list-channel).
1. [Создайте эндпоинт](#create-endpoint).
1. [Отправьте уведомление](#publish).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


## Получите статический ключ доступа {#static-key}

{% include [sa-role-static-key](../../_includes/notifications/sa-role-static-key.md) %}


## Настройте AWS SDK {#aws-sdk}

Пререквизиты и инструкция по установке AWS SDK для Java описаны в [документации AWS](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/setup.html#setup-overview).

### Подготовьте ОС к работе {#prepare-os}

1. Установите Java версии 8 или выше, например, [Oracle Java SE Development Kit](https://www.oracle.com/java/technologies/downloads/). Другие JDK, с которыми работает AWS SDK описаны в [документации AWS](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/setup.html#setup-envtools).
1. Установите систему сборки [maven](https://maven.apache.org/download.cgi).


### Создайте проект {#create-project}

1. Создайте структуру проекта в выбранной директории:

    ```text
    project
    ├──pom.xml
    └──src
        └──main
          └──java
              └──org
                └──example
                    └──App.java
    ```

1. Создайте клиент в файле `App.java` в директории `src/main/java/org/example`:

    ```java
    package org.example;
    
    import java.net.URI;
    import java.net.URISyntaxException;
    
    import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
    import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
    import software.amazon.awssdk.http.apache.ApacheHttpClient;
    import software.amazon.awssdk.regions.Region;
    import software.amazon.awssdk.services.sns.SnsClient;
    
    public class App {
        public static void main(String... args) {
            SnsClient snsClient = getSnsClient();
    
            // Используйте snsClient
    
            snsClient.close();
        }
    
        public static SnsClient getSnsClient() {
            try {
                return SnsClient.builder()
                        .region(Region.of("{{ region-id }}"))
                        .credentialsProvider(StaticCredentialsProvider.create(AwsBasicCredentials
                                .create("<идентификатор_статического_ключа>", "<секретный_ключ>")))
                        .endpointOverride(new URI("https://{{ cns-host }}/"))
                        .httpClientBuilder(ApacheHttpClient.builder())
                        .build();
            } catch (URISyntaxException e) {
                System.err.println(e);
                System.exit(1);
            }
            return null;
        }
    }
    ```

    Где `AwsBasicCredentials` содержит идентификатор статического ключа и секретный ключ.

1. Добавьте конфигурацию проекта в файл `pom.xml`:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
        <modelVersion>4.0.0</modelVersion>
    
        <groupId>org.example</groupId>
        <artifactId>snstest</artifactId>
        <version>1.0-SNAPSHOT</version>
        <packaging>jar</packaging>
        <properties>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
            <maven.compiler.source>1.8</maven.compiler.source>
            <maven.compiler.target>1.8</maven.compiler.target>
            <maven.compiler.plugin.version>3.6.1</maven.compiler.plugin.version>
            <aws.java.sdk.version>2.27.21</aws.java.sdk.version>
            <slf4j.version>1.7.28</slf4j.version>
        </properties>
    
        <dependencyManagement>
            <dependencies>
                <dependency>
                    <groupId>software.amazon.awssdk</groupId>
                    <artifactId>bom</artifactId>
                    <version>${aws.java.sdk.version}</version>
                    <type>pom</type>
                    <scope>import</scope>
                </dependency>
            </dependencies>
        </dependencyManagement>
    
        <dependencies>
            <dependency>
                <groupId>software.amazon.awssdk</groupId>
                <artifactId>sns</artifactId>
            </dependency>
    
            <dependency>
                <groupId>software.amazon.awssdk</groupId>
                <artifactId>apache-client</artifactId>
            </dependency>
    
            <dependency>
                <groupId>org.slf4j</groupId>
                <artifactId>slf4j-nop</artifactId>
                <version>${slf4j.version}</version>
            </dependency>
        </dependencies>
    
        <build>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version>${maven.compiler.plugin.version}</version>
                </plugin>
            </plugins>
        </build>
    
    </project>
    ```

1. Соберите проект:

    ```bash
    mvn clean package
    ```

1. Выполните следующую команду для запуска проекта:

    ```bash
    mvn exec:java -Dexec.mainClass="org.example.App"
    ```


## Создайте канал уведомлений {#create-channel}

1. Импортируйте классы:

    ```java
    import java.util.HashMap;
    import java.util.Map;

    import software.amazon.awssdk.services.sns.SnsClient;
    import software.amazon.awssdk.services.sns.model.SnsException;

    import software.amazon.awssdk.services.sns.model.CreatePlatformApplicationRequest;
    import software.amazon.awssdk.services.sns.model.CreatePlatformApplicationResponse;
    ```

1. Выполните код:

    ```java
    try {
        Map<String, String> attributes = new HashMap<>();
        attributes.put("<тип_аутентификации>", "<ключ>");
        CreatePlatformApplicationRequest request = CreatePlatformApplicationRequest.builder()
                .platform("<тип_платформы>")
                .name("<имя_канала>")
                .attributes(attributes)
                .build();
        CreatePlatformApplicationResponse response = snsClient.createPlatformApplication(request);
        System.out.printf("Platform application ARN: %s\n", response.platformApplicationArn());
    } catch (SnsException e) {
        System.err.println(e.awsErrorDetails().errorMessage());
        System.exit(1);
    }
    ```

    Где:

    * `attributes` — параметры аутентификации на мобильной платформе в формате `ключ=значение`. Значения зависят от типа платформы:

        {% include [auth-attributes](../../_includes/notifications/auth-attributes.md) %}

    * `platform` — тип мобильной платформы:

        {% include [platform-types](../../_includes/notifications/platform-types.md) %}

    * `name` — имя канала уведомлений, задается пользователем.
  
        {% include [channel-name](../../_includes/notifications/channel-name.md) %}

    В результате вы получите идентификатор (ARN) канала уведомлений.


## Получите список каналов уведомлений {#list-channel}

1. Импортируйте классы:

    ```java
    import java.util.Iterator;
    import java.util.List;

    import software.amazon.awssdk.services.sns.SnsClient;
    import software.amazon.awssdk.services.sns.model.SnsException;

    import software.amazon.awssdk.services.sns.model.ListPlatformApplicationsRequest;
    import software.amazon.awssdk.services.sns.model.ListPlatformApplicationsResponse;
    import software.amazon.awssdk.services.sns.model.PlatformApplication;
    ```

1. Выполните код:

    ```java
    try {
        ListPlatformApplicationsRequest request = ListPlatformApplicationsRequest.builder().build();
        ListPlatformApplicationsResponse response = snsClient.listPlatformApplications(request);
        List<PlatformApplication> apps = response.platformApplications();
        Iterator<PlatformApplication> iter = apps.iterator();
        while (iter.hasNext()) {
            PlatformApplication app = (PlatformApplication) iter.next();
            System.out.printf("Application ARN: %s\n", app.platformApplicationArn());
        }
    } catch (SnsException e) {
        System.err.println(e.awsErrorDetails().errorMessage());
        System.exit(1);
    }
    ```

    В результате будет выведен список каналов уведомлений, размещенных в том же каталоге, в котором находится сервисный аккаунт.

## Создайте эндпоинт {#create-endpoint}

1. Импортируйте классы:

    ```java
    import software.amazon.awssdk.services.sns.SnsClient;
    import software.amazon.awssdk.services.sns.model.SnsException;

    import software.amazon.awssdk.services.sns.model.CreatePlatformEndpointRequest;
    import software.amazon.awssdk.services.sns.model.CreatePlatformEndpointResponse;
    ```

1. Выполните код:

    ```java
    try {
        CreatePlatformEndpointRequest request = CreatePlatformEndpointRequest.builder()
                .platformApplicationArn("<ARN_канала_уведомлений>")
                .token("<Push-токен>")
                .build();
        CreatePlatformEndpointResponse response = snsClient.createPlatformEndpoint(request);
        System.out.printf("Endpoint ARN: %s\n", response.endpointArn());
    } catch (SnsException e) {
        System.err.println(e.awsErrorDetails().errorMessage());
        System.exit(1);
    }
    ```

    Где:

    * `platformApplicationArn` — идентификатор (ARN) канала уведомлений.
    * `token` — уникальный Push-токен приложения на устройстве пользователя.


## Отправьте уведомление {#publish}

### Явные уведомления (Bright Push) {#bright-push}

1. Импортируйте классы:

    ```java
    import software.amazon.awssdk.services.sns.SnsClient;
    import software.amazon.awssdk.services.sns.model.SnsException;

    import software.amazon.awssdk.services.sns.model.PublishRequest;
    import software.amazon.awssdk.services.sns.model.PublishResponse;
    ```

1. Выполните код:

    {% list tabs %}

    - Apple iOS (APNs)

      ```java
      try {
          PublishRequest request = PublishRequest.builder()
                  .targetArn("<ARN_эндпоинта>")
                  .message("{\"default\": \"<текст_уведомления>\", \"APNS\": \"{\\\"aps\\\": {\\\"alert\\\": \\\"<текст_уведомления>\\\"}}\"}")
                  .messageStructure("json")
                  .build();
          PublishResponse response = snsClient.publish(request);
          System.out.printf("Message id: %s\n", response.messageId());
      } catch (SnsException e) {
          System.err.println(e.awsErrorDetails().errorMessage());
          System.exit(1);
      }
      ```

    - Google Android (GCM)

      ```java
      try {
          PublishRequest request = PublishRequest.builder()
                  .targetArn("<ARN_эндпоинта>")
                  .message("{\"default\": \"<текст_уведомления>\", \"GCM\": \"{\\\"notification\\\": {\\\"body\\\": \\\"<текст_уведомления>\\\"}}\"}")
                  .messageStructure("json")
                  .build();
          PublishResponse response = snsClient.publish(request);
          System.out.printf("Message id: %s\n", response.messageId());
      } catch (SnsException e) {
          System.err.println(e.awsErrorDetails().errorMessage());
          System.exit(1);
      }
      ```

    {% endlist %}

    Где:

    * `targetArn` — идентификатор (ARN) мобильного эндпоинта.
    * `messageStructure` — формат сообщения.
    * `message` — сообщение.

### Тихие уведомления (Silent Push) {#silent-push}

1. Импортируйте классы:

    ```java
    import software.amazon.awssdk.services.sns.SnsClient;
    import software.amazon.awssdk.services.sns.model.SnsException;

    import software.amazon.awssdk.services.sns.model.PublishRequest;
    import software.amazon.awssdk.services.sns.model.PublishResponse;
    ```

1. Выполните код:

    {% list tabs %}

    - Apple iOS (APNs)

      ```java
      try {
          PublishRequest request = PublishRequest.builder()
                  .targetArn("<ARN_эндпоинта>")
                  .message("{\"default\": \"<текст_уведомления>\", \"APNS\": \"{\\\"key\\\": \\\"value\\\"}\"}")
                  .messageStructure("json")
                  .build();
          PublishResponse response = snsClient.publish(request);
          System.out.printf("Message id: %s\n", response.messageId());
      } catch (SnsException e) {
          System.err.println(e.awsErrorDetails().errorMessage());
          System.exit(1);
      }
      ```

    - Google Android (GCM)

      ```java
      try {
          PublishRequest request = PublishRequest.builder()
                  .targetArn("<ARN_эндпоинта>")
                  .message("{\"default\": \"<текст_уведомления>\", \"GCM\": \"{\\\"data\\\": {\\\"key\\\": \\\"value\\\"}}\"}")
                  .messageStructure("json")
                  .build();
          PublishResponse response = snsClient.publish(request);
          System.out.printf("Message id: %s\n", response.messageId());
      } catch (SnsException e) {
          System.err.println(e.awsErrorDetails().errorMessage());
          System.exit(1);
      }
      ```

    {% endlist %}

    Где:

    * `targetArn` — идентификатор (ARN) мобильного эндпоинта.
    * `message` — сообщение.
    * `messageStructure` — формат сообщения.

### SMS-сообщения {#sms-messages}

1. Импортируйте классы:

    ```java
    import java.util.HashMap;
    import java.util.Map;

    import software.amazon.awssdk.services.sns.SnsClient;
    import software.amazon.awssdk.services.sns.model.SnsException;

    import software.amazon.awssdk.services.sns.model.MessageAttributeValue;
    import software.amazon.awssdk.services.sns.model.PublishRequest;
    import software.amazon.awssdk.services.sns.model.PublishResponse;
    ```

1. Выполните код:

    ```java
    try {
        Map<String, MessageAttributeValue> messageAttributes = new HashMap<>();
        messageAttributes.put("AWS.SNS.SMS.SenderID", MessageAttributeValue.builder()
                .stringValue("<текстовое_имя_отправителя>")
                .dataType("String").build());

        PublishRequest request = PublishRequest.builder()
                .phoneNumber("<номер_телефона>")
                .message("<текст_уведомления>")
                .messageAttributes(messageAttributes)
                .build();
        PublishResponse response = snsClient.publish(request);
        System.out.printf("Message id: %s\n", response.messageId());
    } catch (SnsException e) {
        System.err.println(e.awsErrorDetails().errorMessage());
        System.exit(1);
    }
    ```

    Где:

    * `stringValue` — текстовое имя отправителя.
    * `phoneNumber` — номер телефона получателя.
    * `message` — текст уведомления.


## См. также {#see-also}

* [Начало работы](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Концепции](../concepts/index.md)
* [Документация AWS](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/get-started.html)