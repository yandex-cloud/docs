### Ограничена возможность автомасштабирования дискового пространства {#postgresql_disk_autoscaling_limit}

**Описание**

Достигнут предел автомасштабирования диска, кластер не сможет увеличить дисковое пространство при необходимости. Измените настройки автомасштабирования в кластере и увеличьте лимит.

**Действие**

Чтобы увеличить размер диска:

1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Выберите кластер и нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. В поле **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** укажите максимальный размер хранилища после увеличения.
1. Нажмите **{{ ui-key.yacloud.mdb.forms.button_edit }}**.