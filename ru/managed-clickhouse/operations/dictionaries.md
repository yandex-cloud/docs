# Подключение внешних словарей в {{ mch-name }}

Вы можете подключать к кластеру [внешние словари](../concepts/dictionaries.md#external-dicts) и отключать их. Подробнее о словарях читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/).

{{ mch-name }} поддерживает несколько типов источников словарей:

* {{ CH }};
* HTTP(s);
* {{ MG }};
* {{ MY }};
* {{ PG }}.

Словарями можно управлять либо через SQL (рекомендуемый способ), либо через интерфейсы {{ yandex-cloud }}.

{% note info %}

Количество словарей, которые можно подключить к кластеру, ограничено. Подробнее о лимитах см. в разделе [Квоты и лимиты](../concepts/limits.md).

{% endnote %}

## Получить список словарей {#get-dicts-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список внешних словарей в кластере {{ CH }}:

    1. Посмотрите описание команды CLI для получения детальной информации о кластере:

        ```bash
        {{ yc-mdb-ch }} cluster get --help
        ```

    1. Выполните команду:

        ```bash
        {{ yc-mdb-ch }} cluster get <имя_кластера>
        ```

    Подключенные словари отображаются в блоке `dictionaries:` результата выполнения команды.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.ListExternalDictionaries](../api-ref/Cluster/listExternalDictionaries.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/externalDictionaries'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listExternalDictionaries.md#yandex.cloud.mdb.clickhouse.v1.ListClusterExternalDictionariesResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.ListExternalDictionaries](../api-ref/grpc/Cluster/listExternalDictionaries.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.ListExternalDictionaries
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listExternalDictionaries.md#yandex.cloud.mdb.clickhouse.v1.ListClusterExternalDictionariesResponse).

- SQL {#sql}

    1. [Подключитесь](connect/clients.md) к нужной базе данных кластера {{ mch-name }} с помощью `clickhouse-client`.
    1. Выполните [запрос]({{ ch.docs }}/sql-reference/statements/show/#show-dictionaries) `SHOW DICTIONARIES`.

{% endlist %}

## Создать словарь {#add-dictionary}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% note warning %}

    Если словарь создан в консоли, для него недоступно управление через SQL.

    {% endnote %}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}**.
    1. В правом верхнем углу экрана нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.dictionaries.button-action_add-dictionary }}**.
    1. Укажите [настройки словаря](#settings).
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.dictionaries.button_submit }}**.

