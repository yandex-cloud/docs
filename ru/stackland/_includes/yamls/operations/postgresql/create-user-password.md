```yaml
apiVersion: v1
kind: Secret
metadata:
  name: test-cluster-user-secret
type: Opaque
stringData:
  username: test_user # имя пользователя
  password: "<пароль_пользователя>" # пароль пользователя
---
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlRole
metadata:
  name: test-cluster-test-user # имя ресурса PostgresqlRole в формате <имя-кластера>-<имя-пользователя-с-тире-вместо-нижних-подчеркиваний>
spec:
  cluster: test-cluster # имя ресурса PostgresqlCluster
  username: test_user # имя роли в PostgreSQL
  authentication:
    type: password
    secretName: test-cluster-user-secret # имя Secret с учетными данными
```
