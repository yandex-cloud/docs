```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlCluster
metadata:
  name: cluster
  annotations:
    pgcl.io/description: "Минимальный пример PostgreSQL кластера"
spec:
  instances: 1
  deletionProtection: false # true — запретить удаление кластера до явного отключения защиты
  storage:
    size: 2Gi
    readOnlyTriggerPercent: 90 # процент использования диска для перевода в режим только для чтения (по умолчанию 90)
  version: "17"
  enableSuperuserAccess: true # поле должно иметь значение true при создании кластера. можно изменить после создания кластера
  resources:
    requests: # запросы на ресурсы
      cpu: "500m"
      memory: "1Gi"
    limits: # лимиты на ресурсы
      cpu: "1"
      memory: "2Gi"
  postgresConfiguration: # параметры postgres
    logLevel: info
    parameters:
      max_connections: "100"
      shared_buffers: "128MB"
      work_mem: "16MB"
  poolers: # пуллеры для чтения и записи
    resources:
      requests:
        cpu: "0.1"
        memory: "64Mi"
      limits:
        cpu: "0.2"
        memory: "128Mi"
    rw: # пуллер для записи
      port: 6432 # порт для записи
      instances: 1 # кол-во инстансов
      type: ClusterIP # тип кластера
      odyssey:
        poolMode: session # режим работы пула (session или transaction)
    ro:
      port: 6433
      instances: 1
      type: ClusterIP
      odyssey:
        poolMode: session
    r:
      port: 6434
      instances: 1
      type: ClusterIP
      odyssey:
        poolMode: session
  backup:
    storage:
      type: stackland-storage
```
