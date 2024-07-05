The `managed-airflow.editor` role allows you to manage the Apache Airflow™ clusters, as well as get information about quotas and service resource operations.

Users with this role can:
* View information about the [Apache Airflow™ clusters](../../managed-airflow/concepts/index.md#cluster), as well as create, modify, and delete them.
* Use the Apache Airflow™ [web interface](../../managed-airflow/operations/af-interfaces.md#web-gui).
* [Send requests](../../managed-airflow/operations/af-interfaces.md#rest-api) to the Apache Airflow™ API.

This role also includes the `managed-airflow.user` permissions.

To create Apache Airflow™ clusters, you also need the `vpc.user` role.
