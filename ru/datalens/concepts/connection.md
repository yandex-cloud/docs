# Подключение к {{ datalens-name }}

_Подключение_ содержит информацию о параметрах доступа к источнику данных. Например, IP-адрес хоста БД, порт.

На базе подключения вы можете создавать [_датасеты_](dataset/index.md).

В {{ datalens-short-name }} доступны следующие типы подключений:

* [{{ CH }}](../operations/connection/create-clickhouse.md)
{% if product == "yandex-cloud" %}{% if audience == "internal" %}* [CH over YT](../operations/connection/chyt/create-chyt.md){% endif %}{% endif %}
* [File (CSV)](../operations/connection/create-file.md)
{% if product == "yandex-cloud" %}* [Google Sheets](../operations/connection/create-google-sheets.md){% endif %}
* [{{ PG }}](../operations/connection/create-postgresql.md)
* [{{ MY }}](../operations/connection/create-mysql.md)
* [MS SQL Server](../operations/connection/create-mssql-server.md)
{% if audience != "internal" %}* [BigQuery](../operations/connection/create-big-query.md){% endif %}
{% if product == "yandex-cloud" %}* [Oracle Database](../operations/connection/create-oracle.md){% endif %}
{% if product == "yandex-cloud" %}* [{{ ydb-short-name }}](../operations/connection/create-ydb.md){% endif %}
{% if product == "yandex-cloud" %}* [{{ GP }}](../operations/connection/create-greenplum.md){% endif %}
{% if product == "yandex-cloud" %}* [{{ prometheus-name }}](../operations/connection/create-prometheus.md){% endif %}
{% if product == "yandex-cloud" %}* [Metrica](../operations/connection/create-metrica-api.md){% endif %}
{% if product == "yandex-cloud" %}* [AppMetrica](../operations/connection/create-appmetrica.md){% endif %}
{% if product == "yandex-cloud" %}{% if audience != "internal" %}* [Yandex Cloud Billing](../operations/connection/create-cloud-billing.md){% endif %}{% endif %}
{% if product == "yandex-cloud" %}{% if audience != "internal" %} * [Подкасты Аналитика](../operations/connection/create-podcasts.md){% endif %}{% endif %}
{% if product == "yandex-cloud" %}{% if audience != "internal" %} * [Yandex Monitoring](../operations/connection/create-monitoring.md){% endif %}{% endif %}
{% if product == "yandex-cloud" %}{% if audience != "internal" %} * [Битрикс24](../operations/connection/create-bitrix24.md){% endif %}{% endif %}

{% if product == "yandex-cloud" %}

{% if audience == "internal" %}

{% note warning %}

* Доступ из {{ datalens-short-name }} к источникам во внешней сети по умолчанию закрыт. Чтобы получить доступ, закажите его через [Puncher](https://puncher.yandex-team.ru/?create_protocol=tcp&create_sources=_DL_INT_BACK_PROD_NETS_&create_until=persistent) от `_DL_INT_BACK_PROD_NETS_ ` к источнику и пройдите согласование в СИБ.
* Сетевой доступ от {{ datalens-short-name }} к вашему источнику может быть закрыт и во внутренней сети Яндекса. В этом случае также необходимо заказать доступ через [Puncher](https://puncher.yandex-team.ru/?create_protocol=tcp&create_sources=_DL_INT_BACK_PROD_NETS_&create_until=persistent) от `_DL_INT_BACK_PROD_NETS_ ` к источнику.

{% endnote %}

{% else %}

Вы можете добавить дополнительные типы подключений из списка доступных в [{{ datalens-short-name }} Marketplace](marketplace.md).
 
{% endif %}

{% include [connection-note](../../_includes/datalens/datalens-connection-note.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

## Управление доступом {#access-management}

Вы можете настроить права доступа к подключению. Подробнее в разделе [{#T}](../security/index.md).

{% endif %}