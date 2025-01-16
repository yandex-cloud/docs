---
title: История изменений в {{ metadata-hub-full-name }}
description: В разделе представлена история изменений сервиса {{ metadata-hub-name }}.
---

# История изменений {{ metadata-hub-full-name }} в 2024 году

## Декабрь {#december}

### Новые возможности {#new-features-december}

Добавлена возможность управлять соединениями со следующими СУБД:
* пользовательская инсталляция [{{ TR }}](../operations/create-connection.md#trino-on-premise);
* пользовательская инсталляция [{{ OS }}](../operations/create-connection.md#opensearch-on-premise);
* кластер [{{ mos-name }}](../operations/create-connection.md#mdb-opensearch).

## Ноябрь {#november}

### Новые возможности {#new-features-november}

* В консоли управления появилась возможность подключаться к выбранному [пространству имен](../operations/update-name-space.md) {{ schema-registry-name }}.

## Октябрь {#october}

### Новые возможности {#new-features-october}

* Добавлены новые возможности для интеграции {{ connection-manager-name }} с [{{ data-transfer-full-name }}](../../data-transfer/quickstart.md): выпадающий список доступных подключений при создании трансфера.
* В {{ schema-registry-name }} поддержан механизм аутентификации с помощью [API-ключей](../../iam/concepts/authorization/api-key.md), который избавляет от необходимости регулярно обновлять значение секрета для аутентификации.

### Решенные проблемы {#problems-solved-october}

* Улучшена стабильность при массовом создании подключений в {{ connection-manager-name }}.

## Сентябрь {#september}

### Новые возможности {#new-features-september}

* [Кластеры {{ metastore-full-name }}](../concepts/metastore.md) стали частью сервиса {{ metadata-hub-name }}.
* [{{ schema-registry-name }}](../quickstart/schema-registry.md) доступен в [Preview](../../overview/concepts/launch-stages.md).
* Пользователи сервиса {{ data-transfer-full-name }} могут указывать идентификатор подключения {{ connection-manager-name }} для [настройки эндпоинта {{ mpg-short-name }}](../../data-transfer/operations/endpoint/source/postgresql.md).
* Пользователи сервиса {{ datalens-full-name }} могут использовать {{ connection-manager-name }} для создания подключений к [{{ PG }}](../../datalens/operations/connection/create-postgresql.md#conn-man), [{{ CH }}](../../datalens/operations/connection/create-clickhouse.md#conn-man) и [{{ MY }}](../../datalens/operations/connection/create-mysql.md#conn-man).

## Август {#august}

### Новые возможности {#new-features-august}

Поддержаны соединения для пользовательских инсталляций БД {{ RD }} и кластеров [Managed Service for Redis](../../managed-redis/concepts/index.md).

## Июль {#july}

### Новые возможности {#new-features-july}

Добавлена интеграция [{{ connection-manager-name }}](../concepts/connection-manager.md) с [{{ mch-short-name }}](../../managed-clickhouse). Подключения для кластеров {{ mch-short-name }} [будут создаваться автоматически](../quickstart/connection-manager.md).

## Июнь {#june}

### Новые возможности {#new-features-june}

1. Добавлен фильтр по имени в [списке подключений](../operations/view-connection.md).
1. Добавлена возможность просматривать [операции](../operations/view-connection.md#operations) выбранного подключения.

### Решенные проблемы {#problems-solved-june}

1. Исправлена ошибка просмотра подключений к пользовательским инсталляциям баз данных.
1. Параметры подключения стали доступны для редактирования.

## Май {#may}

### Новые возможности {#new-features-may}

1. Добавлена интеграция [{{ connection-manager-name }}](../concepts/connection-manager.md) с [{{ mmy-short-name }}](../../managed-mysql). Подключения для кластеров {{ mmy-short-name }} [будут создаваться автоматически](../quickstart/connection-manager.md).
1. Добавлена возможность указывать базы данных в подключениях к [{{ CH }}](../operations/create-connection.md#mdb-clickhouse).


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}