* В поле **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** выберите один или оба порога:
  * **{{ ui-key.yacloud.mdb.cluster.field_plannedUsageThreshold }}** — порог для планового увеличения. При его достижении размер хранилища увеличивается во время ближайшего [окна обслуживания](../../../managed-clickhouse/concepts/maintenance.md#maintenance-window).
    
    Для планового увеличения необходимо настроить расписание [окна обслуживания](../../../managed-clickhouse/concepts/maintenance.md#maintenance-window).

  * **{{ ui-key.yacloud.mdb.cluster.field_emergencyUsageThreshold }}** — порог для незамедлительного увеличения. При его достижении размер хранилища увеличивается немедленно.
* Задайте пороговое значение (в процентах от общего размера хранилища). Если выбраны оба порога, значение для незамедлительного увеличения должно быть не меньше, чем для планового.
* Задайте **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}**.