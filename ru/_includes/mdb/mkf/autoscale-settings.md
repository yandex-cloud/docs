1. В поле **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** выберите один или оба порога:
    * **{{ ui-key.yacloud.mdb.cluster.field_plannedUsageThreshold }}** — порог для планового увеличения. Когда он достигнут, объем хранилища увеличивается во время ближайшего [окна обслуживания](../../../managed-kafka/concepts/maintenance.md#maintenance-window).
    * **{{ ui-key.yacloud.mdb.cluster.field_emergencyUsageThreshold }}** — порог для незамедлительного увеличения. Когда он достигнут, объем хранилища увеличивается немедленно.         
1. Задайте пороговое значение (в процентах от общего объема хранилища). Если выбраны оба порога, значение для незамедлительного увеличения должно быть выше, чем для планового.
1. Задайте **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}**.
