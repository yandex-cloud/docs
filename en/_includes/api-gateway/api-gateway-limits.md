#### Quotas {#api-gw-quotas}

Type of limit | Value
----- | -----
Number of [triggers](../../serverless-containers/concepts/trigger/index.md) per cloud | 100

#### Limits {#api-gw-limits}

Type of limit | Value
----- | -----
Maximum size of a request to and a response from {{ api-gw-name }} | 2.5 MB
Maximum specification size | 3.5 MB
Maximum waiting time for a response from the service being integrated | 5 minutes
Maximum size of message being transmitted via a web socket | 128 KB
Maximum size of frame being transmitted via a web socket | 32 KB
Maximum time-to-live of a web socket connection | 60 minutes
Maximum time-to-live of an idle web socket connection | 10 minutes
Number of [user networks](../../api-gateway/concepts/networking.md##user-network) per cloud | 1
Maximum number of triggers per [message queue](../../message-queue/concepts/queue.md) | 1
Maximum message size per trigger | 256 KB