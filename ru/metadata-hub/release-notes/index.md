---
title: История изменений в {{ metadata-hub-full-name }}
description: В разделе представлена история изменений сервиса {{ metadata-hub-name }}.
---

# История изменений {{ metadata-hub-full-name }}

## 2025 год {#2025}

### Октябрь {#oct25}

#### Новые возможности {#new-features-oct25}

* Подключения [{{ connection-manager-name }}](../concepts/connection-manager.md) для кластеров управляемых баз данных {{ MG }} переименованы в подключения {{ SD }}.


* В [{{ data-catalog-name }}](../concepts/data-catalog.md) добавлены новые источники данных: [{{ websql-name }}](../../websql/index.yaml), [{{ SD }}/{{ MG }}](../../storedoc/index.yaml), [{{ OS }}](../../managed-opensearch) и [{{ GP }}](../../managed-greenplum). Также пользователи могут [исполнять SQL-запросы](../operations/data-catalog/web-sql-query.md) с помощью сервиса {{ websql-name }}.

* Добавлена возможность профилирования метаданных в {{ data-catalog-name }}.


#### Решенные проблемы {#problems-solved-oct25}

* В {{ connection-manager-name }} добавлена валидация имени подключения и генерации паролей.

### Сентябрь {#sep25}

#### Новые возможности {#new-features-sep25}

* [{{ connection-manager-name }}](../concepts/connection-manager.md) перешел в стадию [стадию General Availability](../../overview/concepts/launch-stages.md); поддержана работа с YC CLI и Terraform.


* [{{ metastore-full-name }}](../concepts/metastore.md) перешел в стадию [стадию General Availability](../../overview/concepts/launch-stages.md); использование кластеров стало [платным](../pricing.md).

* [{{ data-catalog-name }}](../concepts/data-catalog.md) перешел в стадию [стадию Public Preview](../../overview/concepts/launch-stages.md); реализована [AI-разметка](../operations/data-catalog/markup-metadata.md) метаданных и [AI-поиск](../operations/data-catalog/search-metadata.md).


### Август {#august25}

#### Новые возможности {#new-features-august25}

