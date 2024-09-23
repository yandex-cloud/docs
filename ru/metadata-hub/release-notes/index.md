---
title: "История изменений в {{ metadata-hub-full-name }}"
description: "В разделе представлена история изменений сервиса {{ metadata-hub-name }}."
---

# История изменений {{ metadata-hub-full-name }} в 2024 году

## Сентябрь {#september}

### Новые возможности {#new-features-september}

[Кластеры {{ metastore-full-name }}](../concepts/metastore.md) стали частью сервиса {{ metadata-hub-name }}.

## Август {#august}

### Новые возможности {#new-features-august}

Поддержаны соединения для пользовательских инсталляций БД {{ RD }} и кластеров [{{ mrd-name }}](../../managed-redis/concepts/index.md).

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