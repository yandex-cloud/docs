```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlDatabase
metadata:
  name: test-cluster-test-database
spec:
  cluster: test-cluster
  name: test-database
  owner: test-user
  template: template1 # Template for the database
  encoding: UTF8 # Character encoding
  localeProvider: libc # Locale provider
  locale: en_US.UTF-8 # Default locale
  localeCollate: en_US.UTF-8 # String sorting rule
  localeCType: en_US.UTF-8 # Character classification rule
```
