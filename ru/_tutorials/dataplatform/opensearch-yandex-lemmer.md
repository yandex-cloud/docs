# Использование плагина yandex-lemmer в {{ mos-full-name }}


С помощью плагина `yandex-lemmer` вы можете добавить фильтр, который [помогает улучшить поиск текста](../../managed-opensearch/concepts/plugins.md#yandex-lemmer) на русском языке по документам {{ OS }}.

Чтобы оценить работу плагина, сравните [результаты обычного поиска](#search-without-yandex-lemmer) и [поиска с фильтром `yandex-lemmer`](#search-with-yandex-lemmer), а затем [усовершенствуйте фильтр](#improve-search).

После тестирования [удалите](#clear-out) созданные ресурсы, если они вам больше не нужны.


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ mos-name }}: использование вычислительных ресурсов, выделенных хостам (в том числе хостам с ролью `MANAGER`), и дискового пространства (см. [тарифы {{ OS }}](../../managed-opensearch/pricing.md)).
* Плата за публичные IP-адреса для хостов кластера (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    * Вручную {#manual}

        1. [Создайте кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-create.md#create-cluster) нужной вам конфигурации со следующими настройками:

            * Подключены плагины `yandex-lemmer` и `analysis-icu`.
            * Включен публичный доступ к группе хостов с ролью `DATA`.

        1. Если вы используете группы безопасности в кластере, убедитесь, что они [настроены правильно](../../managed-opensearch/operations/connect.md#configuring-security-groups) и допускают подключение к кластеру.

    * С помощью {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Скачайте в ту же рабочую директорию файл конфигурации [opensearch-yandex-lemmer.tf](https://github.com/yandex-cloud-examples/yc-opensearch-yandex-lemmer/blob/main/opensearch-yandex-lemmer.tf). В файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру {{ mos-name }};
            * кластер {{ mos-name }}.

        1. Укажите в файле `opensearch-yandex-lemmer.tf` переменные:

            * `version` — версия {{ OS }}.
            * `admin_password` — пароль администратора {{ OS }}.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. [Установите SSL-сертификат](../../managed-opensearch/operations/connect.md#ssl-certificate).

1. Проверьте подключение к кластеру с помощью утилиты [cURL](https://curl.haxx.se/):

    {% include [default-connstring](../../_includes/mdb/mos/default-connstring.md) %}

    FQDN хоста можно получить со [списком хостов в кластере](../../managed-opensearch/operations/host-groups.md#list-hosts).

    При успешном подключении будет выведено похожее сообщение:

    ```bash
    {
      "name" : "....{{ dns-zone }}",
      "cluster_name" : "...",
      "cluster_uuid" : "...",
      "version" : {
      "distribution" : "opensearch",
      ...
      },
      "tagline" : "The OpenSearch Project: https://opensearch.org/"
    }
    ```

## Выполните поиск без использования yandex-lemmer {#search-without-yandex-lemmer}

1. Добавьте документ в индекс `simple-index`:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request POST 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/simple-index/_doc?pretty' \
        --data '{
                  "book": "Ночь, когда шел дождь",
                  "author": "Юджиния Райли"
                }'
    ```

    Индекс `simple-index` будет создан автоматически при создании документа. По умолчанию в индексах используется [встроенный анализатор текста]({{ os.docs }}/analyzers/supported-analyzers/index/#built-in-analyzers) `Standard`.

1. Выполните поиск:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/simple-index/_search?pretty' \
        --data '{
                  "query": {
                    "query_string": {
                      "query": "book: когда идут дожди"
                    }
                  }
                }'
    ```

    Результат содержит строки:

    ```bash
    ...
    "hits" : {
      "total" : {
        "value" : 0,
        "relation" : "eq"
      },
      "max_score" : null,
      "hits" : [ ]
    }
    ...
    ```

    Книга не найдена из-за расхождений в исходном документе и в поисковом запросе: `шел дождь` и `идут дожди`.

## Выполните поиск с использованием yandex-lemmer {#search-with-yandex-lemmer}

1. Создайте индекс `lemmer-index`, в котором укажите параметры анализатора `lemmer` и подключите его для поля `book`:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request PUT "https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/lemmer-index?pretty" \
        --data '{
                  "mappings": {
                    "properties": {
                      "book": {
                        "type": "text",
                        "analyzer": "lemmer"
                      }
                    }
                  },
                  "settings": {
                    "analysis": {
                      "analyzer": {
                        "lemmer": {
                          "type": "custom",
                          "tokenizer": "standard",
                          "filter": [
                            "yandex_lemmer"
                          ]
                        }
                      }
                    }
                  }
                }'
    ```

1. Добавьте в индекс `lemmer-index` документ:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request POST 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/lemmer-index/_doc?pretty' \
        --data '{
                  "book": "Ночь, когда шел дождь",
                  "author": "Юджиния Райли"
                }'
    ```

1. Выполните поиск:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/lemmer-index/_search?pretty' \
        --data '{
                  "query": {
                    "query_string": {
                      "query": "book: когда идут дожди"
                    }
                  }
                }'
    ```

    Результат содержит строки:

    ```bash
    ...
    "hits" : {
      "total" : {
        "value" : 1,
        "relation" : "eq"
      },
      "max_score" : 0.9993168,
      "hits" : [
        {
          "_index" : "lemmer-index",
          "_id" : "zoGb_ZIB-3clfLPNjPbo",
          "_score" : 0.9993168,
          "_source" : {
            "book" : "Ночь, когда шел дождь",
            "author" : "Юджиния Райли"
          }
        }
      ]
    }
    ...
    ```

    Книга найдена.

1. Чтобы посмотреть, как работает анализатор `lemmer`, выполните команду:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/lemmer-index/_analyze?pretty' \
        --data '{"field":"book","text":"шел дождь"}'
    ```

    Результат:

    ```bash
    {
      "tokens" : [
        {
          "token" : "шел",
          "start_offset" : 0,
          "end_offset" : 3,
          "type" : "<ALPHANUM>",
          "position" : 0
        },
        {
          "token" : "идти",
          "start_offset" : 0,
          "end_offset" : 3,
          "type" : "<ALPHANUM>",
          "position" : 0
        },
        {
          "token" : "дождь",
          "start_offset" : 4,
          "end_offset" : 9,
          "type" : "<ALPHANUM>",
          "position" : 1
        }
      ]
    }
    ```

    Токен `шел` после прохождения через фильтр `yandex_lemmer` преобразуется в два токена:

    * `шел` — исходный токен;
    * `идти` — начальная форма слова `шел`.

    Токен `дождь` после прохождения через фильтр `yandex_lemmer` остается без изменений, т. к. исходный токен совпадает с начальной формой слова.

## Усовершенствуйте поиск {#improve-search}

Чтобы улучшить поиск текста, добавьте к `yandex-lemmer` дополнительные фильтры:

* `nfc` — выполняет [NFC-нормализацию](https://www.unicode.org/faq/normalization.html) (сопоставление текста), когда одна и та же буква представлена разными символами. Фильтр доступен при подключенном плагине `analysis-icu`.
* `lowercase` — преобразует текст в нижний регистр.
* `yo_ye` — заменяет букву «ё» на «е». Фильтр `yandex-lemmer` не различает эти буквы (найдутся и `ёлка`, и `елка`), но такая замена позволяет улучшить процент попаданий в кеш анализатора и немного сэкономить дисковое пространство.

Чтобы использовать дополнительные фильтры:

1. Создайте индекс `index-with-filters`, в котором добавьте для анализатора `lemmer-improved` фильтр `yandex-lemmer` и дополнительные фильтры:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request PUT "https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/index-with-filters?pretty" \
        --data '{
                  "mappings": {
                    "properties": {
                      "book": {
                        "type": "text",
                        "analyzer": "lemmer-improved"
                      }
                    }
                  },
                  "settings": {
                    "analysis": {
                      "filter": {
                        "nfc": {
                          "type": "icu_transform",
                          "id": "NFC"
                        },
                        "yo_ye": {
                          "type": "pattern_replace",
                          "pattern": "ё",
                          "replacement": "е"
                        }
                      },
                      "analyzer": {
                        "lemmer-improved": {
                          "type": "custom",
                          "tokenizer": "standard",
                          "filter": [
                            "nfc",
                            "lowercase",
                            "yo_ye",
                            "yandex_lemmer"
                          ]
                        }
                      }
                    }
                  }
                }'
    ```

1. Добавьте в индекс документ:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request POST "https://<адрес_хоста_{{ OS }}_с_ролью_DATA>.mdb.yandexcloud.net:9200/index-with-filters/_doc?pretty" \
        --data '{
                  "book": "Чёрный тюльпан",
                  "author": "Александр Дюма"
                }'
    ```

    Здесь в названии книги вместо буквы «й» используются буква «и» (код 1048) и [бревис](https://ru.wikipedia.org/wiki/Кратка) «˘» (код 774).

1. Выполните поиск:

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/index-with-filters2/_search?pretty' \
        --data '{
                  "query": {
                    "query_string": {
                      "query": "book: черный тюльпан"
                    }
                  }
                }'
    ```

    Здесь в названии книги указана буква «й» (код 1049).

    Результат содержит строки:

    ```bash
    ...
    "hits" : {
      "total" : {
        "value" : 1,
        "relation" : "eq"
      },
      "max_score" : 0.2876821,
      "hits" : [
        {
          "_index" : "index-with-filters2",
          "_id" : "34EO_pIB-3clfLPNvvbY",
          "_score" : 0.2876821,
          "_source" : {
            "book" : "Чёрный тюльпан",
            "author" : "Александр Дюма"
          }
        }
      ]
    }
    ...
    ```

    Книга найдена.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

* Вручную {#manual}

    [Удалите кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md).

* С помощью {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
