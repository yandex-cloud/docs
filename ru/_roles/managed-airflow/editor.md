Роль `managed-airflow.editor` позволяет управлять кластерами Apache Airflow™, а также получать информацию о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах Apache Airflow™](../../managed-airflow/concepts/index.md#cluster), а также создавать, изменять и удалять их;
* [использовать веб-интерфейс](../../managed-airflow/operations/af-interfaces.md#web-gui) Apache Airflow™;
* [отправлять запросы](../../managed-airflow/operations/af-interfaces.md#rest-api) к API Apache Airflow™.

Включает разрешения, предоставляемые ролью `managed-airflow.user`.

Для создания кластеров Apache Airflow™ дополнительно необходима роль `vpc.user`.
