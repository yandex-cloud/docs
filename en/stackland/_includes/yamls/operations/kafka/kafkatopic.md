```yaml
apiVersion: kafka.stackland.yandex.cloud/v1alpha1
kind: KafkaTopic
metadata:
  name: kafka-topic-with-config
  labels:
    kafka-cluster: cluster-omdb
spec:
  topicName: with-config
  partitions: 3
  replicas: 3
  config:
    retention.ms: 604800000
    segment.bytes: 1073741824
```
