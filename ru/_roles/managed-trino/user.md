Роль `managed-trino.user` позволяет выполнять базовые операции с кластерами Trino.

Пользователи с этой ролью могут:
* использовать веб-интерфейс Trino;
* отправлять запросы к API Trino;
* просматривать информацию о [кластерах Trino](../../managed-trino/concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-trino/concepts/maintenance.md) кластеров Trino;
* просматривать информацию о [квотах](../../managed-trino/concepts/limits.md#quotas) сервиса Managed Service for Trino.

Включает разрешения, предоставляемые ролью `managed-trino.viewer`.