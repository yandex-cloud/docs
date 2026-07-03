```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlRole
metadata:
  name: test-cluster-test-user # имя ресурса PostgresqlRole в формате <имя-кластера>-<имя-пользователя-с-тире-вместо-нижних-подчеркиваний>
spec:
  cluster: test-cluster # имя ресурса PostgresqlCluster
  username: test_user # имя роли в PostgreSQL
```