- CLI {#cli}

    {% note warning %}

    Если словарь добавлен через CLI, для него недоступно управление через SQL.

    {% endnote %}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать внешний словарь в кластере {{ CH }}:

    1. Посмотрите описание команды CLI для добавления словарей:

        ```bash
        {{ yc-mdb-ch }} cluster add-external-dictionary --help
        ```

    1. Выполните команду добавления словаря и укажите [его настройки](#settings):

        ```bash
        {{ yc-mdb-ch }} cluster add-external-dictionary \
           --name=<имя_кластера_{{ CH }}> \
           --dict-name=<имя_словаря> \
           ...
        ```

- REST API {#api}

    {% note warning %}

    Если словарь добавлен через API, для него недоступно управление через SQL.

    {% endnote %}

    Чтобы создать внешний словарь в кластере {{ CH }}:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.CreateExternalDictionary](../api-ref/Cluster/createExternalDictionary.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            ```json
            {
              "externalDictionary": {
                "name": "<имя_словаря>",
                "structure": {
                  "id": {
                    "name": "<имя_ключевого_столбца_словаря>"
                  },
                  "key": {
                    "attributes": [
                      <массив_столбцов_с_данными_словаря>
                    ]
                  },
                  "rangeMin": {<начальный_столбец_для_RANGE_HASHED>},
                  "rangeMax": {<конечный_столбец_для_RANGE_HASHED>},
                  "attributes": [
                     <массив_описаний_полей>
                  ]
                },
                "layout": {<способ_размещения_в_памяти>},
                "fixedLifetime": "<фиксированный_период_между_обновлениями>",
                "lifetimeRange": {<диапазон_для_выбора_периода_между_обновлениями>},
                "httpSource": {<настройки_источника_HTTP(s)>},
                "mysqlSource": {<настройки_источника_{{ MY }}>},
                "clickhouseSource": {<настройки_источника_{{ CH }}>},
                "mongodbSource": {<настройки_источника_{{ MG }}>},
                "postgresqlSource": {<настройки_источника_{{ PG }}>}
              }
            }
            ```

            Где:

            * `externalDictionary.name` — имя словаря.
            * `externalDictionary.structure` — структура словаря:
                * `id.name` — имя ключевого столбца словаря.
                * `key.attributes` — массив для описания составного ключа словаря.
                * `rangeMin` — описание начального столбца, которое необходимо, если используется способ размещения в памяти `RANGE_HASHED`.
                * `rangeMax` — описание конечного столбца, которое необходимо, если используется способ размещения в памяти `RANGE_HASHED`.
                * `attributes` — массив описаний полей, доступных для запросов к базе данных.

                {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

            * `externalDictionary.layout`— способ размещения словаря в памяти.
            * `externalDictionary.fixedLifetime` — фиксированный период между обновлениями словаря в секундах.
            * `externalDictionary.lifetimeRange` — диапазон, внутри которого {{ CH }} случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов.

              {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-restapi.md) %}

            * `externalDictionary.***Source` — настройки источника данных для словаря. Выберите один из источников и укажите его настройки:
                * `httpSource` — источник HTTP(s).
                * `mysqlSource` — источник {{ MY }}.
                * `clickhouseSource` — источник {{ CH }}.
                * `mongodbSource` — источник {{ MG }}.
                * `postgresqlSource` — источник {{ PG }}.

            Подробное описание атрибутов и других настроек словаря [приведено ниже](#settings).

        1. Выполните запрос:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>:createExternalDictionary' \
              --data '@body.json'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/createExternalDictionary.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    {% note warning %}

    Если словарь добавлен через API, для него недоступно управление через SQL.

    {% endnote %}

    Чтобы создать внешний словарь в кластере {{ CH }}:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.CreateExternalDictionary](../api-ref/grpc/Cluster/createExternalDictionary.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            ```json
            {
              "cluster_id": "<идентификатор_кластера>",
              "external_dictionary": {
                "name": "<имя_словаря>",
                "structure": {
                  "id": {
                    "name": "<имя_ключевого_столбца_словаря>"
                  },
                  "key": {
                    "attributes": [<массив_столбцов_с_данными_словаря>]
                  },
                  "range_min": {<начальный_столбец_для_RANGE_HASHED>},
                  "range_max": {<конечный_столбец_для_RANGE_HASHED>},
                  "attributes": [<массив_описаний_полей>]
                },
                "layout": {<способ_размещения_в_памяти>},
                "fixed_lifetime": "<фиксированный_период_между_обновлениями>",
                "lifetime_range": {<диапазон_для_выбора_периода_между_обновлениями>},
                "http_source": {<настройки_источника_HTTP(s)>},
                "mysql_source": {<настройки_источника_MySQL>},
                "clickhouse_source": {<настройки_источника_ClickHouse®>},
                "mongodb_source": {<настройки_источника_MongoDB>},
                "postgresql_source": {<настройки_источника_PostgreSQL>}
              }
            }
            ```

            Где:

            * `external_dictionary.name` — имя словаря.
            * `external_dictionary.structure` — структура словаря:
                * `id.name` — имя ключевого столбца словаря.
                * `key.attributes` — массив описаний столбцов с данными словаря.
                * `range_min` — описание начального столбца, которое необходимо, если используется способ размещения в памяти `RANGE_HASHED`.
                * `range_max` — описание конечного столбца, которое необходимо, если используется способ размещения в памяти `RANGE_HASHED`.
                * `attributes` — массив описаний полей, доступных для запросов к базе данных.

                {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

            * `external_dictionary.layout`— способ размещения словаря в памяти.
            * `external_dictionary.fixed_lifetime` — фиксированный период между обновлениями словаря в секундах.
            * `external_dictionary.lifetime_range` — диапазон, внутри которого {{ CH }} случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов.

              {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-grpcapi.md) %}

            * `external_dictionary.***_source` — настройки источника данных для словаря. Выберите один из источников и укажите его настройки:
                * `http_source` — источник HTTP(s).
                * `mysql_source` — источник {{ MY }}.
                * `clickhouse_source` — источник {{ CH }}.
                * `mongodb_source` — источник {{ MG }}.
                * `postgresql_source` — источник {{ PG }}.

            Подробное описание атрибутов и других настроек словаря [приведено ниже](#settings).

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

        1. Выполните запрос:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.CreateExternalDictionary \
              < body.json
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/createExternalDictionary.md#yandex.cloud.operation.Operation).

- SQL {#sql}

    {% note warning %}

    Если словарь добавлен через SQL, для него недоступно управление через консоль, CLI и API.

    {% endnote %}

    1. [Подключитесь](connect/clients.md) к нужной базе данных кластера {{ mch-name }} с помощью `clickhouse-client`.
    1. Выполните [DDL-запрос]({{ ch.docs }}/sql-reference/statements/create/dictionary/):

        ```sql
        CREATE DICTIONARY <имя_словаря>(
          <столбцы_данных>
        )
        PRIMARY KEY <имя_столбца_с_ключами>
        SOURCE(<источник>(<конфигурация_источника>))
        LIFETIME(<интервал_обновления>)
        LAYOUT(<способ_размещения_в_памяти>());
        ```

        Где:

        * `<имя_словаря>` — имя нового словаря.
        * `<столбцы_данных>` — список столбцов с данными словаря и их тип.
        * `PRIMARY KEY` — имя ключевого столбца словаря.
        * `SOURCE` — источник и его параметры.
        * `LIFETIME` — периодичность обновления словаря.
        * `LAYOUT` — способ размещения словаря в памяти. Поддерживаются способы:
          * `flat`,
          * `hashed`,
          * `cache`,
          * `range_hashed`,
          * `complex_key_hashed`,
          * `complex_key_cache`.

    Подробное описание настроек читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict/).

{% endlist %}

## Обновить словарь {#update-dictionary}

{% list tabs group=instructions %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.UpdateExternalDictionary](../api-ref/Cluster/updateExternalDictionary.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            ```json
            {
              "externalDictionary": {
                "name": "<имя_словаря>",
                "structure": {
                  "id": {
                    "name": "<имя_ключевого_столбца_словаря>"
                  },
                  "key": {
                    "attributes": [
                      <массив_столбцов_с_данными_словаря>
                    ]
                  },
                  "rangeMin": {<начальный_столбец_для_RANGE_HASHED>},
                  "rangeMax": {<конечный_столбец_для_RANGE_HASHED>},
                  "attributes": [
                     <массив_описаний_полей>
                  ]
                },
                "layout": {<способ_размещения_в_памяти>},
                "fixedLifetime": "<фиксированный_период_между_обновлениями>",
                "lifetimeRange": {<диапазон_для_выбора_периода_между_обновлениями>},
                "httpSource": {<настройки_источника_HTTP(s)>},
                "mysqlSource": {<настройки_источника_{{ MY }}>},
                "clickhouseSource": {<настройки_источника_{{ CH }}>},
                "mongodbSource": {<настройки_источника_{{ MG }}>},
                "postgresqlSource": {<настройки_источника_{{ PG }}>}
              },
              "updateMask": "externalDictionary.<настройка_1>,...,externalDictionary.<настройка_N>"
            }
            ```

            Где:

            * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

              В данном случае перечислите все изменяемые настройки словаря.

            * `externalDictionary.name` — имя словаря.
            * `externalDictionary.structure` — структура словаря:
                * `id.name` — имя ключевого столбца словаря.
                * `key.attributes` — массив для описания составного ключа словаря.
                * `rangeMin` — описание начального столбца, которое необходимо, если используется способ размещения в памяти `RANGE_HASHED`.
                * `rangeMax` — описание конечного столбца, которое необходимо, если используется способ размещения в памяти `RANGE_HASHED`.
                * `attributes` — массив описаний полей, доступных для запросов к базе данных.

                {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

            * `externalDictionary.layout`— способ размещения словаря в памяти.
            * `externalDictionary.fixedLifetime` — фиксированный период между обновлениями словаря в секундах.
            * `externalDictionary.lifetimeRange` — диапазон, внутри которого {{ CH }} случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов.

              {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-restapi.md) %}

            * `externalDictionary.***Source` — настройки источника данных для словаря. Выберите один из источников и укажите его настройки:
                * `httpSource` — источник HTTP(s).
                * `mysqlSource` — источник {{ MY }}.
                * `clickhouseSource` — источник {{ CH }}.
                * `mongodbSource` — источник {{ MG }}.
                * `postgresqlSource` — источник {{ PG }}.

            Подробное описание атрибутов и других настроек словаря [приведено ниже](#settings).

        1. Выполните запрос:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>:updateExternalDictionary' \
              --data '@body.json'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateExternalDictionary.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.UpdateExternalDictionary](../api-ref/grpc/Cluster/updateExternalDictionary.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            ```json
            {
              "cluster_id": "<идентификатор_кластера>",
              "external_dictionary": {
                "name": "<имя_словаря>",
                "structure": {
                  "id": {
                    "name": "<имя_ключевого_столбца_словаря>"
                  },
                  "key": {
                    "attributes": [<массив_столбцов_с_данными_словаря>]
                  },
                  "range_min": {<начальный_столбец_для_RANGE_HASHED>},
                  "range_max": {<конечный_столбец_для_RANGE_HASHED>},
                  "attributes": [<массив_описаний_полей>]
                },
                "layout": {<способ_размещения_в_памяти>},
                "fixed_lifetime": "<фиксированный_период_между_обновлениями>",
                "lifetime_range": {<диапазон_для_выбора_периода_между_обновлениями>},
                "http_source": {<настройки_источника_HTTP(s)>},
                "mysql_source": {<настройки_источника_MySQL>},
                "clickhouse_source": {<настройки_источника_ClickHouse®>},
                "mongodb_source": {<настройки_источника_MongoDB>},
                "postgresql_source": {<настройки_источника_PostgreSQL>}
              },
              "update_mask": "externalDictionary.<настройка_1>,...,externalDictionary.<настройка_N>"
            }
            ```

            Где:

            * `update_mask` — перечень изменяемых параметров в одну строку через запятую.

              В данном случае перечислите все изменяемые настройки словаря.

            * `external_dictionary.name` — имя словаря.
            * `external_dictionary.structure` — структура словаря:
                * `id.name` — имя ключевого столбца словаря.
                * `key.attributes` — массив описаний столбцов с данными словаря.
                * `range_min` — описание начального столбца, которое необходимо, если используется способ размещения в памяти `RANGE_HASHED`.
                * `range_max` — описание конечного столбца, которое необходимо, если используется способ размещения в памяти `RANGE_HASHED`.
                * `attributes` — массив описаний полей, доступных для запросов к базе данных.

                {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

            * `external_dictionary.layout`— способ размещения словаря в памяти.
            * `external_dictionary.fixed_lifetime` — фиксированный период между обновлениями словаря в секундах.
            * `external_dictionary.lifetime_range` — диапазон, внутри которого {{ CH }} случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов.

              {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-grpcapi.md) %}

            * `external_dictionary.***_source` — настройки источника данных для словаря. Выберите один из источников и укажите его настройки:
                * `http_source` — источник HTTP(s).
                * `mysql_source` — источник {{ MY }}.
                * `clickhouse_source` — источник {{ CH }}.
                * `mongodb_source` — источник {{ MG }}.
                * `postgresql_source` — источник {{ PG }}.

            Подробное описание атрибутов и других настроек словаря [приведено ниже](#settings).

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

        1. Выполните запрос:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.UpdateExternalDictionary \
              < body.json
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateExternalDictionary.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить словарь {#delete-dictionary}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного словаря и выберите пункт **{{ ui-key.yacloud.mdb.cluster.dictionaries.button_action-delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить внешний словарь:

    1. Посмотрите описание команды CLI для удаления словаря:

        ```bash
        {{ yc-mdb-ch }} cluster remove-external-dictionary --help
        ```

    1. Удалите словарь с помощью команды:

        ```bash
        {{ yc-mdb-ch }} cluster remove-external-dictionary \
           --name=<имя_кластера> \
           --dict-name=<имя_словаря>
        ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.DeleteExternalDictionary](../api-ref/Cluster/deleteExternalDictionary.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>:deleteExternalDictionary' \
            --data '{
                      "externalDictionaryName": "<имя_словаря>"
                    }'
        ```

        Где `externalDictionaryName` — имя словаря, который нужно удалить. Имя словаря можно запросить со [списком внешних словарей в кластере](#get-dicts-list).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteExternalDictionary.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.DeleteExternalDictionary](../api-ref/grpc/Cluster/deleteExternalDictionary.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "external_dictionary_name": "<имя_словаря>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteExternalDictionary
        ```

        Где `external_dictionary_name` — имя словаря, который нужно удалить. Имя словаря можно запросить со [списком внешних словарей в кластере](#get-dicts-list).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteExternalDictionary.md#yandex.cloud.operation.Operation).

- SQL {#sql}

    1. [Подключитесь](connect/clients.md) к нужной базе данных кластера {{ mch-name }} с помощью `clickhouse-client`.
    1. Выполните [запрос]({{ ch.docs }}/sql-reference/statements/drop/#drop-dictionary) `DROP DICTIONARY <имя_БД>.<имя_словаря>`.

{% endlist %}

## Настройки словарей {#settings}

{% note warning %}

Изменение настроек словарей приводит к перезапуску серверов {{ CH }} на хостах кластера.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_name }}** — имя нового словаря.

  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_source }}** — настройки источника словаря. Выберите один из перечисленных источников и укажите его настройки:

    {% cut "{{ CH }}" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_host }}** — имя хоста {{ CH }}. Необязательный параметр.

        Хост должен находиться в той же сети, что и кластер {{ CH }}.

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}** — порт для подключения к источнику. Необязательный параметр.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}** — имя пользователя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}** — пароль для доступа к базе данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}** — имя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}** — имя таблицы источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_where }}** — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора `id=10` эквивалентно SQL-команде `WHERE id=10`.
    * (Опционально) **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}** — SQL-запрос для проверки изменений словаря. {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.

    {% endcut %}

    {% cut "{{ MG }}" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_host }}** — имя хоста {{ MG }}. Хост должен находиться в той же сети, что и кластер {{ CH }}.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}** — порт для подключения к источнику.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}** — имя пользователя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}** — пароль для доступа к базе данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}** — имя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_collection }}** — имя коллекции {{ MG }}.

    {% endcut %}

    {% cut "{{ MY }}" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_replicas }}** — список реплик {{ MY }}, которые будут использоваться как источник словаря.
        Для реплик можно задать общие параметры подключения или настроить порт, имя пользователя и пароль.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}** — порт для подключения к источнику.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}** — имя пользователя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}** — пароль для доступа к базе данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}** — имя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}** — имя таблицы источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_where }}** — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора `id=10` эквивалентно SQL-команде `WHERE id=10`.
    * (Опционально) **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}** — SQL-запрос для проверки изменений словаря. {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.

    {% endcut %}

    {% cut "{{ PG }}" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_hosts }}** — имена хоста-мастера {{ PG }} и его [реплик](../../managed-postgresql/concepts/replication.md), которые будут использоваться в качестве источника словаря. Хосты должны находиться в той же сети, что и кластер {{ CH }}.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}** — порт для подключения к источнику.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}** — имя пользователя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}** — пароль для доступа к базе данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}** — имя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}** — имя таблицы источника.
    * (Опционально) **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}** — SQL-запрос для проверки изменений словаря. {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_postgresql-ssl-mode }}** — режим для установки защищенного SSL TCP/IP соединения с базой данных {{ PG }}. Подробнее читайте в [документации {{ PG }}](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-PARAMKEYWORDS).

    {% endcut %}

    {% cut "HTTP(s)" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_http-url }}** — URL HTTP(s)-источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_http-format }}** — [формат]({{ ch.docs }}/interfaces/formats/#formats) файла для HTTP(s)-источника. Подробнее о форматах читайте в [документации {{ CH }}]({{ ch.docs }}/interfaces/formats/#formats).

    {% endcut %}

    Подробнее об источниках словарей и параметрах их подключения читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-source/).

  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_layout-type }}** — способ размещения словаря в памяти. Поддерживаются способы: `flat`, `hashed`, `cache`, `range_hashed`, `complex_key_hashed`, `complex_key_cache`. Подробнее о способах размещения словарей в памяти читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).
  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_size-in-cells }}** — количество ячеек кэша для способов `cache`, `complex_key_cache`. Подробнее читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache).
  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_structure-id }}** — имя ключевого столбца словаря. Ключевой столбец должен иметь тип данных UInt64. Используется для способов `flat`, `hashed`, `cache`, `range_hashed`. Подробнее читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key).
  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_structure-attributes }}** — описание составного ключа словаря. Составной ключ может состоять из одного или более элементов. Используется для способов `complex_key_hashed`, `complex_key_cache`:

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-name }}** — имя столбца.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-type }}** — тип данных столбца.
    * (Опционально) **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-nullValue }}** — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
    * (Опционально) **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-expression }}** — [выражение]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions), которое {{ CH }} выполняет со значением столбца.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-hierarchical }}** — признак поддержки иерархии.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-injective }}** — признак инъективности отображения `id` → `attribute`.

    Подробнее о параметрах составного ключа читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#composite-key).

  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_layout-type }}** — настройки частоты обновления словаря:

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_update-interval }}** — периодичность обновления словаря. Выберите тип периода обновления и его настройки:

      * **{{ ui-key.yacloud.mdb.cluster.dictionaries.label_fixed-lifetime }}** — фиксированный период между обновлениями словаря:
        * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_fixed-lifetime }}** — период обновления данных словаря в секундах.

      * **{{ ui-key.yacloud.mdb.cluster.dictionaries.label_range-lifetime }}** — диапазон, внутри которого {{ CH }} случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов:
        * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_range-lifetime-min }}** — минимальное значение периода между обновлениями словаря в секундах.
        * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_range-lifetime-max }}** — максимальное значение периода между обновлениями словаря в секундах.

    Подробнее об обновлении словарей читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).

