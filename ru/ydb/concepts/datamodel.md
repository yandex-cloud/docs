{% include [Introduction](_includes/datamodel/intro.md) %}

{% include [Table](_includes/datamodel/table.md) %}

{% if audience == "internal" or audience == "tech" %}
Возможности настройки таблиц подробно описаны в разделе [{#T}](../getting_started/start_scheme.md).
{% endif %}

{% include [Folder](_includes/datamodel/folder.md) %}

{% if audience == "internal" or audience == "tech" %}

{% include [Persistent Queue](_includes/datamodel/pq.md) %}

{% if audience == "internal" %}

{% note info "Использование в YDB персистентных очередей" %}

В текущей версии в БД сервиса YDB доступны для использования только таблицы и директории. Персистентная очередь доступна в сервисе Logbroker.

{% endnote %}  

{% endif %}

{% include [Block Device](_includes/datamodel/blockdevice.md) %}

{% if audience == "internal" %}

{% note info "Использование в YDB томов сетевого блочного устройства" %}

В текущей версии в БД сервиса YDB доступны для использования только таблицы и директории. Тома сетевого блочного устройства доступны в сервисе Network Block Store, представляющем собой аналог [Amazon EBS](https://en.wikipedia.org/wiki/Amazon_Elastic_Block_Store).

{% endnote %}

{% endif %}
{% endif %}
