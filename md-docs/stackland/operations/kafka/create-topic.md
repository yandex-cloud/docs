# Создать топик

Если вы создали [кластер](create-cluster.md), вы можете создать в нем топик.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте файл ресурса `KafkaTopic`. Например, с помощью команды `touch kafkatopic.yaml`.
  1. Откройте файл и вставьте конфигурацию ниже:

      ```yaml
      apiVersion: kafka.stackland.yandex.cloud/v1alpha1
      kind: KafkaTopic
      metadata:
        name: kafka-topic-with-config
        labels:
          kafka-cluster: cluster-omdb
      spec:
        topicName: with-config
        partitions: 3
        replicas: 3
        config:
          retention.ms: 604800000
          segment.bytes: 1073741824
      ```

  1. Примените манифест: `kubectl apply -f kafkatopic.yaml -n <название проекта>`. При необходимости можно прописать название проекта в параметр ресурса `metadata.namespace` и не использовать в команде.


- Консоль управления {#console}

  1. Если вы еще не открыли проект, выберите проект.
  1. В левом меню выберите **Kafka Clusters**.
  1. Выберите кластер.
  1. Перейдите на вкладку **Топики**.
  1. Нажмите **Создать топик**.
  1. Заполните имя топика и нажмите **Создать**.

{% endlist %}