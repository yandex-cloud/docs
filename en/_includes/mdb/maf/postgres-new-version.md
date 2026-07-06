{% note tip %}

Clusters running {{ AF }} older than 3.0 use `apache-airflow-providers-postgres` 5.13.1 as a default provider. If using a newer provider version, use SQLExecuteQueryOperator instead of PostgresOperator. For more information, see [this official guide](https://airflow.apache.org/docs/apache-airflow-providers-postgres/6.0.0/operators/postgres_operator_howto_guide.html).

{% endnote %}