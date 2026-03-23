# {{ mkf-name }} {#kafka}

{{ mkf-name }} — это брокер сообщений, который позволяет реализовать архитектуру с использованием очередей сообщений. С помощью компонента можно создавать кластеры, топики и управлять доступом пользователей. Для этого используются кастомные ресурсы:

* `KafkaCluster` — для создания кластера;
* `KafkaTopic` — для работы с топиками;
* `KafkaUserAccess` — для управления доступом пользователей.

Управлять интеграцией с {{ KF }} можно с помощью параметров кастомного ресурса `ManagedKafkaConfig`.

## Конфигурация {#configuration}

Пример:

{% include notitle [YAML-файл](../../_includes/yamls/components/managedkafkaconfig.md) %}

Где:

* `defaultStorageClass` — задаёт класс хранения по умолчанию для топиков {{ KF }}.
* `stackland-kafka` — настройки оператора Stackland Kafka: `replicas` (количество реплик), `resources` (ограничения CPU/памяти).
* `strimzi-kafka` — настройки оператора Strimzi Kafka: `replicas`, `resources` (при использовании Strimzi).
* `defaultKafkaResources`, `defaultControllerResources` — ресурсы по умолчанию для брокеров Kafka и контроллера (опционально).
* `monitoring.enabled` — включение мониторинга компонента (опционально).
