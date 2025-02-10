# Transferring data within microservice architectures

Modern applications are migrating from monolithic to microservice architectures. A large number of interacting components appear, which are written in different programming languages and run on various devices.

Using data streaming buses for exchanging information between these components makes it easier to develop a microservice architecture and enhances its reliability and scalability.

![data-microservices](../../_assets/data-streams/data-microservices.svg)

## Benefits {#advantages}

### Reliability {#reliability}

Microservice architectures are usually distributed. Reliability is a key factor in a distributed architecture. It is difficult to support a complete failure model in each application. Therefore, fault tolerance is only built into infrastructure components, whereas other applications become fault-tolerant by drawing it from them.

### Different lifetime {#ttl}

In a monolithic architecture, all components are continuously available for data exchange. Components of a microservice architecture have different lifetimes and cannot rely on direct data exchange between them. Data should be either buffered or sent via a data streaming bus.

### Scalability {#scaling}

The efficiency of applications needs to be ensured as they grow. With data streaming buses, you can simply follow a built-in interaction scenario to make your applications scalable.

## Comparison with {{ KF }} {#comparison}

In the table below, {{ yds-short-name }} is compared with {{ KF }} a popular data streaming bus.

Parameter | {{ yds-full-name }} | {{ KF }}
----|-----|-----
Supported protocol | Amazon Kinesis Data Streams API | {{ KF }}
Supported SDKs | HTTP, Java, C++, Go, and more | HTTP, Java, C++, Go, and more
Cost | A fee for using resources: speed and retention period | A fee for reserving resources: VMs
Operation complexity | No user administration is required | The system is administered by the user, Yandex Cloud is only responsible for the infrastructure
Scaling | Without service interruption (currently, the system can only be scaled up) | With service interruption while restarting a cluster
Integration with Yandex Cloud | High: {{ sf-name }} triggers, {{ api-gw-name }}, and so on |Basic
Security | Authorization using an IAM token and an access key | Username and password based authorization
Reliability | High, data is stored in three availability zones | High, customized by the user
Message delivery time | Less than a second | Less than a second
Data retention period | Set at creation, 1-24 hours | Limited by VM disk capacity
Customizability | Basic parameters | High if the settings are supported in Yandex Cloud

## Setup {#setup}

To set up data transfer between components:

1. [Create a data stream](../../data-streams/quickstart/create-stream.md) {{ yds-short-name }}.
1. [Configure](../../data-streams/quickstart/index.md) the AWS SDK.
1. Use SDKs:
    * [Go](https://docs.aws.amazon.com/sdk-for-go/api/service/kinesis/).
    * [C++](https://sdk.amazonaws.com/cpp/api/LATEST/class_aws_1_1_kinesis_1_1_kinesis_client.html).
    * [Java](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/kinesis/AmazonKinesisClient.html).
    * [JavaScript](https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-kinesis/index.html).
    * [Python](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/kinesis.html).
    * [HTTP Kinesis Data Streams API](../../data-streams/kinesisapi/api-ref.md).
