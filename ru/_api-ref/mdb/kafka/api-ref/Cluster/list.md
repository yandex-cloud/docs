---
editable: false
---

# Метод list
Retrieves the list of Apache Kafka clusters that belong to the specified folder.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. ID of the folder to list Apache Kafka clusters in.  To get the folder ID, make a [list](/docs/resource-manager/api-ref/Folder/list) request.  Максимальная длина строки в символах — 50.
pageSize | The maximum number of results per page to return.  If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/managed-kafka/api-ref/Cluster/list#responses) that can be used to get the next page of results in subsequent list requests.  Максимальное значение — 1000.
pageToken | Page token.  To get the next page of results, set `page_token` to the [nextPageToken](/docs/managed-kafka/api-ref/Cluster/list#responses) returned by a previous list request.  Максимальная длина строки в символах — 100.
filter | A filter expression that filters resources listed in the response.  The expression must specify: 1. The field name to filter by. Currently you can only use filtering with the [Cluster.name](/docs/managed-kafka/api-ref/Cluster#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Мust be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`.  Example of a filter: `name NOT IN 'test,beta'`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
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
          "kafkaConfig_2_1": {
            "compressionType": "string",
            "logFlushIntervalMessages": "integer",
            "logFlushIntervalMs": "integer",
            "logFlushSchedulerIntervalMs": "integer",
            "logRetentionBytes": "integer",
            "logRetentionHours": "integer",
            "logRetentionMinutes": "integer",
            "logRetentionMs": "integer"
          }
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
        "assignPublicIp": true
      },
      "networkId": "string",
      "health": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
clusters[] | **object**<br><p>An Apache Kafka cluster resource. For more information, see the <a href="/docs/managed-kafka/concepts">Concepts</a> section of the documentation.</p> 
clusters[].<br>id | **string**<br><p>ID of the Apache Kafka cluster. This ID is assigned by MDB at creation time.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the Apache Kafka cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
clusters[].<br>name | **string**<br><p>Name of the Apache Kafka cluster. The name must be unique within the folder. 1-63 characters long.</p> 
clusters[].<br>description | **string**<br><p>Description of the Apache Kafka cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Custom labels for the Apache Kafka cluster as <code>key:value</code> pairs. A maximum of 64 labels per resource is allowed.</p> 
clusters[].<br>environment | **string**<br><p>Deployment environment of the Apache Kafka cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with a more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Monitoring system.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the Apache Kafka cluster.</p> 
clusters[].<br>config | **object**<br><p>Configuration of the Apache Kafka cluster.</p> <p>The cluster configuration.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Version of Apache Kafka used in the cluster.</p> 
clusters[].<br>config.<br>kafka | **object**<br><p>Configuration and resource allocation for Apache Kafka brokers.</p> <p>Apache Kafka configuration.</p> 
clusters[].<br>config.<br>kafka.<br>resources | **object**<br>Resources allocated to Apache Kafka brokers.<br><p>Cluster computational resources.</p> 
clusters[].<br>config.<br>kafka.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
clusters[].<br>config.<br>kafka.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
clusters[].<br>config.<br>kafka.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1 | **object**<br><p>Apache Kafka broker configuration. Log flushing and log retention settings are configured here.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>compressionType | **string**<br><p>Сluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: No codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: The codec to use is set by a producer (can be any of ZSTD<code>, </code>LZ4<code>, </code>GZIP<code>or</code>SNAPPY` codecs).</li> </ul> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the [Topic.topic_config.flush_messages] setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of <code>logFlushSchedulerIntervalMs</code> is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the [Topic.topic_config.flush_ms] setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency (in milliseconds) that the log flusher checks whether any log needs to be flushed to disk.</p> <p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if <code>delete</code> [Topic.topic_config.cleanup_policy] is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the [Topic.topic_config.retention_bytes] setting.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of <code>logRetentionHours</code> is used.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of <code>logRetentionMinutes</code> is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the [Topic.topic_config.retention_ms] setting.</p> 
clusters[].<br>config.<br>zookeeper | **object**<br><p>Configuration and resource allocation for ZooKeeper hosts.</p> <p>Zookeeper configuration.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources | **object**<br><p>Resources allocated to ZooKeeper hosts.</p> <p>Cluster computational resources.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
clusters[].<br>config.<br>zoneId[] | **string**<br><p>IDs of availability zones where Apache Kafka brokers reside.</p> 
clusters[].<br>config.<br>brokersCount | **integer** (int64)<br><p>The number of Apache Kafka brokers deployed in each availability zone.</p> 
clusters[].<br>config.<br>assignPublicIp | **boolean** (boolean)<br><p>The flag that defines whether a public IP address is assigned to the cluster. If the value is <code>true</code>, then Apache Kafka cluster is available on the Internet via it's public IP address.</p> 
clusters[].<br>networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (<code>health</code> of all hosts in the cluster is <code>UNKNOWN</code>).</li> <li>ALIVE: Cluster is alive and well (<code>health</code> of all hosts in the cluster is <code>ALIVE</code>).</li> <li>DEAD: Cluster is inoperable (<code>health</code> of all hosts in the cluster is <code>DEAD</code>).</li> <li>DEGRADED: Cluster is in degraded state (<code>health</code> of at least one of the hosts in the cluster is not <code>ALIVE</code>).</li> </ul> 
clusters[].<br>status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-kafka/api-ref/Cluster/list#query_params">pageSize</a>, use <code>next_page_token</code> as the value for the <a href="/docs/managed-kafka/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-kafka/api-ref/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 