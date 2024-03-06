Роль `managed-opensearch.admin` позволяет управлять кластерами OpenSearch и просматривать их логи, а также получать информацию о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* управлять доступом к кластерам OpenSearch;
* просматривать информацию о [кластерах](../../managed-opensearch/concepts/index.md) OpenSearch, а также создавать, изменять, удалять, запускать и останавливать их;
* просматривать логи работы кластеров OpenSearch;
* просматривать информацию о [квотах](../../managed-opensearch/concepts/limits.md#quotas) сервиса Managed Service for OpenSearch;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for OpenSearch.

Включает разрешения, предоставляемые ролью `managed-opensearch.editor`.

Для создания кластеров OpenSearch дополнительно необходима роль `vpc.user`.