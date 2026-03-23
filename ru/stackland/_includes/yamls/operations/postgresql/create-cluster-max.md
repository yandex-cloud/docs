```yaml
apiVersion: v1
kind: Secret
metadata:
  name: secret
type: kubernetes.io/basic-auth
stringData:
  username: postgres
  password: $2b$12$4T***** # пароль для доступа к базе данных
---
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlCluster
metadata:
  name: cluster
  annotations:
    pgcl.io/description: "Полный пример PostgreSQL кластера"
spec:
  instances: 1
  deletionProtection: false # true — защита от случайного удаления кластера
  storage:
    size: 2Gi
#    storageClass: "your-storage-class"
    autoScaling:
      enabled: false # включение автоскейлинга
      maxSize: 300Gi # максимальный размер хранилища
      standardIncreasePercent: 20 # процент увеличения размера хранилища
      resizeTriggerPercent: 80 # процент использования после которого будет запущено увеличение размера хранилища
    readOnlyTriggerPercent: 90 # процент использования диска для перевода в режим только для чтения (по умолчанию 90)
  version: "17"
  enableSuperuserAccess: true # поле должно иметь значение true при создании кластера. можно изменить после создания кластера
  superuserSecretRef:
    name: secret
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
      type: s3
      s3:
        prefix: s3://bucket # бакет для резервных копий
        region: ru-central1
        endpointUrl:  https://storage.yandexcloud.net # endpoint для доступа к бакету
        forcePathStyle: false
        storageClass: STANDARD
        credentialsSecretRef:
          name: access-key-credentials
          accessKeyIdPath: accessKey
          secretAccessKeyPath: secretKey
    schedule: "0 0 2 * * *" # запустить резервное копирование по расписанию (https://pkg.go.dev/github.com/robfig/cron#hdr-CRON_Expression_Format)
```