* В [{{ connection-manager-name }}](../concepts/connection-manager.md) добавлена возможность управлять подключениями с пользовательскими инсталляциями [{{ KF }}](../operations/create-connection.md#kafka) и [кластерами {{ mkf-name }}](../operations/create-connection.md#mdb-kafka), а также поддержаны [шардированные кластеры](../../managed-clickhouse/concepts/sharding.md) в {{ CH }}.

#### Решенные проблемы {#problems-solved-august25}

* Повышена стабильность работы с подключениями в [{{ connection-manager-name }}](../concepts/connection-manager.md).


### Июль {#july25}

#### Новые возможности {#new-features-july25}


* Улучшен пользовательский интерфейс [{{ data-catalog-name }}](../concepts/data-catalog.md); повышена стабильность работы инструмента.


* Добавлена возможность управлять параметрами подключения к базе данных в {{ connection-manager-name }} с помощью [API](../api-ref/authentication-connman.md).

### Июнь {#june25}

#### Новые возможности {#new-features-june25}


* В сервисе {{ metadata-hub-name }} появился инструмент [{{ data-catalog-name }}](../concepts/data-catalog.md) для сбора, анализа и разметки метаданных от различных источников. {{ data-catalog-name }} находится на стадии [Technical Preview](../../overview/concepts/launch-stages.md) и предоставляется по запросу в [техническую поддержку]({{ link-console-support }}).

* При создании новых кластеров [{{ mmy-name }}](../../managed-mysql/operations/cluster-create.md) и [{{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) теперь автоматически создаются подключения в [{{ connection-manager-name }}](../concepts/connection-manager.md). Для старых кластеров доступна миграция.


* Расширен список эндпоинтов в {{ data-transfer-full-name }}, для которых поддержана интеграция с {{ connection-manager-name }}.

### Апрель {#april25}

#### Новые возможности {#new-features-april25}


* При создании нового кластера [{{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md) теперь автоматически создаются подключения в [{{ connection-manager-name }}](../concepts/connection-manager.md). Для старых кластеров доступна миграция.


#### Решенные проблемы {#problems-solved-april25}

* Исправлена конфигурация {{ schema-registry-name }} для устранения ошибки `too many active clients for user`.
* Исправлено удаление субъекта и схемы в {{ schema-registry-name }}.


### Март {#march25}

#### Новые возможности {#new-features-march25}

* Добавлена кнопка загрузки схемы в существующий [субъект](../concepts/schema-registry.md#subject) {{ schema-registry-name }}.
* В документации сервиса появился раздел [{#T}](../public-talks.md).

### Февраль {#february25}

#### Новые возможности {#new-features-february25}

* В списке подключений реализовано разграничение доступа. Пользователи будут видеть только те подключения, к которым у них есть доступ (выдана [роль `connection-manager.auditor`](../security/connection-manager-roles.md#connection-manager-auditor) или [роль `connection-manager.viewer`](../security/connection-manager-roles.md#connection-manager-viewer)). Пользователь с доступом к каталогу будет видеть все подключения в этом каталоге.
* Повышена стабильность работы при передаче пароля сервисам {{ data-transfer-full-name }}, {{ websql-full-name }} и {{ datalens-name }}.

### Январь {#january25}

#### Новые возможности {#new-features-january25}

* Добавлена возможность управлять соединениями с пользовательскими инсталляциями [{{ MG }}](../operations/create-connection.md#mongodb-on-premise) и кластерами [{{ mmg-name }}](../operations/create-connection.md#mdb-mongodb).
* Обновлена настройка ввода пароля в форме [создания](../operations/create-connection.md) и [редактирования](../operations/update-connection.md) соединения. 
* Появилась возможность настраивать политику совместимости JSON-схем в [реестре схем](../concepts/schema-registry.md).

#### Решенные проблемы {#problems-solved-january25}

* Исправлена ошибка работы реестра схем, приводившая к избыточному количеству подключений к базам данных.

## 2024 год {#2024}

### Декабрь {#december}

#### Новые возможности {#new-features-december}

Добавлена возможность управлять соединениями со следующими СУБД:
* пользовательская инсталляция [{{ TR }}](../operations/create-connection.md#trino-on-premise);
* пользовательская инсталляция [{{ OS }}](../operations/create-connection.md#opensearch-on-premise);
* кластер [{{ mos-name }}](../operations/create-connection.md#mdb-opensearch).

### Ноябрь {#november}

#### Новые возможности {#new-features-november}

* В консоли управления появилась возможность подключаться к выбранному [пространству имен](../operations/update-name-space.md) {{ schema-registry-name }}.

### Октябрь {#october}

#### Новые возможности {#new-features-october}

* Добавлены новые возможности для интеграции {{ connection-manager-name }} с [{{ data-transfer-full-name }}](../../data-transfer/quickstart.md): выпадающий список доступных подключений при создании трансфера.
* В {{ schema-registry-name }} поддержан механизм аутентификации с помощью [API-ключей](../../iam/concepts/authorization/api-key.md), который избавляет от необходимости регулярно обновлять значение секрета для аутентификации.

#### Решенные проблемы {#problems-solved-october}

* Улучшена стабильность при массовом создании подключений в {{ connection-manager-name }}.

### Сентябрь {#september}

#### Новые возможности {#new-features-september}

* [Кластеры {{ metastore-full-name }}](../concepts/metastore.md) стали частью сервиса {{ metadata-hub-name }}.
* [{{ schema-registry-name }}](../quickstart/schema-registry.md) доступен в [Preview](../../overview/concepts/launch-stages.md).
* Пользователи сервиса {{ data-transfer-full-name }} могут указывать идентификатор подключения {{ connection-manager-name }} для [настройки эндпоинта {{ mpg-short-name }}](../../data-transfer/operations/endpoint/source/postgresql.md).
* Пользователи сервиса {{ datalens-full-name }} могут использовать {{ connection-manager-name }} для создания подключений к [{{ PG }}](../../datalens/operations/connection/create-postgresql.md#conn-man), [{{ CH }}](../../datalens/operations/connection/create-clickhouse.md#conn-man) и [{{ MY }}](../../datalens/operations/connection/create-mysql.md#conn-man).

### Август {#august}

#### Новые возможности {#new-features-august}

Поддержаны соединения для пользовательских инсталляций БД {{ RD }} и кластеров [Managed Service for Redis](../../managed-redis/concepts/index.md).

### Июль {#july}

#### Новые возможности {#new-features-july}

Добавлена интеграция [{{ connection-manager-name }}](../concepts/connection-manager.md) с [{{ mch-short-name }}](../../managed-clickhouse). Подключения для кластеров {{ mch-short-name }} [будут создаваться автоматически](../quickstart/connection-manager.md).

### Июнь {#june}

#### Новые возможности {#new-features-june}

1. Добавлен фильтр по имени в [списке подключений](../operations/view-connection.md).
1. Добавлена возможность просматривать [операции](../operations/view-connection.md#operations) выбранного подключения.

#### Решенные проблемы {#problems-solved-june}

1. Исправлена ошибка просмотра подключений к пользовательским инсталляциям баз данных.
1. Параметры подключения стали доступны для редактирования.

### Май {#may}

#### Новые возможности {#new-features-may}

1. Добавлена интеграция [{{ connection-manager-name }}](../concepts/connection-manager.md) с [{{ mmy-short-name }}](../../managed-mysql). Подключения для кластеров {{ mmy-short-name }} [будут создаваться автоматически](../quickstart/connection-manager.md).
1. Добавлена возможность указывать базы данных в подключениях к [{{ CH }}](../operations/create-connection.md#mdb-clickhouse).


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}


{% include [metastore-trademark](../../_includes/metadata-hub/metastore-trademark.md) %}
