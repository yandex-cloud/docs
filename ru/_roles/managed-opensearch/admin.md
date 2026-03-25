Роль `managed-opensearch.admin` позволяет управлять кластерами OpenSearch и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к [кластерам OpenSearch](../../managed-opensearch/concepts/index.md) и изменять такие права доступа;
* просматривать информацию о кластерах OpenSearch, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* восстанавливать кластеры OpenSearch из резервных копий;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-opensearch/concepts/maintenance.md) кластеров OpenSearch и изменять такие задания;
* просматривать логи работы кластеров OpenSearch;
* просматривать информацию о [квотах](../../managed-opensearch/concepts/limits.md#quotas) сервиса Managed Service for OpenSearch;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for OpenSearch.

Включает разрешения, предоставляемые ролью `managed-opensearch.editor`.

Для создания кластеров OpenSearch дополнительно необходима роль `vpc.user`.