[Документация Yandex Cloud](../../index.md) > [Yandex WebSQL](../index.md) > [Пошаговые инструкции](index.md) > Создание подключения

# Создание подключения

В сервисе Yandex WebSQL вы можете создать [подключение](../concepts/index.md#connection):

* [к кластерам управляемых БД](#connect-cluster) в Yandex Cloud;
* [к пользовательской инсталляции БД](#connect-db).

## Подключение к кластеру управляемых БД в Yandex Cloud {#connect-cluster}

В Yandex WebSQL вы можете подключиться к БД в кластерах:

* [Yandex Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-list.md);
* [Yandex Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-list.md);
* [Yandex Managed Service for MySQL®](../../managed-mysql/operations/cluster-list.md);
* [Yandex Managed Service for Valkey™](../../managed-valkey/operations/cluster-list.md);
* [Yandex StoreDoc](../../storedoc/operations/cluster-list.md);
* [Yandex MPP Analytics for PostgreSQL](../../managed-greenplum/operations/cluster-list.md).

Перед созданием подключения убедитесь, что вы выбрали нужный каталог. Если у вас есть доступ к ранее созданным в этом каталоге кластерам PostgreSQL, ClickHouse®, MySQL®, Greenplum®, Valkey™ или Yandex StoreDoc, они автоматически отобразятся в подразделе **Подключения Yandex Cloud**. Вам нужно будет только создать подключение к нужной БД в кластере.


{% note info %}

[Yandex Managed Service for Trino](../../managed-trino/index.md) находится на стадии [Preview](../../overview/concepts/launch-stages.md). В интерфейсе Yandex WebSQL пока нельзя создавать подключения к Yandex Managed Service for Trino, но если в текущем каталоге есть кластер Yandex Managed Service for Trino и у пользователя есть к нему доступ, подключение отобразится в WebSQL и будет доступно для использования. 

{% endnote %}


WebSQL использует подключения в Connection Manager сервиса Yandex MetaData Hub, поэтому все подключения, настроенные в Connection Manager, доступны для работы в WebSQL автоматически при условии, что у пользователя есть [роли](../../metadata-hub/security/index.md#service-roles).

Чтобы создать подключение к кластеру управляемых БД Yandex Cloud:

1. Убедитесь, что в настройках кластера включена опция **Доступ из WebSQL**.
1. Откройте [**Подключения**](https://websql.yandex.cloud) Yandex WebSQL.
1. В разделе ![image](../../_assets/console-icons/folder-tree.svg) **Подключения** нажмите ![image](../../_assets/console-icons/square-plus.svg).
1. В поле **Тип базы данных** выберите нужную БД: PostgreSQL, ClickHouse®, MySQL®, Valkey™, Yandex StoreDoc, Greenplum®.
1. В поле **Каталог кластера** выберите каталог, в котором содержится нужный кластер.
1. В поле **Кластер** выберите кластер управляемых БД, к которому вы хотите подключиться. 
1. Укажите **Имя пользователя**, от лица которого будете подключаться к БД в кластере.
1. Введите **Пароль** пользователя.
1. Перечислите **Базы данных**, к которым вы хотите подключиться. Вы можете подключиться только к существующим в этом кластере БД. У пользователя, которого вы указали, должен быть настроен доступ к ним.
1. Нажмите кнопку **Создать**.

Вы также можете [создать подключение](../../metadata-hub/operations/create-connection.md) к кластеру в Connection Manager сервиса Yandex MetaData Hub. Такое подключение появится в Yandex WebSQL автоматически. При этом имя пользователя БД, пароль и имя БД заполняются вручную.

Если подключение прошло успешно, то в дереве подключений отобразится структура кластера. Подключения к БД одного кластера управляемых БД группируются в разворачивающийся список под именем этого кластера.

## Подключиться к пользовательской инсталляции БД {#connect-db}

Чтобы подключиться к пользовательской инсталляции БД через Интернет:

1. Откройте [**Подключения**](https://websql.yandex.cloud) Yandex WebSQL.
1. В разделе ![image](../../_assets/console-icons/folder-tree.svg) **Подключения** нажмите ![image](../../_assets/console-icons/square-plus.svg).
1. В левом нижнем углу открывшегося окна нажмите **Внешнее подключение**.
1. Укажите **Имя** подключения.
1. В поле **Тип базы данных** выберите нужную БД: PostgreSQL, ClickHouse®, MySQL®, Redis, MongoDB, Greenplum®, Valkey™ или Yandex StoreDoc.
1. В разделе **Хосты** задайте конфигурацию хостов:
    * укажите FQDN хоста c БД и номер порта для подключения к БД;
    * для ClickHouse® также укажите порт Native Protocol и имя [шарда](../../managed-clickhouse/operations/shards.md#list-shards).
    * (Опционально) Включите использование [TLS](../../glossary/tls.md).

        Если в вашей компании есть [центр авторизации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.

1. Укажите **Имя пользователя**, от лица которого будете подключаться к БД.
1. Введите **Пароль** пользователя.
1. Перечислите **Базы данных**, к которым вы хотите подключиться. Вы можете подключиться только к существующим БД. У пользователя, которого вы указали, должен быть настроен доступ к ним.
1. Нажмите кнопку **Создать**.

Если подключение прошло успешно, то в дереве подключений отобразится структура БД.

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._