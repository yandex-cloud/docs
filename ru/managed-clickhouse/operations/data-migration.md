# Миграция данных в {{ mch-name }}

Чтобы перенести вашу базу данных в сервис {{ mch-name }}, нужно непосредственно перенести данные, закрыть старую базу данных на запись и перенести нагрузку на кластер БД в {{ yandex-cloud }}.

Перенести данные в кластер {{ mch-name }} можно с помощью [Apache ZooKeeper](http://zookeeper.apache.org) и стандартной утилиты [clickhouse-copier]({{ ch.docs }}/operations/utils/clickhouse-copier/).

Переносить данные на промежуточную виртуальную машину в Compute Cloud нужно, если:

* К кластеру {{ mch-name }} нет доступа из интернета.
* Сетевое оборудование или соединение с {{ CH }}-кластером в {{ yandex-cloud }} не обладают достаточной надежностью.
* Нет среды, в которой можно запустить `clickhouse-copier`.

Этапы миграции:
1. [Подготовьтесь к миграции](#prepare).
1. [Установите Zookeeper](#zookeeper-install).
1. [Создайте кластер {{ mch-name }}](#create-cluster).
1. [Создайте задачу](#copier-task) для `clickhouse-copier`.
1. [Добавьте задачу](#zookeeper-task) для `clickhouse-copier` в Zookeeper.
1. [Запустите](#copier-run) `clickhouse-copier`.

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьтесь к миграции {#prepare}

1. Версии ПО удовлетворяют условиям:

    * Версии {{ CH }} в обоих кластерах должны совпадать.
    * Версия `clickhouse-copier` должна быть не ниже версии {{ CH }} в кластере
    {{ mch-name }}.
    * Версия ZooKeeper — не ниже 3.5.

1. Проверьте, что кластер-источник готов к миграции:

    * Включен SSL для шифрования трафика.
    * Нагрузка на базу или шард, с которого будут копироваться данные, не создаст
    проблем.
    * У `clickhouse-copier` есть доступ к базе данных, и используемый аккаунт имеет
    доступ только на чтение.

1. Если вы используете для миграции виртуальную машину в {{ yandex-cloud }}:
    * ВМ следует создавать в той же облачной сети, что и кластер {{ mch-name }}.
    * Вычислительную мощность ВМ стоит выбирать исходя из объема переносимых данных.


## Установите Zookeeper {#zookeeper-install}

Чтобы скопировать данные, достаточно запустить один узел ZooKeeper.

1. Установите Java Runtime Environment:

    ```bash
    $ sudo apt-get install default-jre
    ```

1. Добавьте пользователя, от имени которого будет запускаться Zookeeper:

    ```
    $ sudo adduser hadoop
    ```

1. Создайте каталоги для данных ZooKeeper:

    ```bash
    $ sudo mkdir -p /var/data/zookeeper
    $ sudo chown -R hadoop:hadoop /var/data
    ```

1. Установите ZooKeeper в режиме одного узла:

    1. Скачайте последнюю стабильную версию (latest stable) дистрибутива. Подробную информацию можно узнать на [странице с релизами](https://zookeeper.apache.org/releases.html).

        ```bash
        $ cd /opt
        $ sudo wget https://downloads.apache.org/zookeeper/zookeeper-3.6.2/apache-zookeeper-3.6.2-bin.tar.gz
        $ sudo mkdir zookeeper
        $ sudo tar -C /opt/zookeeper -xvf apache-zookeeper-3.6.2-bin.tar.gz --strip-components 1
        $ sudo chown hadoop:hadoop -R zookeeper
        ```
    1. Переключитесь на созданного ранее пользователя для запуска ZooKeeper:

        ```
        $ su hadoop
        ```

    1. Создайте файл `zoo.cfg`:

        ```
        nano /opt/zookeeper/conf/zoo.cfg
        ```
        
        со следующим содержимым:
        
        ```ini
        tickTime=2000
        dataDir=/var/data/zookeeper
        clientPort=2181
        ```

    1. Мастер-узел должен иметь уникальный идентификатор. Чтобы задать его, создайте файл  `myid`.
    
       ```
       nano /var/data/zookeeper/myid
       ```
       
       Укажите уникальный идентификатор в качестве содержимого, (например, «1»).

1. Запустить ZooKeeper для отладки можно так:

    ```bash
    $ bash /opt/zookeeper/bin/zkServer.sh start-foreground
    ```

1. Чтобы запустить ZooKeeper в обычном режиме:

    ```bash
    $ bash /opt/zookeeper/bin/zkServer.sh start
    ```


## Создайте кластер {{ mch-name }} {#create-cluster}

Убедитесь, что вычислительная мощность и размер хранилища кластера соответствуют среде,
 в которой развернуты уже имеющиеся базы данных, и [создайте кластер](cluster-create.md).


## Создайте задачу для clickhouse-copier {#copier-task}

Чтобы запустить `clickhouse-copier` с помощью ZooKeeper, нужно подготовить:

* конфигурационный файл для Zookeeper (`config.xml`);
* файл описания задачи (`cp-task.xml`).

Инструкция по использованию `clickhouse-copier` приведена в [документации ClickHouse]({{ ch.docs }}/operations/utils/clickhouse-copier/).


### Подготовьте конфигурационный файл ZooKeeper {#zookeeper-config}

В конфигурационном файле (`config.xml`) нужно указать:

* В элементе `<zookeeper>` — адрес хоста, на котором установлен ZooKeeper.
* В элементе `<caConfig>` — путь к сертификату для подключения к {{ mch-name }}.

Скачать сертификат можно по адресу [https://{{ s3-storage-host }}{{ pem-path }}](https://{{ s3-storage-host }}{{ pem-path }}).

Пример конфигурации:

```xml
<yandex>
  <zookeeper>
    <node>
      <host>127.0.0.1</host>
      <port>2181</port>
    </node>
  </zookeeper>

  <logger>
    <level>trace</level>
    <log>log.log</log>
    <errorlog>log.err.log</errorlog>
    <size>never</size>
  </logger>

  <openSSL>
    <client>
      <loadDefaultCAFile>true</loadDefaultCAFile>
      <caConfig>CA.pem</caConfig>
      <cacheSessions>true</cacheSessions>
      <disableProtocols>sslv2,sslv3</disableProtocols>
      <preferServerCiphers>true</preferServerCiphers>
      <invalidCertificateHandler>
        <name>RejectCertificateHandler</name>
      </invalidCertificateHandler>
    </client>
  </openSSL>
</yandex>
```


### Опишите задачу {#task-description}

Пример описания задачи переноса данных (`cp-task.xml`):

```xml
<yandex>
    <tcp_port_secure>9440</tcp_port_secure> <!-- опционально -->
    <remote_servers>
        <source_cluster>
            <shard>
                <internal_replication>false</internal_replication>
                    <replica>
                        <host>your-clickhouse-server.com</host>
                        <port>9440</port>
                        <user>your-user</user>
                        <password>password</password>
                        <secure>1</secure>
                    </replica>
            </shard>
        </source_cluster>

        <destination_cluster>
               <shard>
                <internal_replication>false</internal_replication>
                    <replica>
                        <host>your-cloud-clickhouse.{{ mdb-host }}</host>
                        <port>9440</port>
                        <user>your-user</user>
                        <password>password</password>
                        <secure>1</secure>
                    </replica>
               </shard>
        </destination_cluster>
    </remote_servers>

    <max_workers>2</max_workers>

    <settings_pull>
        <readonly>1</readonly>
    </settings_pull>

    <settings_push>
        <readonly>0</readonly>
    </settings_push>

    <settings>
        <connect_timeout>3</connect_timeout>
        <insert_distributed_sync>1</insert_distributed_sync>
    </settings>

    <tables>
        <table_hits>
            <cluster_pull>source_cluster</cluster_pull>
    	    <database_pull>your-db</database_pull>
            <table_pull>your-table</table_pull>

            <cluster_push>destination_cluster</cluster_push>
            <database_push>your-db</database_push>
            <table_push>your-table</table_push>

            <engine>
                <!-- Описание движка таблицы, такое же как в процедуре CREATE TABLE
                в кластере-источнике. Для существующей таблицы описание можно
                получить запросом SHOW CREATE table_name -->
	            ENGINE = MergeTree() PARTITION BY Year ORDER BY (Year, FlightDate) SETTINGS index_granularity=8192
	        </engine>

    	    <sharding_key>jumpConsistentHash(intHash64(Year), 2)</sharding_key>

            <enabled_partitions>
                <partition>'2017'</partition>
	        </enabled_partitions>
        </table_hits>
    </tables>
</yandex>
```


## Добавьте задачу для clickhouse-copier в Zookeeper {#zookeeper-task}

Чтобы добавить задачу в ZooKeeper, выполните следующие команды:

```bash
/opt/zookeeper/bin/zkCli.sh -server localhost:2181 deleteall /cp-task.xml/description
/opt/zookeeper/bin/zkCli.sh -server localhost:2181 deleteall /cp-task.xml/task_active_workers
/opt/zookeeper/bin/zkCli.sh -server localhost:2181 deleteall /cp-task.xml

fc=$(cat ./cp-task.xml)
/opt/zookeeper/bin/zkCli.sh -server localhost:2181 create /cp-task.xml ""
/opt/zookeeper/bin/zkCli.sh -server localhost:2181 create /cp-task.xml/description "$fc"
```


## Запустите clickhouse-copier {#copier-run}

{% note warning %}

Если вы не создали каталоги, которые указываете в значении флага `--base-dir` или для сохранения файлов с логами, `clickhouse-copier` может не запуститься.

{% endnote %}

Запустить copier можно с помощью следующей команды (чтобы запустить в режиме демона
добавьте флаг `--daemon`):

```bash
$ clickhouse-copier
  --config ./config.xml \
  --task-path ./cp-task.xml \
  --base-dir ./clickhouse \
  --log-level debug
```

После завершения операции обязательно проверьте логи, чтобы убедиться, что копирование
завершилось успешно.

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, [удалите кластер {{ mch-full-name }}](../operations/cluster-delete.md).
