# Обзор СУБД Greenplum® и сервиса Yandex MPP Analytics for PostgreSQL

Greenplum® — аналитическая колоночная СУБД, предназначенная для хранения и обработки больших объемов информации.

Greenplum® основана на PostgreSQL и представляет собой несколько баз данных PostgreSQL, которые объединены в один кластер по принципу [MPP](https://ru.wikipedia.org/wiki/Массово-параллельная_архитектура) и взаимодействуют друг с другом через сеть Interconnect. Каждый узел кластера использует свою операционную систему, память и диски, благодаря чему данные хранятся и обрабатываются на множестве узлов параллельно. MPP-архитектура позволяет масштабировать систему горизонтально, гарантирует высокую доступность кластера и линейный рост производительности.

## Сценарии применения Greenplum® {#usage}

* Аналитическая БД. Например, в Greenplum® можно линейно ускорять выполнение масштабных хеш-соединений, добавляя дополнительные CPU или узлы.
* Универсальная БД на замену Oracle DB, Microsoft SQL Server или DB2. Greenplum® подходит не только для аналитических задач, но и для выполнения множества коротких [OLTP-запросов](../../glossary/oltp.md), характерных для PostgreSQL.
* Более производительная альтернатива для БД PostgreSQL. Поскольку Greenplum® построена на основе PostgreSQL, она поддерживает многие инструменты для работы с PostgreSQL, например интерфейсы JDBC и ODBC, а также стандарт ANSI SQL:2008.

## Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL {#managed-gp}

Greenplum® создавалась как open-source проект, но в 2024 году доступ к исходному коду закрыли. Несмотря на это, в сервисе Yandex MPP Analytics for PostgreSQL по-прежнему поддерживается Greenplum® версии 6 на основе ее open-source [форка](https://github.com/orgs/open-gpdb/discussions/11). 

Сервис позволяет разворачивать [кластеры](index.md) Greenplum® в инфраструктуре Yandex Cloud и берет на себя большую часть работ по обслуживанию, в том числе:

* Выделение ресурсов, создание и реконфигурация БД, установка обновлений ПО.
* Возвращение кластера в отказоустойчивое состояние в случае сбоя.
* Создание [резервных копий](backup.md) при помощи [WAL-G](https://wal-g.readthedocs.io/), их хранение в S3-хранилище и восстановление данных на любой момент времени ([PITR](https://ru.wikipedia.org/wiki/Восстановление_на_момент_времени)).

Сервис также предлагает инструменты для самостоятельной работы с кластерами Greenplum®:

* [Роли](../security/index.md) для управления доступом к данным.
* [Командный центр](command-center.md) и [метрики](../metrics.md) для отслеживания состояния кластера.
* Расширение [Yezzey](../operations/extensions/yezzey.md) для организации гибридного хранилища.

Кластеры Yandex MPP Analytics for PostgreSQL можно интегрировать с другими сервисами Yandex Cloud, например с [Yandex Data Transfer](../../data-transfer/index.md) для переноса БД или с [Yandex DataLens](../../datalens/index.md) для визуализации данных.

## См. также {see-also}

* [Официальная документация Greenplum®](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/landing-index.html)
* [Как начать работать с Yandex MPP Analytics for PostgreSQL](../quickstart.md)
* [Взаимосвязь ресурсов сервиса Yandex MPP Analytics for PostgreSQL](index.md)
* [Практические руководства Yandex MPP Analytics for PostgreSQL](../tutorials/index.md)

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._