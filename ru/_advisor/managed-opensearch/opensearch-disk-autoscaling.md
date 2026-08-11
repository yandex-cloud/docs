### Автомасштабирование дискового пространства не настроено {#opensearch_disk_autoscaling}

**Описание**

В шардах не настроено автомасштабирование дискового пространства. Настройте автомасштабирование для предотвращения переполнения диска.

**Действие**

Чтобы увеличить размер диска:

1. [Перейдите]({{ link-console-main }}/link/managed-opensearch) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.
1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной группы и выберите пункт **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
1. В поле **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** задайте соответствующие условия автомасштабирования.
1. Нажмите **{{ ui-key.yacloud.mdb.forms.button_edit }}**.