
* `filter` — структура, описывающая обработку событий трейлом. Содержит объекты `path_filter` и `event_filters`.
    * `path_filter` — структура, описывающая обработку трейлом событий уровня конфигурации (Control Plane). Может содержать один объект `some_filter` или один объект `any_filter`. Если в конфигурации отсутствует объект `path_filter`, трейл не будет обрабатывать события Control Plane.

        {% include [path-filter-tf-params](./path-filter-tf-params.md) %}

    * `event_filters` — структура, описывающая обработку трейлом событий уровня сервисов (Data Plane). Если в конфигурации отсутствует объект `event_filters`, трейл не будет обрабатывать события Data Plane. В одном блоке `event_filters` настраивается обработка аудитных логов Data Plane для одного сервиса {{ yandex-cloud }}. Чтобы настроить обработку трейлом событий Data Plane для нескольких сервисов, укажите в конфигурации параметр `event_filters` необходимое количество раз.
        * `service` — идентификатор [сервиса](../../audit-trails/concepts/control-plane-vs-data-plane.md#data-plane-events), в котором трейл будет обрабатывать события.
            Возможные значения:
            * `dns`;
            * `kms`;
            * `lockbox`;
            * `mdb.mongodb`;
            * `mdb.mysql`;
            * `mdb.postgresql`;
            * `storage`.

        * `categories` — структура, описывающая тип собираемых событий.
            * `plane` — уровень событий. Для событий уровня сервисов указывайте значение `DATA_PLANE`.
            * `type` — тип действия события в ресурсе. Возможные значения: `READ` и `WRITE`.

        * `path_filter` — структура, описывающая обработку трейлом событий уровня сервисов (Data Plane). Может содержать один объект `some_filter` или один объект `any_filter`.

            {% include [path-filter-tf-params](./path-filter-tf-params.md) %}