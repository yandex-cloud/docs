```yaml
apiVersion: kafka.stackland.yandex.cloud/v1alpha1
kind: KafkaUserAccess
metadata:
  name: kafka-user
  labels:
    kafka-cluster: cluster-omdb
spec:
  authentication:
    username: kafka-admin
    passwordSecretRef:
      name: kafka-credentials
      key: password
  acl:
    - topic: "*"
      roles:
        - admin
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
