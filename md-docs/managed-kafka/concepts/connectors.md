# Коннекторы

Коннекторы — это [встроенные в Managed Service for Apache Kafka®](#supported) компоненты инструмента Kafka Connect для передачи информации между Apache Kafka® и другими хранилищами данных. Коннектор можно использовать для непрерывной миграции данных в кластер Managed Service for Apache Kafka® или из него. Работа с данными в коннекторе выполняется в отдельных потоках *процесса-исполнителя* Kafka Connect (worker). Подробнее о Kafka Connect в [документации Apache Kafka®](https://kafka.apache.org/42/kafka-connect/overview/).

Коннектор выполняет следующие функции:

* Подключение к кластеру Managed Service for Apache Kafka® и другим хранилищам данных.
* Чтение и запись данных.
* Управление процессом работы с данными.

Для любого типа коннекторов можно указать:

* Лимит задач. Определяет количество одновременно запущенных процессов-исполнителей.
* Дополнительные свойства.

Пошаговые инструкции по работе с коннекторами в разделе [Управление коннекторами](../operations/cluster-connector.md).

## Поддерживаемые коннекторы {#supported-connectors}

### MirrorMaker {#mirrormaker}

{% note info %}

В сервисе Managed Service for Apache Kafka® поддержан **MirrorMaker** версии 2.

{% endnote %}

Коннектор **MirrorMaker** используется для межкластерной репликации топиков Apache Kafka®.

Процесс-исполнитель обращается к хостам-брокерам кластера Managed Service for Apache Kafka® и реплицирует топики, указанные в шаблоне фильтрации коннектора. В зависимости от фактора репликации коннектора, подключение происходит к одному или нескольким брокерам.

Названия топиков в кластере-приемнике совпадают с их названиями в кластере-источнике.

Подробнее о том, как MirrorMaker выполняет перенос данных, см. [в документации Apache Kafka®](https://kafka.apache.org/42/operations/geo-replication-cross-cluster-data-mirroring/).

### S3 Sink {#s3-sink}

Коннектор **S3 Sink** используется только в качестве приемника для экспорта данных из топиков Apache Kafka® в хранилище S3.

Коннектор периодически запрашивает данные из Apache Kafka® и загружает их в хранилище S3. Данные разделяются на куски (chunks), которые представляют собой файл-объекты S3. Размер каждого такого куска данных зависит от заданного максимального количества записей в нем.

Подробнее о том, как S3 Sink выполняет перенос данных, в [документации коннектора](https://github.com/aiven/s3-connector-for-apache-kafka).


## Примеры использования {#examples}

* [Настройка Kafka Connect для работы с кластером Managed Service for Apache Kafka®](../tutorials/kafka-connect.md)
* [Миграция базы данных из стороннего кластера Apache Kafka®](../tutorials/kafka-connectors.md)
* [Перенос данных между кластерами Managed Service for Apache Kafka® с помощью Yandex Data Transfer](../tutorials/mkf-to-mkf-transfer.md)