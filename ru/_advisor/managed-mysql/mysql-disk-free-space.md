### Риск недоступности кластера {#mysql_disk_free_space}

**Описание**

На хосте критически мало свободного места. Это может привести к отключению некоторых операций и недоступности кластера (переходу в режим «только для чтения»). Увеличьте размер диска или очистите неиспользуемые данные.

**Действие**

Чтобы увеличить размер диска:

1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Выберите кластер и нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. В разделе **{{ ui-key.yacloud.mdb.forms.section_storage }}** увеличьте размер диска.
1. Нажмите **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
