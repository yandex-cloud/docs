Роль `managed-airflow.editor` позволяет управлять кластерами Apache Airflow™, а также получать информацию о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах Apache Airflow™](../../managed-airflow/concepts/index.md#cluster), а также создавать, изменять и удалять их;
* использовать веб-интерфейс для доступа к [компонентам Apache Airflow™](../../managed-airflow/concepts/index.md#components).

Включает разрешения, предоставляемые ролью `managed-airflow.viewer`.

Для создания кластеров Apache Airflow™ дополнительно необходима роль `vpc.user`.