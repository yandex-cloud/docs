# Настройки {{ MY }}

Для кластера {{ mmy-name }} можно задать настройки, которые относятся к {{ MY }}. Часть настроек задается [на уровне кластера](#dbms-cluster-settings), часть — [на уровне пользователя](#dbms-user-settings).

Метки рядом с названием настройки позволяют определить, с помощью какого интерфейса задается значение этой настройки: консоль управления, CLI, API или Terraform. Метка {{ tag-all }} указывает, что поддерживаются все перечисленные интерфейсы.

В зависимости от выбранного интерфейса, одна и та же настройка будет представлена по-разному. Например, **Innodb buffer pool size** в консоли управления соответствует:
- `innodb_buffer_pool_size` в gRPC, CLI или Terraform;
- `innodbBufferPoolSize` в REST API.

## Настройки кластера {#dbms-cluster-settings}

{% include [mmy-dbms-settings](../../_includes/mdb/mmy-dbms-settings.md) %}

## Пользовательские настройки {#dbms-user-settings}

Эти настройки действуют на уровне отдельного пользователя.

{% include [mmy-dbms-user-settings](../../_includes/mdb/mmy-dbms-user-settings.md) %}
