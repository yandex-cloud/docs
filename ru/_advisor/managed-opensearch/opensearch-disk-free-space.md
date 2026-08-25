### Риск недоступности кластера {#opensearch_disk_free_space}

**Описание**

На хосте мало свободного места. Это может привести к отключению некоторых операций и недоступности кластера (переходу в режим «только для чтения»). Увеличьте размер диска или очистите неиспользуемые данные.

**Действие**

Чтобы увеличить размер диска:

1. [Перейдите]({{ link-console-main }}/link/managed-opensearch) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.
1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной группы и выберите пункт **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
1. В настройках типа диска увеличьте его размер.
1. Нажмите **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
