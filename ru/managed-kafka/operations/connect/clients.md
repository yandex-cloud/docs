---
title: Подключение к кластеру {{ KF }} в {{ mkf-full-name }}
description: Следуя этой инструкции, вы сможете подключиться к хостам в кластере {{ KF }} с помощью инструментов командной строки и из Docker-контейнера.
---

# Подключение к кластеру {{ KF }} из приложений

В этом разделе представлены настройки для подключения к хостам кластера {{ mkf-name }} с помощью [инструментов командной строки](#command-line-tools) и из [Docker-контейнера](#docker). О подключении из кода вашего приложения см. [Примеры кода](code-examples.md).

Вы можете подключаться к хостам кластера {{ KF }} в публичном доступе только с использованием [SSL-сертификата](index.md#get-ssl-cert). В примерах ниже предполагается, что сертификат `{{ crt-local-file }}` расположен в директории:

* `{{ crt-local-dir }}` для Ubuntu;
* `$HOME\.kafka\` для Windows.

Подключение без использования SSL-сертификата поддерживается только для хостов, находящихся не в публичном доступе. В этом случае трафик внутри виртуальной сети при подключении к БД шифроваться не будет.

При необходимости перед подключением [настройте группы безопасности](index.md#configuring-security-groups) кластера.

Примеры для Linux проверялись в следующем окружении:

* Виртуальная машина в {{ yandex-cloud }} с Ubuntu 20.04 LTS.
* Bash: `5.0.16`.

Примеры для Windows проверялись в следующем окружении:

* Виртуальная машина в {{ yandex-cloud }} с Windows Server 2019 Datacenter.
* Microsoft OpenJDK: `11.0.11`.
* PowerShell: `5.1.17763.1490 Desktop`.

## Инструменты командной строки {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

### Linux (Bash)/macOS (Zsh) {#bash-zsh}

Для подключения к кластеру {{ KF }} из командной строки используйте утилиту `kafkacat` — приложение с открытым исходным кодом, которое может работать как универсальный производитель или потребитель данных. Подробнее читайте в [документации](https://github.com/edenhill/kafkacat).

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install -y kafkacat
```

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

### Windows (PowerShell) {#powershell}

Перед подключением:

1. Установите последнюю доступную версию [Microsoft OpenJDK](https://docs.microsoft.com/en-us/java/openjdk/download).

1. Загрузите [архив с бинарными файлами](https://kafka.apache.org/downloads) для версии {{ KF }}, которая используется в кластере. Версия Scala неважна.

1. Распакуйте архив.

   {% note tip %}

   Распаковывайте файлы {{ KF }} в корневой каталог диска, например, `C:\kafka_2.12-2.6.0\`.

   Если путь к исполняемым и пакетным файлам {{ KF }} будет слишком длинным, то при попытке запустить их возникнет ошибка `The input line is too long`.

   {% endnote %}

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  1. Запустите команду получения сообщений из топика:

      ```powershell
      <путь_к_директории_с_файлами_Apache_Kafka>\bin\windows\kafka-console-consumer.bat `
          --bootstrap-server <FQDN_брокера>:9092 `
          --topic <имя_топика> `
          --property print.key=true `
          --property key.separator=":" `
          --consumer-property security.protocol=SASL_PLAINTEXT `
          --consumer-property sasl.mechanism=SCRAM-SHA-512 `
          --consumer-property sasl.jaas.config="org.apache.kafka.common.security.scram.ScramLoginModule required username='<логин_потребителя>' password='<пароль_потребителя>';" 
      ```

     Команда будет непрерывно считывать новые сообщения из топика.

  1. В отдельном терминале запустите команду отправки сообщения в топик:

      ```powershell
      echo "key:test message" | <путь_к_директории_с_файлами_Apache_Kafka>\bin\windows\kafka-console-producer.bat `
          --bootstrap-server <FQDN_брокера>:9092 `
          --topic <имя_топика> `
          --property parse.key=true `
          --property key.separator=":" `
          --producer-property acks=all `
          --producer-property security.protocol=SASL_PLAINTEXT `
          --producer-property sasl.mechanism=SCRAM-SHA-512 `
          --producer-property sasl.jaas.config="org.apache.kafka.common.security.scram.ScramLoginModule required username='<логин_производителя>' password='<пароль_производителя>';"
      ```

- Подключение с SSL {#with-ssl}

  1. Добавьте SSL-сертификат в хранилище доверенных сертификатов Java (Java Key Store), чтобы драйвер {{ KF }} мог использовать этот сертификат при защищенном подключении к хостам кластера. Задайте пароль в параметре `--storepass` для дополнительной защиты хранилища:

     ```powershell
     keytool.exe -importcert -alias {{ crt-alias }} `
       --file $HOME\.kafka\{{ crt-local-file }} `
       --keystore $HOME\.kafka\ssl `
       --storepass <пароль_хранилища_сертификатов> `
       --noprompt
     ```

  1. Запустите команду получения сообщений из топика:

      ```powershell
      <путь_к_директории_с_файлами_Apache_Kafka>\bin\windows\kafka-console-consumer.bat `
          --bootstrap-server <FQDN_брокера>:9091 `
          --topic <имя_топика> `
          --property print.key=true `
          --property key.separator=":" `
          --consumer-property security.protocol=SASL_SSL `
          --consumer-property sasl.mechanism=SCRAM-SHA-512 `
          --consumer-property ssl.truststore.location=$HOME\.kafka\ssl `
          --consumer-property ssl.truststore.password=<пароль_хранилища_сертификатов> `
          --consumer-property sasl.jaas.config="org.apache.kafka.common.security.scram.ScramLoginModule required username='<логин_потребителя>' password='<пароль_потребителя>';"
      ```

     Команда будет непрерывно считывать новые сообщения из топика.

  1. В отдельном терминале запустите команду отправки сообщения в топик:

      ```powershell
      echo "key:test message" | <путь_к_директории_с_файлами_Apache_Kafka>\bin\windows\kafka-console-producer.bat `
          --bootstrap-server <FQDN_брокера>:9091 `
          --topic <имя_топика> `
          --property parse.key=true `
          --property key.separator=":" `
          --producer-property acks=all `
          --producer-property security.protocol=SASL_SSL `
          --producer-property sasl.mechanism=SCRAM-SHA-512 `
          --producer-property ssl.truststore.location=$HOME\.kafka\ssl `
          --producer-property ssl.truststore.password=<пароль_хранилища_сертификатов> `
          --producer-property sasl.jaas.config="org.apache.kafka.common.security.scram.ScramLoginModule required username='<логин_производителя>' password='<пароль_производителя>';"
      ```

{% endlist %}

{% include [fqdn](../../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [shell-howto](../../../_includes/mdb/mkf/connstr-shell-howto.md) %}

## Подготовка к подключению из Docker-контейнера {#docker}

Чтобы подключаться к кластеру {{ mkf-name }} из Docker-контейнера, добавьте в Dockerfile строки:

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
