Роль `managed-airflow.editor` позволяет управлять кластерами Apache Airflow™.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах Apache Airflow™](../../managed-airflow/concepts/index.md#cluster), а также создавать, изменять, запускать, останавливать и удалять их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к кластерам Apache Airflow™;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-airflow/concepts/maintenance.md) кластеров Apache Airflow™ и изменять такие задания;
* [использовать веб-интерфейс](../../managed-airflow/operations/af-interfaces.md#web-gui) Apache Airflow™;
* [отправлять запросы](../../managed-airflow/operations/af-interfaces.md#rest-api) к API Apache Airflow™;
* просматривать информацию о [квотах](../../managed-airflow/concepts/limits.md#quotas) сервиса Managed Service for Apache Airflow™.

Включает разрешения, предоставляемые ролями `managed-airflow.user` и `managed-airflow.maintenanceTask.editor`.

Для создания кластеров Apache Airflow™ дополнительно необходима роль `vpc.user`.
