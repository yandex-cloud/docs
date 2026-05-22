<!-- Changelog begin -->




<!-- Changelog end -->

# История изменений Yandex MetaData Hub

## 2026 год {#2026}


### Март {#mar26}

Добавлен новый тип источника данных — [DataLens](../../datalens/index.md) — сервис бизнес-аналитики для визуализации данных. Теперь вы можете [настраивать загрузку](../operations/data-catalog/create-ingestion.md) данных из DataLens и [анализировать связи](../quickstart/data-analyst-quickstart.md) между датасетами.


### Январь {#jan26}

Параметры подключения к [Schema Registry](../concepts/schema-registry.md) теперь можно указывать в настройках источников данных [Apache Kafka®](../../data-transfer/operations/endpoint/source/kafka.md) и [Data Streams](../../data-transfer/operations/endpoint/source/data-streams.md) в сервисе Data Transfer.

## 2025 год {#2025}

### Декабрь {#dec25}


#### Новые возможности {#new-features-dec25}

Пользователи [Data Catalog](../concepts/data-catalog.md) получили дополнительные возможности для анализа и управления метаданными:

* пространство для управления разметкой данных с режимом массового редактирования и отображением статистики;

* хранилище данных для просмотра наборов данных, загруженных из нескольких источников.


#### Решенные проблемы {#problems-solved-dec5}

Исправлена ошибка при использовании подключений к пользовательской инсталляции Yandex StoreDoc.


### Ноябрь {#nov25}

#### Новые возможности {#new-features-nov25}

* Добавлен MCP-сервер для Data Catalog, который позволяет подключать AI-агентов для поиска по метаданным, просмотра каталогов, получения метаданных по их идентификаторам и получения связей между метаданными.

* Появилась возможность добавлять запросы в WebSQL.

#### Решенные проблемы {#problems-solved-nov25}

Улучшено профилирование метаданных и контекстный поиск.


### Октябрь {#oct25}

#### Новые возможности {#new-features-oct25}

* Подключения [Connection Manager](../concepts/connection-manager.md) для кластеров управляемых баз данных MongoDB переименованы в подключения Yandex StoreDoc.


* В [Data Catalog](../concepts/data-catalog.md) добавлены новые источники данных: [WebSQL](../../websql/index.md), [Yandex StoreDoc/MongoDB](../../storedoc/index.md), [OpenSearch](../../managed-opensearch/index.md) и [Greenplum®](../../managed-greenplum/index.md). Также пользователи могут [исполнять SQL-запросы](../operations/data-catalog/web-sql-query.md) с помощью сервиса WebSQL.

* Добавлена возможность профилирования метаданных в Data Catalog.


#### Решенные проблемы {#problems-solved-oct25}

* В Connection Manager добавлена валидация имени подключения и генерации паролей.

### Сентябрь {#sep25}

#### Новые возможности {#new-features-sep25}

* [Connection Manager](../concepts/connection-manager.md) перешел в стадию [стадию General Availability](../../overview/concepts/launch-stages.md); поддержана работа с YC CLI и Terraform.


* [Apache Hive™ Metastore](../concepts/metastore.md) перешел в стадию [стадию General Availability](../../overview/concepts/launch-stages.md); использование кластеров стало [платным](../pricing.md).

* [Data Catalog](../concepts/data-catalog.md) перешел в стадию [стадию Public Preview](../../overview/concepts/launch-stages.md); реализована [AI-разметка](../operations/data-catalog/markup-metadata.md) метаданных и [AI-поиск](../operations/data-catalog/search-metadata.md).


### Август {#august25}

#### Новые возможности {#new-features-august25}

