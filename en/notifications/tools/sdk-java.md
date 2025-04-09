# How to get started with the AWS SDK for Java in {{ cns-full-name }}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

To get started with the AWS SDK for Java:

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

You can find the prerequisites and an AWS SDK for Java installation guide in the relevant [AWS documentation](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/setup.html#setup-overview).

### Get your OS ready {#prepare-os}

1. Install Java 8 or higher, e.g., [Oracle Java SE Development Kit](https://www.oracle.com/java/technologies/downloads/). For other JDKs you can use with the AWS SDK, see the [AWS developer guide](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/setup.html#setup-envtools).
1. Install [maven](https://maven.apache.org/download.cgi).


### Create a project {#create-project}

1. In the selected directory, create the project structure:

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

1. Create a client in the `App.java` file in the `src/main/java/org/example` directory:

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
    
            // Use snsClient
    
            snsClient.close();
        }
    
        public static SnsClient getSnsClient() {
            try {
                return SnsClient.builder()
                        .region(Region.of("{{ region-id }}"))
                        .credentialsProvider(StaticCredentialsProvider.create(AwsBasicCredentials
                                .create("<static_key_ID>", "<secret_key>")))
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

    Where `AwsBasicCredentials` contains the static key ID and secret key.

1. Add the project configuration into the `pom.xml` file:

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

1. Build the project:

    ```bash
    mvn clean package
    ```

1. To start the project, run this command:

    ```bash
    mvn exec:java -Dexec.mainClass="org.example.App"
    ```


## Create a notification channel {#create-channel}

1. Import the classes:

    ```java
    import java.util.HashMap;
    import java.util.Map;

    import software.amazon.awssdk.services.sns.SnsClient;
    import software.amazon.awssdk.services.sns.model.SnsException;

    import software.amazon.awssdk.services.sns.model.CreatePlatformApplicationRequest;
    import software.amazon.awssdk.services.sns.model.CreatePlatformApplicationResponse;
    ```

1. Run the following code:

    ```java
    try {
        Map<String, String> attributes = new HashMap<>();
        attributes.put("<authentication_type>", "<key>");
        CreatePlatformApplicationRequest request = CreatePlatformApplicationRequest.builder()
                .platform("<platform_type>")
                .name("<channel_name>")
                .attributes(attributes)
                .build();
        CreatePlatformApplicationResponse response = snsClient.createPlatformApplication(request);
        System.out.printf("Platform application ARN: %s\n", response.platformApplicationArn());
    } catch (SnsException e) {
        System.err.println(e.awsErrorDetails().errorMessage());
        System.exit(1);
    }
    ```

    Where:

    * `attributes`: Mobile platform authentication parameters in `key=value` format. The values depend on the platform:

        {% include [auth-attributes](../../_includes/notifications/auth-attributes.md) %}

    * `platform`: Mobile platform type:

        {% include [platform-types](../../_includes/notifications/platform-types.md) %}

    * `name`: Notification channel name, user-defined.
  
        {% include [channel-name](../../_includes/notifications/channel-name.md) %}

    As a result, you will get a notification channel ID (ARN).


## Get a list of notification channels {#list-channel}

1. Import the classes:

    ```java
    import java.util.Iterator;
    import java.util.List;

    import software.amazon.awssdk.services.sns.SnsClient;
    import software.amazon.awssdk.services.sns.model.SnsException;

    import software.amazon.awssdk.services.sns.model.ListPlatformApplicationsRequest;
    import software.amazon.awssdk.services.sns.model.ListPlatformApplicationsResponse;
    import software.amazon.awssdk.services.sns.model.PlatformApplication;
    ```

1. Run the following code:

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

    You will get the list of notification channels located in the same folder as the service account.

## Create an endpoint {#create-endpoint}

1. Import the classes:

    ```java
    import software.amazon.awssdk.services.sns.SnsClient;
    import software.amazon.awssdk.services.sns.model.SnsException;

    import software.amazon.awssdk.services.sns.model.CreatePlatformEndpointRequest;
    import software.amazon.awssdk.services.sns.model.CreatePlatformEndpointResponse;
    ```

1. Run the following code:

    ```java
    try {
        CreatePlatformEndpointRequest request = CreatePlatformEndpointRequest.builder()
                .platformApplicationArn("<notification_channel_ARN>")
                .token("<push_token>")
                .build();
        CreatePlatformEndpointResponse response = snsClient.createPlatformEndpoint(request);
        System.out.printf("Endpoint ARN: %s\n", response.endpointArn());
    } catch (SnsException e) {
        System.err.println(e.awsErrorDetails().errorMessage());
        System.exit(1);
    }
    ```

    Where:

    * `platformApplicationArn`: Notification channel ID (ARN).
    * `token`: Unique push token for the application on the user’s device.


## Send a notification {#publish}

### Explicit notifications (Bright Push) {#bright-push}

1. Import the classes:

    ```java
    import software.amazon.awssdk.services.sns.SnsClient;
    import software.amazon.awssdk.services.sns.model.SnsException;

    import software.amazon.awssdk.services.sns.model.PublishRequest;
    import software.amazon.awssdk.services.sns.model.PublishResponse;
    ```

1. Run the following code:

    {% list tabs %}

    - Apple iOS (APNs)

      ```java
      try {
          PublishRequest request = PublishRequest.builder()
                  .targetArn("<endpoint_ARN>")
                  .message("{\"default\": \"<notification_text>\", \"APNS\": \"{\\\"aps\\\": {\\\"alert\\\": \\\"<notification_text>\\\"}}\"}")
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
                  .targetArn("<endpoint_ARN>")
                  .message("{\"default\": \"<notification_text>\", \"GCM\": \"{\\\"notification\\\": {\\\"body\\\": \\\"<notification_text>\\\"}}\"}")
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

    Where:

    * `targetArn`: Mobile endpoint ID (ARN)
    * `messageStructure`: Message format
    * `message`: Message

### Silent notifications (Silent Push) {#silent-push}

1. Import the classes:

    ```java
    import software.amazon.awssdk.services.sns.SnsClient;
    import software.amazon.awssdk.services.sns.model.SnsException;

    import software.amazon.awssdk.services.sns.model.PublishRequest;
    import software.amazon.awssdk.services.sns.model.PublishResponse;
    ```

1. Run the following code:

    {% list tabs %}

    - Apple iOS (APNs)

      ```java
      try {
          PublishRequest request = PublishRequest.builder()
                  .targetArn("<endpoint_ARN>")
                  .message("{\"default\": \"<notification_text>\", \"APNS\": \"{\\\"key\\\": \\\"value\\\"}\"}")
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
                  .targetArn("<endpoint_ARN>")
                  .message("{\"default\": \"<notification_text>\", \"GCM\": \"{\\\"data\\\": {\\\"key\\\": \\\"value\\\"}}\"}")
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

    Where:

    * `targetArn`: Mobile endpoint ID (ARN)
    * `message`: Message
    * `messageStructure`: Message format

### Text message {#sms-messages}

1. Import the classes:

    ```java
    import java.util.HashMap;
    import java.util.Map;

    import software.amazon.awssdk.services.sns.SnsClient;
    import software.amazon.awssdk.services.sns.model.SnsException;

    import software.amazon.awssdk.services.sns.model.MessageAttributeValue;
    import software.amazon.awssdk.services.sns.model.PublishRequest;
    import software.amazon.awssdk.services.sns.model.PublishResponse;
    ```

1. Run the following code:

    ```java
    try {
        Map<String, MessageAttributeValue> messageAttributes = new HashMap<>();
        messageAttributes.put("AWS.SNS.SMS.SenderID", MessageAttributeValue.builder()
                .stringValue("<text_name_of_sender>")
                .dataType("String").build());

        PublishRequest request = PublishRequest.builder()
                .phoneNumber("<phone_number>")
                .message("<notification_text>")
                .messageAttributes(messageAttributes)
                .build();
        PublishResponse response = snsClient.publish(request);
        System.out.printf("Message id: %s\n", response.messageId());
    } catch (SnsException e) {
        System.err.println(e.awsErrorDetails().errorMessage());
        System.exit(1);
    }
    ```

    Where:

    * `stringValue`: Sender's text name
    * `phoneNumber`: Recipient's phone number
    * `message`: Notification text


## See also {#see-also}

* [Getting started](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Concepts](../concepts/index.md)
* [AWS developer guide](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/get-started.html)