---
title: All {{ yds-full-name }} HTTP API methods
description: Learn about available {{ yds-full-name }} HTTP API methods.
---

# All methods

The {{ yds-full-name }} HTTP API is compatible with the [Amazon Kinesis Data Streams API](https://docs.aws.amazon.com/kinesis/latest/APIReference/Welcome.html) and provides the following methods:

Method name</br>AWS Kinesis API | Description | Note
--- | --- | ---
AddTagsToStream | Adds or updates tags for the specified data stream. | Not&nbsp;supported by {{ yds-full-name }}.
[CreateStream](methods/createstream.md) | Creates a [data stream](../concepts/glossary.md#stream-concepts). |
[DecreaseStreamRetentionPeriod](methods/decreasetreamretentionperiod.md) | Decreases the [record retention period](../concepts/glossary.md#retention-time) in a data stream.</br>Available retention period options: 4 hours, 12 hours, 24 hours |
[DeleteStream](methods/deletestream.md) | Deletes a data stream, including all its [shards](../concepts/glossary.md#shard) and data. |
DeregisterStreamConsumer | Deregisters the specified stream consumer. | Not&nbsp;supported by {{ yds-full-name }}.
DescribeLimits | Describes shard-level limits. | Not&nbsp;supported by {{ yds-full-name }}.
[DescribeStream](methods/describestream.md) | Retrieves the description of the specified data stream. |
DescribeStreamConsumer | Retrieves the description of the specified registered consumer. | Not&nbsp;supported by {{ yds-full-name }}.
DescribeStreamSummary | Retrieves a summary of the specified stream without shard details. | Not&nbsp;supported by {{ yds-full-name }}.
DisableEnhancedMonitoring | Disables enhanced monitoring. | Not&nbsp;supported by {{ yds-full-name }}.
EnableEnhancedMonitoring | Enables enhanced stream monitoring with shard-level metrics. | Not&nbsp;supported by {{ yds-full-name }}.
[GetRecords](methods/getrecords.md) | Retrieves records from a stream. |
[GetShardIterator](methods/getsharditerator.md) | Retrieves the iterator value. |
[IncreaseStreamRetentionPeriod](methods/increasestreamretentionperiod.md) | Increases the record retention period in a data stream</br>Available retention period options: 4 hours, 12 hours, 24 hours |
ListShards | Lists shards and their details. | Not&nbsp;supported by {{ yds-full-name }}.
ListStreamConsumers | Lists registered data stream consumers and their details. | Not&nbsp;supported by {{ yds-full-name }}.
[ListStreams](methods/liststreams.md) | Lists data streams. |
ListTagsForStream | Lists tags for the specified stream. | Not&nbsp;supported by {{ yds-full-name }}.
MergeShards | Merges two adjacent shards in a stream. | Not&nbsp;supported by {{ yds-full-name }}.
[PutRecord](methods/putrecord.md) | Puts one [record](../concepts/glossary.md#message) into a data stream. |
[PutRecords](methods/putrecords.md) | Puts multiple records into a data stream. |
RegisterStreamConsumer | Registers a dedicated stream consumer. | Not&nbsp;supported by {{ yds-full-name }}.
RemoveTagsFromStream | Removes tags from a stream. | Not&nbsp;supported by {{ yds-full-name }}.
SplitShard | Splits a shard into two new shards. | Not&nbsp;supported by {{ yds-full-name }}.
StartStreamEncryption | Enables or updates server-side encryption using an AWS KMS key for the specified stream. | Not&nbsp;supported by {{ yds-full-name }}.
StopStreamEncryption | Disables server-side encryption for the specified stream. | Not&nbsp;supported by {{ yds-full-name }}.
SubscribeToShard | Establishes a connection between a dedicated consumer and a shard. | Not&nbsp;supported by {{ yds-full-name }}.
[UpdateShardCount](methods/updateshardcount.md) | Updates the number of shards in the specified stream.</br>Only shard count increases are allowed. |