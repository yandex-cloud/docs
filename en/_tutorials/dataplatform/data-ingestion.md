# Ingesting data into storage systems

Mobile phones, various smart devices, and external services are increasingly replacing application components as data sources.

Such sources supply data in massive numbers of small batches. The communication circuits used for transmission are often slow, and the communication time limited. Under such conditions, you want to quickly save the data you receive. Its processing can wait till later. That is why the system first sends the data to data streaming buses and then pulls it from there for processing.

Acting like a streaming bus, {{ yds-full-name }} provides optimal operating conditions for both sources and targets:

* Receives high-frequency and high-speed incoming data without blocking the sources.
* Saves the received data in its own storage.
* Groups data into batches and sends them to the target systems, thus reducing their load.

![data-ingestion](../../_assets/data-streams/data-ingestion.svg)


## Benefits {#advantages}

When working with external devices or services, you want to quickly save the data you receive. You can fetch the saved data from {{ yds-short-name }} through direct reads or by setting up data delivery to {{ yandex-cloud }} storage systems using {{ data-transfer-full-name }}.


### Receiving data {#receiving}

{{ yds-short-name }} receives data over [HTTP](../../data-streams/kinesisapi/api-ref.md). Using [{{ api-gw-full-name }}](/services/api-gateway), you can implement any data ingestion protocol. After ingestion in {{ api-gw-name }}, the data is ready to move to {{ yds-short-name }}.

{{ yds-short-name }} is highly scalable and can accept data from thousands of data sources at the same time.


### Reliability {#reliability}

A data streaming bus is a critical infrastructure component that is tolerant to all kinds of {{ yandex-cloud }} failures. {{ yds-short-name }} stores ingested data across at least three {{ yandex-cloud }} availability zones.


### Batching {#batching}

Data storage and processing systems perform best when data is written in batches. Data batching is most effective at a single point where all your data flows together. Data buses typically serve as that single point.


### Rewinding data {#rewind}

Unlike message queues, data buses store data until the retention period expires without deleting the data after it is read. This allows you to move across the stored data in any direction: from the oldest to the most recent. For example, if a new data format appears and gets written to the target system incorrectly, you can rewind the data stored in the bus to the beginning and then reread and rewrite it to the target system correctly.


### Multiple storage systems {#multiple}

The same data is often stored across multiple storage systems at once: {{ CH }} manages rapid analytics, while {{ objstorage-name }}, long-term storage. With data buses, you can easily handle this: as different apps can read data concurrently, you can set up sending the same data to both storage systems, i.e., {{ CH }} and {{ objstorage-name }}. This solution will also enable you to add a third storage system, such as {{ GP }} or {{ ES }}, at any time.

The multiple storage system approach is very convenient for ensuring compliance with FZ-152, PCI DSS, and other standards that require data retention for at least one year. In which case, while the last month's data goes to a quick access storage system, the rest of the data may be sent to a long-term "cold" storage in {{ objstorage-name }}.


### Masking data and processing logs {#mask}

Data access is limited across employees. For example, certain data may include personal user information that requires restricted access.

You can send the data to {{ sf-name }} for masking or any additional processing as needed.

Once processed, the data can be sent to multiple target systems at once: access to the data containing masked personal data can be granted to all employees, while access to the full data, to administrators only.


### Reading data {#read}

{{ yds-short-name }} supports automatic processing of stored data through code. {{ yds-short-name }} is compatible with the Amazon Kinesis Data Streams API, allowing you to use SDKs for different programming languages: C++, Java, Go, Python, and more.


## Setup {#setup}

To set up data ingestion into storage systems:

1. [Create a data stream](../../data-streams/quickstart/create-stream.md) in {{ yds-short-name }}.
1. [Configure](../../data-streams/quickstart/index.md) the AWS SDK.
1. Configure {{ data-transfer-full-name }} to transfer data to the selected storage system.

    For an example of setting up data delivery from {{ yds-short-name }}, see the [tutorial on how to save data to {{ CH }}](../../data-streams/tutorials/send-to-clickhouse.md).

1. Connect any data processing function to {{ data-transfer-full-name }}. [This GitHub example](https://github.com/yandex-cloud-examples/yc-nginx-logs-data-transfer) illustrates the function code. Alternatively, you can use the SDK to read data directly from {{ yds-short-name }}:

    * [Go](https://docs.aws.amazon.com/sdk-for-go/api/service/kinesis/)
    * [C++](https://sdk.amazonaws.com/cpp/api/LATEST/class_aws_1_1_kinesis_1_1_kinesis_client.html)
    * [Java](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/kinesis/AmazonKinesisClient.html)
    * [JavaScript](https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-kinesis/index.html)
    * [Python](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/kinesis.html)
    * [HTTP Kinesis Data Streams API](../../data-streams/kinesisapi/api-ref.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}