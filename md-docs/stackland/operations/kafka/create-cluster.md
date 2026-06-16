# Создать кластер Apache Kafka®

Если у вас есть ../projects/create-project.md, вы можете создать в нем кластер [Apache Kafka®](../../concepts/components/kafka.md).

{% list tabs group=instructions %}

- CLI {#cli}

  1. Если проект еще не создан, то создайте его: `kubectl create namespace <название проекта>`.
  1. Создайте файл ресурса `KafkaCluster`. Например, с помощью команды `touch kafkacluster.yaml`.
  1. Откройте файл и вставьте конфигурацию ниже:

      ```yaml
      apiVersion: kafka.stackland.yandex.cloud/v1alpha1
      kind: KafkaCluster
      metadata:
        name: cluster-omdb
        labels:
          environment: production
          tier: messaging
      spec:
        version: "4.0.0"
        controller:
          instances: 3
          storage:
            size: 1Gi
            # storageClass: "stackland-default"
        broker:
          instances: 3
          storage:
            size: 2Gi
            # storageClass: "stackland-default"
          diskAutoScaling:
            enabled: true
            maxSize: 300Gi
            minimalIncrement: 2Gi
            standardIncreasePercent: 20
            resizeTriggerPercent: 20
        listenerType: LoadBalancer # Network listener (LoadBalancer or ClusterIP)
        config: # configuration
          offsets.topic.replication.factor: 3
          transaction.state.log.replication.factor: 3
          transaction.state.log.min.isr: 2
          default.replication.factor: 3
          min.insync.replicas: 2
      ```

  1. Примените манифест: `kubectl apply -f kafkacluster.yaml -n <название проекта>`. При необходимости можно прописать название проекта в параметр ресурса `metadata.namespace` и не использовать в команде.

  Чтобы подключиться к кластеру, воспользуйтесь инструкцией [Подключиться к кластеру Apache Kafka®](connect-to-kafka.md).


- Консоль управления {#console}

  1. Если вы еще не открыли проект, выберите проект.
  1. В левом меню выберите **Kafka Clusters**.
  1. Нажмите **Создать**.
  1. Заполните поля:

      * **Название кластера**. Только строчные буквы, цифры и дефисы.
      * **Версия Kafka**, выберите из списка доступных версий.
      * **Количество реплик** сервиса обработки сообщений.
      * **Вычислительные ресурсы**, где **Лимиты** — верхняя граница, **Запросы** — нижняя граница.
      * **Хранилище**, где **Тип диска** — это Storage Class (`stackland-nvme`, `stackland-ssd`, `stackland-hdd`, `stackland-other`). Подробнее о Storage Classes в разделе [Дисковая подсистема](../../concepts/components/disk-storage.md#storage-classes). Можно включить **Автоматическое увеличение размера хранилища**.
      * **Количество реплик** сервиса координации.
      * **Вычислительные ресурсы**, где **Лимиты** — верхняя граница, **Запросы** — нижняя граница.
      * **Хранилище**, где **Тип диска** — это Storage Class (`stackland-nvme`, `stackland-ssd`, `stackland-hdd`, `stackland-other`).

  1. Нажмите **Создать**.

  Чтобы подключиться к кластеру, воспользуйтесь инструкцией [Подключиться к кластеру Apache Kafka®](connect-to-kafka.md).

{% endlist %}