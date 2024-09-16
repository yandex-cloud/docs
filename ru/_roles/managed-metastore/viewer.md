Роль `{{ roles.metastore.viewer }}` позволяет просматривать информацию о кластерах Hive Metastore и логи их работы, а также информацию о квотах сервисов управляемых баз данных Yandex Cloud.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../../metadata-hub/concepts/metastore.md) Hive Metastore;
* просматривать [логи](../../data-proc/concepts/logs.md) кластеров Hive Metastore;
* просматривать информацию о квотах сервисов управляемых баз данных Yandex Cloud;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `{{ roles.metastore.auditor }}`.