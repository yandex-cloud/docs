Роль `managed-elasticsearch.admin` позволяет управлять кластерами Elasticsearch и просматривать их логи, а также получать информацию о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* управлять доступом к [кластерам](../../managed-elasticsearch/concepts/index.md) Elasticsearch;
* просматривать информацию о кластерах Elasticsearch, а также создавать, изменять, удалять, запускать и останавливать их;
* просматривать логи работы кластеров Elasticsearch;
* просматривать информацию о [квотах](../../managed-elasticsearch/concepts/limits.md#mes-quotas) сервиса Managed Service for Elasticsearch;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for Elasticsearch.

Включает разрешения, предоставляемые ролью `managed-elasticsearch.editor`.

Для создания кластеров Elasticsearch дополнительно необходима роль `vpc.user`.