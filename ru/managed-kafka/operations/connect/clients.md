---
title: Подключение к кластеру {{ KF }} в {{ mkf-full-name }}
description: Следуя этой инструкции, вы сможете подключиться к хостам в кластере {{ KF }} с помощью инструментов командной строки и из Docker-контейнера.
---

# Подключение к кластеру {{ KF }} из приложений

В этом разделе представлены настройки для подключения к хостам кластера {{ mkf-name }} с помощью [инструментов командной строки](#command-line-tools) и из [Docker-контейнера](#docker). О подключении из кода вашего приложения смотрите [Примеры кода](code-examples.md).

Вы можете подключаться к хостам кластера {{ KF }} в публичном доступе только с использованием [SSL-сертификата](index.md#get-ssl-cert). В примерах ниже предполагается, что сертификат `{{ crt-local-file }}` расположен в директории `{{ crt-local-dir }}`.


Подключение без использования SSL-сертификата поддерживается только для хостов, находящихся не в публичном доступе. В этом случае трафик внутри виртуальной сети при подключении к БД шифроваться не будет.

При необходимости перед подключением [настройте группы безопасности](index.md#configuring-security-groups) кластера.


Примеры для Linux проверялись в следующем окружении:

* Виртуальная машина в {{ yandex-cloud }} с Ubuntu 20.04 LTS.
* OpenJDK: `11.0.24`.
* Bash: `5.0.16`.

## Инструменты командной строки {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

### kafkactl {#kafkactl}

`kafkactl` — это интерфейс командной строки для взаимодействия с {{ KF }}. Утилита позволяет создавать, обновлять и удалять ресурсы в кластере {{ KF }}, запрашивать информацию (например, о брокерах, темах, сообщениях и т. д.). Может использоваться для потребителей и производителей сообщений.

Перед подключением установите `kafkactl`:

{% include [kafkactl-install](../../../_includes/mdb/mkf/kafkactl_install.md) %}

О других способах установки `kafkactl` читайте в [документации `kafkactl`](https://github.com/deviceinsight/kafkactl#installation).

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  1. Создайте каталог `~/.config/kafkactl` и поместите в него конфигурационный файл `config.yml` с параметрами подключения к кластеру {{ KF }}:

      {% include [kafkactl-folder](../../../_includes/mdb/mkf/kafkactl_folder.md) %}

      {% include [kafkactl-config-no-ssl](../../../_includes/mdb/mkf/kafkactl-config-no-ssl.md) %}

      {% include [fqdn](../../../_includes/mdb/mkf/fqdn-host.md) %}

  1. Запустите команду получения сообщений из топика:

      ```bash
      kafkactl consume <имя_топика>
      ```

     Команда будет непрерывно считывать новые сообщения из топика.

  1. В отдельном терминале запустите команду отправки сообщения в топик:

      ```bash
      echo "test message" | kafkactl produce <имя_топика>
      ```

- Подключение с SSL {#with-ssl}

  1. Создайте каталог `~/.config/kafkactl` и поместите в него конфигурационный файл `config.yml` с параметрами подключения к кластеру {{ KF }}:

      {% include [kafkactl-folder](../../../_includes/mdb/mkf/kafkactl_folder.md) %}

      {% include [kafkactl-config-ssl](../../../_includes/mdb/mkf/kafkactl-config-ssl.md) %}

      {% include [fqdn](../../../_includes/mdb/mkf/fqdn-host.md) %}

  1. Запустите команду получения сообщений из топика:

      ```bash
      kafkactl consume <имя_топика>
      ```

     Команда будет непрерывно считывать новые сообщения из топика.

  1. В отдельном терминале запустите команду отправки сообщения в топик:

      ```bash
      echo "test message" | kafkactl produce <имя_топика>
      ```

{% endlist %}

{% include [shell-howto](../../../_includes/mdb/mkf/connstr-shell-howto.md) %}

### kafkacat {#bash-zsh}

{% include [kafkacat-info](../../../_includes/mdb/mkf/kafkacat-info.md) %}

Утилита [kafkacat](https://github.com/edenhill/kcat) (второе название `kcat`) — приложение с открытым исходным кодом, которое может работать как универсальный производитель или потребитель данных и не требует установки Java Runtime Environment.

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install -y kafkacat
```

{% note info %}

На Ubuntu 24.04 и выше используйте утилиту `kcat`.

{% endnote %}

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  1. Запустите команду получения сообщений из топика:

      ```bash
      kafkacat -C \
               -b <FQDN_брокера>:9092 \
               -t <имя_топика> \
               -X security.protocol=SASL_PLAINTEXT \
               -X sasl.mechanism=SCRAM-SHA-512 \
               -X sasl.username="<логин_потребителя>" \
               -X sasl.password="<пароль_потребителя>" -Z
      ```

     Команда будет непрерывно считывать новые сообщения из топика.

  1. В отдельном терминале запустите команду отправки сообщения в топик:

      ```bash
      echo "test message" | kafkacat -P \
             -b <FQDN_брокера>:9092 \
             -t <имя_топика> \
             -k key \
             -X security.protocol=SASL_PLAINTEXT \
             -X sasl.mechanism=SCRAM-SHA-512 \
             -X sasl.username="<логин_производителя>" \
             -X sasl.password="<пароль_производителя>" -Z
      ```

- Подключение с SSL {#with-ssl}

  1. Запустите команду получения сообщений из топика:

     {% include [default-get-string](../../../_includes/mdb/mkf/default-get-string.md) %}

     Команда будет непрерывно считывать новые сообщения из топика.

  1. В отдельном терминале запустите команду отправки сообщения в топик:

     {% include [default-get-string](../../../_includes/mdb/mkf/default-send-string.md) %}

{% endlist %}

{% include [fqdn](../../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [shell-howto](../../../_includes/mdb/mkf/connstr-shell-howto.md) %}

### Инструменты {{ KF }} для Linux (Bash)/macOS (Zsh) {#kafka-sh}

{% include [kafka-cli-tools-intro](../../../_includes/mdb/mkf/kafka-cli-tools-intro.md) %}

Перед подключением:

1. Установите OpenJDK:

    ```bash
    sudo apt update && sudo apt install --yes default-jdk
    ```

1. Загрузите [архив с бинарными файлами](https://kafka.apache.org/community/downloads/) для версии {{ KF }}, которая используется в кластере. Версия Scala неважна.

1. Распакуйте архив.

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    1. {% include [connect-properties-no-ssl](../../../_includes/mdb/mkf/connect-properties-no-ssl.md) %}

    1. Запустите команду получения сообщений из топика:

        ```bash
        <путь_к_директории_с_файлами_Apache_Kafka>/bin/kafka-console-consumer.sh \
          --consumer.config <путь_к_файлу_с_параметрами_для_потребителя> \
          --bootstrap-server <FQDN_брокера>:9092 \
          --topic <имя_топика> \
          --property print.key=true \
          --property key.separator=":"
        ```

        Команда будет непрерывно считывать новые сообщения из топика.

    1. В отдельном терминале запустите команду отправки сообщения в топик:

        ```bash
        echo "key:test message" | <путь_к_директории_с_файлами_Apache_Kafka>/bin/kafka-console-producer.sh \
          --producer.config <путь_к_файлу_с_параметрами_для_производителя> \
          --bootstrap-server <FQDN_брокера>:9092 \
          --topic <имя_топика> \
          --property parse.key=true \
          --property key.separator=":"
        ```

- Подключение с SSL {#with-ssl}

    1. Перейдите в каталог, где будет располагаться хранилище сертификатов Java:

        ```bash
        cd /etc/security
        ```

    1. {% include [keytool-importcert](../../../_includes/mdb/keytool-importcert.md) %}

    1. Создайте файлы с параметрами для подключения к кластеру: файл для производителя и файл для потребителя.

        Эти файлы имеют одинаковое содержимое, различаются только реквизиты пользователя:

        ```ini
        sasl.mechanism=SCRAM-SHA-512
        sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
          username="<логин_производителя_или_потребителя>" \
          password="<пароль_производителя_или_потребителя>";
        security.protocol=SASL_SSL
        ssl.truststore.location=/etc/security/ssl
        ssl.truststore.password=<пароль_хранилища_сертификатов>
        ```

    1. Запустите команду получения сообщений из топика:

        ```bash
        <путь_к_директории_с_файлами_Apache_Kafka>/bin/kafka-console-consumer.sh \
          --consumer.config <путь_к_файлу_с_параметрами_для_потребителя> \
          --bootstrap-server <FQDN_брокера>:9091 \
          --topic <имя_топика> \
          --property print.key=true \
          --property key.separator=":"
        ```

        Команда будет непрерывно считывать новые сообщения из топика.

    1. В отдельном терминале запустите команду отправки сообщения в топик:

        ```bash
        echo "key:test message" | <путь_к_директории_с_файлами_Apache_Kafka>/bin/kafka-console-producer.sh \
          --producer.config <путь_к_файлу_с_параметрами_для_производителя> \
          --bootstrap-server <FQDN_брокера>:9091 \
          --topic <имя_топика> \
          --property parse.key=true \
          --property key.separator=":"
        ```

{% endlist %}

{% include [fqdn](../../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [shell-howto](../../../_includes/mdb/mkf/connstr-shell-howto.md) %}

## Подготовка к подключению из Docker-контейнера {#docker}

### Подключение с помощью kafkactl {docker-kafkactl}

Чтобы подключаться к кластеру {{ mkf-name }} из Docker-контейнера с помощью `kafkactl`:

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

  1. В каталоге с Dockerfile создайте конфигурационный файл `config.yml`.

      {% include [kafkactl-config-no-ssl](../../../_includes/mdb/mkf/kafkactl-config-no-ssl.md) %}

  1. Добавьте в Dockerfile строки:

      ```bash
      COPY config.yml $HOME/.config/kafkactl/config.yml
      RUN apt-get update && \
          apt-get install -y wget && \
          wget https://github.com/deviceinsight/kafkactl/releases/download/v<номер_версии>/<имя_архива>.tar.gz && \
          tar xzf <имя_архива>.tar.gz kafkactl && \
          mv kafkactl /usr/local/bin
      ```

      {% include [kafkactl-version](../../../_includes/mdb/mkf/kafkactl-version.md) %}


- Подключение с SSL {#with-ssl}

  1. В каталоге с Dockerfile создайте конфигурационный файл `config.yml`.

      {% include [kafkactl-config-ssl](../../../_includes/mdb/mkf/kafkactl-config-ssl.md) %}

  1. Добавьте в Dockerfile строки:

      ```bash
      COPY config.yml $HOME/.config/kafkactl/config.yml
      RUN apt-get update && \
          apt-get install -y wget && \
          wget https://github.com/deviceinsight/kafkactl/releases/download/v<номер_версии>/<имя_архива>.tar.gz && \
          tar xzf <имя_архива>.tar.gz kafkactl && \
          mv kafkactl /usr/local/bin && \
          mkdir --parents {{ crt-local-dir }} && \
          wget "{{ crt-web-path }}" \
               --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
          chmod 0655 {{ crt-local-dir }}{{ crt-local-file }}
      ```

      {% include [kafkactl-version](../../../_includes/mdb/mkf/kafkactl-version.md) %}

{% endlist %}

### Подключение с помощью kafkacat {docker-kafkacat}

{% include [kafkacat-info](../../../_includes/mdb/mkf/kafkacat-info.md) %}

Чтобы подключаться к кластеру {{ mkf-name }} из Docker-контейнера с помощью `kafkacat`, добавьте в Dockerfile строки:

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  ```bash
  RUN apt-get update && \
      apt-get install kafkacat --yes
  ```

- Подключение с SSL {#with-ssl}

  ```bash
  RUN apt-get update && \
      apt-get install wget kafkacat --yes && \
      mkdir --parents {{ crt-local-dir }} && \
      wget "{{ crt-web-path }}" \
           --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
      chmod 0655 {{ crt-local-dir }}{{ crt-local-file }}
  ```

{% endlist %}
