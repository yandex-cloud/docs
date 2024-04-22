---
title: "Настройки {{ ES }}"
description: "Для кластера {{ mes-name }} можно задать настройки, которые относятся к {{ ES }}."
---

# Настройки {{ ES }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

Для кластера {{ mes-name }} можно задать настройки, которые относятся к {{ ES }}.

Метки рядом с названием настройки позволяют определить, с помощью какого интерфейса задается значение этой настройки: консоль управления, CLI, [API](../../glossary/rest-api.md) или {{ TF }}. Метка {{ tag-all }} указывает, что поддерживаются все перечисленные интерфейсы.

В зависимости от выбранного интерфейса, одна и та же настройка будет представлена по-разному, например:

* **Fielddata cache size** в консоли управления соответствует:

    * `fielddata_cache_size` в gRPC API, CLI, {{ TF }};
    * `fielddataCacheSize` в REST API.

## Настройки на уровне кластера

Доступны следующие настройки:

* **Fielddata cache size**{#setting-fielddata-cache-size} {{ tag-all }}

    Максимальный объем кеша, выделенного под данные полей. Задается в виде строки, указывающей относительное (`20%`) или абсолютное (`12GB`) значение. Максимальное значение — `40%` от объема памяти кучи JVM. По умолчанию значение не задано — объем кеша, выделенного под данные полей, неограничен.

    Подробнее см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-fielddata.html).

* **Reindex remote whitelist**{#setting-reindex-remote-whitelist} {{ tag-api }}

    Разделенный запятыми список IP-адресов или [FQDN](../../glossary/fqdn.md) хостов, а также их портов, разрешенных к использованию в качестве удаленного источника для [Reindex API]({{ links.es.reindex-api }}).

    Допускается использование подстановочного символа `*` для указания диапазонов IP-адресов или портов, например:

    ```text
    hostname:9200, 192.168.0.*:9200, localhost:*
    ```

    Подробнее см. в [документации {{ ES }}]({{ links.es.reindex-api }}#reindex-from-remote).

* **Reindex SSL CA path**{#setting-reindex-ssl-ca-path} {{ tag-api }}

    Локальный путь к файлу сертификата, который кластер будет использовать для защиты подключения к удаленному источнику при использовании [Reindex API]({{ links.es.reindex-api }}).

    [Добавьте файл сертификата в качестве расширения](../operations/cluster-extensions.md#add) кластера и укажите путь в формате:

    ```text
    /etc/elasticsearch/extensions/<имя_расширения>/<имя_сертификата>
    ```

    Подробнее см. в [документации {{ ES }}]({{ links.es.reindex-api }}#reindex-ssl).
