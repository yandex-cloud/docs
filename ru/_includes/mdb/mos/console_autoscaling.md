* В поле **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** задайте соответствующие условия, чтобы:

    * Размер хранилища увеличился в следующее [окно обслуживания](../../../managed-opensearch/concepts/maintenance.md#maintenance-window), когда хранилище окажется заполнено более чем на указанную долю (%).
    * Размер хранилища увеличился незамедлительно, когда хранилище окажется заполнено более чем на указанную долю (%).

    Можно задать оба условия, но порог для незамедлительного увеличения должен быть выше порога для увеличения в окно обслуживания.

* В поле **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** укажите максимальный размер хранилища, который может быть установлен при автоматическом увеличении размера хранилища.

    {% include [storage-resize-steps](storage-resize-steps.md) %}

    
    {% include [warn-storage-resize](warn-storage-resize.md) %}
     

Если настроено увеличение хранилища в окно обслуживания, настройте расписание окна обслуживания.
