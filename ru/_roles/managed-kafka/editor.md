Роль `managed-kafka.editor` позволяет управлять кластерами Apache Kafka®.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах Apache Kafka®](../../managed-kafka/concepts/index.md), а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к кластерам Apache Kafka®;
* использовать [веб-интерфейс](../../managed-kafka/concepts/kafka-ui.md) Kafka UI для Apache Kafka®;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-kafka/concepts/maintenance.md) кластеров Apache Kafka® и изменять такие задания;
* просматривать логи работы кластеров Apache Kafka®;
* просматривать информацию о [квотах](../../managed-kafka/concepts/limits.md#mkf-quotas) сервиса Managed Service for Apache Kafka®;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for Apache Kafka®.

Включает разрешения, предоставляемые ролями `managed-kafka.viewer`, `managed-kafka.user`, `managed-kafka.interfaceUser` и `managed-kafka.maintenanceTask.editor`.

Для создания кластеров Apache Kafka® дополнительно необходима роль `vpc.user`.