* В [Connection Manager](../concepts/connection-manager.md) добавлена возможность управлять подключениями с пользовательскими инсталляциями [Apache Kafka®](../operations/create-connection.md#kafka) и [кластерами Managed Service for Apache Kafka®](../operations/create-connection.md#mdb-kafka), а также поддержаны [шардированные кластеры](../../managed-clickhouse/concepts/sharding.md) в ClickHouse®.

#### Решенные проблемы {#problems-solved-august25}

* Повышена стабильность работы с подключениями в [Connection Manager](../concepts/connection-manager.md).


### Июль {#july25}

#### Новые возможности {#new-features-july25}


* Улучшен пользовательский интерфейс [Data Catalog](../concepts/data-catalog.md); повышена стабильность работы инструмента.


* Добавлена возможность управлять параметрами подключения к базе данных в Connection Manager с помощью [API](../api-ref/authentication-connman.md).

### Июнь {#june25}

#### Новые возможности {#new-features-june25}


* В сервисе Yandex MetaData Hub появился инструмент [Data Catalog](../concepts/data-catalog.md) для сбора, анализа и разметки метаданных от различных источников. Data Catalog находится на стадии [Technical Preview](../../overview/concepts/launch-stages.md) и предоставляется по запросу в [техническую поддержку](https://center.yandex.cloud/support).

* При создании новых кластеров [Managed Service for MySQL®](../../managed-mysql/operations/cluster-create.md) и [Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md) теперь автоматически создаются подключения в [Connection Manager](../concepts/connection-manager.md). Для старых кластеров доступна миграция.


* Расширен список эндпоинтов в Yandex Data Transfer, для которых поддержана интеграция с Connection Manager.

### Апрель {#april25}

#### Новые возможности {#new-features-april25}


* При создании нового кластера [Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-create.md) теперь автоматически создаются подключения в [Connection Manager](../concepts/connection-manager.md). Для старых кластеров доступна миграция.


#### Решенные проблемы {#problems-solved-april25}

* Исправлена конфигурация Schema Registry для устранения ошибки `too many active clients for user`.
* Исправлено удаление субъекта и схемы в Schema Registry.


### Март {#march25}

#### Новые возможности {#new-features-march25}

* Добавлена кнопка загрузки схемы в существующий [субъект](../concepts/schema-registry.md#subject) Schema Registry.
* В документации сервиса появился раздел [Публичные материалы о Yandex MetaData Hub](../public-talks.md).

### Февраль {#february25}

#### Новые возможности {#new-features-february25}

* В списке подключений реализовано разграничение доступа. Пользователи будут видеть только те подключения, к которым у них есть доступ (выдана [роль `connection-manager.auditor`](../security/connection-manager-roles.md#connection-manager-auditor) или [роль `connection-manager.viewer`](../security/connection-manager-roles.md#connection-manager-viewer)). Пользователь с доступом к каталогу будет видеть все подключения в этом каталоге.
* Повышена стабильность работы при передаче пароля сервисам Yandex Data Transfer, Yandex WebSQL и DataLens.

### Январь {#january25}

#### Новые возможности {#new-features-january25}

* Добавлена возможность управлять соединениями с пользовательскими инсталляциями [MongoDB](../operations/create-connection.md#mongodb-on-premise) и кластерами [Yandex StoreDoc](../operations/create-connection.md#mdb-mongodb).
* Обновлена настройка ввода пароля в форме [создания](../operations/create-connection.md) и [редактирования](../operations/update-connection.md) соединения. 
* Появилась возможность настраивать политику совместимости JSON-схем в [реестре схем](../concepts/schema-registry.md).

#### Решенные проблемы {#problems-solved-january25}

* Исправлена ошибка работы реестра схем, приводившая к избыточному количеству подключений к базам данных.

## 2024 год {#2024}

### Декабрь {#december}

#### Новые возможности {#new-features-december}

Добавлена возможность управлять соединениями со следующими СУБД:
* пользовательская инсталляция [Trino](../operations/create-connection.md#trino-on-premise);
* пользовательская инсталляция [OpenSearch](../operations/create-connection.md#opensearch-on-premise);
* кластер [Managed Service for OpenSearch](../operations/create-connection.md#mdb-opensearch).

### Ноябрь {#november}

#### Новые возможности {#new-features-november}

* В консоли управления появилась возможность подключаться к выбранному [пространству имен](../operations/update-name-space.md) Schema Registry.

### Октябрь {#october}

#### Новые возможности {#new-features-october}

* Добавлены новые возможности для интеграции Connection Manager с [Yandex Data Transfer](../../data-transfer/quickstart.md): выпадающий список доступных подключений при создании трансфера.
* В Schema Registry поддержан механизм аутентификации с помощью [API-ключей](../../iam/concepts/authorization/api-key.md), который избавляет от необходимости регулярно обновлять значение секрета для аутентификации.

#### Решенные проблемы {#problems-solved-october}

* Улучшена стабильность при массовом создании подключений в Connection Manager.

### Сентябрь {#september}

#### Новые возможности {#new-features-september}

* [Кластеры Apache Hive™ Metastore](../concepts/metastore.md) стали частью сервиса Yandex MetaData Hub.
* [Schema Registry](../quickstart/schema-registry.md) доступен в [Preview](../../overview/concepts/launch-stages.md).
* Пользователи сервиса Yandex Data Transfer могут указывать идентификатор подключения Connection Manager для [настройки эндпоинта Managed Service for PostgreSQL](../../data-transfer/operations/endpoint/source/postgresql.md).
* Пользователи сервиса Yandex DataLens могут использовать Connection Manager для создания подключений к [PostgreSQL](../../datalens/operations/connection/create-postgresql.md#conn-man), [ClickHouse®](../../datalens/operations/connection/create-clickhouse.md#conn-man) и [MySQL®](../../datalens/operations/connection/create-mysql.md#conn-man).

### Август {#august}

#### Новые возможности {#new-features-august}

Поддержаны соединения для пользовательских инсталляций БД Redis и кластеров [Yandex Managed Service for Valkey™](../../managed-valkey/concepts/index.md).

### Июль {#july}

#### Новые возможности {#new-features-july}

Добавлена интеграция [Connection Manager](../concepts/connection-manager.md) с [Managed Service for ClickHouse®](../../managed-clickhouse/index.md). Подключения для кластеров Managed Service for ClickHouse® [будут создаваться автоматически](../quickstart/connection-manager.md).

### Июнь {#june}

#### Новые возможности {#new-features-june}

1. Добавлен фильтр по имени в [списке подключений](../operations/view-connection.md).
1. Добавлена возможность просматривать [операции](../operations/view-connection.md#operations) выбранного подключения.

#### Решенные проблемы {#problems-solved-june}

1. Исправлена ошибка просмотра подключений к пользовательским инсталляциям баз данных.
1. Параметры подключения стали доступны для редактирования.

### Май {#may}

#### Новые возможности {#new-features-may}

1. Добавлена интеграция [Connection Manager](../concepts/connection-manager.md) с [Managed Service for MySQL®](../../managed-mysql/index.md). Подключения для кластеров Managed Service for MySQL® [будут создаваться автоматически](../quickstart/connection-manager.md).
1. Добавлена возможность указывать базы данных в подключениях к [ClickHouse®](../operations/create-connection.md#mdb-clickhouse).


_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._


_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._