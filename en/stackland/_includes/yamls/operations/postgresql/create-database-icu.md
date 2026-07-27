```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlDatabase
metadata:
  name: test-cluster-test-database
spec:
  cluster: test-cluster
  name: test-database
  owner: test-user
  template: template1
  encoding: UTF8
  localeProvider: icu # Locale provider
  icuLocale: en-US # ICU locale name
  icuRules: "" # Additional ICU collation rules
```
