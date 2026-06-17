# Как начать работать с AWS SDK для Kotlin в Yandex Cloud Notification Service

{% note info %}

Сервис находится на [стадии Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы начать работу с AWS SDK для Kotlin:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Получите статический ключ доступа](#static-key).
1. [Настройте AWS SDK](#aws-sdk).
1. [Создайте канал уведомлений](#create-channel).
1. [Получите список каналов](#list-channel).
1. [Создайте эндпоинт](#create-endpoint).
1. [Отправьте уведомление](#publish).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


## Получите статический ключ доступа {#static-key}

Для аутентификации в Cloud Notification Service используется [статический ключ доступа](../../iam/concepts/authorization/access-key.md). Этот ключ выпускается на [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), и все действия выполняются от имени этого сервисного аккаунта.

Чтобы получить статический ключ доступа:
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../iam/roles-reference.md#editor) `editor` на каталог.
1. Для сервисного аккаунта [создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа.

    Сохраните идентификатор и секретный ключ.


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
            region = "ru-central1"; endpointUrl =
            Url.parse("https://notifications.yandexcloud.net/"); credentialsProvider =
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

        Имя должно быть уникальным для всего CNS. После создания канала изменить имя нельзя. Имя может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name), для RuStore — значение `packageName`.

    * `platform` — тип мобильной платформы:

        * `APNS` и `APNS_SANDBOX` — Apple Push Notification service (APNs). Для тестирования приложения используйте `APNS_SANDBOX`.
        * `GCM` — Firebase Cloud Messaging (FCM).
        * `HMS` — Huawei Mobile Services (HMS).
        * `RUSTORE` — RuStore Android.

    * `attributes` — параметры аутентификации на мобильной платформе в формате `ключ=значение`. Значения зависят от типа платформы:

        * APNs:
        
            * Аутентификация с токеном:
        
                * `PlatformPrincipal` — путь к файлу с ключом подписи токена, полученный в Apple.
                * `PlatformCredential` — идентификатор ключа подписи (Key ID).
                * `ApplePlatformTeamID` — идентификатор разработчика (Team ID).
                * `ApplePlatformBundleID` — идентификатор приложения (Bundle ID).
        
            * Аутентификация с сертификатом:
        
                * `PlatformPrincipal` — SSL-сертификат в формате `.pem`.
                * `PlatformCredential` — закрытый ключ сертификата в формате `.pem`.
        
                    Чтобы сохранить сертификат и закрытый ключ в отдельных файлах формата `.pem`, вы можете воспользоваться утилитой [openssl](https://docs.openssl.org/1.1.1/man1/pkcs12) в Linux:
                    
                    ```bash
                    openssl pkcs12 -in Certificates.p12 -nokeys -nodes -out certificate.pem
                    openssl pkcs12 -in Certificates.p12 -nocerts -nodes -out privatekey.pem
                    ```
        
            Аутентификация с токеном — более современный и безопасный метод.
        
        * FCM: `PlatformCredential` — ключ сервисного аккаунта Google Cloud в формате JSON для аутентификации с помощью HTTP v1 API или API-ключ (server key) для аутентификации с помощью Legacy API.
        
            Используйте HTTP v1 API, так как с июля 2024 года [FCM legacy API не поддерживается](https://firebase.google.com/docs/cloud-messaging/migrate-v1).
        
        * HMS:
        
            * `PlatformPrincipal` — идентификатор ключа.
            * `PlatformCredential` — API-ключ.

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


## Полезные ссылки {#see-also}

* [Начало работы](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Концепции](../concepts/index.md)
* [Документация AWS](https://docs.aws.amazon.com/sdk-for-kotlin/latest/developer-guide/get-started.html)