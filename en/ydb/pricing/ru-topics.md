---
title: Estimating the cost of topic operations in {{ ydb-full-name }}
description: In this article, you will learn how to calculate the cost of topic operations.
editable: false
---

# Estimating the cost of topic operations



## Pricing modes

The pricing for data operations in [{{ ydb-short-name }} topics]({{ ydb.docs }}/concepts/topic) using {{ ydb-short-name }} request units (RUs) applies to the topics with the _on-demand pricing mode_. In this mode, topics are created by default via the {{ ydb-short-name }} CLI/SDK as well as when creating a [CDC feed]({{ ydb.docs }}/concepts/cdc).

If you create a topic as a storage for a {{ yds-short-name }} [stream](../../data-streams/concepts/glossary.md#stream-concepts), [_pricing based on dedicated resources_](../../data-streams/pricing.md#rules) applies to it by default. For the topics with pricing based on dedicated resources, no {{ ydb-short-name }} RUs are charged. You pay for the resource usage on an hourly basis within {{ yds-full-name }}.

You can change any topic's pricing mode by explicitly calling the [ydb topic alter]({{ ydb.docs }}/reference/ydb-cli/topic-alter) {{ ydb-short-name }} CLI command or SDK method.

## Calculation of RU consumption {#rules}

For topics with on-demand pricing, {{ ydb-short-name }} calculates the cost of operations in RUs as follows.

### TopicAPI {#topic-api}

`TopicAPI` is used when working with the {{ ydb-short-name }} SDK and CLI. It provides methods for streaming data reads and writes. The cost of calling these methods in RUs is calculated as explained below:

1. Each data read or write method call, i.e., opening a data read or write stream, costs 1 RU.
1. Within each streaming data transfer method (session) opened, a certain amount of transferred (written or read) data is accumulated. Once this amount exceeds the established block limits, 1 RU is additionally charged per block. The block sizes for reads and writes are different:

    Type | Block size
    --- | ---
    Reads | 8 KB
    Writes | 4 KB

**Calculation example**

1. Let’s assume a new streaming write method is called. At that point, 1 RU is charged.
1. Within this method, a 1 KB batch of data to write is transferred. Since the 4 KB write block limit is not exceeded, no additional RUs are charged.
1. Within this method, a 8 KB batch of data to write is transferred. The total amount of data transferred within the method call is now 9 KB, including two blocks of 4 KB each. This means 2 RUs are charged, 1 RU per block.
1. Within this method, a 6 KB batch of data to write is transferred. The total amount of data transferred within the method call is now 15 KB, including three data blocks of 4 KB each. This costs 3 RUs. As 2 RUs were transferred before, the difference is transferred now: 3 RUs - 2 RUs = 1 RU.

The data reads are calculated in a similar way; the only difference is that the block size is 8 KB.

### DataStreamsAPI {#data-streams-api}

`DataStreamsAPI` is used when accessing a topic via the data streams interface that is compatible with AWS Kinesis. This interface does not support streaming read and write methods. Therefore, to transfer each data block, you need to call a separate unary method (request-response). The cost of calling these methods in RUs is calculated as explained below:

1. Each data read or write method call for transferring or receiving a new data block costs 1 RU.
1. What is calculated here is the amount of data blocks transferred in a request to the write method or received in response to the read method call. The block sizes for reads and writes are different:

    Type | Block size
    --- | ---
    Reads | 8 KB
    Writes | 4 KB

1. 1 RU is charged for each complete data block transferred.

**Calculation example**

1. Let’s assume the `getRecords` KinesisAPI method is called.
1. A 20 KB batch of data is received in response. The batch contains two complete read blocks, 8 KB each.
1. The cost of method call in RU is 1 RU per call plus 2 RUs for two complete data blocks received, which equals 3 RUs.

### KafkaAPI {#kafka-api}

`KafkaAPI` does not support streaming read and write methods. To transfer each data block, you need to call a separate unary method (request-response). The cost of calling these methods in RUs is calculated as explained below:

1. Each data read or write method call to transfer or receive the next data block costs 1 RU (effective as of July 1, 2024).
1. What is calculated here is the amount of data blocks transferred in a request to the write method or received in response to the read method call. The block sizes for read and write operations are different:

    Type | Block size
    --- | ---
    Reads | 8 KB
    Writes | 4 KB

1. 1 RU is charged for each complete data block transferred.

**Calculation example**

1. Let’s assume the `FETCH` KafkaAPI method is called.
1. A 20 KB batch of data is received in response. The batch contains two complete read blocks, 8 KB each.
1. The cost of method call in RU is 1 RU per call plus 2 RUs for two complete data blocks received, which equals 3 RUs.


The data writes are calculated in a similar way; the only difference is that the block size is 4 KB.
