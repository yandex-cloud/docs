# Настройки {{ PG }}

Для кластера {{ mpg-name }} можно задать настройки, которые относятся к {{ PG }}. Часть настроек задается [на уровне кластера](#dbms-cluster-settings), часть — [на уровне пользователя](#user-level-settings).

Метки рядом с названием настройки позволяют определить, с помощью какого интерфейса задается значение этой настройки: консоль управления, CLI, [API](../../glossary/rest-api.md) или {{ TF }}. Метка {{ tag-all }} указывает, что поддерживаются все перечисленные интерфейсы.

В зависимости от выбранного интерфейса, одна и та же настройка будет представлена по-разному, например:
- **Backend flush after** в консоли управления соответствует:
  - `backend_flush_after` в gRPC API, CLI, {{ TF }};
  - `backendFlushAfter` в REST API;
- **Default transaction isolation** в настройках уровня пользователя в консоли управления соответствует:
  - `--default-transaction-isolation` в CLI;
  - `default_transaction_isolation` в gRPC API;
  - `defaultTransactionIsolation` в REST API.

## Зависимость настроек от класса хостов и размера хранилища {#settings-instance-dependent}

Значения некоторых настроек {{ PG }} могут быть автоматически скорректированы при изменении класса хостов или размера хранилища:

- Если значения не были заданы или не подходят новому классу/размеру, будут применены настройки по умолчанию для этого класса/размера.
- Если заданные вручную настройки подходят для нового класса/размера, они не будут изменены.

Список настроек, зависящих от класса хостов:

- [Autovacuum max workers](#setting-autovacuum-max-workers).
- [Autovacuum vacuum cost delay](#setting-autovacuum-vacuum-cost-delay).
- [Autovacuum vacuum cost limit](#setting-autovacuum-vacuum-cost-limit).
- [Conn limit](#setting-conn-limit).
- [Max connections](#setting-max-connections).
- [Shared buffers](#setting-shared-buffers).

Список настроек, зависящих от размера хранилища:

- [Max wal size](#setting-max-wal-size);
- [Min wal size](#setting-min-wal-size).

## Настройки на уровне кластера {#dbms-cluster-settings}

Доступны следующие настройки:

{% include [mpg-dbms-settings](../../_includes/mdb/mpg/dbms-settings.md) %}

## Настройки на уровне пользователя {#dbms-user-settings}

Эти настройки влияют на поведение {{ PG }} при работе с запросами пользователя:

{% include [mpg-dbms-user-settings](../../_includes/mdb/mpg-dbms-user-settings.md) %}
