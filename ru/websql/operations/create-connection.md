# Создание подключения

В сервисе {{ websql-full-name }} вы можете создать подключение:

* [к кластерам управляемых БД](#connect-cluster) в {{ yandex-cloud }};
* [к публично доступной БД через Интернет](#connect-db).

## Подключение к кластеру управляемых БД в {{ yandex-cloud }} {#connect-cluster}

В {{ websql-full-name }} вы можете подключиться к БД в кластерах:

* [{{ mpg-full-name }}](../../managed-postgresql/operations/cluster-list.md);
* [{{ mch-full-name }}](../../managed-clickhouse/operations/cluster-list.md);
* [{{ mmy-full-name }}](../../managed-mysql/operations/cluster-list.md).

{% include notitle [connect-to-cluster](../../_includes/websql/connect-to-cluster.md) %}

Вы также можете [создать подключение](../../metadata-hub/operations/create-connection.md) к кластеру в {{ connection-manager-name }} сервиса {{ metadata-hub-full-name }}. Такое подключение появится в {{ websql-full-name }} автоматически. При этом имя пользователя БД, пароль и имя БД заполняются вручную.

Если подключение прошло успешно, то в дереве подключений отобразится структура кластера. Подключения к БД одного кластера управляемых БД группируются в разворачивающийся список под именем этого кластера.

## Подключиться к публично доступной БД {#connect-db}

Чтобы подключиться к публично доступной БД через Интернет:

{% include notitle [connect-to-db](../../_includes/websql/connect-to-db.md) %}

Если подключение прошло успешно, то в дереве подключений отобразится структура БД.
