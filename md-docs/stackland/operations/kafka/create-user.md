# Создать пользователя

Если у вас есть ../projects/create-project.md, вы можете создать в нем пользователя [Apache Kafka®](../../concepts/components/kafka.md).

## Через CLI

1. Если проект еще не создан, то создайте его: `kubectl create namespace <название проекта>`.
1. Создайте файл ресурса `KafkaUserAccess`. Например, с помощью команды `touch kafkauseraccess.yaml`.
1. Откройте файл и вставьте конфигурацию ниже. Создайте вместе с пользователем секрет:

    {% list tabs %}

    - Администратор

        ```yaml
        apiVersion: kafka.stackland.yandex.cloud/v1alpha1
        kind: KafkaUserAccess
        metadata:
          name: kafka-user
          labels:
            kafka-cluster: cluster-omdb
        spec:
          authentication:
            username: kafka-admin
            passwordSecretRef:
              name: kafka-credentials
              key: password
          acl:
            - topic: "*"
              roles:
                - admin
        ---
        apiVersion: v1
        kind: Secret
        metadata:
          name: kafka-credentials
        type: kubernetes.io/basic-auth
        stringData:
            password: kafka-password
        ---
        ```

    - Потребитель

        ```yaml
        apiVersion: kafka.stackland.yandex.cloud/v1alpha1
        kind: KafkaUserAccess
        metadata:
          name: kafka-user-consumer
          labels:
            kafka-cluster: cluster-omdb
        spec:
          authentication:
            username: kafka-consumer
            passwordSecretRef:
              name: kafka-credentials
              key: password
          acl:
            - topic: someTopic
              roles:
                - consumer
        ---
        apiVersion: v1
        kind: Secret
        metadata:
          name: kafka-credentials
        type: kubernetes.io/basic-auth
        stringData:
            password: kafka-password
        ---
        ```

    - Производитель

        ```yaml
        apiVersion: kafka.stackland.yandex.cloud/v1alpha1
        kind: KafkaUserAccess
        metadata:
          name: kafka-user-producer
          labels:
            kafka-cluster: cluster-omdb
        spec:
          authentication:
            username: kafka-producer
            passwordSecretRef:
              name: kafka-credentials
              key: password
          acl:
            - topic: someTopic
              roles:
                - producer
        ---
        apiVersion: v1
        kind: Secret
        metadata:
          name: kafka-credentials
        type: kubernetes.io/basic-auth
        stringData:
            password: kafka-password
        ---
        ```

    {% endlist %}

1. Примените манифест: `kubectl apply -f kafkauseraccess.yaml -n <название проекта>`. При необходимости можно прописать название проекта в параметр ресурса `metadata.namespace` и не использовать в команде.

## Через консоль управления

1. Если вы еще не открыли проект, выберите проект.
1. В левом меню выберите **Kafka Clusters**.
1. Выберите кластер.
1. Перейдите на вкладку **Пользователи**.
1. Нажмите **Создать пользователя**.
1. Заполните имя пользователя и пароль.
1. Нажмите **Использовать паттерн** под выбором топика.
1. Чтобы выбрать все топики, введите паттерн: "*".
1. Выберите роль.
1. Нажмите **Создать**.