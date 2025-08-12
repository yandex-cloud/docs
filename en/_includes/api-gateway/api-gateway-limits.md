#### Quotas {#api-gw-quotas}

#|
|| Type of limit | Value ||
|| Number of [triggers](../../serverless-containers/concepts/trigger/index.md) per cloud^1^ 
`serverless.triggers.count` | 100 ||
|| Number of [user networks](../../api-gateway/concepts/networking.md#user-network) per cloud | 10 ||
|#

{% include [quota-trigger-count](../quota-trigger-count.md) %}

#### Limits {#api-gw-limits}

Type of limit | Value
----- | -----
Maximum size of a request to and a response from {{ api-gw-name }} | 2.5 MB
Maximum specification size | 3.5 MB
Maximum request processing timeout | 10 minutes^1^
Maximum size of message being transmitted via a web socket | 128 KB
Maximum size of frame being transmitted via a web socket | 32 KB
Maximum time-to-live of a web socket connection | 60 minutes
Maximum time-to-live of an idle web socket connection | 10 minutes
Maximum number of triggers per [message queue](../../message-queue/concepts/queue.md) | 1
Maximum message size per trigger^2^ | 230 KB
Maximum number of [domains](../../api-gateway/concepts/index.md#domains) you can connect to a single API gateway | 20

^1^ Default value: 5 minutes.
^2^ The message may include service metadata, which will reduce the maximum message size.