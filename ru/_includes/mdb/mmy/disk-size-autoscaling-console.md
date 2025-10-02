* Выберите опцию **{{ ui-key.yacloud.mdb.cluster.field_plannedUsageThreshold }}** и укажите процент **{{ ui-key.yacloud.mdb.cluster.field_threshold-value }}**, при достижении которого хранилище будет увеличено в следующее [окно обслуживания](../../../managed-mysql/concepts/maintenance.md#maintenance-window).
      
* Выберите опцию **{{ ui-key.yacloud.mdb.cluster.field_emergencyUsageThreshold }}** и укажите процент **{{ ui-key.yacloud.mdb.cluster.field_threshold-value }}**, при достижении которого хранилище будет увеличено незамедлительно.

* В поле **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** укажите максимальный размер хранилища, который может быть достигнут при автоматическом увеличении.

{% note warning %}
      
{% include [note-storage-resize](note-storage-resize.md) %}
* Если выбрано увеличение размера хранилища в окно обслуживания, настройте расписание [окна обслуживания](../../../managed-mysql/concepts/maintenance.md#maintenance-window).

{% endnote %}

[Подробнее об автоматическом увеличении размера хранилища](../../../managed-mysql/concepts/storage.md#disk-size-autoscaling).