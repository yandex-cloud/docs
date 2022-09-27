---
editable: false
sourcePath: en/_api-ref/mdb/kafka/api-ref/Cluster/list.md
---

# Method list
Retrieves the list of Apache Kafka® clusters that belong to the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-kafka/v1/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list Apache Kafka® clusters in.</p> <p>To get the folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-kafka/api-ref/Cluster/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-kafka/api-ref/Cluster/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token.</p> <p>To get the next page of results, set <a href="/docs/managed-kafka/api-ref/Cluster/list#query_params">pageToken</a> to the <a href="/docs/managed-kafka/api-ref/Cluster/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>Filter support is not currently implemented. Any filters are ignored.</p> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "clusters": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "environment": "string",
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "config": {
        "version": "string",
        "kafka": {
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },

          // `clusters[].config.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`, `kafkaConfig_2_8`, `kafkaConfig_3`
          "kafkaConfig_2_1": {
            "compressionType": "string",
            "logFlushIntervalMessages": "integer",
            "logFlushIntervalMs": "integer",
            "logFlushSchedulerIntervalMs": "integer",
            "logRetentionBytes": "integer",
            "logRetentionHours": "integer",
            "logRetentionMinutes": "integer",
            "logRetentionMs": "integer",
            "logSegmentBytes": "integer",
            "logPreallocate": true,
            "socketSendBufferBytes": "integer",
            "socketReceiveBufferBytes": "integer",
            "autoCreateTopicsEnable": true,
            "numPartitions": "integer",
            "defaultReplicationFactor": "integer",
            "messageMaxBytes": "integer",
            "replicaFetchMaxBytes": "integer",
            "sslCipherSuites": [
              "string"
            ],
            "offsetsRetentionMinutes": "integer"
          },
          "kafkaConfig_2_6": {
            "compressionType": "string",
            "logFlushIntervalMessages": "integer",
            "logFlushIntervalMs": "integer",
            "logFlushSchedulerIntervalMs": "integer",
            "logRetentionBytes": "integer",
            "logRetentionHours": "integer",
            "logRetentionMinutes": "integer",
            "logRetentionMs": "integer",
            "logSegmentBytes": "integer",
            "logPreallocate": true,
            "socketSendBufferBytes": "integer",
            "socketReceiveBufferBytes": "integer",
            "autoCreateTopicsEnable": true,
            "numPartitions": "integer",
            "defaultReplicationFactor": "integer",
            "messageMaxBytes": "integer",
            "replicaFetchMaxBytes": "integer",
            "sslCipherSuites": [
              "string"
            ],
            "offsetsRetentionMinutes": "integer"
          },
          "kafkaConfig_2_8": {
            "compressionType": "string",
            "logFlushIntervalMessages": "integer",
            "logFlushIntervalMs": "integer",
            "logFlushSchedulerIntervalMs": "integer",
            "logRetentionBytes": "integer",
            "logRetentionHours": "integer",
            "logRetentionMinutes": "integer",
            "logRetentionMs": "integer",
            "logSegmentBytes": "integer",
            "logPreallocate": true,
            "socketSendBufferBytes": "integer",
            "socketReceiveBufferBytes": "integer",
            "autoCreateTopicsEnable": true,
            "numPartitions": "integer",
            "defaultReplicationFactor": "integer",
            "messageMaxBytes": "integer",
            "replicaFetchMaxBytes": "integer",
            "sslCipherSuites": [
              "string"
            ],
            "offsetsRetentionMinutes": "integer"
          },
          "kafkaConfig_3": {
            "compressionType": "string",
            "logFlushIntervalMessages": "integer",
            "logFlushIntervalMs": "integer",
            "logFlushSchedulerIntervalMs": "integer",
            "logRetentionBytes": "integer",
            "logRetentionHours": "integer",
            "logRetentionMinutes": "integer",
            "logRetentionMs": "integer",
            "logSegmentBytes": "integer",
            "logPreallocate": true,
            "socketSendBufferBytes": "integer",
            "socketReceiveBufferBytes": "integer",
            "autoCreateTopicsEnable": true,
            "numPartitions": "integer",
            "defaultReplicationFactor": "integer",
            "messageMaxBytes": "integer",
            "replicaFetchMaxBytes": "integer",
            "sslCipherSuites": [
              "string"
            ],
            "offsetsRetentionMinutes": "integer"
          },
          // end of the list of possible fields`clusters[].config.kafka`

        },
        "zookeeper": {
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          }
        },
        "zoneId": [
          "string"
        ],
        "brokersCount": "integer",
        "assignPublicIp": true,
        "unmanagedTopics": true,
        "schemaRegistry": true,
        "access": {
          "dataTransfer": true
        }
      },
      "networkId": "string",
      "health": "string",
      "status": "string",
      "securityGroupIds": [
        "string"
      ],
      "hostGroupIds": [
        "string"
      ],
      "deletionProtection": true,
      "maintenanceWindow": {

        // `clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
        "anytime": {},
        "weeklyMaintenanceWindow": {
          "day": "string",
          "hour": "string"
        },
        // end of the list of possible fields`clusters[].maintenanceWindow`

      },
      "plannedOperation": {
        "info": "string",
        "delayedUntil": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clusters[] | **object**<br><p>List of Apache Kafka® clusters.</p> 
clusters[].<br>id | **string**<br><p>ID of the Apache Kafka® cluster. This ID is assigned at creation time.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the Apache Kafka® cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>name | **string**<br><p>Name of the Apache Kafka® cluster. The name must be unique within the folder. 1-63 characters long. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
clusters[].<br>description | **string**<br><p>Description of the Apache Kafka® cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Custom labels for the Apache Kafka® cluster as ``key:value`` pairs. A maximum of 64 labels per resource is allowed.</p> 
clusters[].<br>environment | **string**<br><p>Deployment environment of the Apache Kafka® cluster.</p> <ul> <li>PRODUCTION: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Description of monitoring systems relevant to the Apache Kafka® cluster.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the Apache Kafka® cluster.</p> 
clusters[].<br>config | **object**<br><p>Configuration of the Apache Kafka® cluster.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Version of Apache Kafka® used in the cluster. Possible values: ``2.1``, ``2.6``.</p> 
clusters[].<br>config.<br>kafka | **object**<br><p>Configuration and resource allocation for Kafka brokers.</p> 
clusters[].<br>config.<br>kafka.<br>resources | **object**<br>Resources allocated to Kafka brokers.
clusters[].<br>config.<br>kafka.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
clusters[].<br>config.<br>kafka.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted.</p> 
clusters[].<br>config.<br>kafka.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1 | **object** <br>`clusters[].config.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`, `kafkaConfig_2_8`, `kafkaConfig_3`<br><br><p>Kafka version 2.1 broker configuration.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>compressionType | **string**<br><p>Cluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMessages`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of ``logFlushSchedulerIntervalMs`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMs`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if ``delete`` ``cleanupPolicy`` is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionBytes`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionHours`` is used.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionMinutes`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionMs`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logSegmentBytes | **integer** (int64)<br><p>The maximum size of a single log file.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``segmentBytes`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logPreallocate | **boolean** (boolean)<br><p>Should pre allocate file when create new segment?</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``preallocate`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>socketSendBufferBytes | **integer** (int64)<br><p>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>socketReceiveBufferBytes | **integer** (int64)<br><p>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>autoCreateTopicsEnable | **boolean** (boolean)<br><p>Enable auto creation of topic on the server</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>numPartitions | **integer** (int64)<br><p>Default number of partitions per topic on the whole cluster</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>defaultReplicationFactor | **integer** (int64)<br><p>Default replication factor of the topic on the whole cluster</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>messageMaxBytes | **integer** (int64)<br><p>The largest record batch size allowed by Kafka. Default value: 1048588.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>replicaFetchMaxBytes | **integer** (int64)<br><p>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>sslCipherSuites[] | **string**<br><p>A list of cipher suites.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>offsetsRetentionMinutes | **integer** (int64)<br><p>Offset storage time after a consumer group loses all its consumers. Default: 10080.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6 | **object** <br>`clusters[].config.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`, `kafkaConfig_2_8`, `kafkaConfig_3`<br><br><p>Kafka version 2.6 broker configuration.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>compressionType | **string**<br><p>Cluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMessages`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of ``logFlushSchedulerIntervalMs`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMs`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if ``delete`` ``cleanupPolicy`` is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionBytes`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionHours`` is used.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionMinutes`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionMs`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logSegmentBytes | **integer** (int64)<br><p>The maximum size of a single log file.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``segmentBytes`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logPreallocate | **boolean** (boolean)<br><p>Should pre allocate file when create new segment?</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``preallocate`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>socketSendBufferBytes | **integer** (int64)<br><p>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>socketReceiveBufferBytes | **integer** (int64)<br><p>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>autoCreateTopicsEnable | **boolean** (boolean)<br><p>Enable auto creation of topic on the server</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>numPartitions | **integer** (int64)<br><p>Default number of partitions per topic on the whole cluster</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>defaultReplicationFactor | **integer** (int64)<br><p>Default replication factor of the topic on the whole cluster</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>messageMaxBytes | **integer** (int64)<br><p>The largest record batch size allowed by Kafka. Default value: 1048588.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>replicaFetchMaxBytes | **integer** (int64)<br><p>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>sslCipherSuites[] | **string**<br><p>A list of cipher suites.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>offsetsRetentionMinutes | **integer** (int64)<br><p>Offset storage time after a consumer group loses all its consumers. Default: 10080.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8 | **object** <br>`clusters[].config.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`, `kafkaConfig_2_8`, `kafkaConfig_3`<br><br><p>Kafka version 2.8 broker configuration.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>compressionType | **string**<br><p>Cluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMessages`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of ``logFlushSchedulerIntervalMs`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMs`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if ``delete`` ``cleanupPolicy`` is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionBytes`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionHours`` is used.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionMinutes`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionMs`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>logSegmentBytes | **integer** (int64)<br><p>The maximum size of a single log file.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``segmentBytes`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>logPreallocate | **boolean** (boolean)<br><p>Should pre allocate file when create new segment?</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``preallocate`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>socketSendBufferBytes | **integer** (int64)<br><p>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>socketReceiveBufferBytes | **integer** (int64)<br><p>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>autoCreateTopicsEnable | **boolean** (boolean)<br><p>Enable auto creation of topic on the server</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>numPartitions | **integer** (int64)<br><p>Default number of partitions per topic on the whole cluster</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>defaultReplicationFactor | **integer** (int64)<br><p>Default replication factor of the topic on the whole cluster</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>messageMaxBytes | **integer** (int64)<br><p>The largest record batch size allowed by Kafka. Default value: 1048588.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>replicaFetchMaxBytes | **integer** (int64)<br><p>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>sslCipherSuites[] | **string**<br><p>A list of cipher suites.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_8.<br>offsetsRetentionMinutes | **integer** (int64)<br><p>Offset storage time after a consumer group loses all its consumers. Default: 10080.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3 | **object** <br>`clusters[].config.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`, `kafkaConfig_2_8`, `kafkaConfig_3`<br><br><p>Kafka version 3.x broker configuration.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>compressionType | **string**<br><p>Cluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMessages`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of ``logFlushSchedulerIntervalMs`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMs`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if ``delete`` ``cleanupPolicy`` is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionBytes`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionHours`` is used.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionMinutes`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionMs`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>logSegmentBytes | **integer** (int64)<br><p>The maximum size of a single log file.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``segmentBytes`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>logPreallocate | **boolean** (boolean)<br><p>Should pre allocate file when create new segment?</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``preallocate`` setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>socketSendBufferBytes | **integer** (int64)<br><p>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>socketReceiveBufferBytes | **integer** (int64)<br><p>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>autoCreateTopicsEnable | **boolean** (boolean)<br><p>Enable auto creation of topic on the server</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>numPartitions | **integer** (int64)<br><p>Default number of partitions per topic on the whole cluster</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>defaultReplicationFactor | **integer** (int64)<br><p>Default replication factor of the topic on the whole cluster</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>messageMaxBytes | **integer** (int64)<br><p>The largest record batch size allowed by Kafka. Default value: 1048588.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>replicaFetchMaxBytes | **integer** (int64)<br><p>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>sslCipherSuites[] | **string**<br><p>A list of cipher suites.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_3.<br>offsetsRetentionMinutes | **integer** (int64)<br><p>Offset storage time after a consumer group loses all its consumers. Default: 10080.</p> 
clusters[].<br>config.<br>zookeeper | **object**<br><p>Configuration and resource allocation for ZooKeeper hosts.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources | **object**<br><p>Resources allocated to ZooKeeper hosts.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
clusters[].<br>config.<br>zoneId[] | **string**<br><p>IDs of availability zones where Kafka brokers reside.</p> 
clusters[].<br>config.<br>brokersCount | **integer** (int64)<br><p>The number of Kafka brokers deployed in each availability zone.</p> 
clusters[].<br>config.<br>assignPublicIp | **boolean** (boolean)<br><p>The flag that defines whether a public IP address is assigned to the cluster. If the value is ``true``, then Apache Kafka® cluster is available on the Internet via it's public IP address.</p> 
clusters[].<br>config.<br>unmanagedTopics | **boolean** (boolean)<br><p>Allows to manage topics via AdminAPI</p> 
clusters[].<br>config.<br>schemaRegistry | **boolean** (boolean)<br><p>Enables managed schema registry on cluster</p> 
clusters[].<br>config.<br>access | **object**<br><p>Access policy for external services.</p> 
clusters[].<br>config.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Allow access for DataTransfer.</p> 
clusters[].<br>networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: state of the cluster is unknown (``health`` of all hosts in the cluster is ``UNKNOWN``).</li> <li>ALIVE: cluster is alive and well (``health`` of all hosts in the cluster is ``ALIVE``).</li> <li>DEAD: cluster is inoperable (``health`` of all hosts in the cluster is ``DEAD``).</li> <li>DEGRADED: cluster is in degraded state (``health`` of at least one of the hosts in the cluster is not ``ALIVE``).</li> </ul> 
clusters[].<br>status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: cluster state is unknown.</li> <li>CREATING: cluster is being created.</li> <li>RUNNING: cluster is running normally.</li> <li>ERROR: cluster encountered a problem and cannot operate.</li> <li>UPDATING: cluster is being updated.</li> <li>STOPPING: cluster is stopping.</li> <li>STOPPED: cluster stopped.</li> <li>STARTING: cluster is starting.</li> </ul> 
clusters[].<br>securityGroupIds[] | **string**<br><p>User security groups</p> 
clusters[].<br>hostGroupIds[] | **string**<br><p>Host groups hosting VMs of the cluster.</p> 
clusters[].<br>deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
clusters[].<br>maintenanceWindow | **object**<br><p>Window of maintenance operations.</p> 
clusters[].<br>maintenanceWindow.<br>anytime | **object** <br>`clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object** <br>`clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
clusters[].<br>plannedOperation | **object**<br><p>Scheduled maintenance operation.</p> 
clusters[].<br>plannedOperation.<br>info | **string**<br><p>The maximum string length in characters is 256.</p> 
clusters[].<br>plannedOperation.<br>delayedUntil | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-kafka/api-ref/Cluster/list#query_params">pageSize</a>, use <a href="/docs/managed-kafka/api-ref/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-kafka/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-kafka/api-ref/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 