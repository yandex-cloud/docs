{% include [Introduction](../oss/public/_includes/concepts/datamodel/intro.md) %}

{% include [Table](../oss/public/_includes/concepts/datamodel/table.md) %}

{% if audience == "internal" or audience == "tech" %}
Возможности настройки таблиц подробно описаны в разделе [{#T}](../getting_started/start_scheme.md).
{% endif %}

{% include [Folder](../oss/public/_includes/concepts/datamodel/folder.md) %}

{% if audience == "internal" or audience == "tech" %}

{% include [Persistent Queue](../oss/public/_includes/concepts/datamodel/pq.md) %}

{% if audience == "internal" %}

{% note info "Использование в YDB персистентных очередей" %}

В текущей версии в БД сервиса YDB доступны для использования только таблицы и директории. Персистентная очередь доступна в сервисе Logbroker.

{% endnote %}  

{% endif %}

{% include [Block Device](../oss/public/_includes/concepts/datamodel/blockdevice.md) %}

{% if audience == "internal" %}

{% note info "Использование в YDB томов сетевого блочного устройства" %}

В текущей версии в БД сервиса YDB доступны для использования только таблицы и директории. Тома сетевого блочного устройства доступны в сервисе Network Block Store, представляющем собой аналог [Amazon EBS](https://en.wikipedia.org/wiki/Amazon_Elastic_Block_Store).

{% endnote %}

{% endif %}
{% endif %}
