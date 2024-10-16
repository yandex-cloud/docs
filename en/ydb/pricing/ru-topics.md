---
title: Rules for estimating the cost of topic operations in {{ ydb-full-name }}
description: In this tutorial, you will learn how to calculate the cost of topic operations.
---

# Rules for estimating the cost of topic operations



## Pricing modes

Pricing for operations with data in [{{ ydb-short-name }} topics](https://ydb.tech/docs/en/concepts/topic) using {{ ydb-short-name }} Request Units applies to topics with _On-demand pricing mode_. In this mode, topics are by default created via the {{ ydb-short-name }} CLI/SDK and while creating a [CDC stream](https://ydb.tech/docs/en/concepts/cdc).

If you create a topic as storage for a {{ yds-short-name }} [stream](../../data-streams/concepts/glossary.md#stream-concepts), [_pricing based on allocated resources_](../../data-streams/pricing.md#rules) applies to it by default. For topics with pricing for allocated resources, no {{ ydb-short-name }} Request Units are charged. You pay for resource usage on an hourly basis within {{ yds-full-name }}.

You can change any topic's pricing mode by explicitly running the [ydb topic alter](https://ydb.tech/docs/en/reference/ydb-cli/topic-alter) {{ ydb-short-name }} CLI command or SDK method.

## Calculation of Request Unit usage {#rules}

For topics with on-demand pricing, {{ ydb-short-name }} calculates the cost of operations in Request Units as follows.

### TopicAPI {#topic-api}

The TopicAPI is used when working with the {{ ydb-short-name }} SDK and CLI. It provides methods for streaming data reads and writes. The cost of calling these methods in Request Units (RU) is calculated as explained below:

1. Each data read or write method call, that is, opening a data read or write stream, costs 1 RU.
1. Within each streaming data transfer method (session) opened, a certain volume of transferred (written or read) data is accumulated. Once this volume exceeds the established block limits, 1 RU is additionally charged per block. The block sizes for reads and writes differ:

   | Direction | Block size |
   --- | ---
   | Reads | 8 KB |
   | Writes | 4 KB |

**Calculation example**

1. A new streaming write method is called. 1 RU is charged at that point.
1. Within this method, a 1 KB batch of data to be written is transferred. Since the 4 KB write block limit is not exceeded, no additional RUs are charged.
1. Within this method, an 8 KB batch of data to be written is transferred. The total amount of data transferred within the method call is now 9 KB, including 2 blocks of 4 KB each. 2 RUs are charged, 1 RU per block.
1. Within this method, a 6 KB batch of data to be written is transferred. The total amount of data transferred within the method call is now 15 KB, including 3 data blocks of 4 KB each. This costs 3 RUs. As 2 RUs were transferred before, the difference is transferred now: 3 RUs - 2 RUs = 1 RU.

Calculation for data reads is performed in a similar way, but for an 8 KB block.

### DataStreamsAPI {#data-streams-api}

The DataStreamsAPI is used when accessing a topic through the data streams interface that is compatible with AWS Kinesis. This interface does not support streaming reads and writes. Therefore, to transfer each data block, you need to call an individual unary method (request-response). The cost of calling these methods in Request Units (RU) is calculated as explained below:

1. Each data read or write method call for transferring or receiving a new data block costs 1 RU.
1. The volume of data blocks transferred in a request to the write method or received in response to the read method call is calculated. The block sizes for reads and writes differ:

   | Direction | Block size |
   --- | ---
   | Reads | 8 KB |
   | Writes | 4 KB |

1. 1 RU is charged for each complete data block transferred.

**Calculation example**

1. The `getRecords` KinesisAPI method is called.
1. A 20 KB batch of data is received in response. The batch contains two complete read blocks, 8 KB each.
1. The cost of method call in RU = 1 RU per call + 2 RUs for two complete data blocks received = 3 RUs.

### KafkaAPI {#kafka-api}

The KafkaAPI does not support streaming reads and writes. To transfer each data block, a separate unary method (request-response) has to be called. The cost of calling these methods in Request Units (RU) is calculated as explained below:

1. Each data read or write method call to transfer or receive the next data block costs 1 RU (effective as of July 1, 2024).
1. The volume of data blocks transferred in a request to the write method or received in response to the read method call is calculated. The block sizes for read and write operations differ:

   | Direction | Block size |
   --- | ---
   | Reads | 8 KB |
   | Writes | 4 KB |

1. 1 RU is charged for each complete data block transferred.

**Calculation example**

1. The `FETCH` KafkaAPI method is called.
1. A 20 KB batch of data is received in response. The batch contains two complete read blocks, 8 KB each.
1. The cost of method call in RU = 1 RU per call + 2 RUs for two complete data blocks received = 3 RUs.


Calculation for data writes is performed in a similar way, but for a 4 KB block.
