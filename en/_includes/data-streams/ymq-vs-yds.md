# Comparison of data exchange buses and data streams

{{ yandex-cloud }} uses {{ message-queue-full-name }} and {{ yds-full-name }} for exchanging data. Both services perform similar tasks, but are designed for different use cases:

* {{ message-queue-full-name }} is focused on messaging between components of distributed applications.
* {{ yds-full-name }} is designed for transmitting data streams (such as logs of application operation or user actions, database CDC streams, or data from devices) for their processing by applications.

## {{ message-queue-full-name }}

Messaging buses are focused on delivering separate, independent messages to application components (handlers) and implement a task processing queue scenario. Tasks are enqueued and a handler takes them from this queue and executes them. Only one application can read messages from a single queue. A handler may have multiple instances running at the same time.

Messaging buses are suitable for processing a set of independent tasks, each of which can be performed by any handler. The main thing is that an event is processed, no matter in what order.

For example, message queues are used by [search robots]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Поисковый_робот){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Web_crawler){% endif %}. A web crawler finds page URLs and enqueues them. Parsers get these URLs, download the pages, and perform processing. A message queue acts as a task queue, increasing the fault tolerance and scalability of a system like this.

## {{ yds-full-name }}

{{ yds-full-name }} is designed to transmit data streams, rather than individual messages, to applications. The throughput of processed data streams can range from kilobytes to terabytes or more per hour.

Data in {{ yds-full-name }} is transmitted through streams that consist of shards. All incoming records have keys that identify which shard the data will get into. Within a single shard, the data is read as it is written.

In {{ yds-full-name }}, unlike {{ message-queue-full-name }}, different applications can simultaneously read data from the same stream. At the same time, each application can read data from an arbitrary position.

Reading data simultaneously by different applications may be necessary in the following cases:

* When the same data needs to be processed by multiple applications at once.
* To protect against errors. If an error occurs in the handler, you can fix it and recalculate the enqueued data properly.
* When launching a new application. When developing a new application version, you can run it in parallel with the main one and test it on real data.

You can transmit any data via data buses, but most often these are application logs, user action logs, or data from devices. {{ yds-full-name }} supports an HTTP API to exchange data.

## Comparison of {{ message-queue-full-name }} and {{ yds-full-name }}

Parameter | {{ message-queue-full-name }} | {{ yds-full-name }}
--|--|--
Basic scenario| A queue of tasks across application components | Transferring data across applications, delivering data to storage systems {{ yandex-cloud }}
Data recipient | Components of a single application | Independent applications
Guarantees | [At least once](https://www.cloudcomputingpatterns.org/at_least_once_delivery/) for regular queues, [exactly once](https://www.cloudcomputingpatterns.org/exactly_once_delivery/) for FIFO queues | At least once
Order of receiving messages| Guaranteed for FIFO queues and not guaranteed for regular queues | Guaranteed
Throughput | Up to 300 messages per second for regular queues and up to 30 messages per second for FIFO queues | Not limited, depends on the number of shards
What you pay for | Message write and read requests | Shards, their performance, and the amount of data stored
Supported protocol | [Amazon SQS API](../../message-queue/api-ref/index.md) | [Amazon Kinesis Data Streams API](../../data-streams/kinesisapi/api-ref.md)
Which {{ yandex-cloud }} services integration is available for | [{{ sf-full-name }}](../../functions/), [{{ api-gw-full-name }}](../../api-gateway/) | [{{ sf-full-name }}](../../functions/), [{{ api-gw-full-name }}](../../api-gateway/), [{{ data-transfer-full-name }}](../../data-transfer/)
Reliability | Data is stored in all availability zones | Data is stored in all availability zones
Scalability for reads | Server | Client ([KCL](https://docs.aws.amazon.com/streams/latest/dev/shared-throughput-kcl-consumers.html)). KCL 1.x versions are supported