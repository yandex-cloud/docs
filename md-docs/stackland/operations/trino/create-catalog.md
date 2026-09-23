[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных и аналитика > Managed Service for Trino > Создать каталог

# Создать каталог Managed Service for Trino

[Каталог](../../concepts/components/trino.md#catalogs) Trino задает подключение к источнику данных. Один каталог описывается ресурсом `TrinoCatalog` и привязывается к конкретному кластеру через поле `spec.cluster`.

Поддерживаемые типы каталогов:

* PostgreSQL — параметры подключения задаются в `spec.postgres`.
* ClickHouse® — параметры подключения задаются в `spec.clickhouse`.
* Apache Iceberg™ — подключение к [Iceberg REST Catalog](../../concepts/components/rest-catalog.md) в Stackland задается в `spec.stacklandRestCatalog`.

В манифесте укажите один блок с настройками коннектора. Параметр `spec.type` добавлять не нужно.

{% note info %}

При создании каталога Managed Service for Trino пересоздает кластер. На время применения новой конфигурации кластер переходит в состояние `Updating`, активные запросы прерываются. Подробнее см. в разделе [Обновление кластера](../../concepts/components/trino.md#cluster-update).

{% endnote %}

## Через CLI {#cli}

1. Подготовьте источник данных:

    * Для PostgreSQL и ClickHouse® подготовьте Secret с учетными данными.
    * Для Apache Iceberg™ убедитесь, что включены компоненты Iceberg REST Catalog и [Object Storage](../../concepts/components/storage.md). [Создайте каталог Iceberg REST Catalog](../rest-catalog/create-catalog.md) в том же пространстве имен, что и кластер Trino, и дождитесь состояния `ready`. [Назначьте права](../rest-catalog/create-principal.md) пользователю или сервисному аккаунту, от имени которого будут выполняться запросы.

1. Создайте файл ресурса `TrinoCatalog`. Например, с помощью команды `touch trinocatalog.yaml`.
1. Откройте файл и вставьте конфигурацию для нужного типа каталога:

    {% list tabs %}

    - PostgreSQL

        ```yaml
        ---
        apiVersion: v1
        kind: Secret
        metadata:
          name: postgres-secret
        stringData:
          username: <имя_пользователя>
          password: <пароль_пользователя>
        ---
        apiVersion: trino.stackland.yandex.cloud/v1alpha1
        kind: TrinoCatalog
        metadata:
          name: postgresql-test-trino-full
        spec:
          cluster: trino-full
          name: postgresql-test
          postgres:
            url: postgres.example.svc.cluster.local:5432/database
            credentialsSecretRef:
              name: postgres-secret
              usernameKey: username
              passwordKey: password
        ```

        Параметры:

        * `spec.cluster` — имя кластера Trino, к которому подключается каталог.
        * `spec.name` — имя каталога в Trino (используется в SQL-запросах: `SELECT * FROM <имя_каталога>.schema.table`).
        * `spec.postgres.url` — адрес сервера PostgreSQL в формате `host:port/database`.
        * `spec.postgres.credentialsSecretRef` — ссылка на Secret с учетными данными и имена ключей `usernameKey` и `passwordKey`.

    - ClickHouse

        ```yaml
        ---
        apiVersion: v1
        kind: Secret
        metadata:
          name: clickhouse-secret
        stringData:
          username: <имя_пользователя>
          password: <пароль_пользователя>
        ---
        apiVersion: trino.stackland.yandex.cloud/v1alpha1
        kind: TrinoCatalog
        metadata:
          name: clickhouse-test-trino-full
        spec:
          cluster: trino-full
          name: clickhouse-test
          clickhouse:
            url: clickhouse.example.svc.cluster.local:8123/default
            credentialsSecretRef:
              name: clickhouse-secret
              usernameKey: username
              passwordKey: password
        ```

        Параметры:

        * `spec.cluster` — имя кластера Trino.
        * `spec.name` — имя каталога в Trino.
        * `spec.clickhouse.url` — адрес сервера ClickHouse® в формате `host:port/database`.
        * `spec.clickhouse.credentialsSecretRef` — ссылка на Secret с учетными данными.

    - Iceberg

        Укажите имя ресурса `StacklandRestCatalog`. Параметры подключения к каталогу и хранилищу заполняются автоматически.

        ```yaml
        apiVersion: trino.stackland.yandex.cloud/v1alpha1
        kind: TrinoCatalog
        metadata:
          name: iceberg-test-trino-full
        spec:
          cluster: trino-full
          name: iceberg-test
          stacklandRestCatalog:
            catalogRef: analytics
        ```

        Параметры:

        * `spec.cluster` — имя кластера Trino.
        * `spec.name` — имя каталога в SQL-запросах Trino.
        * `spec.stacklandRestCatalog.catalogRef` — имя ресурса `StacklandRestCatalog` в том же пространстве имен.
        * `spec.stacklandRestCatalog.useExternalEndpoint` — использование внешнего адреса каталога. По умолчанию `false`: используется внутренний адрес. Значение `true` можно указать, если для каталога [включен публичный доступ](../../concepts/components/rest-catalog.md#endpoints) и заполнено поле `status.externalEndpoint`.
        * `spec.stacklandRestCatalog.additionalProperties` — [дополнительные настройки Iceberg](../../concepts/components/trino.md#iceberg-settings): формат и сжатие данных, размер файлов, требования к фильтрам в запросах, статистика, работа с хранилищем и поддержка представлений Iceberg. Необязательный параметр.

        В следующем примере используется внешний адрес каталога. Для новых таблиц по умолчанию выбраны формат `PARQUET`, сжатие `ZSTD` и целевой максимальный размер файлов `512MB`. Для запросов к партиционированным таблицам в SQL-схемах `reports` и `events` требуется фильтр по ключам партиционирования. Тайм-аут установки соединения с хранилищем составляет `10s`, тайм-аут чтения или записи — `30s`. Параметр `iceberg.rest-catalog.view-endpoints-enabled: true` включает поддержку представлений Iceberg. При создании представлений указывайте `SECURITY INVOKER` — подробнее в разделе [Представления Iceberg](../../concepts/components/trino.md#iceberg-views).

        ```yaml
        apiVersion: trino.stackland.yandex.cloud/v1alpha1
        kind: TrinoCatalog
        metadata:
          name: iceberg-test-trino-full
        spec:
          cluster: trino-full
          name: iceberg-test
          stacklandRestCatalog:
            catalogRef: analytics
            useExternalEndpoint: true
            additionalProperties:
              iceberg.rest-catalog.view-endpoints-enabled: true
              iceberg.file-format: PARQUET
              iceberg.compression-codec: ZSTD
              iceberg.target-max-file-size: "512MB"
              iceberg.query-partition-filter-required: true
              iceberg.query-partition-filter-required-schemas: "reports,events"
              s3.socket-connect-timeout: "10s"
              s3.socket-timeout: "30s"
        ```

    {% endlist %}

    {% note tip %}

    Имя ресурса (`metadata.name`) формируйте как `<spec.name>-<spec.cluster>` — как в примерах выше. Иначе оператор отклонит создание каталога.

    {% endnote %}

1. Примените манифест: `kubectl apply -f trinocatalog.yaml -n <пространство_имен>`.

## Через консоль управления {#console}

Для подключения Apache Iceberg™ сначала [создайте каталог Iceberg REST Catalog](../rest-catalog/create-catalog.md#console) в том же пространстве имен, дождитесь его готовности и [назначьте права](../rest-catalog/create-principal.md#console) пользователю или группе.

1. Если вы еще не открыли проект, выберите проект.
1. Выберите пространство имен, в котором создан кластер.
1. В левом меню выберите **Trino** → **Кластеры**.
1. Выберите кластер.
1. Откройте вкладку **Каталоги** и нажмите **Создать каталог**.
1. Заполните поля:

    **Основные настройки**

    * **Имя** — имя каталога в Trino. Записывается в `spec.name`. Имя ресурса Kubernetes (`metadata.name`) консоль формирует автоматически как `<имя_каталога>-<имя_кластера>`.
    * **Тип** — тип коннектора: `postgresql`, `clickhouse` или `iceberg`.

    После выбора типа отобразится блок **Настройки каталога**.

    **Настройки каталога: PostgreSQL**

    * **URL** — адрес сервера в формате `host:port/database`.
    * **Имя пользователя** — пользователь PostgreSQL.
    * **Пароль** — пароль пользователя.

    **Настройки каталога: ClickHouse**

    * **URL** — адрес сервера в формате `host:port/database`.
    * **Имя пользователя** — пользователь ClickHouse®.
    * **Пароль** — пароль пользователя.

    **Настройки каталога: Iceberg**

    * **REST Catalog** — каталог Iceberg REST Catalog в текущем пространстве имен.
    * **Способ доступа** — **Внутренний** или **Внешний**. Внешний способ доступен, если у выбранного каталога настроен внешний адрес.

    **Дополнительные настройки** (необязательно)

    Укажите поддерживаемые настройки коннектора в формате «ключ — значение». Каждый ключ можно добавить только один раз. Для Apache Iceberg™ доступны [настройки хранения данных, запросов, обращения к хранилищу и представлений Iceberg](../../concepts/components/trino.md#iceberg-settings).

1. Нажмите **Создать**.

Готово, каталог появился в списке **Каталоги**. После того как оператор применит новую конфигурацию и кластер перейдет в состояние `Running`, каталог будет доступен в SQL-запросах.