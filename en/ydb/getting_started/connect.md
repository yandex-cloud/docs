# Connecting to databases

{% if audience == "internal" %}

{{ ydb-short-name }} databases are accessed over gRPC protocol. You can find the database endpoint to connect to under [web interface](https://ydb.yandex-team.ru/) in the **Info** tab.

![Database API Endpoint](../_assets/db_ui_info_cluster_api.png)

To gain access, use [Puncher](https://puncher.yandex-team.ru) to create permission requests for accessing {{ ydb-short-name }} cluster servers and their network load balancers over TCP.

## Accessing ydb-ru clusters {#access-to-ydb-ru}

Use separate requests to specify:

* Load balancer address: ydb-ru.yandex.net, TCP, port 2135.

![Puncher_request_form_4slb_sample](../_assets/puncher_request_4slb_form_ydb_ru.png)

* Macro: ```_C_YDB_RU_``` for databases in the `ydb-ru` cluster, TCP, port range 31000-32000.

![Puncher_request_form_sample](../_assets/puncher_request_form_ydb_ru.png)

## Accessing ydb-ru-prestable clusters {#access-to-ydb-ru-prestable}

Use separate requests to specify:

* Load balancer address: ydb-ru-prestable.yandex.net, TCP, port 2135.

![Puncher_request_form_4slb_sample](../_assets/puncher_request_4slb_form_ydb_ru_prestable.png)

* Macro: ```_C_YDB_RU_PRESTABLE``` for databases in the ydb-ru cluster, TCP, port range 31000-32000.

![Puncher_request_form_sample](../_assets/puncher_request_form_ydb_ru_prestable.png)

{% else if audience == "external" %}

{{ ydb-short-name }} databases are accessed over gRPC protocol. To find the endpoint to connect to a database:

1. Go to the **Databases** page in the management console.

1. Click the name of the database you want the endpoint of. The **Navigation** page opens.

1. Go to the **Overview** page. The database endpoint is shown in the **Endpoints** field.

{% endif %}

