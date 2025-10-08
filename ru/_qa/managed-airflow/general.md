### Как исправить ошибку про пересечение диапазонов IP-адресов при создании кластера? {#ip-addresses}

Во время создания кластера {{ maf-name }} вы можете получить ошибку:

```text
user subnet overlaps with service network range {{ airflow-service-address }}, see documentation for details
```

Ошибка означает, что при создании кластера вы выбрали подсеть, диапазон IP-адресов которой пересекается с диапазоном адресов `{{ airflow-service-address }}` служебной подсети. В ней {{ yandex-cloud }} управляет компонентами кластера {{ maf-name }}.

Чтобы исправить ошибку, выберите другую подсеть, диапазон IP-адресов которой не пересекается с диапазоном служебной подсети. Подробнее о требованиях к подсетям кластера см. в разделе [Сеть](../../managed-airflow/concepts/network.md#subnet-requirements).

### Как исправить ошибку отсутствия прав при подключении сервисного аккаунта к кластеру? {#attach-service-account}

{% include notitle [attach-sa-create-update](../attach-sa-create-update.md) %}

### Как исправить ошибку `No module named 'airflow.providers.postgres.operators'`? {#airflow-provider-postgres-operators}

При работе с кластером {{ mpg-full-name }} из кластера {{ AF }} вы можете получить ошибку:

```bash
Broken DAG: [/opt/airflow/dags/postgre.py] Traceback (most recent call last):
  File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
  File "/opt/airflow/dags/postgre.py", line 2, in <module>
    from airflow.providers.postgres.operators.postgres import PostgresOperator
ModuleNotFoundError: No module named 'airflow.providers.postgres.operators'
```

По умолчанию используется провайдер `apache-airflow-providers-postgres` версии 5.13.1. Ошибка может возникать при использовании `PostgresOperator` с более новыми версиями провайдера.

**Решение**:

Если вы работаете с более новой версией провайдера, вместо PostgresOperator используйте SQLExecuteQueryOperator. Подробнее см. в [официальной документации](https://airflow.apache.org/docs/apache-airflow-providers-postgres/6.0.0/operators/postgres_operator_howto_guide.html).

### Как исправить ошибку `AirflowException: Unknown hook type "postgres"`? {#airflow-provider-postgres-operators-2}

При работе с кластером {{ mpg-full-name }} из кластера {{ AF }} вы можете получить ошибку:

```bash
Task failed with exception: source="task"
AirflowException: Unknown hook type "postgres"
```

По умолчанию в кластерах {{ maf-full-name }} с версией {{ AF }} выше 3.0 не установлен провайдер `apache-airflow-providers-postgres`.

**Решение**:

При создании или изменении кластера {{ maf-name }} в блоке **{{ ui-key.yacloud.mdb.forms.section_dependencies }}** добавьте pip-пакет `apache-airflow-providers-postgres`.

### Как исправить ошибку `No module named 'airflow_clickhouse_plugin'`? {#airflow-clickhouse-plugin}

При работе с кластером {{ mch-full-name }} из кластера {{ AF }} вы можете получить ошибку:

```bash
Traceback (most recent call last):
  File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
  File "/opt/airflow/dags/dags/clickhouse.py", line 2, in <module>
    from airflow_clickhouse_plugin.hooks.clickhouse import ClickHouseHook
ModuleNotFoundError: No module named 'airflow_clickhouse_plugin'
```

По умолчанию в {{ maf-full-name }} не установлен плагин `airflow-clickhouse-plugin`.

**Решение**:

При создании или изменении кластера {{ maf-name }} в блоке **{{ ui-key.yacloud.mdb.forms.section_dependencies }}** добавьте pip-пакет `airflow-clickhouse-plugin`.