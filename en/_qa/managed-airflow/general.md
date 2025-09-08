#### How do I fix the IP address range overlap error when creating a cluster? {#ip-addresses}

When creating a {{ maf-name }} cluster you may get the following error:

```text
user subnet overlaps with service network range {{ airflow-service-address }}, see documentation for details
```

This error means that when creating the cluster, you selected a subnet whose IP address range overlaps with the `{{ airflow-service-address }}` address range of the service subnet. In this subnet, {{ yandex-cloud }} manages the {{ maf-name }} cluster components.

To fix this error, select another subnet whose IP address range does not overlap with the service subnet range. Learn more about cluster subnet requirements in [Network](../../managed-airflow/concepts/network.md#subnet-requirements).

#### How can I fix the no permission error when attaching a service account to a cluster? {#attach-service-account}

{% include notitle [attach-sa-create-update](../attach-sa-create-update.md) %}

#### How do I fix the `No module named 'airflow.providers.postgres.operators'` error? {#airflow-provider-postgres-operators}

When accessing a {{ mpg-full-name }} cluster from an {{ AF }} cluster, you may get this error:

```bash
Broken DAG: [/opt/airflow/dags/postgre.py] Traceback (most recent call last):
  File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
  File "/opt/airflow/dags/postgre.py", line 2, in <module>
    from airflow.providers.postgres.operators.postgres import PostgresOperator
ModuleNotFoundError: No module named 'airflow.providers.postgres.operators'
```

`apache-airflow-providers-postgres` 5.13.1 is used by default. The error may occur if using `PostgresOperator` with newer provider versions.

**Solution:**

If using a newer provider version, use SQLExecuteQueryOperator instead of PostgresOperator. For more information, see [the official documentation](https://airflow.apache.org/docs/apache-airflow-providers-postgres/6.0.0/operators/postgres_operator_howto_guide.html).
