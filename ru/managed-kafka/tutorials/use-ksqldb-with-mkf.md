# Поставка данных в ksqlDB

ksqlDB — это база данных, которая предназначена для потоковой обработки сообщений, поступающих из топиков {{ KF }}. Работа с потоком сообщений в ksqlDB похожа на работу с таблицами в обычной базе данных. Таблица ksqlDB автоматически пополняется данными, поступающими из топика, а данные, которые вы добавите в таблицу ksqlDB, отправляются в топик {{ KF }}. Подробнее см. в [документации ksqlDB](https://docs.ksqldb.io/en/latest).

Чтобы настроить поставку данных из {{ mkf-name }} в ksqlDB:
1. [Настройте интеграцию с {{ KF }} для базы ksqlDB](#configure-ksqldb-for-kf).
1. [Изучите формат данных, поступающих от {{ mkf-name }}](#explore-kf-data-format).
1. [Создайте в ksqlDB таблицу для записи потока данных из топика {{ KF }}](#create-kf-table).
1. [Получите тестовые данные из кластера {{ mkf-name }}](#get-data-from-kf)
1. [Запишите тестовые данные в ksqlDB](#insert-data-to-ksqldb).
1. [Проверьте наличие тестовых данных в топике {{ KF }}](#fetch-data-from-kf).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей вам конфигурации:
    
    * Если сервер ksqlDB размещен в интернете, создайте кластер {{ mkf-name }} с публичным доступом.
    
    * Если сервер ksqlDB размещен в {{ yandex-cloud }}, создайте кластер {{ mkf-name }} в той же [облачной сети](../../vpc/concepts/network.md), где находится ksqlDB.


1. [Создайте топики](../../managed-kafka/operations/cluster-topics.md#create-topic) в кластере {{ mkf-name }}:
   1. Служебный топик `_confluent-ksql-default__command_topic` с настройками:
        * Фактор репликации — `1`.
        * Количество разделов — `1`.
        * Политика очистки лога — `Delete`.
        * Время жизни сегмента лога, мс — `-1`.
        * Минимальное число синхронных реплик — `1`.
   1. Служебный топик `default_ksql_processing_log`. Настройки топика могут быть любыми.
   1. Топик для хранения данных `locations`. Настройки топика могут быть любыми.

1. [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-user) с именем `ksql` и назначьте ему роли `ACCESS_ROLE_PRODUCER` и `ACCESS_ROLE_CONSUMER` для всех созданных ранее топиков.

1. Убедитесь, что вы можете подключиться к серверу ksqlDB.

1. Установите утилиту `kafkacat` на сервер ksqlDB и убедитесь, что можете с ее помощью [подключиться к кластеру {{ mkf-name }} через SSL](../../managed-kafka/operations/connect.md#get-ssl-cert).

1. Установите утилиту для потоковой обработки JSON-файлов [jq](https://stedolan.github.io/jq/) на сервер ksqlDB. 

## Настройте интеграцию с {{ KF }} для базы ksqlDB {#configure-ksqldb-for-kf}

1. Подключитесь к серверу ksqlDB.
1. Добавьте SSL-сертификат в хранилище доверенных сертификатов Java (Java Key Store), чтобы ksqlDB мог использовать этот сертификат при защищенном подключении к хостам кластера. При этом задайте пароль в параметре `-storepass` для дополнительной защиты хранилища:

   ```bash
   cd /etc/ksqldb && \
   sudo keytool -importcert -alias {{ crt-alias }} -file {{ crt-local-dir }}{{ crt-local-file }} \
   -keystore ssl -storepass <пароль хранилища сертификатов> \
   --noprompt
   ```

1. Укажите в файле конфигурации ksqlDB `/etc/ksqldb/ksql-server.properties` данные для аутентификации в кластере {{ mkf-name }}:

   ```ini
   bootstrap.servers=<FQDN брокера 1:9091, ..., FQDN брокера N:9091>
   sasl.mechanism=SCRAM-SHA-512
   security.protocol=SASL_SSL
   ssl.truststore.location=/etc/ksqldb/ssl
   ssl.truststore.password=<пароль хранилища сертификатов>
   sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="ksql" password="<пароль пользователя ksql>";
   ```

   FQDN брокеров можно запросить со [списком хостов в кластере](../operations/cluster-hosts.md#list-hosts), имя кластера — со [списком кластеров в каталоге](../operations/cluster-list.md#list-clusters).

1. Перезапустите сервис ksqlDB командой:

    ```bash
    sudo systemctl restart confluent-ksqldb.service
    ````

## Изучите формат данных, поступающих от {{ mkf-name }} {#explore-kf-data-format}

Обработка потока данных из {{ mkf-name }} зависит от формата представления в сообщении {{ KF }}.

В примере в топик {{ KF }} `locations` будут записываться геоданные в формате JSON:
* идентификатор `profileId`;
* широта `latitude`;
* долгота `longitude`;

Эти данные будут передаваться в виде сообщений {{ KF }}. Каждое такое сообщение будет содержать JSON-объект как строку следующего вида:

```json
{"profileId": "c2309eec", "latitude": 37.7877, "longitude": -122.4205}
```

База ksqlDB будет использовать таблицу из трех столбцов, в которой хранятся значения соответствующих параметров из сообщений {{ KF }}. 

Далее выполним настройку полей потоковой таблицы в базе ksqlDB.

## Создайте в ksqlDB таблицу для записи потока данных из топика {{ KF }} {#create-kf-table}

Чтобы записывать информацию из топика {{ KF }}, создайте в базе ksqlDB таблицу. Структура таблицы соответствует [формату данных](#explore-kf-data-format), которые поступают из {{ mkf-name }}:
1. Подключитесь к серверу ksqlDB.
1. Запустите клиент `ksql` командой:

   ```bash
   ksql http://0.0.0.0:8088
   ```

1. Выполните запрос:

   ```sql
   CREATE STREAM riderLocations 
   (
     profileId VARCHAR,
     latitude DOUBLE,
     longitude DOUBLE
   ) WITH 
   (
     kafka_topic='locations', 
     value_format='json', 
     partitions=<количество разделов топика "locations">
   );
   ``` 

   Эта потоковая таблица будет автоматически наполняться сообщениями из топика `locations` кластера {{ mkf-name }}. Для чтения сообщений ksqlDB использует [настройки](#configure-ksqldb-for-kf) пользователя `ksql`.

   Подробнее о создании потоковой таблицы на движке ksqlDB см. в [документации ksqlDB](https://www.confluent.io/blog/how-real-time-stream-processing-works-with-ksqldb).

1. Выполните запрос:
         
   ```sql
   SELECT * FROM riderLocations WHERE 
            GEO_DISTANCE(latitude, longitude, 37.4133, -122.1162) <= 5 
            EMIT CHANGES;
   ```
   
   Запрос ожидает появления данных в таблице в реальном времени.

## Получите тестовые данные из кластера {{ mkf-name }} {#get-data-from-kf}

1. Подключитесь к серверу ksqlDB.   
1. Создайте файл `sample.json` со следующими тестовыми данными:

   ```json
   {
     "profileId": "c2309eec", 
     "latitude": 37.7877,
     "longitude": -122.4205
   }

   {
     "profileId": "4ab5cbad", 
     "latitude": 37.3952,
     "longitude": -122.0813
   }

   {
     "profileId": "4a7c7b41", 
     "latitude": 37.4049,
     "longitude": -122.0822
   }   
   ```

1. Отправьте файл `sample.json` в топик `locations` кластера {{ mkf-name }} с помощью `jq`  и `kafkacat`:

   ```bash
   jq -rc . sample.json | kafkacat -P \
      -b <FQDN брокера 1:9091, ..., FQDN брокера N:9091> \
      -t locations \
      -X security.protocol=SASL_SSL \
      -X sasl.mechanisms=SCRAM-SHA-512 \
      -X sasl.username=ksql \
      -X sasl.password="<пароль пользователя ksql>" \
      -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
   ```

   Информация отправляется с помощью пользователя `ksql`. Подробнее о настройке SSL-сертификата и работе с `kafkacat` см. в разделе [{#T}](../operations/connect.md).

1. Убедитесь, что в [сессии](#create-kf-table) отобразились данные, которые были отправлены в топик:

   ```text
   +--------------------------+--------------------------+------------------------+
   |PROFILEID                 |LATITUDE                  |LONGITUDE               |
   +--------------------------+--------------------------+------------------------+
   |4ab5cbad                  |37.3952                   |-122.0813               | 
   |4a7c7b41                  |37.4049                   |-122.0822               |
   ```

  Данные считываются с помощью пользователя `ksql`.

## Запишите тестовые данные в ksqlDB {#insert-data-to-ksqldb}

1. Подключитесь к серверу ksqlDB.
1. Запустите клиент `ksql` командой:

   ```bash
   ksql http://0.0.0.0:8088
   ```

1. Вставьте тестовые данные в таблицу `riderLocations`:

   ```sql
   INSERT INTO riderLocations (profileId, latitude, longitude) VALUES ('18f4ea86', 37.3903, -122.0643);
   INSERT INTO riderLocations (profileId, latitude, longitude) VALUES ('8b6eae59', 37.3944, -122.0813);
   INSERT INTO riderLocations (profileId, latitude, longitude) VALUES ('4ddad000', 37.7857, -122.4011);
   ```

   Эти данные синхронно отправляются в топик {{ KF }} `locations` с помощью пользователя `ksql`.

## Проверьте наличие тестовых данных в топике {{ KF }} {#fetch-data-from-kf}

1. Подключитесь к серверу ksqlDB.
1. Проверьте сообщения в топике `locations` кластера {{ mkf-name }} с помощью `kafkacat` и пользователя `ksql`:

   ```bash
   kafkacat -C \
    -b <FQDN брокера 1:9091, ..., FQDN брокера N:9091> \
    -t locations \
    -X security.protocol=SASL_SSL \
    -X sasl.mechanisms=SCRAM-SHA-512 \
    -X sasl.username=ksql \
    -X sasl.password="<пароль пользователя ksql>" \
    -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z -K:
   ```

1. Убедитесь, что в консоли отображаются сообщения, которые вы [записали в таблицу](#insert-data-to-ksqldb). 

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

* [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
* Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
* [Удалите кластер {{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
