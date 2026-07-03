# Создать каталог {{ mtr-name }}

[Каталог](../../concepts/components/trino.md#catalogs) {{ TR }} задает подключение к внешнему источнику данных. Один каталог описывается ресурсом `TrinoCatalog` и привязывается к конкретному кластеру через поле `spec.cluster`.

Поддерживаемые типы каталогов:

* `postgresql` — подключение к {{ PG }}.
* `clickhouse` — подключение к {{ CH }}.
* `iceberg` — подключение к {{ IBRG }} через REST catalog.

{% note info %}

При создании каталога {{ mtr-name }} пересоздает кластер. На время применения новой конфигурации кластер переходит в состояние `Updating`, активные запросы прерываются. Подробнее см. в разделе [Обновление кластера](../../concepts/components/trino.md#cluster-update).

{% endnote %}

## Через CLI {#cli}

1. Подготовьте Secret с учетными данными для подключения к источнику данных.
1. Создайте файл ресурса `TrinoCatalog`. Например, с помощью команды `touch trinocatalog.yaml`.
1. Откройте файл и вставьте конфигурацию для нужного типа каталога:

    {% list tabs %}

    - PostgreSQL

        {% include notitle [YAML-файл](../../_includes/yamls/operations/trino/create-catalog-postgresql.md) %}

        Параметры:

        * `spec.cluster` — имя кластера {{ TR }}, к которому подключается каталог.
        * `spec.name` — имя каталога в {{ TR }} (используется в SQL-запросах: `SELECT * FROM <имя_каталога>.schema.table`).
        * `spec.postgres.url` — адрес сервера {{ PG }} в формате `host:port/database`.
        * `spec.postgres.credentialsSecretRef` — ссылка на Secret с учетными данными и имена ключей `usernameKey` и `passwordKey`.

    - ClickHouse

        {% include notitle [YAML-файл](../../_includes/yamls/operations/trino/create-catalog-clickhouse.md) %}

        Параметры:

        * `spec.cluster` — имя кластера {{ TR }}.
        * `spec.name` — имя каталога в {{ TR }}.
        * `spec.clickhouse.url` — адрес сервера {{ CH }} в формате `host:port/database`.
        * `spec.clickhouse.credentialsSecretRef` — ссылка на Secret с учетными данными.

    - Iceberg (REST catalog, S3)

        Пример каталога Iceberg с REST catalog, аутентификацией через client credentials и хранилищем в произвольном S3-совместимом бакете.

        {% include notitle [YAML-файл](../../_includes/yamls/operations/trino/create-catalog-iceberg.md) %}

        Параметры:

        * `spec.iceberg.url` — URL REST catalog.
        * `spec.iceberg.storageType` — тип хранилища данных. Допустимые значения: `s3`, `stackland-storage`.
        * `spec.iceberg.rest.warehouse` — имя REST catalog.
        * `spec.iceberg.rest.oauth2.clientCredentials` — параметры аутентификации client credentials: URL сервера авторизации (`tokenEndpoint`) и Secret с идентификатором и секретом клиента.
        * `spec.iceberg.s3.endpoint`, `region` — параметры S3-хранилища.
        * `spec.iceberg.s3.credentialsSecretRef` — Secret с `access-key-id` и `secret-access-key`.

        Для статического токена вместо `clientCredentials` укажите `spec.iceberg.rest.oauth2.accessTokenSecretRef` со ссылкой на Secret с токеном.

    - Iceberg (REST catalog, {{ objstorage-name }})

        Пример каталога Iceberg с использованием управляемого объектного хранилища {{ stackland-name }}. Доступно, только если в кластере включен компонент [{{ objstorage-name }}](../../concepts/components/storage.md).

        {% include notitle [YAML-файл](../../_includes/yamls/operations/trino/create-catalog-iceberg-stackland-storage.md) %}

        Параметры:

        * `spec.iceberg.rest.oauth2.clientCredentials` — параметры аутентификации client credentials для платформенного {{ rest-catalog-name }}: URL сервера авторизации (`tokenEndpoint`) и секрет с `clientId` и `clientSecret` пользователя `RestCatalogPrincipal`.
        * `spec.iceberg.storageType: stackland-storage`.
        * `spec.iceberg.stacklandStorage.bucketRef` — ссылка на ресурс `Bucket` в текущем пространстве имен.

        AccessKey и AccessBinding оператор создает автоматически. Параметры подключения к S3 заполняет оператор.

        {% note info %}

        Пример рассчитан на подключение к платформенному [{{ rest-catalog-name }}](../../concepts/components/rest-catalog.md). Подставьте значения из ресурса `RestCatalog` и секрета пользователя:

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

    * **Имя** — имя каталога в {{ TR }}. Записывается в `spec.name`. Имя ресурса Kubernetes (`metadata.name`) консоль формирует автоматически как `<имя_каталога>-<имя_кластера>`.
    * **Тип** — тип коннектора. Допустимые значения: `postgresql`, `clickhouse`, `iceberg`.

    После выбора типа отобразится блок **Настройки каталога**.

    **Настройки каталога: PostgreSQL**

    * **URL** — адрес сервера в формате `host:port/database`.
    * **Имя пользователя** — пользователь {{ PG }}.
    * **Пароль** — пароль пользователя.

    **Настройки каталога: ClickHouse**

    * **URL** — адрес сервера в формате `host:port/database`.
    * **Имя пользователя** — пользователь {{ CH }}.
    * **Пароль** — пароль пользователя.

    **Настройки каталога: Iceberg (REST catalog)**

    Подсекция **Подключение**:

    * **URL** — URL REST catalog.
    * **Warehouse** — имя REST catalog (необязательно).

    Подсекция **Аутентификация** (необязательно):

    * **Способ аутентификации** — `Без аутентификации`, `Статический токен` или `Client credentials`.
    * Для статического токена: **Токен доступа**.
    * Для client credentials: **Адрес сервера авторизации**, **Идентификатор клиента**, **Секрет клиента**. Для платформенного {{ rest-catalog-name }} в качестве **Идентификатора клиента** и **Секрета клиента** укажите `clientId` и `clientSecret` пользователя [`RestCatalogPrincipal`](../rest-catalog/create-principal.md). В подменю **Дополнительно** можно задать **Область доступа (scope)**, **Обновление токена** и **Обмен токенов**.

    Подсекция **Хранилище данных**:

    * **Тип хранилища** — `s3` или `stackland-storage`. Значение `stackland-storage` доступно, только если в кластере включен компонент **{{ objstorage-name }}**.
    * Для `s3`: **Endpoint**, **Регион**, **Access key ID**, **Secret access key**, **Path-style access**.
    * Для `stackland-storage`: **Бакет** — выбор бакета из списка ресурсов `Bucket` в текущем пространстве имен.

    **Дополнительные настройки** (необязательно)

    Раздел для произвольных настроек коннектора в формате «Ключ–Значение». Каждый ключ можно добавить только один раз.

1. Нажмите **Создать**.

Готово, каталог появился в списке **Каталоги**. После того как оператор применит новую конфигурацию и кластер перейдет в состояние `Running`, каталог будет доступен в SQL-запросах.
