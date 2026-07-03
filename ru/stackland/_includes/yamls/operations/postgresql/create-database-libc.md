```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlDatabase
metadata:
  name: test-cluster-test-database
spec:
  cluster: test-cluster
  name: test-database
  owner: test-user
  template: template1 # шаблон, на основе которого создается база данных
  encoding: UTF8 # кодировка символов
  localeProvider: libc # провайдер локали
  locale: en_US.UTF-8 # локаль по умолчанию
  localeCollate: en_US.UTF-8 # правило сортировки строк
  localeCType: en_US.UTF-8 # правило классификации символов
```
