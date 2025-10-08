{% note tip %}

В кластерах с версией {{ AF }} ниже 3.0 по умолчанию используется провайдер `apache-airflow-providers-postgres` версии 5.13.1. Если вы работаете с более новой версией провайдера, вместо PostgresOperator используйте SQLExecuteQueryOperator. Подробнее см. в [официальной документации](https://airflow.apache.org/docs/apache-airflow-providers-postgres/6.0.0/operators/postgres_operator_howto_guide.html).

{% endnote %}