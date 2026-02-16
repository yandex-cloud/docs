# Как начать работать с AWS SDK для Kotlin в {{ cns-full-name }}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

Чтобы начать работу с AWS SDK для Kotlin:

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

Пререквизиты и инструкция по установке AWS SDK для Kotlin описаны в [документации AWS](https://docs.aws.amazon.com/sdk-for-kotlin/latest/developer-guide/setup-basic-onetime-setup.html#setup-overview).

Для работы с уведомлениями RuStore Android познакомьтесь с [документацией RuStore SDK](https://www.rustore.ru/help/sdk/push-notifications/kotlin-java/6-5-0).

### Подготовьте ОС к работе {#prepare-os}

1. Установите Java версии 8 или выше, например, [Oracle Java SE Development Kit](https://www.oracle.com/java/technologies/downloads/). Другие JDK, с которыми работает AWS SDK описаны в [документации AWS](https://docs.aws.amazon.com/sdk-for-kotlin/latest/developer-guide/setup-basic-onetime-setup.html#setup-envtools).
1. Установите систему сборки [Gradle](https://gradle.org/install/).


### Создайте проект {#create-project}

1. Создайте новый проект:

    1. Выполните следующую команду:

        ```shell
        gradle init --type kotlin-application --dsl kotlin
        ```

    1. В интерактивном режиме для каждого сообщения выберите значение по умолчанию, нажав клавишу **Enter**.

1. В файл `settings.gradle.kts` в корне проекта добавьте зависимости:

    ```text
    dependencyResolutionManagement {
        repositories {
            mavenCentral()
        }
    
        versionCatalogs {
            create("awssdk") {
                from("aws.sdk.kotlin:version-catalog:1.4.0")
            }
        }
    }
    ```

   Версию `1.4.0` можно заменить на [последнюю версию SDK для Kotlin](https://github.com/awslabs/aws-sdk-kotlin/releases).

1. Скопируйте в файл `gradle/libs.versions.toml` следующий код:

    ```text
    [versions]
    junit-jupiter-engine = "5.10.3"
    
    [libraries]
    junit-jupiter-engine = { module = "org.junit.jupiter:junit-jupiter-engine", version.ref = "junit-jupiter-engine" }
    
    [plugins]
    kotlin-jvm = { id = "org.jetbrains.kotlin.jvm", version = "2.1.0" }
    ```

1. Скопируйте в файл `app/build.gradle.kts` следующий код:

    ```text
    plugins {
        alias(libs.plugins.kotlin.jvm)
        application
    }
    
    
    dependencies {
        implementation(awssdk.services.sns) // Add dependency on the AWS SDK for Kotlin's SNS client.
    
        testImplementation("org.jetbrains.kotlin:kotlin-test-junit5")
        testImplementation(libs.junit.jupiter.engine)
        testRuntimeOnly("org.junit.platform:junit-platform-launcher")
    }
    
    java {
        toolchain {
            languageVersion = JavaLanguageVersion.of(21)
        }
    }
    
    application {
        mainClass = "org.example.AppKt"
    }
    
    tasks.named<Test>("test") {
        useJUnitPlatform()
    }
    ```

1. Создайте клиент в файле `app/src/main/kotlin/org/example/App.kt`:

    ```kotlin
    package org.example
    
    import aws.sdk.kotlin.services.sns.SnsClient
    import aws.smithy.kotlin.runtime.net.url.Url
    import aws.sdk.kotlin.runtime.auth.credentials.StaticCredentialsProvider
    import aws.smithy.kotlin.runtime.auth.awscredentials.Credentials
    
    import kotlinx.coroutines.runBlocking
    
    suspend fun main(): Unit = runBlocking {
        val snsClient = SnsClient {
            region = "{{ region-id }}"; endpointUrl =
            Url.parse("https://{{ cns-host }}/"); credentialsProvider =
            StaticCredentialsProvider(
                Credentials(
                    "<идентификатор_статического_ключа>",
                    "<секретный_ключ>"
                )
            )
        }
    
        // Используйте snsClient
    }
    ```

    Где `credentialsProvider` содержит идентификатор статического ключа и секретный ключ.

1. Выполните следующую команду для запуска проекта:

    ```bash
    gradle run
    ```


## Создайте канал уведомлений {#create-channel}

1. Импортируйте классы:

    ```kotlin
    import aws.sdk.kotlin.services.sns.model.CreatePlatformApplicationRequest
    ```

1. Выполните код:

    ```kotlin
    snsClient.use {
        val response = snsClient.createPlatformApplication(CreatePlatformApplicationRequest {
            name = "<имя_канала>"
            platform = "<тип_платформы>"
            attributes = mapOf("<тип_аутентификации>" to "<ключ>")
        })
        println("Platform application ARN: ${response.platformApplicationArn}")
    }
    ```

    Где:

    * `name` — имя канала уведомлений, задается пользователем.

        {% include [channel-name](../../_includes/notifications/channel-name.md) %}

    * `platform` — тип мобильной платформы:

        {% include [platform-types](../../_includes/notifications/platform-types.md) %}

    * `attributes` — параметры аутентификации на мобильной платформе в формате `ключ=значение`. Значения зависят от типа платформы:

        {% include [auth-attributes](../../_includes/notifications/auth-attributes.md) %}

    В результате вы получите идентификатор (ARN) канала уведомлений.


## Получите список каналов уведомлений {#list-channel}

1. Импортируйте классы:

    ```kotlin
    import aws.sdk.kotlin.services.sns.model.ListPlatformApplicationsRequest
    ```

1. Выполните код:

    ```kotlin
    snsClient.use {
        val response = snsClient.listPlatformApplications(ListPlatformApplicationsRequest {})
        response.platformApplications?.forEach { app ->
            println("Application ARN: ${app.platformApplicationArn}")
        }
    }
    ```

    В результате будет выведен список каналов уведомлений, размещенных в том же каталоге, в котором находится сервисный аккаунт.


## Создайте эндпоинт {#create-endpoint}

1. Импортируйте классы:

    ```kotlin
    import aws.sdk.kotlin.services.sns.model.CreatePlatformEndpointRequest
    ```

1. Выполните код:

    ```kotlin
    snsClient.use {
        val response = snsClient.createPlatformEndpoint(CreatePlatformEndpointRequest {
            platformApplicationArn = "<ARN_канала_уведомлений>"
            token = "<Push-токен>"
        })
        println("Endpoint ARN: ${response.endpointArn}")
    }
    ```

    Где:

    * `platformApplicationArn` — идентификатор (ARN) канала уведомлений.
    * `token` — уникальный Push-токен приложения на устройстве пользователя.


## Отправьте уведомление {#publish}

### Явные уведомления (Bright Push) {#bright-push}

1. Импортируйте классы:

    ```kotlin
    import aws.sdk.kotlin.services.sns.model.PublishRequest
    ```

1. Выполните код:

    {% list tabs %}

    - Apple iOS (APNs)

      ```kotlin
      snsClient.use {
          val response = snsClient.publish(PublishRequest {
              targetArn = "<ARN_эндпоинта>"
              message = "{\"default\": \"<текст_уведомления>\", \"APNS\": \"{\\\"aps\\\": {\\\"alert\\\": \\\"<текст_уведомления>\\\"}}\"}"
              messageStructure = "json"
          })
          println("Message id: ${response.messageId}")
      }
      ```

    - Google Android (GCM)

      ```kotlin
      snsClient.use {
          val response = snsClient.publish(PublishRequest {
              targetArn = "<ARN_эндпоинта>"
              message = "{\"default\": \"<текст_уведомления>\", \"GCM\": \"{\\\"notification\\\": {\\\"body\\\": \\\"<текст_уведомления>\\\"}}\"}"
              messageStructure = "json"
          })
          println("Message id: ${response.messageId}")
      }
      ```

    {% endlist %}

    Где:

    * `targetArn` — идентификатор (ARN) мобильного эндпоинта.
    * `message` — сообщение.
    * `messageStructure` — формат сообщения.


### Тихие уведомления (Silent Push) {#silent-push}

1. Импортируйте классы:

    ```kotlin
    import aws.sdk.kotlin.services.sns.model.PublishRequest
    ```

1. Выполните код:

    {% list tabs %}

    - Apple iOS (APNs)

      ```kotlin
      snsClient.use {
          val response = snsClient.publish(PublishRequest {
              targetArn = "<ARN_эндпоинта>"
              message = "{\"default\": \"<текст_уведомления>\", \"APNS\": \"{\\\"key\\\": \\\"value\\\"}\"}"
              messageStructure = "json"
          })
          println("Message id: ${response.messageId}")
      }
      ```

    - Google Android (GCM)

      ```kotlin
      snsClient.use {
          val response = snsClient.publish(PublishRequest {
              targetArn = "<ARN_эндпоинта>"
              message = "{\"default\": \"<текст_уведомления>\", \"GCM\": \"{\\\"data\\\": {\\\"key\\\": \\\"value\\\"}}\"}"
              messageStructure = "json"
          })
          println("Message id: ${response.messageId}")
      }
      ```

    {% endlist %}

    Где:

    * `targetArn` — идентификатор (ARN) мобильного эндпоинта.
    * `message` — сообщение.
    * `messageStructure` — формат сообщения.


### SMS-сообщения {#sms-messages}

1. Импортируйте классы:

    ```kotlin
    import aws.sdk.kotlin.services.sns.model.PublishRequest
    import aws.sdk.kotlin.services.sns.model.MessageAttributeValue
    ```

1. Выполните код:

    ```kotlin
    snsClient.use {
        val response = snsClient.publish(PublishRequest {
            phoneNumber = "<номер_телефона>"
            message = "<текст_уведомления>"
            messageAttributes = mapOf("AWS.SNS.SMS.SenderID" to MessageAttributeValue {
                dataType = "String"; stringValue = "<текстовое_имя_отправителя>"
            })
        })
        println("Message id: ${response.messageId}")
    }
    ```

    Где:

    * `phoneNumber` — номер телефона получателя.
    * `message` — текст уведомления.
    * `stringValue` — текстовое имя отправителя.


## См. также {#see-also}

* [Начало работы](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Концепции](../concepts/index.md)
* [Документация AWS](https://docs.aws.amazon.com/sdk-for-kotlin/latest/developer-guide/get-started.html)