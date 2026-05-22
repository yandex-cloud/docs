# Подключиться к кластеру {{ KF }}

В данной инструкции мы разберем команды [kcat](https://github.com/edenhill/kcat) для внешнего и внутреннего [подключения к кластеру {{ KF }}](#how-to) и отправим сообщение от производителя к потребителю.

## Перед началом работы {#before-begin}

1. Установите утилиту [kcat](https://github.com/edenhill/kcat).
1. Если проект еще не создан, создайте его: `kubectl create namespace <название проекта>`.
1. Создайте [кластер {{ KF }}](create-cluster.md).
1. Создайте [топик](create-topic.md).
1. Создайте [пользователя](create-user.md) с правами администратора.

## Как подключиться к кластеру {{ KF }} {#how-to}

{% list tabs %}

- Внешнее подключение

  {% note info %}

  Чтобы была возможность подключаться к {{ KF }} извне кластера, в настройках кластера {{ KF }} должна быть включена опция публичного доступа (`listenerType: LoadBalancer`).

  {% endnote %}

  1. Получите внешнюю ссылку на кластер {{ KF }}: `kubectl get kafkaclusters <название кластера> -o jsonpath='{.status.listenersStatus.external.fqdn}' -n <название проекта>`.
  1. Получите порт для подключения: `kubectl get kafkaclusters <название кластера> -o jsonpath='{.status.listenersStatus.external.port}' -n <название проекта>`.
  1. Скопируйте сертификат для подключения из поля `status.listenersStatus.external.certificate` ресурса кластера {{ KF }}: `kubectl describe kafkaclusters <название кластера> -n <название проекта>`.
  1. Сохраните сертификат в файл `<путь до сертификата>/ca.crt`.
  1. Запустите команду получения сообщений из топика:

      ```bash
      kcat -C \
      -b <ссылка на кластер>:<порт> \
      -t <название топика> \
      -X security.protocol=SASL_SSL \
      -X sasl.mechanism=SCRAM-SHA-512 \
      -X sasl.username="<имя пользователя>" \
      -X sasl.password="<пароль пользователя>" \
      -X ssl.endpoint.identification.algorithm=none \
      -X ssl.ca.location=/<путь до сертификата>/ca.crt -Z -K:
      ```

  1. Откройте новый терминал и отправьте сообщение в топик:

      ```bash
      echo "test message" | kcat -P \
      -b <ссылка на кластер>:<порт> \
      -t <название топика> \
      -k key \
      -X security.protocol=SASL_SSL \
      -X sasl.mechanism=SCRAM-SHA-512 \
      -X sasl.username="<имя пользователя>" \
      -X sasl.password="<пароль пользователя>" \
      -X ssl.endpoint.identification.algorithm=none \
      -X ssl.ca.location=/<путь до сертификата>/ca.crt -Z
      ```

  Потребитель получит сообщение: "test message".

- Внутреннее подключение

  1. Получите внутреннюю ссылку на кластер {{ KF }}: `kubectl get kafkaclusters <название кластера> -o jsonpath='{.status.listenersStatus.internal.fqdn}' -n <название проекта>`.
  1. Получите порт для подключения: `kubectl get kafkaclusters <название кластера> -o jsonpath='{.status.listenersStatus.internal.port}' -n <название проекта>`.
  1. Запустите команду получения сообщений из топика:

      ```bash
      kcat -C \
      -b <ссылка на кластер>:<порт> \
      -t <название топика> \
      -X security.protocol=SASL_PLAINTEXT \
      -X sasl.mechanism=SCRAM-SHA-512 \
      -X sasl.username="<имя пользователя>" \
      -X sasl.password="<пароль пользователя>" -Z -K:
      ```

  1. Откройте новый терминал и отправьте сообщение в топик:

      ```bash
      echo "test message" | kcat -P \
      -b <ссылка на кластер>:<порт> \
      -t <название топика> \
      -k key \
      -X security.protocol=SASL_PLAINTEXT \
      -X sasl.mechanism=SCRAM-SHA-512 \
      -X sasl.username="<имя пользователя>" \
      -X sasl.password="<пароль пользователя>" -Z
      ```

  Потребитель получит сообщение: "test message".

{% endlist %}
