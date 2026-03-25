Роль `managed-spark.editor` позволяет управлять кластерами Apache Spark™ и заданиями.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах Apache Spark™](../../managed-spark/concepts/index.md), а также создавать, изменять, запускать, останавливать и удалять их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к кластерам Apache Spark™;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-spark/concepts/maintenance.md) кластеров Apache Spark™ и изменять такие задания;
* использовать веб-интерфейс Apache Spark™;
* просматривать информацию о [заданиях](../../managed-spark/operations/index.md#jobs), а также создавать, запускать и отменять их;
* просматривать информацию о [квотах](../../managed-spark/concepts/limits.md#quotas) сервиса Managed Service for Apache Spark™.

Включает разрешения, предоставляемые ролями `managed-spark.user` и `managed-spark.maintenanceTask.editor`.

Для создания кластеров Apache Spark™ дополнительно необходима роль `vpc.user`.