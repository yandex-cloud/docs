# Начало работы с Connection Manager


Управляйте подключениями к источникам данных PostgreSQL, MySQL®, ClickHouse®, Redis, Valkey™, OpenSearch, MongoDB, Trino и Apache Kafka® с Yandex Connection Manager.

## Интеграция с сервисами управляемых баз данных {#mdb-integration}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте кластер [Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-create.md), [Managed Service for MySQL®](../../managed-mysql/operations/cluster-create.md) и [Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md). Для новых кластеров интеграция с Connection Manager будет включена автоматически.
  1. Чтобы включить интеграцию сервиса с существующими кластерами управляемых баз данных, в дополнительных настройках кластера выберите **Использовать Connection Manager**. После сохранения настроек кластера, все его подключения будут создаваться автоматически. Отменить настройку интеграции нельзя.
  1. Для проверки автоматически созданного подключения, перейдите в [Connection Manager](https://console.yandex.cloud/link/metadata-hub/connection-manager) в консоли управления.

  В списке подключений вы можете просмотреть подключения, созданные для ваших кластеров, и [настроить доступ](../operations/connection-access.md) к ним. В списке [зависимостей](../operations/view-connection.md#dependencies) подключения вы сможете просмотреть, для каких кластеров управляемых баз данных используется это подключение. Вы также можете посмотреть список и статус [операций](../operations/operation-connection.md) для выбранного подключения.

{% endlist %}

## Управление подключениями к базам данных {#database-connections}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
  1. Нажмите кнопку **Создать подключение**.
  1. Укажите имя подключения и тип базы данных.
  1. Опционально добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Укажите параметры подключения в зависимости от выбранной базы данных:
     * [подключение к управляемой базе данных в кластере](../operations/create-connection.md#mdb-connection);
     * [подключение к пользовательской инсталляции базы данных](../operations/create-connection.md#on-premise-connection).
  1. Укажите данные для аутентификации подключения.

     {% note tip %}

     Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [Yandex DataLens](../../datalens/concepts/index.md), укажите внешний адрес хоста.

     {% endnote %}
  
  1. Нажмите кнопку **Создать**.


{% endlist %}

После того как подключение будет создано, вы можете [просмотреть его настройки](../operations/update-connection.md#list-connections) в списке подключений и [изменить их](../operations/update-connection.md#update-connections), посмотреть список [операций](../operations/operation-connection.md) для выбранного подключения, а также [управлять доступом](../operations/connection-access.md) к этому подключению.


## Что дальше {#what-is-next}

* [Просмотрите информацию о подключении](../operations/view-connection.md).
* [Измените настройки подключения](../operations/update-connection.md).
* [Настройте права доступа к подключению](../operations/connection-access.md).
* [Удалите ненужное подключение](../operations/delete-connection.md).


_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._