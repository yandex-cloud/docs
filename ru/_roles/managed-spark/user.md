
Роль `managed-spark.user` позволяет выполнять базовые операции с кластерами {{ SPRK }} и заданиями.

Пользователи с этой ролью могут:
* использовать веб-интерфейс {{ SPRK }};
* просматривать информацию о [заданиях](../../managed-spark/operations/index.md#jobs), а также создавать, запускать и отменять их;
* просматривать информацию о [кластерах {{ SPRK }}](../../managed-spark/concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-spark/concepts/maintenance.md) кластеров {{ SPRK }};
* просматривать информацию о [квотах](../../managed-spark/concepts/limits.md#quotas) сервиса {{ msp-name }}.

Включает разрешения, предоставляемые ролью `managed-spark.viewer`.