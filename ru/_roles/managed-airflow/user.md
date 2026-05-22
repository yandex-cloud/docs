Роль `managed-airflow.user` позволяет выполнять базовые операции с кластерами {{ AF }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ AF }}](../../managed-airflow/concepts/index.md#cluster) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* [использовать веб-интерфейс](../../managed-airflow/operations/af-interfaces.md#web-gui) {{ AF }};
* [отправлять запросы](../../managed-airflow/operations/af-interfaces.md#rest-api) к API {{ AF }};
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-airflow/concepts/maintenance.md) кластеров {{ AF }};
* просматривать информацию о [квотах](../../managed-airflow/concepts/limits.md#quotas) сервиса {{ maf-name }}.

Включает разрешения, предоставляемые ролью `managed-airflow.viewer`.
