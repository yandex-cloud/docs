# Обзор СУБД Greenplum® и Apache Cloudberry™ в сервисе Yandex MPP Analytics for PostgreSQL

Сервис Yandex MPP Analytics for PostgreSQL позволяет разворачивать в инфраструктуре Yandex Cloud [кластеры](index.md) аналитических колоночных массово-параллельных ([MPP](https://ru.wikipedia.org/wiki/Массово-параллельная_архитектура)) СУБД на основе PostgreSQL для работы с большими объемами данных. Каждая СУБД объединяет несколько баз данных PostgreSQL в кластер по принципу MPP и обеспечивает их взаимодействие через сеть Interconnect. Каждый узел кластера использует свою операционную систему, память и диски, благодаря чему данные хранятся и обрабатываются на множестве узлов параллельно. MPP-архитектура позволяет масштабировать систему горизонтально, гарантирует высокую доступность кластера и линейный рост производительности. 

В сервисе доступны следующие СУБД:

* Greenplum® 6.28 и 6.29 — основаны на PostgreSQL версии 9.4. 

    Greenplum® создавалась как open-source проект, но в 2024 году доступ к исходному коду закрыли. Несмотря на это, в сервисе Yandex MPP Analytics for PostgreSQL по-прежнему поддерживается Greenplum® версии 6 на основе ее open-source [форка](https://github.com/open-gpdb/gpdb).

* Apache Cloudberry™ 2 — основана на Greenplum® версии 7, но использует более новое ядро PostgreSQL версии 14, а также поддерживает работу с динамическими таблицами и форматом [PAX](https://cloudberry.apache.org/docs/operate-with-data/pax-table-format/).

    Apache Cloudberry™ — это open-source проект, который разрабатывается под лицензией Apache License v2.0. 

    Apache Cloudberry™ будет базовым дистрибутивом для новых мажорных версий сервиса Yandex MPP Analytics for PostgreSQL.

Подробнее о различиях Apache Cloudberry™ и Greenplum® в [отдельном разделе](cloudberry-vs-greenplum/breaking-changes.md).

Yandex MPP Analytics for PostgreSQL берет на себя большую часть работ по обслуживанию кластеров, в том числе:

* Выделение ресурсов, создание и реконфигурация БД, установка обновлений ПО.
* Возвращение кластера в отказоустойчивое состояние в случае сбоя.
* Создание [резервных копий](backup.md) при помощи [WAL-G](https://wal-g.readthedocs.io/), их хранение в S3-хранилище и восстановление данных на любой момент времени ([PITR](https://ru.wikipedia.org/wiki/Восстановление_на_момент_времени)).

Сервис также предлагает инструменты для самостоятельной работы с кластерами:

* [Роли](../security/index.md) для управления доступом к данным.
* [Командный центр](command-center.md) и [метрики](../metrics.md) для отслеживания состояния кластера.
* Расширение [Yezzey](../operations/extensions/yezzey.md) для организации гибридного хранилища.

Кластеры Yandex MPP Analytics for PostgreSQL можно интегрировать с другими сервисами Yandex Cloud, например с [Yandex Data Transfer](../../data-transfer/index.md) для переноса БД или с [Yandex DataLens](../../datalens/index.md) для визуализации данных.

## Сценарии применения Yandex MPP Analytics for PostgreSQL {#usage}

* Аналитическая БД. Например, вы можете линейно ускорять выполнение масштабных хеш-соединений, добавляя дополнительные CPU или узлы.
* Универсальная БД на замену Oracle DB, Microsoft SQL Server или IBM DB2. Yandex MPP Analytics for PostgreSQL можно использовать не только для аналитических задач, но и для выполнения множества коротких [OLTP-запросов](../../glossary/oltp.md), характерных для PostgreSQL.
* Более производительная альтернатива для БД PostgreSQL. Поскольку доступные в сервисе СУБД основаны на PostgreSQL, сервис поддерживает многие инструменты для работы с PostgreSQL, например интерфейсы JDBC и ODBC, а также стандарт ANSI SQL:2008.

## Полезные ссылки {see-also}

* [Официальная документация Greenplum®](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/landing-index.html)
* [Официальная документация Apache Cloudberry™](https://cloudberry.apache.org/docs/)
* [Как начать работать с Yandex MPP Analytics for PostgreSQL](../quickstart.md)
* [Взаимосвязь ресурсов сервиса Yandex MPP Analytics for PostgreSQL](index.md)
* [Практические руководства Yandex MPP Analytics for PostgreSQL](../tutorials/index.md)

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_Apache® и Apache Cloudberry™ являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._