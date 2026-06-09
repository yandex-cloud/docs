# Передача данных в эндпоинт-приемник Elasticsearch


С помощью сервиса Yandex Data Transfer вы можете переносить данные в базу Elasticsearch и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Подготовьте базу данных Elasticsearch](#prepare) к трансферу.
1. [Настройте эндпоинт-приемник](#endpoint-settings) в Yandex Data Transfer.
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [Apache Kafka®](../source/kafka.md);
* [YDS](../source/data-streams.md);
* [PostgreSQL](../source/postgresql.md).
* [Elasticsearch](../source/elasticsearch.md);
* [OpenSearch](../source/opensearch.md).

Полный список поддерживаемых источников и приемников в Yandex Data Transfer читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Подготовка базы данных приемника {#prepare}

{% note info %}

Версии Elasticsearch ниже 7.x не поддерживаются.

{% endnote %}

Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../../../interconnect/concepts/index.md) или [VPN](../../../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../../../overview/concepts/public-ips.md#virtual-private-cloud}).

Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../../../concepts/network.md#source-external).

* Убедитесь, что количество колонок в источнике не превышает максимальное количество полей в индексах Elasticsearch. Максимальное количество полей задается в [параметре](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-settings-limit.html#mapping-settings-limit) `index.mapping.total_fields.limit` и по умолчанию составляет `1000`.

    Чтобы увеличить значение параметра, [настройте шаблон](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-put-template.html#indices-put-template), по которому максимальное количество полей в создаваемых индексах будет равно указанному значению.

    {% cut "Пример запроса для настройки шаблона" %}

    ```bash
    curl \
        --user <имя_пользователя_Elasticsearch>:<пароль> \
        --header 'Content-Type: application/json' \
        --request PUT "https://<FQDN_кластера_Elasticsearch>:9200/_template/index_defaults" \
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

    Для настройки шаблона можно также использовать [интерфейс Kibana](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-mgmt.html#manage-index-templates).

    Проверить текущее значение параметра `index.mapping.total_fields.limit` можно с помощью [интерфейса Kibana](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-mgmt.html#view-edit-indices), либо выполнив запрос:

    ```bash
    curl \
        --user <имя_пользователя_Elasticsearch>:<пароль> \
        --header 'Content-Type: application/json' \
        --request GET 'https://<FQDN_кластера_Elasticsearch>:9200/<название_индекса>/_settings/*total_fields.limit?include_defaults=true'
    ```

* По умолчанию при трансфере данных в единичный индекс задействуется только один хост. Чтобы распределить нагрузку между хостами при передаче больших объемов данных, [настройте шаблон](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-put-template.html#indices-put-template), по которому создаваемые индексы будут заранее разбиты на шарды.

    {% cut "Пример запроса для настройки шаблона" %}

    ```bash
    curl \
        --user <имя_пользователя_Elasticsearch>:<пароль> \
        --header 'Content-Type: application/json' \
        --request PUT 'https://<FQDN_кластера_Elasticsearch>:9200/_template/index_defaults' \
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

    Для настройки шаблона можно также использовать [интерфейс Kibana](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-mgmt.html#manage-index-templates).

## Настройка эндпоинта-приемника Elasticsearch {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки подключения к Elasticsearch](#on-premise). Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).


### Пользовательская инсталляция {#on-premise}

Подключение к узлам с явным указанием сетевых адресов и портов.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Узлы с данными** — нажмите на значок ![image](../../../../_assets/console-icons/plus.svg), чтобы добавить новый узел с данными. Для каждого узла укажите:

    * **Хост** — IP-адрес или FQDN хоста с ролью `DATA`, к которому необходимо подключиться.

    * **Порт** — номер порта, который сервис Data Transfer будет использовать для подключения к хосту с ролью `DATA`.

    * **SSL** — выберите, если используется безопасное соединение SSL.

    * **Сертификат CA** — загрузите файл сертификата или добавьте его содержимое в текстовом виде, если требуется шифрование передаваемых данных, например, для соответствия требованиям PCI DSS.

    * **Идентификатор подсети** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md).
      Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
      
   * **Пользователь** — укажите имя пользователя, под которым сервис Data Transfer будет подключаться к кластеру.

   * **Пароль** — укажите пароль пользователя для доступа к кластеру.


   * **Группы безопасности** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.

     Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [Сеть в Yandex Data Transfer](../../../concepts/network.md).


{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Политика очистки** — выберите способ очистки данных в приемнике перед переносом:

        * `Не очищать` — выберите эту опцию, если будет производиться только репликация без копирования данных.

        * `Drop` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).

            Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.

    * **Исправить некорректные ключи в документах** — выберите эту опцию, чтобы для полей на приемнике выполнялась автозамена ключей, невалидных для Elasticsearch.

        Правила автозамены:
        
        * Пустые или состоящие из пробелов и точек ключи будут заменены на подчеркивание: `""`, `" "`, `"."` → `"_"`.
        * Точки в начале и конце ключа будут удалены: `"somekey."`, `".somekey"` → `"somekey"`.
        * Если две точки стоят друг за другом, либо между ними есть только пробелы, весь фрагмент будет заменен на точку: `" some . . key"` → `" some . key"`.
        
        Пример: `". s o m e  ..incorrect....key.    . . "` → `" s o m e  .incorrect.key"`.

{% endlist %}


После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).