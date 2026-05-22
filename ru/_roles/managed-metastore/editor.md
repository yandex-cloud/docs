
Роль `managed-metastore.editor` позволяет управлять кластерами {{ metastore-name }}, а также просматривать логи их работы и информацию о квотах сервисов управляемых баз данных {{ yandex-cloud }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../../metadata-hub/concepts/metastore.md) {{ metastore-name }}, а также создавать, изменять, запускать, останавливать и удалять такие кластеры;
* [экспортировать и импортировать](../../metadata-hub/operations/metastore/export-and-import.md) кластеры {{ metastore-name }};
* просматривать логи кластеров {{ metastore-name }};
* просматривать информацию о квотах сервисов управляемых баз данных {{ yandex-cloud }};
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `managed-metastore.viewer`.

Для создания кластеров дополнительно необходима [роль](../../vpc/security/index.md#vpc-user) `vpc.user`.
