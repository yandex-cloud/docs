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
  cluster: test-cluster
  username: test_user
  authentication:
    type: password
    secretName: test-cluster-user-secret
  membership: # родительские роли, в которые включается пользователь
    - test-parent-role
  options:
    superuser: false # права суперпользователя
    login: true # разрешить вход
    createdb: false # право создавать базы данных
    createrole: false # право создавать роли
    inherit: true # наследование прав родительских ролей
    replication: false # право использовать репликацию
    bypassRLS: false # обход политик row-level security
    connectionLimit: -1 # лимит одновременных подключений, -1 — без лимита
    validUntil: "2026-12-31T23:59:59Z" # срок действия пароля в формате RFC3339
```
