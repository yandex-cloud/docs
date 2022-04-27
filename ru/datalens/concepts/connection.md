# Подключение

_Подключение_ содержит информацию о параметрах доступа к источнику данных. Например, IP-адрес хоста БД, порт.

На базе подключения вы можете создавать [_датасеты_](dataset/index.md).

В {{ datalens-short-name }} доступны следующие типы подключений:

- **ClickHouse**
- **PostgreSQL**
- **MySQL**
- **CSV-файл**
- **Google Sheets**
- **MS SQL Server**
- **Oracle Database**
- **YDB**
- **Greenplum**
{% if audience == "internal" %} - **Prometheus** {% endif %}
- **Metrica** (в режиме прямого доступа)
- **AppMetrica** (в режиме прямого доступа)
- **Yandex Cloud Billing**

{% if audience == "internal" %}

{% note warning %}

* Доступ из {{ datalens-short-name }} к источникам во внешней сети по умолчанию закрыт. Чтобы получить доступ, закажите его через [Puncher](https://puncher.yandex-team.ru/?create_protocol=tcp&create_sources=_DL_INT_BACK_PROD_NETS_&create_until=persistent) от `_DL_INT_BACK_PROD_NETS_ ` к источнику и пройдите согласование в СИБ.
* Сетевой доступ от {{ datalens-short-name }} к вашему источнику может быть закрыт и во внутренней сети Яндекса. В этом случае также необходимо заказать доступ через [Puncher](https://puncher.yandex-team.ru/?create_protocol=tcp&create_sources=_DL_INT_BACK_PROD_NETS_&create_until=persistent) от `_DL_INT_BACK_PROD_NETS_ ` к источнику.

{% endnote %}

{% else %}

Вы можете добавить дополнительные типы подключений из списка доступных в [{{ datalens-short-name }} Marketplace](marketplace.md).
 
{% endif %}

{% include [connection-note](../../_includes/datalens/datalens-connection-note.md) %}

## Управление доступом {#access-management}

Вы можете настроить права доступа к подключению. Подробнее в разделе [{#T}](../security/index.md).

#### См. также {#see-also}

- [{#T}](../operations/connection/create-clickhouse.md)
- [{#T}](../operations/connection/create-csv.md)
- [{#T}](../operations/connection/create-google-sheets.md)
- [{#T}](../operations/connection/create-mysql.md)
- [{#T}](../operations/connection/create-postgresql.md)
- [{#T}](../operations/connection/create-mssql-server.md)
- [{#T}](../operations/connection/create-oracle.md)
- [{#T}](../operations/connection/create-ydb.md)
- [{#T}](../operations/connection/create-greenplum.md)
{% if audience == "internal" %} - [{#T}](../operations/connection/create-prometheus.md) {% endif %}
- [{#T}](../operations/connection/create-metrica-api.md)
- [{#T}](../operations/connection/create-appmetrica.md)
{% if audience != "internal" %} - [{#T}](../operations/connection/create-cloud-billing.md) {% endif %}
