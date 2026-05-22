The `managed-airflow.user` role enables performing basic operations on {{ AF }} clusters.

Users with this role can:
* View info on [{{ AF }} clusters](../../managed-airflow/concepts/index.md#cluster) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* Use the {{ AF }} [web interface](../../managed-airflow/operations/af-interfaces.md#web-gui).
* [Send requests](../../managed-airflow/operations/af-interfaces.md#rest-api) to the {{ AF }} API.
* View info on [maintenance](../../managed-airflow/concepts/maintenance.md) tasks for {{ AF }} clusters.
* View info on [quotas](../../managed-airflow/concepts/limits.md#quotas) for {{ maf-name }}.

This role includes the `managed-airflow.viewer` permissions.
