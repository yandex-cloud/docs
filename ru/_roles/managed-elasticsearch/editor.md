Роль `managed-elasticsearch.editor` позволяет управлять кластерами Elasticsearch и просматривать их логи, а также получать информацию о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../../managed-elasticsearch/concepts/index.md) Elasticsearch, а также создавать, изменять, удалять, запускать и останавливать их;
* просматривать логи работы кластеров Elasticsearch;
* просматривать информацию о [квотах](../../managed-elasticsearch/concepts/limits.md#mes-quotas) сервиса Managed Service for Elasticsearch;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for Elasticsearch.

Включает разрешения, предоставляемые ролью `managed-elasticsearch.viewer`.

Для создания кластеров Elasticsearch дополнительно необходима роль `vpc.user`.