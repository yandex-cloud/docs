- **Начало резервного копирования (UTC)** — время по UTC, когда требуется начать [резервное копирование](../../managed-clickhouse/operations/cluster-backups.md) кластера (в 24-часовом формате). Если время не задано, резервное копирование начнется в 22:00 UTC.

- **Доступ из {{ datalens-name }}** — включите эту опцию, чтобы получить возможность анализировать данные из кластера в сервисе [{{ datalens-full-name }}](../../datalens/concepts/index.md). Подробнее о настройке подключения см. в разделе [Подключение к {{ datalens-name }}](../../managed-clickhouse/operations/datalens-connect.md).
  
- **Доступ из консоли управления** — включите эту опцию, чтобы получить возможность [выполнять SQL-запросы](../../managed-clickhouse/operations/web-sql-query.md) к базам кластера из консоли управления {{ yandex-cloud }}.

- **Доступ из Метрики и AppMetrica** — включите эту опцию, чтобы получить возможность [импортировать данные из AppMetrica](https://appmetrica.yandex.ru/docs/cloud/index.html) в кластер.