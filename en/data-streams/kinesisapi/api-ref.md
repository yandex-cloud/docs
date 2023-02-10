# All methods

The {{yds-full-name}} HTTP API compatible with the [Amazon Kinesis Data Streams API](https://docs.aws.amazon.com/kinesis/latest/APIReference/Welcome.html) provides the following methods:

| AWS Kinesis API</br>method | Description | Comment |
| --- | --- | --- |
| AddTagsToStream | Adds or updates tags for the specified data stream. | Not&nbsp;supported by {{ yds-full-name }}. |
| [CreateStream](methods/createstream.md) | Creates a [stream](../concepts/glossary.md#stream-concepts). |
| [DecreaseStreamRetentionPeriod](methods/decreasetreamretentionperiod.md) | Decreases the [retention period](../concepts/glossary.md#retention-time) for messages in a stream.</br>Possible values: 4 hours, 12 hours, 24 hours. |
| [DeleteStream](methods/deletestream.md) | Deletes a stream and all of its [shards](../concepts/glossary.md#shard) and data. |
| DeregisterStreamConsumer | Deregisters the specified stream consumer. | Not&nbsp;supported by {{ yds-full-name }}. |
| DescribeLimits | Describes shard limits. | Not&nbsp;supported by {{ yds-full-name }}. |
| [DescribeStream](methods/describestream.md) | Gets a description of the specified stream. |
| DescribeStreamConsumer | Gets a description of the specified registered consumer. | Not&nbsp;supported by {{ yds-full-name }}. |
| DescribeStreamSummary | Gets a summary of the specified stream without a list of shards. | Not&nbsp;supported by {{ yds-full-name }}. |
| DisableEnhancedMonitoring | Disables enhanced monitoring. | Not&nbsp;supported by {{ yds-full-name }}. |
| EnableEnhancedMonitoring | Enables enhanced stream monitoring for shard-level metrics. | Not&nbsp;supported by {{ yds-full-name }}. |
| [GetRecords](methods/getrecords.md) | Gets messages from a stream. |
| [GetShardIterator](methods/getsharditerator.md) | Gets the value of an iterator. |
| [IncreaseStreamRetentionPeriod](methods/increasestreamretentionperiod.md) | Increases the retention period for messages in a stream.</br>Possible values: 4 hours, 12 hours, 24 hours. |
| ListShards | Outputs a list of shards and information about them. | Not&nbsp;supported by {{ yds-full-name }}. |
| ListStreamConsumers | Outputs a list of the consumers registered to receive data from a stream and provides information about them. | Not&nbsp;supported by {{ yds-full-name }}. |
| [ListStreams](methods/liststreams.md) | Outputs a list of streams. |
| ListTagsForStream | Outputs a list of tags for the specified stream. | Not&nbsp;supported by {{ yds-full-name }}. |
| MergeShards | Merges two adjacent stream shards into one. | Not&nbsp;supported by {{ yds-full-name }}. |
| [PutRecord](methods/putrecord.md) | Puts one [message](../concepts/glossary.md#message) into a stream. |
| [PutRecords](methods/putrecords.md) | Puts multiple messages into a stream. |
| RegisterStreamConsumer | Registers a given stream consumer. | Not&nbsp;supported by {{ yds-full-name }}. |
| RemoveTagsFromStream | Removes tags from a stream. | Not&nbsp;supported by {{ yds-full-name }}. |
| SplitShard | Splits a stream shard into two new shards. | Not&nbsp;supported by {{ yds-full-name }}. |
| StartStreamEncryption | Enables or updates server-side encryption using an AWS KMS key for a given stream. | Not&nbsp;supported by {{ yds-full-name }}. |
| StopStreamEncryption | Disables server-side encryption for a given stream. | Not&nbsp;supported by {{ yds-full-name }}. |
| SubscribeToShard | Establishes a connection between the specified consumer and shard. | Not&nbsp;supported by {{ yds-full-name }}. |
| [UpdateShardCount](methods/updateshardcount.md) | Updates the number of shards in the specified stream.</br>Only an increase in the shard count is allowed. |