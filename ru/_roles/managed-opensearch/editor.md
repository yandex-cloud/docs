Роль `managed-opensearch.editor` позволяет управлять кластерами OpenSearch.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах OpenSearch](../../managed-opensearch/concepts/index.md), а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к кластерам OpenSearch;
* восстанавливать кластеры OpenSearch из резервных копий;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-opensearch/concepts/maintenance.md) кластеров OpenSearch и изменять такие задания;
* просматривать логи работы кластеров OpenSearch;
* просматривать информацию о [квотах](../../managed-opensearch/concepts/limits.md#quotas) сервиса Managed Service for OpenSearch;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for OpenSearch.

Включает разрешения, предоставляемые ролями `managed-opensearch.viewer`, `managed-opensearch.user`, `managed-opensearch.restorer` и `managed-opensearch.maintenanceTask.editor`.

Для создания кластеров OpenSearch дополнительно необходима роль `vpc.user`.