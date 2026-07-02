[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for ClickHouse®](../index.md) > [Пошаговые инструкции](index.md) > Хранение и обработка данных > Подключение внешних словарей

# Подключение внешних словарей в Managed Service for ClickHouse®

Вы можете подключать к кластеру [внешние словари](../concepts/dictionaries.md#external-dicts) и отключать их. Подробнее о словарях читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary).

Managed Service for ClickHouse® поддерживает несколько типов источников словарей:

* ClickHouse®;
* HTTP(s);
* Yandex StoreDoc;
* MySQL®;
* PostgreSQL.

Словарями можно управлять либо через SQL (рекомендуемый способ), либо через интерфейсы Yandex Cloud.

{% note info %}

Количество словарей, которые можно подключить к кластеру, ограничено. Подробнее о лимитах в разделе [Квоты и лимиты](../concepts/limits.md).

{% endnote %}

## Получить список словарей {#get-dicts-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Словари**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы получить список внешних словарей в кластере ClickHouse®:

    1. Посмотрите описание команды CLI для получения детальной информации о кластере:

        ```bash
        yc managed-clickhouse cluster get --help
        ```

    1. Выполните команду:

        ```bash
        yc managed-clickhouse cluster get <имя_кластера>
        ```

    Подключенные словари отображаются в блоке `dictionaries:` результата выполнения команды.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.ListExternalDictionaries](../api-ref/Cluster/listExternalDictionaries.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/externalDictionaries'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listExternalDictionaries.md#yandex.cloud.mdb.clickhouse.v1.ListClusterExternalDictionariesResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.ListExternalDictionaries](../api-ref/grpc/Cluster/listExternalDictionaries.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.ListExternalDictionaries
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listExternalDictionaries.md#yandex.cloud.mdb.clickhouse.v1.ListClusterExternalDictionariesResponse).

- SQL {#sql}

    1. [Подключитесь](connect/clients.md) к нужной базе данных кластера Managed Service for ClickHouse® с помощью `clickhouse-client`.
    1. Выполните [запрос](https://clickhouse.com/docs/ru/sql-reference/statements/show#show-dictionaries) `SHOW DICTIONARIES`.

{% endlist %}

## Создать словарь {#add-dictionary}

{% note info %}

* Словари, создаваемые через интерфейсы Yandex Cloud, располагаются в глобальном пространстве имен кластера ClickHouse®. При использовании SQL словарь создается в указанной базе данных и находится в пространстве имен этой базы данных.
* При создании внешнего словаря через SQL доступно больше источников и настроек. Например, словари с источником Redis или Cassandra можно создать только через SQL.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% note warning %}

    Если словарь создан в консоли, для него недоступно управление через SQL.

    {% endnote %}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Словари**.
    1. В правом верхнем углу экрана нажмите кнопку **Создать словарь**.
    1. Укажите [настройки словаря](#settings).
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    {% note warning %}

    Если словарь добавлен через CLI, для него недоступно управление через SQL.

    {% endnote %}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать внешний словарь в кластере ClickHouse®:

    1. Посмотрите описание команды CLI для добавления словарей:

        ```bash
        yc managed-clickhouse cluster add-external-dictionary --help
        ```

    1. Выполните команду добавления словаря и укажите [его настройки](#settings):

        ```bash
        yc managed-clickhouse cluster add-external-dictionary \
           --name=<имя_кластера_ClickHouse®> \
           --dict-name=<имя_словаря> \
           ...
        ```

- REST API {#api}

    {% note warning %}

    Если словарь добавлен через API, для него недоступно управление через SQL.

    {% endnote %}

    Чтобы создать внешний словарь в кластере ClickHouse®:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.CreateExternalDictionary](../api-ref/Cluster/createExternalDictionary.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

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
                "mysqlSource": {<настройки_источника_MySQL®>},
                "clickhouseSource": {<настройки_источника_ClickHouse®>},
                "mongodbSource": {<настройки_источника_Yandex_StoreDoc>},
                "postgresqlSource": {<настройки_источника_PostgreSQL>}
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

                {% note warning %}
                
                Поля `structure.id.name` и `structure.key.attributes` — взаимоисключающие. Использование одного делает невозможным использование другого.
                
                {% endnote %}

            * `externalDictionary.layout`— способ размещения словаря в памяти.
            * `externalDictionary.fixedLifetime` — фиксированный период между обновлениями словаря в секундах.
            * `externalDictionary.lifetimeRange` — диапазон, внутри которого ClickHouse® случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов.

              {% note warning %}
              
              Поля `fixedLifetime` и `lifetimeRange` — взаимоисключающие. Использование одного делает невозможным использование другого.
              
              {% endnote %}

            * `externalDictionary.***Source` — настройки источника данных для словаря. Выберите один из источников и укажите его настройки:
                * `httpSource` — источник HTTP(s).
                * `mysqlSource` — источник MySQL®.
                * `clickhouseSource` — источник ClickHouse®.
                * `mongodbSource` — источник Yandex StoreDoc.
                * `postgresqlSource` — источник PostgreSQL.

            Подробное описание атрибутов и других настроек словаря [приведено ниже](#settings).

        1. Выполните запрос:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>:createExternalDictionary' \
              --data '@body.json'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/createExternalDictionary.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    {% note warning %}

    Если словарь добавлен через API, для него недоступно управление через SQL.

    {% endnote %}

    Чтобы создать внешний словарь в кластере ClickHouse®:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.CreateExternalDictionary](../api-ref/grpc/Cluster/createExternalDictionary.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                "mysql_source": {<настройки_источника_MySQL®>},
                "clickhouse_source": {<настройки_источника_ClickHouse®>},
                "mongodb_source": {<настройки_источника_Yandex_StoreDoc>},
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

                {% note warning %}
                
                Поля `structure.id.name` и `structure.key.attributes` — взаимоисключающие. Использование одного делает невозможным использование другого.
                
                {% endnote %}

            * `external_dictionary.layout`— способ размещения словаря в памяти.
            * `external_dictionary.fixed_lifetime` — фиксированный период между обновлениями словаря в секундах.
            * `external_dictionary.lifetime_range` — диапазон, внутри которого ClickHouse® случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов.

              {% note warning %}
              
              Поля `fixed_lifetime` и `lifetime_range` — взаимоисключающие. Использование одного делает невозможным использование другого.
              
              {% endnote %}

            * `external_dictionary.***_source` — настройки источника данных для словаря. Выберите один из источников и укажите его настройки:
                * `http_source` — источник HTTP(s).
                * `mysql_source` — источник MySQL®.
                * `clickhouse_source` — источник ClickHouse®.
                * `mongodb_source` — источник Yandex StoreDoc.
                * `postgresql_source` — источник PostgreSQL.

            Подробное описание атрибутов и других настроек словаря [приведено ниже](#settings).

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Выполните запрос:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              mdb.api.cloud.yandex.net:443 \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.CreateExternalDictionary \
              < body.json
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/createExternalDictionary.md#yandex.cloud.operation.Operation).

- SQL {#sql}

    {% note warning %}

    Если словарь добавлен через SQL, для него недоступно управление через консоль, CLI и API.

    {% endnote %}

    1. [Подключитесь](connect/clients.md) к нужной базе данных кластера Managed Service for ClickHouse® с помощью `clickhouse-client`.
    1. Выполните [DDL-запрос](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary):

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

    Подробное описание настроек читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary).

{% endlist %}

## Обновить словарь {#update-dictionary}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Словари**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного словаря и выберите пункт **Редактировать**.
    1. Измените [настройки словаря](#settings).

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы обновить внешний словарь в кластере ClickHouse®:

    1. Посмотрите описание команды CLI для обновления словаря:

        ```bash
        yc managed-clickhouse cluster update-external-dictionary --help
        ```

    1. Выполните команду добавления словаря и укажите [его настройки](#settings):

        ```bash
        yc managed-clickhouse cluster update-external-dictionary \
           --name <имя_кластера_ClickHouse®> \
           --dict-name <имя_словаря> \
           ...
        ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.UpdateExternalDictionary](../api-ref/Cluster/updateExternalDictionary.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

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
                "mysqlSource": {<настройки_источника_MySQL®>},
                "clickhouseSource": {<настройки_источника_ClickHouse®>},
                "mongodbSource": {<настройки_источника_Yandex_StoreDoc>},
                "postgresqlSource": {<настройки_источника_PostgreSQL>}
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

                {% note warning %}
                
                Поля `structure.id.name` и `structure.key.attributes` — взаимоисключающие. Использование одного делает невозможным использование другого.
                
                {% endnote %}

            * `externalDictionary.layout`— способ размещения словаря в памяти.
            * `externalDictionary.fixedLifetime` — фиксированный период между обновлениями словаря в секундах.
            * `externalDictionary.lifetimeRange` — диапазон, внутри которого ClickHouse® случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов.

              {% note warning %}
              
              Поля `fixedLifetime` и `lifetimeRange` — взаимоисключающие. Использование одного делает невозможным использование другого.
              
              {% endnote %}

            * `externalDictionary.***Source` — настройки источника данных для словаря. Выберите один из источников и укажите его настройки:
                * `httpSource` — источник HTTP(s).
                * `mysqlSource` — источник MySQL®.
                * `clickhouseSource` — источник ClickHouse®.
                * `mongodbSource` — источник Yandex StoreDoc.
                * `postgresqlSource` — источник PostgreSQL.

            Подробное описание атрибутов и других настроек словаря [приведено ниже](#settings).

        1. Выполните запрос:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>:updateExternalDictionary' \
              --data '@body.json'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateExternalDictionary.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.UpdateExternalDictionary](../api-ref/grpc/Cluster/updateExternalDictionary.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                "mysql_source": {<настройки_источника_MySQL®>},
                "clickhouse_source": {<настройки_источника_ClickHouse®>},
                "mongodb_source": {<настройки_источника_Yandex_StoreDoc>},
                "postgresql_source": {<настройки_источника_ PostgreSQL>}
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

                {% note warning %}
                
                Поля `structure.id.name` и `structure.key.attributes` — взаимоисключающие. Использование одного делает невозможным использование другого.
                
                {% endnote %}

            * `external_dictionary.layout`— способ размещения словаря в памяти.
            * `external_dictionary.fixed_lifetime` — фиксированный период между обновлениями словаря в секундах.
            * `external_dictionary.lifetime_range` — диапазон, внутри которого ClickHouse® случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов.

              {% note warning %}
              
              Поля `fixed_lifetime` и `lifetime_range` — взаимоисключающие. Использование одного делает невозможным использование другого.
              
              {% endnote %}

            * `external_dictionary.***_source` — настройки источника данных для словаря. Выберите один из источников и укажите его настройки:
                * `http_source` — источник HTTP(s).
                * `mysql_source` — источник MySQL®.
                * `clickhouse_source` — источник ClickHouse®.
                * `mongodb_source` — источник Yandex StoreDoc.
                * `postgresql_source` — источник PostgreSQL.

            Подробное описание атрибутов и других настроек словаря [приведено ниже](#settings).

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Выполните запрос:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              mdb.api.cloud.yandex.net:443 \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.UpdateExternalDictionary \
              < body.json
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateExternalDictionary.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить словарь {#delete-dictionary}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Словари**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного словаря и выберите пункт **Удалить словарь**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы удалить внешний словарь:

    1. Посмотрите описание команды CLI для удаления словаря:

        ```bash
        yc managed-clickhouse cluster remove-external-dictionary --help
        ```

    1. Удалите словарь с помощью команды:

        ```bash
        yc managed-clickhouse cluster remove-external-dictionary \
           --name=<имя_кластера> \
           --dict-name=<имя_словаря>
        ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.DeleteExternalDictionary](../api-ref/Cluster/deleteExternalDictionary.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>:deleteExternalDictionary' \
            --data '{
                      "externalDictionaryName": "<имя_словаря>"
                    }'
        ```

        Где `externalDictionaryName` — имя словаря, который нужно удалить. Имя словаря можно запросить со [списком внешних словарей в кластере](#get-dicts-list).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteExternalDictionary.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.DeleteExternalDictionary](../api-ref/grpc/Cluster/deleteExternalDictionary.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteExternalDictionary
        ```

        Где `external_dictionary_name` — имя словаря, который нужно удалить. Имя словаря можно запросить со [списком внешних словарей в кластере](#get-dicts-list).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteExternalDictionary.md#yandex.cloud.operation.Operation).

- SQL {#sql}

    1. [Подключитесь](connect/clients.md) к нужной базе данных кластера Managed Service for ClickHouse® с помощью `clickhouse-client`.
    1. Выполните [запрос](https://clickhouse.com/docs/ru/sql-reference/statements/drop#drop-dictionary) `DROP DICTIONARY <имя_БД>.<имя_словаря>`.

{% endlist %}

## Настройки словарей {#settings}

{% note warning %}

Изменение настроек словарей приводит к перезапуску серверов ClickHouse® на хостах кластера.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  * **Имя** — имя нового словаря. После создания словаря нельзя будет изменить его имя.

  * **Источник** — настройки источника словаря. Выберите один из перечисленных источников и укажите его настройки:

    {% cut "ClickHouse" %}

    * **Хост** — имя хоста ClickHouse®. Необязательный параметр.

        Хост должен находиться в той же сети, что и кластер ClickHouse®.

    * **Порт** — порт для подключения к источнику. Необязательный параметр.
    * **Пользователь** — имя пользователя базы данных источника.
    * **Пароль** — пароль для доступа к базе данных источника.
    * **База данных** — имя базы данных источника.
    * **Таблица** — имя таблицы источника.
    * **Условие выбора** — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора `id=10` эквивалентно SQL-команде `WHERE id=10`.
    * (Опционально) **Проверка статуса словаря** — SQL-запрос для проверки изменений словаря. ClickHouse® будет обновлять словарь только при изменении результата выполнения этого запроса.

    {% endcut %}

    {% cut "StoreDoc" %}

    * **Хост** — имя хоста Yandex StoreDoc. Хост должен находиться в той же сети, что и кластер ClickHouse®.
    * **Порт** — порт для подключения к источнику.
    * **Пользователь** — имя пользователя базы данных источника.
    * **Пароль** — пароль для доступа к базе данных источника.
    * **База данных** — имя базы данных источника.
    * **Коллекция** — имя коллекции Yandex StoreDoc.

    {% endcut %}

    {% cut "MySQL" %}

    * **Реплики** — список реплик MySQL®, которые будут использоваться как источник словаря.
        Для реплик можно задать общие параметры подключения или настроить порт, имя пользователя и пароль.
    * **Порт** — порт для подключения к источнику.
    * **Пользователь** — имя пользователя базы данных источника.
    * **Пароль** — пароль для доступа к базе данных источника.
    * **База данных** — имя базы данных источника.
    * **Таблица** — имя таблицы источника.
    * **Условие выбора** — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора `id=10` эквивалентно SQL-команде `WHERE id=10`.
    * (Опционально) **Проверка статуса словаря** — SQL-запрос для проверки изменений словаря. ClickHouse® будет обновлять словарь только при изменении результата выполнения этого запроса.

    {% endcut %}

    {% cut "PostgreSQL" %}

    * **Хосты** — имена хоста-мастера PostgreSQL и его [реплик](../../managed-postgresql/concepts/replication.md), которые будут использоваться в качестве источника словаря. Хосты должны находиться в той же сети, что и кластер ClickHouse®.
    * **Порт** — порт для подключения к источнику.
    * **Пользователь** — имя пользователя базы данных источника.
    * **Пароль** — пароль для доступа к базе данных источника.
    * **База данных** — имя базы данных источника.
    * **Таблица** — имя таблицы источника.
    * (Опционально) **Проверка статуса словаря** — SQL-запрос для проверки изменений словаря. ClickHouse® будет обновлять словарь только при изменении результата выполнения этого запроса.
    * **SSL mode** — режим для установки защищенного SSL TCP/IP соединения с базой данных PostgreSQL. Подробнее читайте в [документации PostgreSQL](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-PARAMKEYWORDS).

    {% endcut %}

    {% cut "HTTP(s) " %}

    * **URL** — URL HTTP(s)-источника.
    * **Формат файла** — [формат](https://clickhouse.com/docs/ru/interfaces/formats#formats) файла для HTTP(s)-источника. Подробнее о форматах читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/interfaces/formats#formats).

    {% endcut %}


    Подробнее об источниках словарей и параметрах их подключения читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/sources).

  * **Размещение в памяти** — способ размещения словаря в памяти. Поддерживаются способы: `flat`, `hashed`, `complex_key_hashed`, `range_hashed`, `cache`, `complex_key_cache`, `sparse_hashed`, `complex_key_sparse_hashed`, `complex_key_range_hashed`, `direct`, `complex_key_direct`, `ip_trie`. Подробнее о способах размещения словарей в памяти читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts).
  * **Размер кэша** — количество ячеек кеша для способов `cache`, `complex_key_cache`. Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/cache).
  * **Чтение просроченных ключей** — определяет, разрешать ли считывать ключи с истекшим сроком действия. Используется для способов `cache` и `complex_key_cache`. Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/cache).
  * Настройки очереди обновлений, в которой создаются задачи обновления кеша, если ключи не найдены в словаре. Настройки используются для способов `cache` и `complex_key_cache`.

    * **Макс. размер очереди обновления** — максимальное количество задач обновления в очереди. Значение по умолчанию — `100000`.
    * **Таймаут размещения в очереди** — максимальное время ожидания в миллисекундах для отправки задачи обновления в очередь. Значение по умолчанию — `10`.
    * **Таймаут ожидания очереди** — максимальное время ожидания в миллисекундах для завершения задачи обновления. Значение по умолчанию — `60000` (1 минута).
    * **Макс. кол-во потоков обновления** — максимальное количество потоков для обновления словаря кеша. Значение по умолчанию — `4`.

    Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/cache).

  * Настройки размера плоских массивов. Используются для способа `flat`.

    * **Начальный размер массива** — начальный размер ключа словаря. Значение по умолчанию — `1024`.
    * **Макс. размер массива** — максимальный размер ключа словаря. Определяет размер памяти, который использует словарь, так как этот размер пропорционален значению самого большого ключа. Значение по умолчанию — `500000`.

    Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/flat).

  * **Доступ к ключу из атрибутов** — позволяет получать имя составного ключа с помощью функции `dictGetString`. Используется для способа `ip_trie`. Включение этой настройки увеличивает нагрузку на оперативную память.
  * **Числовой ключ** — имя ключевого столбца словаря. Ключевой столбец должен иметь тип данных UInt64. Используется для способов `flat`, `hashed`, `range_hashed`, `cache`, `sparse_hashed`, `direct`. Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/attributes#numeric-key).
  * **Столбцы данных** — описание составного ключа словаря. Составной ключ может состоять из одного или более элементов. Используется для способов `complex_key_*` и `ip_trie`:

    * **Имя** — имя столбца.
    * **Тип данных** — тип данных столбца.
    * (Опционально) **Значение по умолчанию** — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
    * (Опционально) **Выражение** — [выражение](https://clickhouse.com/docs/ru/sql-reference/syntax#syntax-expressions), которое ClickHouse® выполняет со значением столбца.
    * **Иерархический** — признак поддержки иерархии.
    * **Инъективный** — признак инъективности отображения `id` → `attribute`.

    Подробнее о параметрах составного ключа читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/attributes#composite-key).

  * **Размещение в памяти** — настройки частоты обновления словаря:

    * **Период** — периодичность обновления словаря. Выберите тип периода обновления и его настройки:

      * **фиксированный** — фиксированный период между обновлениями словаря:
        * **Длительность периода** — период обновления данных словаря в секундах.

      * **переменный** — диапазон, внутри которого ClickHouse® случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов:
        * **Минимум** — минимальное значение периода между обновлениями словаря в секундах.
        * **Максимум** — максимальное значение периода между обновлениями словаря в секундах.

    Подробнее об обновлении словарей читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/lifetime).

- CLI {#cli}

  * `--dict-name` — имя нового словаря.
  * `--***-source` — настройки источника словаря. Выберите один из перечисленных источников и укажите его настройки:

    {% cut "`--clickhouse-source` — источник ClickHouse®" %}

    * `host` — имя хоста источника. Необязательный параметр.

        Хост должен находиться в той же сети, что и кластер ClickHouse®.

    * `port` — порт для подключения к источнику. Необязательный параметр.
    * `db` — имя базы данных источника.
    * `user` — имя пользователя базы данных источника.
    * `password` — пароль для доступа к базе данных источника.
    * `table` — имя таблицы источника.
    * `where` — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора `id=10` эквивалентно SQL-команде `WHERE id=10`.
    * `secure` — использовать ли SSL для установки соединения.

    {% endcut %}

    {% cut "`--mongodb-source` — источник Yandex StoreDoc" %}

    * `host` — имя хоста источника. Хост должен находиться в той же сети, что и кластер ClickHouse®.
    * `port` — порт для подключения к источнику.
    * `db` — имя базы данных источника.
    * `user` — имя пользователя базы данных источника.
    * `password` — пароль для доступа к базе данных источника.
    * `connection` — имя коллекции источника.

    {% endcut %}

    {% cut "`--mysql-source` – источник MySQL®" %}

    * `db` — имя базы данных источника.
    * `user` — имя пользователя базы данных источника.
    * `password` — пароль для доступа к базе данных источника.
    * `table` — имя таблицы источника.
    * `where` — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора`id=10` эквивалентно SQL-команде `WHERE id=10`.
    * `share-connection` – сделать ли соединение общим для нескольких запросов.
    * `close-connection` — закрывать ли соединение после каждого запроса.

    {% endcut %}

    {% cut "`--postgresql-source` — источник PostgreSQL" %}

    * `table` — имя таблицы источника.
    * `ssl-mode` — режим для установки защищенного SSL TCP/IP соединения с базой данных PostgreSQL. Допустимые значения: `disable`, `allow`, `prefer`, `verify-ca`, `verify-full`.

    {% endcut %}

    {% cut "`--http-source` – источник HTTP(s)" %}

    * `url` — URL HTTP(s)-источника.
    * `format` — формат файла для HTTP(s)-источника. Подробнее о форматах читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/interfaces/formats#formats).

    {% endcut %}

  * `--http-header` — особый HTTP-заголовок запроса к источнику HTTP(s):

    * `name` – имя заголовка;
    * `value` — значение заголовка.

  * `--mysql-replica` — настройки реплик источника MySQL®:

    * `host` — имя хоста реплики.
    * `priority` — приоритет реплики. При попытке соединения ClickHouse® обходит реплики в соответствии с приоритетом. Чем меньше цифра, тем выше приоритет.
    * `port` — порт для подключения к реплике.
    * `user` — имя пользователя базы данных.
    * `password` — пароль для доступа к базе данных.

  * `--mysql-invalidate-query` — запрос для проверки изменений словаря MySQL®. ClickHouse® будет обновлять словарь только при изменении результата выполнения этого запроса.

  * `--postgresql-source-hosts` — имена хоста-мастера PostgreSQL и его [реплик](../../managed-postgresql/concepts/replication.md), которые будут использоваться в качестве источника PostgreSQL. Хосты должны находиться в той же сети, что и кластер ClickHouse®.

  * `--postgresql-invalidate-query` — запрос для проверки изменений словаря PostgreSQL. ClickHouse® будет обновлять словарь только при изменении результата выполнения этого запроса.

  * `--layout-type` — способ размещения словаря в памяти. Поддерживаются способы: `flat`, `hashed`, `complex_key_hashed`, `range_hashed`, `cache`, `complex_key_cache`, `sparse_hashed`, `complex_key_sparse_hashed`, `complex_key_range_hashed`, `direct`, `complex_key_direct`, `ip_trie`. Подробнее о способах размещения словарей в памяти читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts).
  * `--layout-size-in-cells` — количество ячеек кеша для способов `cache`, `complex_key_cache`. Подробнее о кеше читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/cache).
  * `--layout-allow-read-expired-keys` — определяет, разрешать ли считывать ключи с истекшим сроком действия. Используется для способов `cache` и `complex_key_cache`. Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/cache).
  * Настройки очереди обновлений, в которой создаются задачи обновления кеша, если ключи не найдены в словаре. Настройки используются для способов `cache` и `complex_key_cache`.

    * `--layout-max-update-queue-size` — максимальное количество задач обновления в очереди. Значение по умолчанию — `100000`.
    * `--layout-update-queue-push-timeout-milliseconds` — максимальное время ожидания в миллисекундах для отправки задачи обновления в очередь. Значение по умолчанию — `10`.
    * `--layout-query-wait-timeout-milliseconds` — максимальное время ожидания в миллисекундах для завершения задачи обновления. Значение по умолчанию — `60000` (1 минута).
    * `--layout-max-threads-for-updates` — максимальное количество потоков для обновления словаря кеша. Значение по умолчанию — `4`.

    Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/cache).

  * Настройки размера плоских массивов. Используются для способа `flat`.

    * `--layout-initial-array-size` — начальный размер ключа словаря. Значение по умолчанию — `1024`.
    * `--layout-max-array-size` — максимальный размер ключа словаря. Определяет размер памяти, который использует словарь, так как этот размер пропорционален значению самого большого ключа. Значение по умолчанию — `500000`.

    Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/flat).

  * `--layout-access-to-key-from-attributes` — позволяет получать имя составного ключа с помощью функции `dictGetString`. Используется для способа `ip_trie`. Включение этой настройки увеличивает нагрузку на оперативную память.
  * `--structure-id` — имя ключевого столбца словаря. Ключевой столбец должен иметь тип данных UInt64. Используется для способов `flat`, `hashed`, `range_hashed`, `cache`, `sparse_hashed`, `direct`. Подробнее о ключах читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/attributes#numeric-key).
  * `--structure-key` — описание составного ключа словаря. Составной ключ может состоять из одного или более элементов. Используется для способов `complex_key_*` и `ip_trie`:

    * `name` — имя столбца.
    * `type` — тип данных столбца.
    * `null-value` — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
    * `expression` — [выражение](https://clickhouse.com/docs/ru/sql-reference/syntax#syntax-expressions), которое ClickHouse® выполняет со значением столбца.
    * `hierarchical` — признак поддержки иерархии.
    * `injective` — признак инъективности отображения `id` → `attribute`.

    Подробнее о параметрах составного ключа читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/attributes#composite-key).

    {% note warning %}

    Настройки `--structure-id` и `--structure-key` — взаимоисключающие. Использование одной делает невозможным использование другой.

    {% endnote %}

  * `--structure-attribute` — описание полей, доступных для запросов к базе данных:

    * `name` — имя столбца.
    * `type` — тип данных столбца.
    * `null-value` — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
    * `expression` — [выражение](https://clickhouse.com/docs/ru/sql-reference/syntax#syntax-expressions), которое ClickHouse® выполняет со значением столбца.
    * `hierarchical` — признак поддержки иерархии.
    * `injective` — признак инъективности отображения `id` → `attribute`.

  * `--fixed-lifetime` — фиксированный период между обновлениями словаря в секундах.
  * `--lifetime-range` — диапазон, внутри которого ClickHouse® случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов.

    * `min` — минимальное значение периода между обновлениями словаря в секундах.
    * `max` — максимальное значение периода между обновлениями словаря в секундах.

    {% note warning %}

    Настройки `--fixed-lifetime` и `--lifetime-range` — взаимоисключающие. Использование одной делает невозможным использование другой.

    {% endnote %}

- REST API {#api}

  * `externalDictionary` – настройки нового словаря:

    * `name` — имя нового словаря.
    * `***Source` – источник данных для словаря. Выберите один из перечисленных источников и укажите его настройки:

      {% cut "`clickhouseSource` — источник ClickHouse®" %}

      * `db` — имя базы данных источника.
      * `table` — имя таблицы источника.
      * `where` — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора `id=10` эквивалентно SQL-команде `WHERE id=10`.
      * `host` — имя хоста источника. Необязательный параметр.

          Хост должен находиться в той же сети, что и кластер ClickHouse®.

      * `port` — порт для подключения к источнику. Необязательный параметр.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `secure` — использовать ли SSL для установки соединения.

      {% endcut %}

      {% cut "`mongodbSource` — источник Yandex StoreDoc" %}

      * `db` — имя базы данных источника.
      * `host` — имя хоста источника. Хост должен находиться в той же сети, что и кластер ClickHouse®.
      * `port` — порт для подключения к источнику.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `collection` — имя коллекции источника.

      {% endcut %}

      {% cut "`mysqlSource` – источник MySQL®" %}

      * `db` — имя базы данных источника.
      * `table` — имя таблицы источника.
      * `where` — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора`id=10` эквивалентно SQL-команде `WHERE id=10`.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `replicas` — настройки реплик источника:
        * `host` — имя хоста реплики. Хост должен находиться в той же сети, что и кластер ClickHouse®.
        * `priority` — приоритет реплики. При попытке соединения ClickHouse® обходит реплики в соответствии с приоритетом. Чем меньше цифра, тем выше приоритет.
        * `port` — порт для подключения к реплике.
        * `user` — имя пользователя базы данных.
        * `password` — пароль для доступа к базе данных.
      * `invalidateQuery` — запрос для проверки изменений словаря MySQL®. ClickHouse® будет обновлять словарь только при изменении результата выполнения этого запроса.
      * `shareConnection` — сделать ли соединение общим для нескольких запросов.
      * `closeConnection` — закрывать ли соединение после каждого запроса.

      {% endcut %}

      {% cut "`postgresqlSource` — источник PostgreSQL" %}

      * `db` — имя базы данных источника.
      * `table` — имя таблицы источника.
      * `port` — порт для подключения к источнику.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `sslMode` — режим для установки защищенного SSL TCP/IP соединения с базой данных PostgreSQL. Допустимые значения: `DISABLE`, `ALLOW`, `PREFER`, `VERIFY_CA`, `VERIFY_FULL`.
      * `hosts` — имена хоста-мастера PostgreSQL и его [реплик](../../managed-postgresql/concepts/replication.md), которые будут использоваться в качестве источника словаря. Хосты должны находиться в той же сети, что и кластер ClickHouse®.
      * `invalidateQuery` — запрос для проверки изменений словаря. ClickHouse® будет обновлять словарь только при изменении результата выполнения этого запроса.

      {% endcut %}

      {% cut "`httpSource` – источник HTTP(s)" %}

      * `url` — URL HTTP(s)-источника.
      * `format` — формат файла для HTTP(s)-источника. Подробнее о форматах читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/interfaces/formats#formats).
      * `headers` – особые HTTP-заголовки запроса к источнику:
        * `name` – имя заголовка;
        * `value` — значение заголовка.

      {% endcut %}

    * `layout.type` — способ размещения словаря в памяти. Поддерживаются способы: `FLAT`, `HASHED`, `COMPLEX_KEY_HASHED`, `RANGE_HASHED`, `CACHE`, `COMPLEX_KEY_CACHE`, `SPARSE_HASHED`, `COMPLEX_KEY_SPARSE_HASHED`, `COMPLEX_KEY_RANGE_HASHED`, `DIRECT`, `COMPLEX_KEY_DIRECT`, `IP_TRIE`. Подробнее о способах размещения словарей в памяти читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts).
    * `layout.sizeInCells` — количество ячеек кеша для способов `CACHE`, `COMPLEX_KEY_CACHE`. Подробнее о кеше читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/cache).
    * `layout.allowReadExpiredKeys` — определяет, разрешать ли считывать ключи с истекшим сроком действия. Используется для способов `CACHE` и `COMPLEX_KEY_CACHE`. Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/cache).
    * Настройки очереди обновлений, в которой создаются задачи обновления кеша, если ключи не найдены в словаре. Настройки используются для способов `CACHE` и `COMPLEX_KEY_CACHE`.

      * `layout.maxUpdateQueueSize` — максимальное количество задач обновления в очереди. Значение по умолчанию — `100000`.
      * `layout.updateQueuePushTimeoutMilliseconds` — максимальное время ожидания в миллисекундах для отправки задачи обновления в очередь. Значение по умолчанию — `10`.
      * `layout.queryWaitTimeoutMilliseconds` — максимальное время ожидания в миллисекундах для завершения задачи обновления. Значение по умолчанию — `60000` (1 минута).
      * `layout.maxThreadsForUpdates` — максимальное количество потоков для обновления словаря кеша. Значение по умолчанию — `4`.

      Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/cache).

    * Настройки размера плоских массивов. Используются для способа `FLAT`.

      * `layout.initialArraySize` — начальный размер ключа словаря. Значение по умолчанию — `1024`.
      * `layout.maxArraySize` — максимальный размер ключа словаря. Определяет размер памяти, который использует словарь, так как этот размер пропорционален значению самого большого ключа. Значение по умолчанию — `500000`.

      Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/flat).

    * `layout.accessToKeyFromAttributes` — позволяет получать имя составного ключа с помощью функции `dictGetString`. Используется для способа `IP_TRIE`. Включение этой настройки увеличивает нагрузку на оперативную память.
    * `structure.id.name` — имя ключевого столбца словаря. Ключевой столбец должен иметь тип данных UInt64. Используется для способов `FLAT`, `HASHED`, `RANGE_HASHED`, `CACHE`, `SPARSE_HASHED`, `DIRECT`. Подробнее о ключах читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/attributes#numeric-key).
    * `structure.key.attributes` — описание составного ключа словаря. Составной ключ может состоять из одного или более элементов. Используется для способов `COMPLEX_KEY_*` и `IP_TRIE`:

      * `name` — имя столбца.
      * `type` — тип данных столбца.
      * `nullValue` — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
      * `expression` — [выражение](https://clickhouse.com/docs/ru/sql-reference/syntax#syntax-expressions), которое ClickHouse® выполняет со значением столбца.
      * `hierarchical` — признак поддержки иерархии.
      * `injective` — признак инъективности отображения `id` → `attribute`.

      Подробнее о параметрах составного ключа читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/attributes#composite-key).

      {% note warning %}
      
      Поля `structure.id.name` и `structure.key.attributes` — взаимоисключающие. Использование одного делает невозможным использование другого.
      
      {% endnote %}

    * `structure.attributes` — описание полей, доступных для запросов к базе данных:

      * `name` — имя столбца.
      * `type` — тип данных столбца.
      * `nullValue` — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
      * `expression` — [выражение](https://clickhouse.com/docs/ru/sql-reference/syntax#syntax-expressions), которое ClickHouse® выполняет со значением столбца.
      * `hierarchical` — признак поддержки иерархии.
      * `injective` — признак инъективности отображения `id` → `attribute`.

    * `fixedLifetime` — фиксированный период между обновлениями словаря в секундах.
    * `lifetimeRange` — диапазон, внутри которого ClickHouse® случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов. Границы диапазона задаются в настройках:

      * `min` — минимальное значение периода между обновлениями словаря в секундах.
      * `max` — максимальное значение периода между обновлениями словаря в секундах.

      {% note warning %}
      
      Поля `fixedLifetime` и `lifetimeRange` — взаимоисключающие. Использование одного делает невозможным использование другого.
      
      {% endnote %}

- gRPC API {#grpc-api}

  * `external_dictionary` – настройки нового словаря:

    * `name` — имя нового словаря.
    * `***_source` – источник данных для словаря. Выберите один из перечисленных источников и укажите его настройки:

      {% cut "`clickhouse_source` — источник ClickHouse®" %}

      * `db` — имя базы данных источника.
      * `table` — имя таблицы источника.
      * `where` — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора `id=10` эквивалентно SQL-команде `WHERE id=10`.
      * `host` — имя хоста источника. Необязательный параметр.

          Хост должен находиться в той же сети, что и кластер ClickHouse®.

      * `port` — порт для подключения к источнику. Необязательный параметр.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `secure` — использовать ли SSL для установки соединения.

      {% endcut %}

      {% cut "`mongodb_source` — источник Yandex StoreDoc" %}

      * `db` — имя базы данных источника.
      * `host` — имя хоста источника. Хост должен находиться в той же сети, что и кластер ClickHouse®.
      * `port` — порт для подключения к источнику.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `collection` — имя коллекции источника.

      {% endcut %}

      {% cut "`mysql_source` – источник MySQL®" %}

      * `db` — имя базы данных источника.
      * `table` — имя таблицы источника.
      * `where` — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора`id=10` эквивалентно SQL-команде `WHERE id=10`.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `replicas` — настройки реплик источника:
        * `host` — имя хоста реплики. Хост должен находиться в той же сети, что и кластер ClickHouse®.
        * `priority` — приоритет реплики. При попытке соединения ClickHouse® обходит реплики в соответствии с приоритетом. Чем меньше цифра, тем выше приоритет.
        * `port` — порт для подключения к реплике.
        * `user` — имя пользователя базы данных.
        * `password` — пароль для доступа к базе данных.
      * `invalidate_query` — запрос для проверки изменений словаря MySQL®. ClickHouse® будет обновлять словарь только при изменении результата выполнения этого запроса.
      * `share_connection` — сделать ли соединение общим для нескольких запросов.
      * `close_connection` — закрывать ли соединение после каждого запроса.

      {% endcut %}

      {% cut "`postgresql_source` — источник PostgreSQL" %}

      * `db` — имя базы данных источника.
      * `table` — имя таблицы источника.
      * `port` — порт для подключения к источнику.
      * `user` — имя пользователя базы данных источника.
      * `password` — пароль для доступа к базе данных источника.
      * `ssl_mode` — режим для установки защищенного SSL TCP/IP соединения с базой данных PostgreSQL. Допустимые значения: `DISABLE`, `ALLOW`, `PREFER`, `VERIFY_CA`, `VERIFY_FULL`.
      * `hosts` — имена хоста-мастера PostgreSQL и его [реплик](../../managed-postgresql/concepts/replication.md), которые будут использоваться в качестве источника словаря. Хосты должны находиться в той же сети, что и кластер ClickHouse®.
      * `invalidate_query` — запрос для проверки изменений словаря. ClickHouse® будет обновлять словарь только при изменении результата выполнения этого запроса.

      {% endcut %}

      {% cut "`http_source` – источник HTTP(s)" %}

      * `url` — URL HTTP(s)-источника.
      * `format` — формат файла для HTTP(s)-источника. Подробнее о форматах читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/interfaces/formats#formats).
      * `headers` – особые HTTP-заголовки запроса к источнику:
        * `name` – имя заголовка;
        * `value` — значение заголовка.

      {% endcut %}

    * `layout.type` — способ размещения словаря в памяти. Поддерживаются способы: `FLAT`, `HASHED`, `COMPLEX_KEY_HASHED`, `RANGE_HASHED`, `CACHE`, `COMPLEX_KEY_CACHE`, `SPARSE_HASHED`, `COMPLEX_KEY_SPARSE_HASHED`, `COMPLEX_KEY_RANGE_HASHED`, `DIRECT`, `COMPLEX_KEY_DIRECT`, `IP_TRIE`. Подробнее о способах размещения словарей в памяти читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts).
    * `layout.size_in_cells` — количество ячеек кеша для способов `CACHE`, `COMPLEX_KEY_CACHE`. Подробнее о кеше читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/cache).
    * `layout.allow_read_expired_keys` — определяет, разрешать ли считывать ключи с истекшим сроком действия. Используется для способов `CACHE` и `COMPLEX_KEY_CACHE`. Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/cache).
    * Настройки очереди обновлений, в которой создаются задачи обновления кеша, если ключи не найдены в словаре. Настройки используются для способов `CACHE` и `COMPLEX_KEY_CACHE`.

      * `layout.max_update_queue_size` — максимальное количество задач обновления в очереди. Значение по умолчанию — `100000`.
      * `layout.update_queue_push_timeout_milliseconds` — максимальное время ожидания в миллисекундах для отправки задачи обновления в очередь. Значение по умолчанию — `10`.
      * `layout.query_wait_timeout_milliseconds` — максимальное время ожидания в миллисекундах для завершения задачи обновления. Значение по умолчанию — `60000` (1 минута).
      * `layout.max_threads_for_updates` — максимальное количество потоков для обновления словаря кеша. Значение по умолчанию — `4`.

      Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/cache).

    * Настройки размера плоских массивов. Используются для способа `FLAT`.

      * `layout.initial_array_size` — начальный размер ключа словаря. Значение по умолчанию — `1024`.
      * `layout.max_array_size` — максимальный размер ключа словаря. Определяет размер памяти, который использует словарь, так как этот размер пропорционален значению самого большого ключа. Значение по умолчанию — `500000`.

      Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/layouts/flat).

    * `layout.access_to_key_from_attributes` — позволяет получать имя составного ключа с помощью функции `dictGetString`. Используется для способа `IP_TRIE`. Включение этой настройки увеличивает нагрузку на оперативную память.
    * `structure.id.name` — имя ключевого столбца словаря. Ключевой столбец должен иметь тип данных UInt64. Используется для способов `FLAT`, `HASHED`, `RANGE_HASHED`, `CACHE`, `SPARSE_HASHED`, `DIRECT`. Подробнее о ключах читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/attributes#numeric-key).
    * `structure.key.attributes` — описание составного ключа словаря. Составной ключ может состоять из одного или более элементов. Используется для способов `COMPLEX_KEY_*` и `IP_TRIE`:

      * `name` — имя столбца.
      * `type` — тип данных столбца.
      * `null_value` — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
      * `expression` — [выражение](https://clickhouse.com/docs/ru/sql-reference/syntax#syntax-expressions), которое ClickHouse® выполняет со значением столбца.
      * `hierarchical` — признак поддержки иерархии.
      * `injective` — признак инъективности отображения `id` → `attribute`.

      Подробнее о параметрах составного ключа читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary/attributes#composite-key).

      {% note warning %}
      
      Поля `structure.id.name` и `structure.key.attributes` — взаимоисключающие. Использование одного делает невозможным использование другого.
      
      {% endnote %}

    * `structure.attributes` — описание полей, доступных для запросов к базе данных:

      * `name` — имя столбца.
      * `type` — тип данных столбца.
      * `null_value` — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
      * `expression` — [выражение](https://clickhouse.com/docs/ru/sql-reference/syntax#syntax-expressions), которое ClickHouse® выполняет со значением столбца.
      * `hierarchical` — признак поддержки иерархии.
      * `injective` — признак инъективности отображения `id` → `attribute`.

    * `fixed_lifetime` — фиксированный период между обновлениями словаря в секундах.
    * `lifetime_range` — диапазон, внутри которого ClickHouse® случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов. Границы диапазона задаются в настройках:

      * `min` — минимальное значение периода между обновлениями словаря в секундах.
      * `max` — максимальное значение периода между обновлениями словаря в секундах.

      {% note warning %}
      
      Поля `fixed_lifetime` и `lifetime_range` — взаимоисключающие. Использование одного делает невозможным использование другого.
      
      {% endnote %}

{% endlist %}

## Примеры {#examples}

Пусть существует кластер ClickHouse® `mych` с идентификатором `cat0adul1fj0********`, и в этот кластер нужно подключить словарь с тестовыми характеристиками:

* имя словаря `mychdict`;
* имя ключевого столбца `id`;
* поля, доступные для запросов к базе данных:
    * `id` с типом `UInt64`;
    * `field1`с типом `String`;
* фиксированный период между обновлениями словаря 300 секунд;
* способ размещения словаря в памяти `cache` с размером кеша в 1024 ячейки;
* источник PostgreSQL:
    * база данных `db1`;
    * имя таблицы `table1`;
    * порт для подключения `6432`;
    * имя пользователя базы данных `user1`;
    * пароль для доступа к базе данных `user1user1`;
    * режим для установки защищенного SSL TCP/IP соединения с базой данных `verify-full`;
    * особый FQDN хоста-мастера `c-c9qash3nb1v9********.rw.mdb.yandexcloud.net`.

{% list tabs group=instructions %}

- CLI {#cli}

    Выполните следующую команду:

    ```bash
    yc managed-clickhouse cluster add-external-dictionary \
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
                          `port=6432,`
                          `user=user1,`
                          `password=user1user1,`
                          `ssl-mode=verify-full \
       --postgresql-source-hosts=c-c9qash3nb1v9********.rw.mdb.yandexcloud.net
    ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

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
              "table": "table1",
              "port": "5432",
              "user": "user1",
              "password": "user1user1",
              "sslMode": "VERIFY_FULL",
              "hosts": ["c-c9qash3nb1v9********.rw.mdb.yandexcloud.net"]
            }
          }
        }
        ```

    1. Выполните запрос c помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/cat0adul1fj0********:createExternalDictionary' \
            --data '@body.json'
        ```

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "cat0adul1fj0********",
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
              "table": "table1",
              "port": "5432",
              "user": "user1",
              "password": "user1user1",
              "ssl_mode": "VERIFY_FULL",
              "hosts": ["c-c9qash3nb1v9********.rw.mdb.yandexcloud.net"]
            }
          }
        }
        ```

    1. Выполните запрос с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.CreateExternalDictionary \
            < body.json
        ```

- SQL {#sql}

    1. [Подключитесь](connect/clients.md) к нужной базе данных кластера Managed Service for ClickHouse® с помощью `clickhouse-client`.
    1. Выполните [DDL-запрос](https://clickhouse.com/docs/ru/sql-reference/statements/create/dictionary):

        ```sql
        CREATE DICTIONARY mychdict(
          `id` UInt64,
          `field1` String
        )
        PRIMARY KEY id
        SOURCE(POSTGRESQL(
           port 5432
           host 'c-c9qash3nb1v9********.rw.mdb.yandexcloud.net'
           user 'user1'
           password 'user1user1'
           db 'db1'
           table 'table1'
        ))
        LIFETIME(300)
        LAYOUT(CASHE(SIZE_IN_CELLS 1024));
        ```

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._