- CLI {#cli}

  * `--dict-name` — имя нового словаря.
  * `--***-source` — настройки источника словаря. Выберите один из перечисленных источников и укажите его настройки:

    {% cut "`--clickhouse-source` — источник {{ CH }}" %}

    * `host` — имя хоста источника. Необязательный параметр.

        Хост должен находиться в той же сети, что и кластер {{ CH }}.

    * `port` — порт для подключения к источнику. Необязательный параметр.
    * `db` — имя базы данных источника.
    * `user` — имя пользователя базы данных источника.
    * `password` — пароль для доступа к базе данных источника.
    * `table` — имя таблицы источника.
    * `where` — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора `id=10` эквивалентно SQL-команде `WHERE id=10`.
    * `secure` — использовать ли SSL для установки соединения.

    {% endcut %}

    {% cut "`--mongodb-source` — источник {{ MG }}" %}

    * `host` — имя хоста источника. Хост должен находиться в той же сети, что и кластер {{ CH }}.
    * `port` — порт для подключения к источнику.
    * `db` — имя базы данных источника.
    * `user` — имя пользователя базы данных источника.
    * `password` — пароль для доступа к базе данных источника.
    * `connection` — имя коллекции источника.

    {% endcut %}

    {% cut "`--mysql-source` – источник {{ MY }}" %}

    * `db` — имя базы данных источника.
    * `user` — имя пользователя базы данных источника.
    * `password` — пароль для доступа к базе данных источника.
    * `table` — имя таблицы источника.
    * `where` — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора`id=10` эквивалентно SQL-команде `WHERE id=10`.
    * `share-connection` – сделать ли соединение общим для нескольких запросов.
    * `close-connection` — закрывать ли соединение после каждого запроса.

    {% endcut %}

    {% cut "`--postgresql-source` — источник {{ PG }}" %}

    * `table` — имя таблицы источника.
    * `ssl-mode` — режим для установки защищенного SSL TCP/IP соединения с базой данных {{ PG }}. Допустимые значения: `disable`, `allow`, `prefer`, `verify-ca`, `verify-full`.

    {% endcut %}

    {% cut "`--http-source` – источник HTTP(s)" %}

    * `url` — URL HTTP(s)-источника.
    * `format` — формат файла для HTTP(s)-источника. Подробнее о форматах читайте в [документации {{ CH }}]({{ ch.docs }}/interfaces/formats/#formats).

    {% endcut %}

  * `--http-header` — особый HTTP-заголовок запроса к источнику HTTP(s):

    * `name` – имя заголовка;
    * `value` — значение заголовка.

  * `--mysql-replica` — настройки реплик источника {{ MY }}:

    * `host` — имя хоста реплики.
    * `priority` — приоритет реплики. При попытке соединения {{ CH }} обходит реплики в соответствии с приоритетом. Чем меньше цифра, тем выше приоритет.
    * `port` — порт для подключения к реплике.
    * `user` — имя пользователя базы данных.
    * `password` — пароль для доступа к базе данных.

  * `--mysql-invalidate-query` — запрос для проверки изменений словаря {{ MY }}. {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.

  * `--postgresql-source-hosts` — имена хоста-мастера {{ PG }} и его [реплик](../../managed-postgresql/concepts/replication.md), которые будут использоваться в качестве источника {{ PG }}. Хосты должны находиться в той же сети, что и кластер {{ CH }}.

  * `--postgresql-invalidate-query` — запрос для проверки изменений словаря {{ PG }}. {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.

  * `--layout-type` — способ размещения словаря в памяти. Поддерживаются способы: `flat`, `hashed`, `cache`, `range_hashed`, `complex_key_hashed`, `complex_key_cache`. Подробнее о способах размещения словарей в памяти читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).
  * `--layout-size-in-cells` — количество ячеек кэша для способов `cache`, `complex_key_cache`. Подробнее о кэше читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache).
  * `--layout-max-array-size` — максимальное значение ключа для способа `flat`. Определяет размер памяти, который использует словарь, так как этот размер пропорционален значению самого большого ключа. Подробнее о значении ключа читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#flat).
  * `--structure-id` — имя ключевого столбца словаря. Ключевой столбец должен иметь тип данных UInt64. Используется для способов `flat`, `hashed`, `cache`, `range_hashed`. Подробнее о ключах читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key).
  * `--structure-key` — описание составного ключа словаря. Составной ключ может состоять из одного или более элементов. Используется для способов `complex_key_hashed`, `complex_key_cache`:

    * `name` — имя столбца.
    * `type` — тип данных столбца.
    * `null-value` — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
    * `expression` — [выражение]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions), которое {{ CH }} выполняет со значением столбца.
    * `hierarchical` — признак поддержки иерархии.
    * `injective` — признак инъективности отображения `id` → `attribute`.

    Подробнее о параметрах составного ключа читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#composite-key).

    {% note warning %}

    Настройки `--structure-id` и `--structure-key` — взаимоисключающие. Использование одной делает невозможным использование другой.

    {% endnote %}

  * `--structure-attribute` — описание полей, доступных для запросов к базе данных:

    * `name` — имя столбца.
    * `type` — тип данных столбца.
    * `null-value` — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
    * `expression` — [выражение]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions), которое {{ CH }} выполняет со значением столбца.
    * `hierarchical` — признак поддержки иерархии.
    * `injective` — признак инъективности отображения `id` → `attribute`.

  * `--fixed-lifetime` — фиксированный период между обновлениями словаря в секундах.
  * `--lifetime-range` — диапазон, внутри которого {{ CH }} случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов.

    * `min` — минимальное значение периода между обновлениями словаря в секундах.
    * `max` — максимальное значение периода между обновлениями словаря в секундах.

    {% note warning %}

    Настройки `--fixed-lifetime` и `--lifetime-range` — взаимоисключающие. Использование одной делает невозможным использование другой.

    {% endnote %}

