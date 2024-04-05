
* `filter` — структура, описывающая обработку событий трейлом. Содержит объекты `path_filter` и `event_filter`.
    * `path_filter` — структура, описывающая обработку трейлом событий уровня конфигурации (Control Plane). Может содержать один объект `root.some_filter` или один объект `root.any_filter`. Если в конфигурации отсутствует объект `path_filter`, трейл не будет обрабатывать события Control Plane.

        {% include [path-filter-clispec-params](./path-filter-clispec-params.md) %}

    * `event_filter` — структура, описывающая обработку трейлом событий уровня сервисов (Data Plane). Если в конфигурации отсутствует объект `event_filter`, трейл не будет обрабатывать события Data Plane.
        * `filters.service` — идентификатор [сервиса](../../audit-trails/concepts/control-plane-vs-data-plane.md#data-plane-events), в котором трейл будет обрабатывать события. В одном блоке `filters.service` настраивается обработка аудитных логов Data Plane для одного сервиса {{ yandex-cloud }}. Чтобы настроить обработку трейлом событий Data Plane для нескольких сервисов, укажите в конфигурации параметр `filters.service` необходимое количество раз.
            Возможные значения:
            * `dns`;
            * `kms`;
            * `lockbox`;
            * `mdb.mongodb`;
            * `mdb.mysql`;
            * `mdb.postgresql`;
            * `storage`.

        * `filters.categories` — структура, описывающая тип собираемых событий.
            * `plane` — уровень событий. Для событий уровня сервисов указывайте значение `DATA_PLANE`.
            * `type` — тип действия события в ресурсе. Возможные значения: `READ` и `WRITE`.

        * `filters.path_filter` — структура, описывающая обработку трейлом событий уровня сервисов (Data Plane). Может содержать один объект `root.some_filter` или один объект `root.any_filter`.

            {% include [path-filter-clispec-params](./path-filter-clispec-params.md) %}