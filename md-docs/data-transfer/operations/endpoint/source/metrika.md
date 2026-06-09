# Передача данных из эндпоинта-источника {{ metrika }}


С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из счетчика [{{ metrika }}]({{ metrika-link }}) в управляемую базу данных {{ yandex-cloud }}.

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../troubleshooting/index.md) по их устранению.

## Сценарии передачи данных из {{ metrika }} {#scenarios}

С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из счетчика [{{ metrika }}]({{ metrika-link }}) в кластер {{ CH }}. Такой перенос обеспечивает полноту переносимых данных из {{ metrika }} и предоставляет возможности для:

* обработки данных средствами {{ CH }};
* стриминга из {{ CH }} в другие локации;
* визуализации с помощью [{{ datalens-full-name }}]({{ link-datalens-main-promo }}) или других сервисов.

См. [практическое руководство](../../../tutorials/metrika-to-clickhouse.md) по переносу данных из счетчика {{ metrika }} в кластер {{ CH }}.

Подробное описание остальных возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка эндпоинта-источника {{ metrika-endpoint }} {#endpoint-settings}

{% note info %}

Передача данных из источника {{ metrika }} возможна при подключении пакета [{{ metrika-pro }}]({{ link-yandex }}/support/metrica/pro/intro.html) или использовании [Data Streaming из Яндекс Метрики](https://yandex.cloud/ru/marketplace/products/varioqub/metrica-data-streaming).

{% endnote %}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к сервису [{{ metrika }}]({{ metrika-link }}).

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.counter_ids.title }}** — укажите [номера счетчиков](https://yandex.ru/support/metrica/general/tag-id.html), из которых будут поступать данные.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.token.title }}** — укажите токен для подтверждения доступа к счетчикам. Его можно получить по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=36b7fc9aa96c4fa09158bcacbbdc796a).
    * (Опционально) укажите временной интервал, для которого надо произвести выгрузку данных. Эта возможность поддержана для трансферов типа {{ dt-type-copy }}. Конечная дата должна быть позже начальной даты на семь дней.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.hits.title }}** — выберите, передавать ли информацию о хитах.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.hits.columns.title }}** — выберите поля хита, которые нужно экспортировать. Помимо выбранных полей, всегда экспортируется несколько обязательных полей.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.visits.title }}** — выберите, передавать ли информацию о визитах.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.visits.columns.title }}** — выберите поля визита, которые нужно экспортировать. Помимо выбранных полей, всегда экспортируется несколько обязательных полей.

- {{ TF }} {#tf}

    * Тип эндпоинта — `metrika_source`.

    * `counter_ids` — [номера счетчиков](https://yandex.ru/support/metrica/general/tag-id.html), из которых будут поступать данные.

    * `token.raw` — токен для подтверждения доступа к счетчикам. Его можно получить по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=36b7fc9aa96c4fa09158bcacbbdc796a).

    * `streams` — параметры передаваемых данных:
      
      * `type` — тип данных. Укажите одно из значений:
      
          * `METRIKA_STREAM_TYPE_HITS` — хиты (необновляемые, устарело);
          * `METRIKA_STREAM_TYPE_HITS_V2` — хиты;
          * `METRIKA_STREAM_TYPE_VISITS` — визиты.
      
      * `columns` — список полей, которые нужно экспортировать. Их можно посмотреть в консоли управления. Помимо указанных полей всегда экспортируется несколько обязательных полей.

    Пример структуры конфигурационного файла:

    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        metrika_source {
          counter_ids = [<номера_счетчиков>]
          token {
            raw = "<токен>"
          }
          streams {
            type    = "<тип_данных>"
            columns = ["<список_полей>"]
          }
        }
      }
    }
    ```

- API {#api}

    * `counterIds` — [номера счетчиков](https://yandex.ru/support/metrica/general/tag-id.html), из которых будут поступать данные.

    * `token.raw` — токен для подтверждения доступа к счетчикам. Его можно получить по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=36b7fc9aa96c4fa09158bcacbbdc796a).

    * `streams` — параметры передаваемых данных:
      
      * `type` — тип данных. Укажите одно из значений:
      
          * `METRIKA_STREAM_TYPE_HITS` — хиты (необновляемые, устарело);
          * `METRIKA_STREAM_TYPE_HITS_V2` — хиты;
          * `METRIKA_STREAM_TYPE_VISITS` — визиты.
      
      * `columns` — список полей, которые нужно экспортировать. Их можно посмотреть в консоли управления. Помимо указанных полей всегда экспортируется несколько обязательных полей.

{% endlist %}

Подробнее о настройках в [документации сервиса]({{ link-yandex }}/support/metrica/index.html).

## Настройка приемника данных {#supported-targets}

Настройте поддерживаемый приемник данных:

* [{{ CH }}](../target/clickhouse.md).

Полный список поддерживаемых источников и приемников в сервисе {{ data-transfer-full-name }} читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._