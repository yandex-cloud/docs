Роль `managed-metastore.admin` позволяет управлять кластерами Apache Hive™ Metastore, а также просматривать логи их работы и информацию о квотах сервисов управляемых баз данных Yandex Cloud.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../../metadata-hub/concepts/metastore.md) Apache Hive™ Metastore, а также создавать, изменять, запускать, останавливать и удалять такие кластеры;
* [экспортировать и импортировать](../../metadata-hub/operations/metastore/export-and-import.md) кластеры Apache Hive™ Metastore;
* просматривать логи кластеров Apache Hive™ Metastore;
* просматривать информацию о квотах сервисов управляемых баз данных Yandex Cloud;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `managed-metastore.editor`.

Для создания кластеров дополнительно необходима [роль](../../vpc/security/index.md#vpc-user) `vpc.user`.