- REST API {#api}

  * `externalDictionary` – настройки нового словаря:

    * `name` — имя нового словаря.
    * `***Source` – источник данных для словаря. Выберите один из перечисленных источников и укажите его настройки:

      {% cut "`clickhouseSource` — источник {{ CH }}" %}

      * `db` — имя базы данных источника.
      * `table` — имя таблицы источника.
      * `where` — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора `id=10` эквивалентно SQL-команде `WHERE id=10`.
      * `host` — имя хоста источника. Необязательный параметр.

          Хост должен находиться в той же сети, что и кластер {{ CH }}.

      * `port` — порт для подключения к источнику. Необязательный параметр.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `secure` — использовать ли SSL для установки соединения.

      {% endcut %}

      {% cut "`mongodbSource` — источник {{ MG }}" %}

      * `db` — имя базы данных источника.
      * `host` — имя хоста источника. Хост должен находиться в той же сети, что и кластер {{ CH }}.
      * `port` — порт для подключения к источнику.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `collection` — имя коллекции источника.

      {% endcut %}

      {% cut "`mysqlSource` – источник {{ MY }}" %}

      * `db` — имя базы данных источника.
      * `table` — имя таблицы источника.
      * `where` — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора`id=10` эквивалентно SQL-команде `WHERE id=10`.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `replicas` — настройки реплик источника:
        * `host` — имя хоста реплики. Хост должен находиться в той же сети, что и кластер {{ CH }}.
        * `priority` — приоритет реплики. При попытке соединения {{ CH }} обходит реплики в соответствии с приоритетом. Чем меньше цифра, тем выше приоритет.
        * `port` — порт для подключения к реплике.
        * `user` — имя пользователя базы данных.
        * `password` — пароль для доступа к базе данных.
      * `invalidateQuery` — запрос для проверки изменений словаря {{ MY }}. {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.
      * `shareConnection` — сделать ли соединение общим для нескольких запросов.
      * `closeConnection` — закрывать ли соединение после каждого запроса.

      {% endcut %}

      {% cut "`postgresqlSource` — источник {{ PG }}" %}

      * `db` — имя базы данных источника.
      * `table` — имя таблицы источника.
      * `port` — порт для подключения к источнику.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `sslMode` — режим для установки защищенного SSL TCP/IP соединения с базой данных {{ PG }}. Допустимые значения: `DISABLE`, `ALLOW`, `PREFER`, `VERIFY_CA`, `VERIFY_FULL`.
      * `hosts` — имена хоста-мастера {{ PG }} и его [реплик](../../managed-postgresql/concepts/replication.md), которые будут использоваться в качестве источника словаря. Хосты должны находиться в той же сети, что и кластер {{ CH }}.
      * `invalidateQuery` — запрос для проверки изменений словаря. {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.

      {% endcut %}

      {% cut "`httpSource` – источник HTTP(s)" %}

      * `url` — URL HTTP(s)-источника.
      * `format` — формат файла для HTTP(s)-источника. Подробнее о форматах читайте в [документации {{ CH }}]({{ ch.docs }}/interfaces/formats/#formats).
      * `headers` – особые HTTP-заголовки запроса к источнику:
        * `name` – имя заголовка;
        * `value` — значение заголовка.

      {% endcut %}

    * `layout.type` — способ размещения словаря в памяти. Поддерживаются способы: `FLAT`, `HASHED`, `CACHE`, `RANGE_HASHED`, `COMPLEX_KEY_HASHED`, `COMPLEX_KEY_CACHE`. Подробнее о способах размещения словарей в памяти читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).
    * `layout.sizeInCells` — количество ячеек кэша для способов `CACHE`, `COMPLEX_KEY_CACHE`. Подробнее о кэше читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache).
    * `layout.maxArraySize` — максимальное значение ключа для способа `FLAT`. Определяет размер памяти, который использует словарь, так как этот размер пропорционален значению самого большого ключа. Подробнее о значении ключа читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#flat).
    * `structure.id.name` — имя ключевого столбца словаря. Ключевой столбец должен иметь тип данных UInt64. Используется для способов `FLAT`, `HASHED`, `CACHE`, `RANGE_HASHED`. Подробнее о ключах читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key).
    * `structure.key.attributes` — описание составного ключа словаря. Составной ключ может состоять из одного или более элементов. Используется для способов `COMPLEX_KEY_HASHED`, `COMPLEX_KEY_CACHE`:

      * `name` — имя столбца.
      * `type` — тип данных столбца.
      * `nullValue` — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
      * `expression` — [выражение]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions), которое {{ CH }} выполняет со значением столбца.
      * `hierarchical` — признак поддержки иерархии.
      * `injective` — признак инъективности отображения `id` → `attribute`.

      Подробнее о параметрах составного ключа читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#composite-key).

      {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

    * `structure.attributes` — описание полей, доступных для запросов к базе данных:

      * `name` — имя столбца.
      * `type` — тип данных столбца.
      * `nullValue` — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
      * `expression` — [выражение]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions), которое {{ CH }} выполняет со значением столбца.
      * `hierarchical` — признак поддержки иерархии.
      * `injective` — признак инъективности отображения `id` → `attribute`.

    * `fixedLifetime` — фиксированный период между обновлениями словаря в секундах.
    * `lifetimeRange` — диапазон, внутри которого {{ CH }} случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов. Границы диапазона задаются в настройках:

      * `min` — минимальное значение периода между обновлениями словаря в секундах.
      * `max` — максимальное значение периода между обновлениями словаря в секундах.

      {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-restapi.md) %}

