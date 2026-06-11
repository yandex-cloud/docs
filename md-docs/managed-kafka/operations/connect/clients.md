# Подключение к кластеру Apache Kafka® из приложений

В этом разделе представлены настройки для подключения к хостам кластера Managed Service for Apache Kafka® с помощью [инструментов командной строки](#command-line-tools) и из [Docker-контейнера](#docker). О подключении из кода вашего приложения см. [Примеры кода](code-examples.md).

Вы можете подключаться к хостам кластера Apache Kafka® в публичном доступе только с использованием [SSL-сертификата](index.md#get-ssl-cert). В примерах ниже предполагается, что сертификат `YandexInternalRootCA.crt` расположен в директории:

* `/usr/local/share/ca-certificates/Yandex/` для Ubuntu;
* `$HOME\.kafka\` для Windows.


Подключение без использования SSL-сертификата поддерживается только для хостов, находящихся не в публичном доступе. В этом случае трафик внутри виртуальной сети при подключении к БД шифроваться не будет.

При необходимости перед подключением [настройте группы безопасности](index.md#configuring-security-groups) кластера.


Примеры для Linux проверялись в следующем окружении:

* Виртуальная машина в Yandex Cloud с Ubuntu 20.04 LTS.
* OpenJDK: `11.0.24`.
* Bash: `5.0.16`.

Примеры для Windows проверялись в следующем окружении:

* Виртуальная машина в Yandex Cloud с Windows Server 2019 Datacenter.
* Microsoft OpenJDK: `11.0.11`.
* PowerShell: `5.1.17763.1490 Desktop`.

## Инструменты командной строки {#command-line-tools}

Примеры кода с заполненным FQDN хоста доступны в [консоли управления](https://console.yandex.cloud) по нажатию кнопки **Подключиться** на странице кластера.

### kafkactl {#kafkactl}

`kafkactl` — это интерфейс командной строки для взаимодействия с Apache Kafka®. Утилита позволяет создавать, обновлять и удалять ресурсы в кластере Apache Kafka®, запрашивать информацию (например, о брокерах, темах, сообщениях и т. д.). Может использоваться для потребителей и производителей сообщений.

Перед подключением установите `kafkactl`:

```bash
wget https://github.com/deviceinsight/kafkactl/releases/download/v<номер_версии>/<имя_архива>.tar.gz
tar xzf <имя_архива>.tar.gz kafkactl
sudo mv kafkactl /usr/local/bin
```

Версию и имя архива можно посмотреть на [странице релизов `kafkactl`](https://github.com/deviceinsight/kafkactl/releases).

О других способах установки `kafkactl` читайте в [документации `kafkactl`](https://github.com/deviceinsight/kafkactl#installation).

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  1. Создайте каталог `~/.config/kafkactl` и поместите в него конфигурационный файл `config.yml` с параметрами подключения к кластеру Apache Kafka®:

      ```bash
      cd ~/ && \
      mkdir --parents .config/kafkactl && \
      cd ~/.config/kafkactl
      ```

      Пример файла `config.yml`:
      
      ```yaml
      contexts:
        default:
          brokers:
          - <FQDN_брокера>:9092
          sasl:
            enabled: true
            username: <логин_потребителя>
            password: <пароль_потребителя>
            mechanism: scram-sha512
      ```

      Как получить FQDN хоста-брокера, читайте в [инструкции](index.md#get-fqdn).

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

  1. Создайте каталог `~/.config/kafkactl` и поместите в него конфигурационный файл `config.yml` с параметрами подключения к кластеру Apache Kafka®:

      ```bash
      cd ~/ && \
      mkdir --parents .config/kafkactl && \
      cd ~/.config/kafkactl
      ```

      Пример файла `config.yml`:
      
      ```yaml
      contexts:
        default:
          brokers:
          - <FQDN_брокера>:9091
          sasl:
            enabled: true
            username: <логин_потребителя>
            password: <пароль_потребителя>
            mechanism: scram-sha512
          tls:
            enabled: true
            ca: /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
      ```

      Как получить FQDN хоста-брокера, читайте в [инструкции](index.md#get-fqdn).

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

Убедитесь, что в первом терминале отобразилось сообщение `test message`, отправленное во втором.

### kafkacat {#bash-zsh}

{% note info %}

`kafkacat` — это устаревший инструмент. Он работает только для кластеров с версией Apache Kafka® ниже 4.0. Если ваш кластер с версией Apache Kafka® 4.0 или выше, используйте утилиту [kafkactl](clients.md#kafkactl).

{% endnote %}

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

     ```bash
     kafkacat -C \
              -b <FQDN_брокера>:9091 \
              -t <имя_топика> \
              -X security.protocol=SASL_SSL \
              -X sasl.mechanism=SCRAM-SHA-512 \
              -X sasl.username="<логин_потребителя>" \
              -X sasl.password="<пароль_потребителя>" \
              -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt -Z -K:
     ```

     Команда будет непрерывно считывать новые сообщения из топика.

  1. В отдельном терминале запустите команду отправки сообщения в топик:

     ```bash
     echo "test message" | kafkacat -P \
         -b <FQDN_брокера>:9091 \
         -t <имя_топика> \
         -k key \
         -X security.protocol=SASL_SSL \
         -X sasl.mechanism=SCRAM-SHA-512 \
         -X sasl.username="<логин_производителя>" \
         -X sasl.password="<пароль_производителя>" \
         -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt -Z
     ```

{% endlist %}

Как получить FQDN хоста-брокера, читайте в [инструкции](index.md#get-fqdn).

Убедитесь, что в первом терминале отобразилось сообщение `test message`, отправленное во втором.

### Инструменты Apache Kafka® для Linux (Bash)/macOS (Zsh) {#kafka-sh}

В состав [архивов с бинарными файлами Apache Kafka®](https://kafka.apache.org/community/downloads/) включен набор инструментов, который позволяет управлять кластером Apache Kafka® и сущностями в нем. Подробнее об этих инструментах читайте в [документации вендора Apache Kafka®](https://docs.confluent.io/kafka/operations-tools/kafka-tools.html).

Далее на примере будет показано, как указать реквизиты пользователя для подключения и использовать инструменты с этими реквизитами:

* С помощью [kafka-console-producer](https://docs.confluent.io/kafka/operations-tools/kafka-tools.html#kafka-console-producer-sh) будет отправлено сообщение в топик.
* С помощью [kafka-console-consumer](https://docs.confluent.io/kafka/operations-tools/kafka-tools.html#kafka-console-consumer-sh) будет получено сообщение из топика.

Перед подключением:

1. Установите OpenJDK:

    ```bash
    sudo apt update && sudo apt install --yes default-jdk
    ```

1. Загрузите [архив с бинарными файлами](https://kafka.apache.org/community/downloads/) для версии Apache Kafka®, которая используется в кластере. Версия Scala неважна.

1. Распакуйте архив.

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    1. Создайте файлы с параметрами для подключения к кластеру: файл для производителя и файл для потребителя.
       
       Эти файлы имеют одинаковое содержимое, различаются только реквизиты пользователя:
       
       ```ini
       sasl.mechanism=SCRAM-SHA-512
       sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
         username="<логин_производителя_или_потребителя>" \
         password="<пароль_производителя_или_потребителя>";
       security.protocol=SASL_PLAINTEXT
       ```

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

    1. Добавьте SSL-сертификат в хранилище доверенных сертификатов Java (Java Key Store), чтобы драйвер Apache Kafka® мог использовать этот сертификат при защищенном подключении к хостам кластера. Задайте пароль не короче 6 символов в параметре `-storepass` для дополнительной защиты хранилища:
       
       ```bash
       sudo keytool -importcert \
                    -alias YandexCA -file /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt \
                    -keystore ssl -storepass <пароль_хранилища_сертификатов> \
                    --noprompt
       ```

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

Как получить FQDN хоста-брокера, читайте в [инструкции](index.md#get-fqdn).

Убедитесь, что в первом терминале отобразилось сообщение `test message`, отправленное во втором.

### Инструменты Apache Kafka® для Windows (PowerShell) {#powershell}

В состав [архивов с бинарными файлами Apache Kafka®](https://kafka.apache.org/community/downloads/) включен набор инструментов, который позволяет управлять кластером Apache Kafka® и сущностями в нем. Подробнее об этих инструментах читайте в [документации вендора Apache Kafka®](https://docs.confluent.io/kafka/operations-tools/kafka-tools.html).

Далее на примере будет показано, как указать реквизиты пользователя для подключения и использовать инструменты с этими реквизитами:

* С помощью [kafka-console-producer](https://docs.confluent.io/kafka/operations-tools/kafka-tools.html#kafka-console-producer-sh) будет отправлено сообщение в топик.
* С помощью [kafka-console-consumer](https://docs.confluent.io/kafka/operations-tools/kafka-tools.html#kafka-console-consumer-sh) будет получено сообщение из топика.

Хотя документация по инструментам содержит упоминание скриптов `.sh`, она актуальна и при работе в Windows. Сами инструменты одинаковы для любой платформы, различаются лишь скрипты, которые запускают их, например:

* `bin/kafka-console-producer.sh` для Linux (Bash)/macOS (Zsh).
* `bin\windows\kafka-console-producer.bat` для Windows (PowerShell).

Перед подключением:

1. Установите последнюю доступную версию [Microsoft OpenJDK](https://docs.microsoft.com/en-us/java/openjdk/download).

1. Загрузите [архив с бинарными файлами](https://kafka.apache.org/community/downloads/) для версии Apache Kafka®, которая используется в кластере. Версия Scala неважна.

1. Распакуйте архив.

   {% note tip %}

   Распаковывайте файлы Apache Kafka® в корневой каталог диска, например, `C:\kafka_2.12-2.6.0\`.

   Если путь к исполняемым и пакетным файлам Apache Kafka® будет слишком длинным, то при попытке запустить их возникнет ошибка `The input line is too long`.

   {% endnote %}

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  1. Создайте файлы с параметрами для подключения к кластеру: файл для производителя и файл для потребителя.
     
     Эти файлы имеют одинаковое содержимое, различаются только реквизиты пользователя:
     
     ```ini
     sasl.mechanism=SCRAM-SHA-512
     sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
       username="<логин_производителя_или_потребителя>" \
       password="<пароль_производителя_или_потребителя>";
     security.protocol=SASL_PLAINTEXT
     ```

  1. Запустите команду получения сообщений из топика:

      ```powershell
      <путь_к_директории_с_файлами_Apache_Kafka>\bin\windows\kafka-console-consumer.bat `
          --consumer.config <путь_к_файлу_с_параметрами_для_потребителя> `
          --bootstrap-server <FQDN_брокера>:9092 `
          --topic <имя_топика> `
          --property print.key=true `
          --property key.separator=":"
      ```

     Команда будет непрерывно считывать новые сообщения из топика.

  1. В отдельном терминале запустите команду отправки сообщения в топик:

      ```powershell
      echo "key:test message" | <путь_к_директории_с_файлами_Apache_Kafka>\bin\windows\kafka-console-producer.bat `
          --producer.config <путь_к_файлу_с_параметрами_для_производителя> `
          --bootstrap-server <FQDN_брокера>:9092 `
          --topic <имя_топика> `
          --property parse.key=true `
          --property key.separator=":"
      ```

- Подключение с SSL {#with-ssl}

  1. Добавьте SSL-сертификат в хранилище доверенных сертификатов Java (Java Key Store), чтобы драйвер Apache Kafka® мог использовать этот сертификат при защищенном подключении к хостам кластера. Задайте пароль в параметре `--storepass` для дополнительной защиты хранилища:

     ```powershell
     keytool.exe -importcert -alias YandexCA `
       --file $HOME\.kafka\YandexInternalRootCA.crt `
       --keystore $HOME\.kafka\ssl `
       --storepass <пароль_хранилища_сертификатов> `
       --noprompt
     ```

  1. Создайте файлы с параметрами для подключения к кластеру: файл для производителя и файл для потребителя.

     Эти файлы имеют одинаковое содержимое, различаются только реквизиты пользователя:

     ```ini
     sasl.mechanism=SCRAM-SHA-512
     sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
       username="<логин_производителя_или_потребителя>" \
       password="<пароль_производителя_или_потребителя>";
     security.protocol=SASL_SSL
     ssl.truststore.location=<значение_переменной_$HOME>\\.kafka\\ssl
     ssl.truststore.password=<пароль_хранилища_сертификатов>
     ```

     В качестве значения параметра `ssl.truststore.location` укажите полный путь к хранилищу сертификатов, например:

     ```ini
     ssl.truststore.location=C:\\Users\\Administrator\\.kafka\\ssl
     ```

     Хранилище сертификатов расположено по пути `$HOME\.kafka\ssl`, но в значении нельзя использовать переменные среды окружения. Чтобы раскрыть переменную, выполните команду:

     ```powershell
     echo $HOME
     ```

     {% note warning %}

     Используйте `\\` вместо `\` при указании значения параметра `ssl.truststore.location`, иначе при запуске команд не удастся получить доступ к хранилищу сертификатов.

     {% endnote %}

  1. Запустите команду получения сообщений из топика:

      ```powershell
      <путь_к_директории_с_файлами_Apache_Kafka>\bin\windows\kafka-console-consumer.bat `
          --consumer.config <путь_к_файлу_с_параметрами_для_потребителя> `
          --bootstrap-server <FQDN_брокера>:9091 `
          --topic <имя_топика> `
          --property print.key=true `
          --property key.separator=":"
      ```

     Команда будет непрерывно считывать новые сообщения из топика.

  1. В отдельном терминале запустите команду отправки сообщения в топик:

      ```powershell
      echo "key:test message" | <путь_к_директории_с_файлами_Apache_Kafka>\bin\windows\kafka-console-producer.bat `
          --producer.config <путь_к_файлу_с_параметрами_для_производителя> `
          --bootstrap-server <FQDN_брокера>:9091 `
          --topic <имя_топика> `
          --property parse.key=true `
          --property key.separator=":"
      ```

{% endlist %}

Как получить FQDN хоста-брокера, читайте в [инструкции](index.md#get-fqdn).

Убедитесь, что в первом терминале отобразилось сообщение `test message`, отправленное во втором.

## Подготовка к подключению из Docker-контейнера {#docker}

### Подключение с помощью kafkactl {docker-kafkactl}

Чтобы подключаться к кластеру Managed Service for Apache Kafka® из Docker-контейнера с помощью `kafkactl`:

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

  1. В каталоге с Dockerfile создайте конфигурационный файл `config.yml`.

      Пример файла `config.yml`:
      
      ```yaml
      contexts:
        default:
          brokers:
          - <FQDN_брокера>:9092
          sasl:
            enabled: true
            username: <логин_потребителя>
            password: <пароль_потребителя>
            mechanism: scram-sha512
      ```

  1. Добавьте в Dockerfile строки:

      ```bash
      COPY config.yml $HOME/.config/kafkactl/config.yml
      RUN apt-get update && \
          apt-get install -y wget && \
          wget https://github.com/deviceinsight/kafkactl/releases/download/v<номер_версии>/<имя_архива>.tar.gz && \
          tar xzf <имя_архива>.tar.gz kafkactl && \
          mv kafkactl /usr/local/bin
      ```

      Версию и имя архива можно посмотреть на [странице релизов `kafkactl`](https://github.com/deviceinsight/kafkactl/releases).


- Подключение с SSL {#with-ssl}

  1. В каталоге с Dockerfile создайте конфигурационный файл `config.yml`.

      Пример файла `config.yml`:
      
      ```yaml
      contexts:
        default:
          brokers:
          - <FQDN_брокера>:9091
          sasl:
            enabled: true
            username: <логин_потребителя>
            password: <пароль_потребителя>
            mechanism: scram-sha512
          tls:
            enabled: true
            ca: /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
      ```

  1. Добавьте в Dockerfile строки:

      ```bash
      COPY config.yml $HOME/.config/kafkactl/config.yml
      RUN apt-get update && \
          apt-get install -y wget && \
          wget https://github.com/deviceinsight/kafkactl/releases/download/v<номер_версии>/<имя_архива>.tar.gz && \
          tar xzf <имя_архива>.tar.gz kafkactl && \
          mv kafkactl /usr/local/bin && \
          mkdir --parents /usr/local/share/ca-certificates/Yandex/ && \
          wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
               --output-document /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
          chmod 0655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
      ```

      Версию и имя архива можно посмотреть на [странице релизов `kafkactl`](https://github.com/deviceinsight/kafkactl/releases).

{% endlist %}

### Подключение с помощью kafkacat {docker-kafkacat}

{% note info %}

`kafkacat` — это устаревший инструмент. Он работает только для кластеров с версией Apache Kafka® ниже 4.0. Если ваш кластер с версией Apache Kafka® 4.0 или выше, используйте утилиту [kafkactl](clients.md#kafkactl).

{% endnote %}

Чтобы подключаться к кластеру Managed Service for Apache Kafka® из Docker-контейнера с помощью `kafkacat`, добавьте в Dockerfile строки:

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
      mkdir --parents /usr/local/share/ca-certificates/Yandex/ && \
      wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
           --output-document /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
      chmod 0655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
  ```

{% endlist %}