### Ограничена возможность автомасштабирования дискового пространства {#mysql_disk_autoscaling_limit}

**Описание**

Достигнут предел автомасштабирования, кластер не сможет увеличить дисковое пространство при необходимости. Измените настройки автомасштабирования в кластере и увеличьте лимит.

**Действие**

Чтобы изменить настройки автомасштабирования:

  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. В дополнительных настройках кластера **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}** выберите опцию **{{ ui-key.yacloud.mdb.cluster.field_plannedUsageThreshold }}** и укажите процент **{{ ui-key.yacloud.mdb.cluster.field_threshold-value }}**, при достижении которого хранилище будет увеличено в следующее [окно обслуживания](../../managed-mysql/concepts/maintenance.md#maintenance-window).