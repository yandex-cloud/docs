```yaml
apiVersion: v1
kind: Secret
metadata:
  name: <название_кластера>-<имя_пользователя>
type: Opaque
stringData:
  password: "<пароль>"
---
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseUser
metadata:
  name: <название_кластера>-<имя_пользователя>
spec:
  cluster: <название_кластера>
  name: <имя_пользователя>
  roles:
    - name: <название_кластера>-reader
    - name: <название_кластера>-writer
  authentication:
    secretName: <название_кластера>-<имя_пользователя>
```
