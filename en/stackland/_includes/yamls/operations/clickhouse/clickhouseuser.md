```yaml
apiVersion: v1
kind: Secret
metadata:
  name: <cluster_name>-<username>
type: Opaque
stringData:
  password: "<password>"
---
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseUser
metadata:
  name: <cluster_name>-<username>
spec:
  cluster: <cluster_name>
  name: <username>
  roles:
    - name: <cluster_name>-reader
    - name: <cluster_name>-writer
  authentication:
    secretName: <cluster_name>-<username>
```
