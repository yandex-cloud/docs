
Роль `managed-airflow.editor` позволяет управлять кластерами {{ AF }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ AF }}](../../managed-airflow/concepts/index.md#cluster), а также создавать, изменять, запускать, останавливать и удалять их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к кластерам {{ AF }};
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-airflow/concepts/maintenance.md) кластеров {{ AF }} и изменять такие задания;
* [использовать веб-интерфейс](../../managed-airflow/operations/af-interfaces.md#web-gui) {{ AF }};
* [отправлять запросы](../../managed-airflow/operations/af-interfaces.md#rest-api) к API {{ AF }};
* просматривать информацию о [квотах](../../managed-airflow/concepts/limits.md#quotas) сервиса {{ maf-name }}.

Включает разрешения, предоставляемые ролями `managed-airflow.user` и `managed-airflow.maintenanceTask.editor`.

Для создания кластеров {{ AF }} дополнительно необходима роль `vpc.user`.
