# How to get started with the AWS SDK for Kotlin in {{ cns-full-name }}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

To get started with the AWS SDK for Kotlin:

1. [Get your cloud ready](#before-you-begin).
1. [Get a static access key](#static-key).
1. [Configure the AWS SDK](#aws-sdk).
1. [Create a notification channel](#create-channel).
1. [Get a list of channels](#list-channel).
1. [Create an endpoint](#create-endpoint).
1. [Send a notification](#publish).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


## Get a static access key {#static-key}

{% include [sa-role-static-key](../../_includes/notifications/sa-role-static-key.md) %}


## Configure the AWS SDK {#aws-sdk}

You can find the prerequisites and an AWS SDK for Kotlin installation guide in the relevant [AWS documentation](https://docs.aws.amazon.com/sdk-for-kotlin/latest/developer-guide/setup-basic-onetime-setup.html#setup-overview).


### Get your OS ready {#prepare-os}

1. Install Java 8 or higher, e.g., [Oracle Java SE Development Kit](https://www.oracle.com/java/technologies/downloads/). For other JDKs you can use with the AWS SDK, see the [AWS developer guide](https://docs.aws.amazon.com/sdk-for-kotlin/latest/developer-guide/setup-basic-onetime-setup.html#setup-envtools).
1. Install [Gradle](https://gradle.org/install/).


### Create a project {#create-project}

1. Create a new project:

    1. Run this command:

        ```shell
        gradle init --type kotlin-application --dsl kotlin
        ```

    1. Select the default value for each message by pressing **Enter** in interactive mode.

1. Add dependencies to the `settings.gradle.kts` file in the project root:

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

   You can replace `1.4.0` with the [latest version of the SDK for Kotlin](https://github.com/awslabs/aws-sdk-kotlin/releases).

1. Copy the following code to the `gradle/libs.versions.toml` file:

    ```text
    [versions]
    junit-jupiter-engine = "5.10.3"
    
    [libraries]
    junit-jupiter-engine = { module = "org.junit.jupiter:junit-jupiter-engine", version.ref = "junit-jupiter-engine" }
    
    [plugins]
    kotlin-jvm = { id = "org.jetbrains.kotlin.jvm", version = "2.1.0" }
    ```

1. Copy the following code to the `app/build.gradle.kts` file:

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

1. Create a client in the `app/src/main/kotlin/org/example/App.kt` file:

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
                    "<static_key_ID>",
                    "<secret_key>"
                )
            )
        }
    
        // Use snsClient
    }
    ```

    Where `credentialsProvider` contains the static key ID and secret key.

1. To start the project, run this command:

    ```bash
    gradle run
    ```


## Create a notification channel {#create-channel}

1. Import the classes:

    ```kotlin
    import aws.sdk.kotlin.services.sns.model.CreatePlatformApplicationRequest
    ```

1. Run the following code:

    ```kotlin
    snsClient.use {
        val response = snsClient.createPlatformApplication(CreatePlatformApplicationRequest {
            name = "<channel_name>"
            platform = "<platform_type>"
            attributes = mapOf("<authentication_type>" to "<key>")
        })
        println("Platform application ARN: ${response.platformApplicationArn}")
    }
    ```

    Where:

    * `name`: Notification channel name, user-defined. The name must be unique within the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). It may contain lowercase and uppercase Latin letters, numbers, underscores, hyphens, and periods. It may be from 1 to 256 characters long. For APNs channels, we recommend specifying the bundle ID in the name, and for FCM and HMS, the full package name.
    * `platform`: Mobile platform type:

        {% include [platform-types](../../_includes/notifications/platform-types.md) %}

    * `attributes`: Mobile platform authentication parameters in `key=value` format. The values depend on platform:

        {% include [auth-attributes](../../_includes/notifications/auth-attributes.md) %}

    As a result, you will get a notification channel ID (ARN).


## Get a list of notification channels {#list-channel}

1. Import the classes:

    ```kotlin
    import aws.sdk.kotlin.services.sns.model.ListPlatformApplicationsRequest
    ```

1. Run the following code:

    ```kotlin
    snsClient.use {
        val response = snsClient.listPlatformApplications(ListPlatformApplicationsRequest {})
        response.platformApplications?.forEach { app ->
            println("Application ARN: ${app.platformApplicationArn}")
        }
    }
    ```

    You will get the list of notification channels located in the same folder as the service account.


## Create an endpoint {#create-endpoint}

1. Import the classes:

    ```kotlin
    import aws.sdk.kotlin.services.sns.model.CreatePlatformEndpointRequest
    ```

1. Run the following code:

    ```kotlin
    snsClient.use {
        val response = snsClient.createPlatformEndpoint(CreatePlatformEndpointRequest {
            platformApplicationArn = "<notification_channel_ARN>"
            token = "<push_token>"
        })
        println("Endpoint ARN: ${response.endpointArn}")
    }
    ```

    Where:

    * `platformApplicationArn`: Notification channel ID (ARN).
    * `token`: Unique push token for the application on the user’s device.


## Send a notification {#publish}

### Explicit notifications (Bright Push) {#bright-push}

1. Import the classes:

    ```kotlin
    import aws.sdk.kotlin.services.sns.model.PublishRequest
    ```

1. Run the following code:

    {% list tabs %}

    - Apple iOS (APNs)

      ```kotlin
      snsClient.use {
          val response = snsClient.publish(PublishRequest {
              targetArn = "<endpoint_ARN>"
              message = "{\"default\": \"<notification_text>\", \"APNS\": \"{\\\"aps\\\": {\\\"alert\\\": \\\"<notification_text>\\\"}}\"}"
              messageStructure = "json"
          })
          println("Message id: ${response.messageId}")
      }
      ```

    - Google Android (GCM)

      ```kotlin
      snsClient.use {
          val response = snsClient.publish(PublishRequest {
              targetArn = "<endpoint_ARN>"
              message = "{\"default\": \"<notification_text>\", \"GCM\": \"{\\\"notification\\\": {\\\"body\\\": \\\"<notification_text>\\\"}}\"}"
              messageStructure = "json"
          })
          println("Message id: ${response.messageId}")
      }
      ```

    {% endlist %}

    Where:

    * `targetArn`: Mobile endpoint ID (ARN)
    * `message`: Message
    * `messageStructure`: Message format


### Silent notifications (Silent Push) {#silent-push}

1. Import the classes:

    ```kotlin
    import aws.sdk.kotlin.services.sns.model.PublishRequest
    ```

1. Run the following code:

    {% list tabs %}

    - Apple iOS (APNs)

      ```kotlin
      snsClient.use {
          val response = snsClient.publish(PublishRequest {
              targetArn = "<endpoint_ARN>"
              message = "{\"default\": \"<notification_text>\", \"APNS\": \"{\\\"key\\\": \\\"value\\\"}\"}"
              messageStructure = "json"
          })
          println("Message id: ${response.messageId}")
      }
      ```

    - Google Android (GCM)

      ```kotlin
      snsClient.use {
          val response = snsClient.publish(PublishRequest {
              targetArn = "<endpoint_ARN>"
              message = "{\"default\": \"<notification_text>\", \"GCM\": \"{\\\"data\\\": {\\\"key\\\": \\\"value\\\"}}\"}"
              messageStructure = "json"
          })
          println("Message id: ${response.messageId}")
      }
      ```

    {% endlist %}

    Where:

    * `targetArn`: Mobile endpoint ID (ARN)
    * `message`: Message
    * `messageStructure`: Message format


### Text message {#sms-messages}

1. Import the classes:

    ```kotlin
    import aws.sdk.kotlin.services.sns.model.PublishRequest
    import aws.sdk.kotlin.services.sns.model.MessageAttributeValue
    ```

1. Run the following code:

    ```kotlin
    snsClient.use {
        val response = snsClient.publish(PublishRequest {
            phoneNumber = "<phone_number>"
            message = "<notification_text>"
            messageAttributes = mapOf("AWS.SNS.SMS.SenderID" to MessageAttributeValue {
                dataType = "String"; stringValue = "<sender's_text_name>"
            })
        })
        println("Message id: ${response.messageId}")
    }
    ```

    Where:

    * `phoneNumber`: Recipient's phone number
    * `message`: Notification text
    * `stringValue`: Sender's text name


## See also {#see-also}

* [Getting started](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Concepts](../concepts/index.md)
* [AWS developer guide](https://docs.aws.amazon.com/sdk-for-kotlin/latest/developer-guide/get-started.html)