- gRPC API {#grpc-api}

  * `external_dictionary` – настройки нового словаря:

    * `name` — имя нового словаря.
    * `***_source` – источник данных для словаря. Выберите один из перечисленных источников и укажите его настройки:

      {% cut "`clickhouse_source` — источник {{ CH }}" %}

      * `db` — имя базы данных источника.
      * `table` — имя таблицы источника.
      * `where` — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора `id=10` эквивалентно SQL-команде `WHERE id=10`.
      * `host` — имя хоста источника. Необязательный параметр.

          Хост должен находиться в той же сети, что и кластер {{ CH }}.

      * `port` — порт для подключения к источнику. Необязательный параметр.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `secure` — использовать ли SSL для установки соединения.

      {% endcut %}

      {% cut "`mongodb_source` — источник {{ MG }}" %}

      * `db` — имя базы данных источника.
      * `host` — имя хоста источника. Хост должен находиться в той же сети, что и кластер {{ CH }}.
      * `port` — порт для подключения к источнику.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `collection` — имя коллекции источника.

      {% endcut %}

      {% cut "`mysql_source` – источник {{ MY }}" %}

      * `db` — имя базы данных источника.
      * `table` — имя таблицы источника.
      * `where` — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора`id=10` эквивалентно SQL-команде `WHERE id=10`.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `replicas` — настройки реплик источника:
        * `host` — имя хоста реплики. Хост должен находиться в той же сети, что и кластер {{ CH }}.
        * `priority` — приоритет реплики. При попытке соединения {{ CH }} обходит реплики в соответствии с приоритетом. Чем меньше цифра, тем выше приоритет.
        * `port` — порт для подключения к реплике.
        * `user` — имя пользователя базы данных.
        * `password` — пароль для доступа к базе данных.
      * `invalidate_query` — запрос для проверки изменений словаря {{ MY }}. {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.
      * `share_connection` — сделать ли соединение общим для нескольких запросов.
      * `close_connection` — закрывать ли соединение после каждого запроса.

      {% endcut %}

      {% cut "`postgresql_source` — источник {{ PG }}" %}

      * `db` — имя базы данных источника.
      * `table` — имя таблицы источника.
      * `port` — порт для подключения к источнику.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `ssl_mode` — режим для установки защищенного SSL TCP/IP соединения с базой данных {{ PG }}. Допустимые значения: `DISABLE`, `ALLOW`, `PREFER`, `VERIFY_CA`, `VERIFY_FULL`.
      * `hosts` — имена хоста-мастера {{ PG }} и его [реплик](../../managed-postgresql/concepts/replication.md), которые будут использоваться в качестве источника словаря. Хосты должны находиться в той же сети, что и кластер {{ CH }}.
      * `invalidate_query` — запрос для проверки изменений словаря. {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.

      {% endcut %}

      {% cut "`http_source` – источник HTTP(s)" %}

      * `url` — URL HTTP(s)-источника.
      * `format` — формат файла для HTTP(s)-источника. Подробнее о форматах читайте в [документации {{ CH }}]({{ ch.docs }}/interfaces/formats/#formats).
      * `headers` – особые HTTP-заголовки запроса к источнику:
        * `name` – имя заголовка;
        * `value` — значение заголовка.

      {% endcut %}

    * `layout.type` — способ размещения словаря в памяти. Поддерживаются способы: `FLAT`, `HASHED`, `CACHE`, `RANGE_HASHED`, `COMPLEX_KEY_HASHED`, `COMPLEX_KEY_CACHE`. Подробнее о способах размещения словарей в памяти читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).
    * `layout.size_in_cells` — количество ячеек кэша для способов `CACHE`, `COMPLEX_KEY_CACHE`. Подробнее о кэше читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache).
    * `layout.max_array_size` — максимальное значение ключа для способа `FLAT`. Определяет размер памяти, который использует словарь, так как этот размер пропорционален значению самого большого ключа. Подробнее о значении ключа читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#flat).
    * `structure.id.name` — имя ключевого столбца словаря. Ключевой столбец должен иметь тип данных UInt64. Используется для способов `FLAT`, `HASHED`, `CACHE`, `RANGE_HASHED`. Подробнее о ключах читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key).
    * `structure.key.attributes` — описание составного ключа словаря. Составной ключ может состоять из одного или более элементов. Используется для способов `COMPLEX_KEY_HASHED`, `COMPLEX_KEY_CACHE`:

      * `name` — имя столбца.
      * `type` — тип данных столбца.
      * `null_value` — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
      * `expression` — [выражение]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions), которое {{ CH }} выполняет со значением столбца.
      * `hierarchical` — признак поддержки иерархии.
      * `injective` — признак инъективности отображения `id` → `attribute`.

      Подробнее о параметрах составного ключа читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#composite-key).

      {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

    * `structure.attributes` — описание полей, доступных для запросов к базе данных:

      * `name` — имя столбца.
      * `type` — тип данных столбца.
      * `null_value` — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
      * `expression` — [выражение]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions), которое {{ CH }} выполняет со значением столбца.
      * `hierarchical` — признак поддержки иерархии.
      * `injective` — признак инъективности отображения `id` → `attribute`.

    * `fixed_lifetime` — фиксированный период между обновлениями словаря в секундах.
    * `lifetime_range` — диапазон, внутри которого {{ CH }} случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов. Границы диапазона задаются в настройках:

      * `min` — минимальное значение периода между обновлениями словаря в секундах.
      * `max` — максимальное значение периода между обновлениями словаря в секундах.

      {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-grpcapi.md) %}

