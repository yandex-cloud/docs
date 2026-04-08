```yaml
apiVersion: kafka.stackland.yandex.cloud/v1alpha1
kind: KafkaCluster
metadata:
  name: cluster-omdb
  labels:
    environment: production
    tier: messaging
spec:
  version: "4.0.0"
  controller:
    instances: 3
    storage:
      size: 1Gi
      # storageClass: "stackland-default"
  broker:
    instances: 3
    storage:
      size: 2Gi
      # storageClass: "stackland-default"
    diskAutoScaling:
      enabled: true
      maxSize: 300Gi
      minimalIncrement: 2Gi
      standardIncreasePercent: 20
      resizeTriggerPercent: 20
  listenerType: LoadBalancer # Network listener (LoadBalancer or ClusterIP)
  config: # configuration
    offsets.topic.replication.factor: 3
    transaction.state.log.replication.factor: 3
    transaction.state.log.min.isr: 2
    default.replication.factor: 3
    min.insync.replicas: 2
```
