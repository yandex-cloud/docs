# История изменений в {{ ml-platform-full-name }}

Здесь будет опубликована информация об изменениях в сервисе {{ ml-platform-full-name }}.

{% if product == "yandex-cloud" %}

{% note tip %}

Чтобы всегда быть в курсе последних изменений и обновлений, подпишитесь на наш Telegram-канал новостей [{{ ml-platform-full-name }} Community](https://t.me/yandex_datasphere).

{% endnote %}

## Релиз 20.10.2022 {#201022}

Значительно улучшили работу с кластерами Apache Spark™:
1. В {{ ml-platform-name }} появился новый тип ресурсов — [шаблоны {{ dataproc-name }}](concepts/data-proc-template.md).
1. Появилась возможность [конфигурировать livy-сессию](concepts/data-proc.md#sessions) при работе с кластерами {{ dataproc-name }}.
1. Теперь {{ ml-platform-name }} поддерживает [работу с библиотекой Spark SQL](concepts/data-proc.md#sql).

## Релиз 23.09.2022 {#230922}

Встречайте большое обновление {{ ml-platform-name }}: новый интерфейс, сообщества, ресурсы и множество других возможностей для ML-разработки.

{% include [old-releases](../_includes/datasphere/migration/release-notes-old.md) %}

{% endif %}
