# Comparison of data exchange buses and data streams

The services of data buses and data streams solve similar tasks, but in different use cases:

* {{ message-queue-full-name }} is focused on messaging between components of distributed applications.
* {{ yds-full-name }} is designed for transmitting data streams (such as logs of application operation or user actions, database CDC streams, or data from devices) for their processing by applications.

## {{ message-queue-full-name }}

Messaging buses help deliver separate, independent messages to application components (handlers) and function as a task processing queue. Tasks are enqueued and then picked up by a handler to run. Only one application can read messages from a single queue. A handler may have multiple instances running at the same time.

Messaging buses are suitable for processing independent tasks, each of which can be run by any handler. The main thing is that an event is processed, no matter in what order.

E.g., [web crawlers](https://en.wikipedia.org/wiki/Web_crawler) use message queues. A web crawler finds page URLs and enqueues them. Parsers get these URLs, download the pages, and process them. A message queue acts as a task queue, boosting the fault tolerance and scalability of such a system.

## {{ yds-full-name }}

{{ yds-full-name }} is designed to transmit data streams, rather than individual messages, to applications. The throughput of processed data streams may range from kilobytes to terabytes or more per hour.

Data in {{ yds-full-name }} is transmitted through streams that consist of shards. All incoming records have keys that identify which shard the data will get into. Within a single shard, the data is read as it is written.

In {{ yds-full-name }}, unlike {{ message-queue-full-name }}, different applications can simultaneously read data from the same stream. At the same time, each application can read data from any position.

Reading data simultaneously by different applications may be necessary in the following cases:

* When you need to process the same data by multiple applications at once.
* To protect against errors. If an error occurs in the handler, you can fix it and recalculate the enqueued data properly.
* When launching a new application. When developing a new application version, you can run it in parallel with the main one and test it on real data.

You can transmit any data via data buses, but most often these are application logs, user action logs, or data from devices. {{ yds-full-name }} supports an HTTP API to exchange data.

## {{ message-queue-full-name }} and {{ yds-full-name }} comparison

Parameter | {{ message-queue-full-name }} | {{ yds-full-name }}
--|--|--
Primary use case | Task queue for application components | Transmitting data from one application to another, delivering data to {{ yandex-cloud }} data storages
Who receives data| Components of a single application | Independent applications
Guarantees | [At least once](https://www.cloudcomputingpatterns.org/at_least_once_delivery/) for a standard queue; [exactly once](https://www.cloudcomputingpatterns.org/exactly_once_delivery/) for a FIFO queue | At least once
Message order | Guaranteed for a FIFO queue; not guaranteed for a standard queue | Guaranteed
Throughput | Up to 300 messages per second for a standard queue; up to 30 messages per second for a FIFO queue | Not limited and defined by the number of shards
What you pay for | Queries to read and write messages | Shards, speed per shard, and amount of stored data
Supported protocol | [Amazon SQS API](../../message-queue/api-ref/index.md) | [Amazon Kinesis Data Streams API](../../data-streams/kinesisapi/api-ref.md)
{{ yandex-cloud }} service integration | [{{ sf-full-name }}](../../functions/), [{{ api-gw-full-name }}](../../api-gateway/) | [{{ sf-full-name }}](../../functions/), [{{ api-gw-full-name }}](../../api-gateway/), [{{ data-transfer-full-name }}](../../data-transfer/)
Reliability | Data is stored in all availability zones. | Data is stored in all availability zones.
Scalability in terms of read access | Server | Client ([KCL](https://docs.aws.amazon.com/streams/latest/dev/shared-throughput-kcl-consumers.html)). KCL 1.x versions are supported.
