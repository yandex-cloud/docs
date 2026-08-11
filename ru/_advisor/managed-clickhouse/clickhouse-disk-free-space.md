### Нехватка места на диске {#clickhouse_disk_free_space}

**Описание**

На хосте критически мало свободного места. Это может привести к недоступности кластера. Увеличьте размер диска или очистите неиспользуемые данные.

**Действие**

Чтобы увеличить размер диска:

1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
1. Выберите кластер и нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. В разделе **{{ ui-key.yacloud.mdb.forms.section_disk }}** увеличьте размер диска.
1. Нажмите **{{ ui-key.yacloud.mdb.forms.button_edit }}**.