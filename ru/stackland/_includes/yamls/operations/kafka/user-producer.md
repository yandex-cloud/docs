```yaml
apiVersion: kafka.stackland.yandex.cloud/v1alpha1
kind: KafkaUserAccess
metadata:
  name: kafka-user-producer
  labels:
    kafka-cluster: cluster-omdb
spec:
  authentication:
    username: kafka-producer
    passwordSecretRef:
      name: kafka-credentials
      key: password
  acl:
    - topic: someTopic
      roles:
        - producer
---
apiVersion: v1
kind: Secret
metadata:
  name: kafka-credentials
type: kubernetes.io/basic-auth
stringData:
    password: kafka-password
---
```
