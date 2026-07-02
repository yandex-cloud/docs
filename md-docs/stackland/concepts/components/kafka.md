[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > Концепции > [Компоненты](overview.md) > Managed Service for Apache Kafka®

# Managed Service for Apache Kafka® {#kafka}

Managed Service for Apache Kafka® — это брокер сообщений, который позволяет реализовать архитектуру с использованием очередей сообщений. С помощью компонента можно создавать кластеры, топики и управлять доступом пользователей. Для этого используются кастомные ресурсы:

* `KafkaCluster` — для создания кластера;
* `KafkaTopic` — для работы с топиками;
* `KafkaUserAccess` — для управления доступом пользователей.

Управлять интеграцией с Apache Kafka® можно с помощью параметров кастомного ресурса `ManagedKafkaConfig`.

## Конфигурация {#configuration}

Пример:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: ManagedKafkaConfig
metadata:
  name: main
spec:
  enabled: true
  settings:
    defaultStorageClass: stackland-default
    stackland-kafka:
      replicas: 1
      resources:
        limits:
          cpu: "500m"
          memory: "512Mi"
        requests:
          cpu: "200m"
          memory: "256Mi"
    strimzi-kafka:
      replicas: 1
      resources:
        limits:
          cpu: "500m"
          memory: "512Mi"
        requests:
          cpu: "100m"
          memory: "256Mi"
    monitoring:
      enabled: false
```

Где:

* `defaultStorageClass` — задаёт класс хранения по умолчанию для топиков Apache Kafka®.
* `stackland-kafka` — настройки оператора Stackland Kafka: `replicas` (количество реплик), `resources` (ограничения CPU/памяти).
* `strimzi-kafka` — настройки оператора Strimzi Kafka: `replicas`, `resources` (при использовании Strimzi).
* `defaultKafkaResources`, `defaultControllerResources` — ресурсы по умолчанию для брокеров Kafka и контроллера (опционально).
* `monitoring.enabled` — включение мониторинга компонента (опционально).