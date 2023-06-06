* Убедитесь, что количество колонок в источнике не превышает максимальное количество полей в индексах {{ OS }}. Максимальное количество полей задается в параметре `index.mapping.total_fields.limit` и по умолчанию составляет `1000`.

    Чтобы увеличить значение параметра, [настройте шаблон](https://opensearch.org/docs/latest/im-plugin/index-templates/), по которому максимальное количество полей в создаваемых индексах будет равно указанному значению.

    {% cut "Пример запроса для настройки шаблона" %}

    ```bash
    curl \
    --user <имя пользователя {{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request PUT "https://<адрес хоста {{ OS }} с ролью DATA>:9200/_template/index_defaults" \
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

    При такой настройке шаблона, все новые индексы с маской `cdc*` смогут содержать до `2000` полей.

    {% endcut %}

    Для настройки шаблона можно также использовать [интерфейс OpenSearch Dashboards](https://opensearch.org/docs/latest/dashboards/im-dashboards/component-templates/).

    Чтобы проверить текущее значение параметра `index.mapping.total_fields.limit`, выполните запрос:

    ```bash
    curl \
        --user <имя пользователя {{ OS }}>:<пароль> \
        --header 'Content-Type: application/json' \
        --request GET 'https://<адрес хоста {{ OS }} с ролью DATA>:9200/<название индекса>/_settings/*total_fields.limit?include_defaults=true'
    ```

* По умолчанию при трансфере данных в единичный индекс задействуется только один хост. Чтобы распределить нагрузку между хостами при передаче больших объемов данных, [настройте шаблон](https://opensearch.org/docs/latest/im-plugin/index-templates/), по которому создаваемые индексы будут заранее разбиты на шарды.

    {% cut "Пример запроса для настройки шаблона" %}

    ```bash
    curl \
    --user <имя пользователя {{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request PUT 'https://<адрес хоста {{ OS }} с ролью DATA>:9200/_template/index_defaults' \
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