{% endlist %}

## Примеры {#examples}

Пусть существует кластер {{ CH }} `mych` с идентификатором `{{ cluster-id }}`, и в этот кластер нужно подключить словарь с тестовыми характеристиками:

* имя словаря `mychdict`;
* имя ключевого столбца `id`;
* поля, доступные для запросов к базе данных:
    * `id` с типом `UInt64`;
    * `field1`с типом `String`;
* фиксированный период между обновлениями словаря 300 секунд;
* способ размещения словаря в памяти `cache` с размером кеша в 1024 ячейки;
* источник {{ PG }}:
    * база данных `db1`;
    * имя таблицы `table1`;
    * порт для подключения `{{ port-mpg }}`;
    * имя пользователя базы данных `user1`;
    * пароль для доступа к базе данных `user1user1`;
    * режим для установки защищенного SSL TCP/IP соединения с базой данных `verify-full`;
    * особый FQDN хоста-мастера `c-c9qash3nb1v9********.rw.{{ dns-zone }}`.

{% list tabs group=instructions %}

- CLI {#cli}

    Выполните следующую команду:

    ```bash
    {{ yc-mdb-ch }} cluster add-external-dictionary \
       --name=mych \
       --dict-name=mychdict \
       --structure-id=id \
       --structure-attribute name=id,`
                            `type=UInt64,`
                            `name=field1,`
                            `type=String \
       --fixed-lifetime=300 \
       --layout-type=cache \
       --layout-size-in-cells 1024 \
       --postgresql-source db=db1,`
                          `table=table1,`
                          `port={{ port-mpg }},`
                          `user=user1,`
                          `password=user1user1,`
                          `ssl-mode=verify-full \
       --postgresql-source-hosts=c-c9qash3nb1v9********.rw.{{ dns-zone }}
    ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "externalDictionary": {
            "name": "mychdict",
            "structure": {
              "id": {
                "name": "id"
              },
              "attributes": [
                {
                  "name": "id",
                  "type": "UInt64"
                },
                {
                  "name": "field1",
                  "type": "String"
                }
              ]
            },
            "layout": {
              "type": "CACHE",
              "sizeInCells": "1024"
            },
            "fixedLifetime": "300",
            "postgresqlSource": {
              "db": "db1",
              "table": "table",
              "port": "5432",
              "user": "user1",
              "password": "user1user1",
              "sslMode": "VERIFY_FULL",
              "hosts": ["c-c9qash3nb1v9********.rw.{{ dns-zone }}"]
            }
          }
        }
        ```

    1. Выполните запрос c помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{{ cluster-id }}:createExternalDictionary' \
            --data '@body.json'
        ```

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "{{ cluster-id }}",
          "external_dictionary": {
            "name": "mychdict",
            "structure": {
              "id": {
                "name": "id"
              },
              "attributes": [
                {
                  "name": "id",
                  "type": "UInt64"
                },
                {
                  "name": "field1",
                  "type": "String"
                }
              ]
            },
            "layout": {
              "type": "CACHE",
              "size_in_cells": "1024"
            },
            "fixed_lifetime": "300",
            "postgresql_source": {
              "db": "db1",
              "table": "table",
              "port": "5432",
              "user": "user1",
              "password": "user1user1",
              "ssl_mode": "VERIFY_FULL",
              "hosts": ["c-c9qash3nb1v9********.rw.{{ dns-zone }}"]
            }
          }
        }
        ```

    1. Выполните запрос с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.CreateExternalDictionary \
            < body.json
        ```

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
