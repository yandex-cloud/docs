[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных > Managed Service for Trino > Создать каталог

# Создать каталог Managed Service for Trino

[Каталог](../../concepts/components/trino.md#catalogs) Trino задает подключение к внешнему источнику данных. Один каталог описывается ресурсом `TrinoCatalog` и привязывается к конкретному кластеру через поле `spec.cluster`.

Поддерживаемые типы каталогов:

* `postgresql` — подключение к PostgreSQL.
* `clickhouse` — подключение к ClickHouse®.
* `iceberg` — подключение к Apache Iceberg™ через REST catalog.

{% note info %}

При создании каталога Managed Service for Trino пересоздает кластер. На время применения новой конфигурации кластер переходит в состояние `Updating`, активные запросы прерываются. Подробнее см. в разделе [Обновление кластера](../../concepts/components/trino.md#cluster-update).

{% endnote %}

## Через CLI {#cli}

1. Подготовьте Secret с учетными данными для подключения к источнику данных.
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
          type: postgresql
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
          type: clickhouse
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

    - Iceberg (REST catalog, S3)

        Пример каталога Iceberg с REST catalog, аутентификацией через client credentials и хранилищем в произвольном S3-совместимом бакете.

        ```yaml
        ---
        apiVersion: v1
        kind: Secret
        metadata:
          name: iceberg-oauth2-secret
        stringData:
          client-id: <идентификатор_клиента>
          client-secret: <секрет_клиента>
        ---
        apiVersion: v1
        kind: Secret
        metadata:
          name: iceberg-s3-secret
        stringData:
          access-key-id: <access_key_id>
          secret-access-key: <secret_access_key>
        ---
        apiVersion: trino.stackland.yandex.cloud/v1alpha1
        kind: TrinoCatalog
        metadata:
          name: iceberg-test-trino-full
        spec:
          cluster: trino-full
          type: iceberg
          name: iceberg-test
          iceberg:
            url: https://iceberg-rest.example.svc.cluster.local:8181
            catalogType: rest
            storageType: s3
            rest:
              warehouse: my-warehouse
              oauth2:
                clientCredentials:
                  tokenEndpoint: https://auth.example.com/token
                  credentialsSecretRef:
                    name: iceberg-oauth2-secret
                    clientIdKey: client-id
                    clientSecretKey: client-secret
            s3:
              endpoint: https://storage.yandexcloud.net
              region: ru-central1
              credentialsSecretRef:
                name: iceberg-s3-secret
                accessKeyIdKey: access-key-id
                secretAccessKeyKey: secret-access-key
        ```

        Параметры:

        * `spec.iceberg.url` — URL REST catalog.
        * `spec.iceberg.storageType` — тип хранилища данных. Допустимые значения: `s3`, `stackland-storage`.
        * `spec.iceberg.rest.warehouse` — имя REST catalog.
        * `spec.iceberg.rest.oauth2.clientCredentials` — параметры аутентификации client credentials: URL сервера авторизации (`tokenEndpoint`) и Secret с идентификатором и секретом клиента.
        * `spec.iceberg.s3.endpoint`, `region` — параметры S3-хранилища.
        * `spec.iceberg.s3.credentialsSecretRef` — Secret с `access-key-id` и `secret-access-key`.

        Для статического токена вместо `clientCredentials` укажите `spec.iceberg.rest.oauth2.accessTokenSecretRef` со ссылкой на Secret с токеном.

    - Iceberg (REST catalog, Object Storage)

        Пример каталога Iceberg с использованием управляемого объектного хранилища Stackland. Доступно, только если в кластере включен компонент [Object Storage](../../concepts/components/storage.md).

        ```yaml
        apiVersion: trino.stackland.yandex.cloud/v1alpha1
        kind: TrinoCatalog
        metadata:
          name: iceberg-stackland-trino-full
        spec:
          cluster: trino-full
          type: iceberg
          name: iceberg-stackland
          iceberg:
            url: http://iceberg-rest-catalog.stackland-iceberg-rest-catalog.svc:8181/api/catalog
            catalogType: rest
            storageType: stackland-storage
            rest:
              warehouse: my-warehouse
              oauth2:
                clientCredentials:
                  tokenEndpoint: http://iceberg-rest-catalog.stackland-iceberg-rest-catalog.svc:8181/api/catalog/v1/oauth/tokens
                  credentialsSecretRef:
                    name: <секрет_пользователя>
                    clientIdKey: clientId
                    clientSecretKey: clientSecret
            stacklandStorage:
              bucketRef: <имя_бакета>
        ```

        Параметры:

        * `spec.iceberg.rest.oauth2.clientCredentials` — параметры аутентификации client credentials для платформенного Iceberg REST Catalog: URL сервера авторизации (`tokenEndpoint`) и секрет с `clientId` и `clientSecret` пользователя `RestCatalogPrincipal`.
        * `spec.iceberg.storageType: stackland-storage`.
        * `spec.iceberg.stacklandStorage.bucketRef` — ссылка на ресурс `Bucket` в текущем пространстве имен.

        AccessKey и AccessBinding оператор создает автоматически. Параметры подключения к S3 заполняет оператор.

        {% note info %}

        Пример рассчитан на подключение к платформенному [Iceberg REST Catalog](../../concepts/components/rest-catalog.md). Подставьте значения из ресурса `RestCatalog` и секрета пользователя:

        * `spec.iceberg.url` — значение `status.endpoint`;
        * `spec.iceberg.rest.oauth2.clientCredentials.tokenEndpoint` — значение `status.oauth2TokenEndpoint`;
        * `spec.iceberg.rest.warehouse` — имя ресурса `RestCatalog`;
        * `credentialsSecretRef` — секрет с `clientId` и `clientSecret` пользователя `RestCatalogPrincipal` (см. [Создать пользователя каталога](../rest-catalog/create-principal.md)).

        {% endnote %}

    {% endlist %}

    {% note tip %}

    Имя ресурса (`metadata.name`) формируйте как `<spec.name>-<spec.cluster>` — как в примерах выше. Иначе оператор отклонит создание каталога.

    {% endnote %}

1. Примените манифест: `kubectl apply -f trinocatalog.yaml -n <пространство_имен>`.

## Через консоль управления {#console}

1. Если вы еще не открыли проект, выберите проект.
1. Выберите пространство имен, в котором создан кластер.
1. В левом меню выберите **Trino** → **Кластеры**.
1. Выберите кластер.
1. Откройте вкладку **Каталоги** и нажмите **Создать каталог**.
1. Заполните поля:

    **Основные настройки**

    * **Имя** — имя каталога в Trino. Записывается в `spec.name`. Имя ресурса Kubernetes (`metadata.name`) консоль формирует автоматически как `<имя_каталога>-<имя_кластера>`.
    * **Тип** — тип коннектора. Допустимые значения: `postgresql`, `clickhouse`, `iceberg`.

    После выбора типа отобразится блок **Настройки каталога**.

    **Настройки каталога: PostgreSQL**

    * **URL** — адрес сервера в формате `host:port/database`.
    * **Имя пользователя** — пользователь PostgreSQL.
    * **Пароль** — пароль пользователя.

    **Настройки каталога: ClickHouse**

    * **URL** — адрес сервера в формате `host:port/database`.
    * **Имя пользователя** — пользователь ClickHouse®.
    * **Пароль** — пароль пользователя.

    **Настройки каталога: Iceberg (REST catalog)**

    Подсекция **Подключение**:

    * **URL** — URL REST catalog.
    * **Warehouse** — имя REST catalog (необязательно).

    Подсекция **Аутентификация** (необязательно):

    * **Способ аутентификации** — `Без аутентификации`, `Статический токен` или `Client credentials`.
    * Для статического токена: **Токен доступа**.
    * Для client credentials: **Адрес сервера авторизации**, **Идентификатор клиента**, **Секрет клиента**. Для платформенного Iceberg REST Catalog в качестве **Идентификатора клиента** и **Секрета клиента** укажите `clientId` и `clientSecret` пользователя [`RestCatalogPrincipal`](../rest-catalog/create-principal.md). В подменю **Дополнительно** можно задать **Область доступа (scope)**, **Обновление токена** и **Обмен токенов**.

    Подсекция **Хранилище данных**:

    * **Тип хранилища** — `s3` или `stackland-storage`. Значение `stackland-storage` доступно, только если в кластере включен компонент **Object Storage**.
    * Для `s3`: **Endpoint**, **Регион**, **Access key ID**, **Secret access key**, **Path-style access**.
    * Для `stackland-storage`: **Бакет** — выбор бакета из списка ресурсов `Bucket` в текущем пространстве имен.

    **Дополнительные настройки** (необязательно)

    Раздел для произвольных настроек коннектора в формате «Ключ–Значение». Каждый ключ можно добавить только один раз.

1. Нажмите **Создать**.

Готово, каталог появился в списке **Каталоги**. После того как оператор применит новую конфигурацию и кластер перейдет в состояние `Running`, каталог будет доступен в SQL-запросах.