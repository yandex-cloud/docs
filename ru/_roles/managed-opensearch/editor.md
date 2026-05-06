
Роль `managed-opensearch.editor` позволяет управлять кластерами {{ OS }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ OS }}](../../managed-opensearch/concepts/index.md), а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к кластерам {{ OS }};
* восстанавливать кластеры {{ OS }} из резервных копий;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-opensearch/concepts/maintenance.md) кластеров {{ OS }} и изменять такие задания;
* просматривать логи работы кластеров {{ OS }};
* просматривать информацию о [квотах](../../managed-opensearch/concepts/limits.md#quotas) сервиса {{ mos-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mos-name }}.

Включает разрешения, предоставляемые ролями `managed-opensearch.viewer`, `managed-opensearch.user`, `managed-opensearch.restorer` и `managed-opensearch.maintenanceTask.editor`.

Для создания кластеров {{ OS }} дополнительно необходима роль `vpc.user`.