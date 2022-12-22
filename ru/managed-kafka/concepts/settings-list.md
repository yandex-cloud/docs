# Настройки Apache Kafka®

Для кластера {{ mkf-name }} можно задать настройки, которые относятся к {{ KF }}. Часть настроек задается [на уровне кластера](#cluster-settings), часть — [на уровне топиков](#topic-settings).

Метки рядом с названием настройки позволяют определить, с помощью какого интерфейса задается значение этой настройки: консоль управления, CLI, {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %} или {{ TF }}. Метка {{ tag-all }} указывает, что поддерживаются все перечисленные интерфейсы.

В зависимости от выбранного интерфейса, одна и та же настройка будет представлена по-разному, например, **Compression type** в консоли управления соответствует:

* `--compression-type` в CLI;
* `compression_type` в gRPC API и {{ TF }};
* `compressionType` в REST API.

## Настройки уровня кластера {#cluster-settings}

Доступны следующие настройки:

{% include [kafka-settings](../../_includes/mdb/mkf/kafka-settings.md) %}

## Настройки отдельных топиков {#topic-settings}

Доступны следующие настройки:

{% include [topic-settings](../../_includes/mdb/mkf/topic-settings.md) %}
