* Убедитесь, что количество колонок в источнике не превышает максимальное количество полей в индексах {{ OS }}. Максимальное количество полей задается в параметре `index.mapping.total_fields.limit` и по умолчанию составляет `1000`.

    {% note warning %}

    Превышение лимита приведет к ошибке `Limit of total fields [1000] has been exceeded` и остановке трансфера.

    {% endnote %}

    Чтобы увеличить значение параметра, [настройте шаблон](https://opensearch.org/docs/latest/im-plugin/index-templates/), по которому максимальное количество полей в создаваемых индексах будет равно указанному значению.

    {% cut "Пример запроса для настройки шаблона" %}

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request PUT "https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/_template/index_defaults" \
    --data '
        {
            "index_patterns": "cdc*",
            "settings": {
                "index": {
                    "mapping": {
                        "total_fields": {
                            "limit": "2000"
                        }
                    }
                }
            }
        }'
    ```

    При такой настройке шаблона все новые индексы с маской `cdc*` смогут содержать до `2000` полей.

    {% endcut %}

    Для настройки шаблона можно также использовать [интерфейс OpenSearch Dashboards](https://opensearch.org/docs/latest/dashboards/im-dashboards/component-templates/).

    Чтобы проверить текущее значение параметра `index.mapping.total_fields.limit`, выполните запрос:

    ```bash
    curl \
        --user <имя_пользователя_{{ OS }}>:<пароль> \
        --header 'Content-Type: application/json' \
        --request GET 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/<название_индекса>/_settings/*total_fields.limit?include_defaults=true'
    ```

* По умолчанию при трансфере данных в единичный индекс задействуется только один хост. Чтобы распределить нагрузку между хостами при передаче больших объемов данных, [настройте шаблон](https://opensearch.org/docs/latest/im-plugin/index-templates/), по которому создаваемые индексы будут заранее разбиты на шарды.

    {% cut "Пример запроса для настройки шаблона" %}

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/_template/index_defaults' \
    --data '
        {
            "index_patterns": "cdc*",
            "settings" : {
                "index" : {
                    "number_of_shards" : 15,
                    "number_of_replicas" : 1
                }
            }
        }'
    ```

    {% endcut %}

    При такой настройке шаблона, все новые индексы с маской `cdc*` будут разбиты на `15` шардов.

    Для настройки шаблона можно также использовать [интерфейс OpenSearch Dashboards](https://opensearch.org/docs/latest/dashboards/im-dashboards/component-templates/).

* Чтобы повысить безопасность и доступность данных, установите политику, которая будет создавать новый индекс при выполнении хотя бы одного из условий (рекомендуемые значения):

    * Когда размер индекса превысит 50 ГБ.
    * Когда возраст индекса превысит 30 дней.

    Создать и включить политику можно с помощью запросов. Подробнее о политиках см. [в документации {{ OS }}]({{ os.docs }}/im-plugin/ism/policies/).

    {% cut "Пример запроса для создания политики" %}

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/_plugins/_ism/policies/rollover_policy' \
    --data '
        {
            "policy": {
                "description": "Example rollover policy",
                "default_state": "rollover",
                "schema_version": 1,
                "states": [
                    {
                        "name": "rollover",
                        "actions": [
                            {
                                "rollover": {
                                    "min_index_age": "30d",
                                    "min_primary_shard_size": "50gb"
                                }
                            }
                        ],
                        "transitions": []
                    }
                ],
                "ism_template": {
                    "index_patterns": ["log*"],
                    "priority": 100
                }
            }
        }'
    ```

    {% endcut %}

    {% cut "Пример запроса для назначения политике псевдонима" %}

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/_index_template/ism_rollover' \
    --data '
        {
            "index_patterns": ["log*"],
            "template": {
                "settings": {
                    "plugins.index_state_management.rollover_alias": "log"
                }
            }
        }'
    ```

    {% endcut %}

    {% cut "Пример запроса для создания индекса с псевдонимом политики" %}

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/log-000001' \
    --data '
        {
            "aliases": {
                "log": {
                    "is_write_index": true
                }
            }
        }'
    ```

    {% endcut %}

    {% cut "Пример запроса для проверки, прикреплена ли политика к индексу" %}

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request GET 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/_plugins/_ism/explain/log-000001?pretty'
    ```

    {% endcut %}
