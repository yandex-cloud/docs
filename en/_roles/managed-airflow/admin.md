
The `managed-airflow.admin` role enables managing {{ AF }} clusters and access to them.

Users with this role can:
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for [{{ AF }} clusters](../../managed-airflow/concepts/index.md#cluster) and modify such permissions.
* View info on {{ AF }} clusters, as well as create, modify, run, stop, and delete them.
* View info on [maintenance](../../managed-airflow/concepts/maintenance.md) tasks for {{ AF }} clusters and modify such tasks.
* Use the {{ AF }} [web interface](../../managed-airflow/operations/af-interfaces.md#web-gui).
* [Send requests](../../managed-airflow/operations/af-interfaces.md#rest-api) to the {{ AF }} API.
* View info on [quotas](../../managed-airflow/concepts/limits.md#quotas) for {{ maf-name }}.

This role includes the `managed-airflow.editor` permissions.

To create {{ AF }} clusters, you also need the `vpc.user` role.
