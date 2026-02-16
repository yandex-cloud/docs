The `managed-airflow.admin` role allows you to manage the Apache Airflow™ clusters and get information about quotas and service resource operations.

Users with this role can:
* Manage access to the [Apache Airflow™ clusters](../../managed-airflow/concepts/index.md#cluster).
* Use the Apache Airflow™ [web interface](../../managed-airflow/operations/af-interfaces.md#web-gui).
* [Send requests](../../managed-airflow/operations/af-interfaces.md#rest-api) to the Apache Airflow™ API.

This role includes the `managed-airflow.editor` permissions.

To create Apache Airflow™ clusters, you also need the `vpc.user` role.
