```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlDatabase
metadata:
  name: test-cluster-test-database
spec:
  cluster: test-cluster
  name: test-database
  owner: test-user
  allowConnections: true # разрешить подключения к базе данных
  connectionLimit: -1 # лимит подключений, -1 — без лимита
  isTemplate: false # использовать базу данных как шаблон
  tablespace: pg_default # tablespace по умолчанию
  schemas: # управляемые схемы
    - name: test-schema
      owner: test-user
      state: present # present — создать или поддерживать, absent — удалить
```
