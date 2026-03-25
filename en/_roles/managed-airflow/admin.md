The `managed-airflow.admin` role enables managing Apache Airflow™ clusters and access to them.

Users with this role can:
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for [Apache Airflow™ clusters](../../managed-airflow/concepts/index.md#cluster) and modify such permissions.
* View info on Apache Airflow™ clusters, as well as create, modify, run, stop, and delete them.
* View info on [maintenance](../../managed-airflow/concepts/maintenance.md) tasks for Apache Airflow™ clusters and modify such tasks.
* Use the Apache Airflow™ [web interface](../../managed-airflow/operations/af-interfaces.md#web-gui).
* [Send requests](../../managed-airflow/operations/af-interfaces.md#rest-api) to the Apache Airflow™ API.
* View info on [quotas](../../managed-airflow/concepts/limits.md#quotas) for Managed Service for Apache Airflow™.

This role includes the `managed-airflow.editor` permissions.

To create Apache Airflow™ clusters, you also need the `vpc.user` role.
