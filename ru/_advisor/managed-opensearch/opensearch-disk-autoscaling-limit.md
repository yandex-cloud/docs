### Ограничена возможность автомасштабирования дискового пространства {#opensearch-disk-autoscaling-limit}

**Описание**

Достигнут предел автомасштабирования диска, кластер не сможет увеличить дисковое пространство при необходимости. Измените настройки автомасштабирования в кластере и увеличьте лимит.

**Действие**

Чтобы увеличить размер диска:

1. [Перейдите]({{ link-console-main }}/link/managed-opensearch) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.
1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной группы и выберите пункт **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
1. Укажите максимальный размер хранилища после увеличения.
1. Нажмите **{{ ui-key.yacloud.mdb.forms.button_edit }}**.