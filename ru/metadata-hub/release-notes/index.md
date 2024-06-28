# История изменений {{ metadata-hub-name }} в 2024 году

## Май {#may}

### Новые возможности {#new-features-may}

1. Добавлена интеграция [{{ connection-manager-name }}](../concepts/connection-manager.md) с [{{ mmy-short-name }}](../../managed-mysql). Подключения для кластеров {{ mmy-short-name }} [будут создаваться автоматически](../quickstart/connection-manager.md).
1. Добавлена возможность указывать базы данных в подключениях к [{{ CH }}](../operations/create-connection.md#mdb-clickhouse).

## Июнь {#june}

### Новые возможности {#new-features-june}

1. Добавлен фильтр по имени в [списке подключений](../operations/view-connection.md).
1. Добавлена возможность просматривать [операции](../operations/view-connection.md#operations) выбранного подключения.

### Решенные проблемы {#problems-solved-june}

1. Исправлена ошибка просмотра подключений к пользовательским инсталляциям баз данных.
1. Параметры подключения стали доступны для редактирования.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}