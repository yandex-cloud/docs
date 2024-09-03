Роль `datalens.instances.admin` предоставляет доступ к сервису DataLens в качестве администратора экземпляра DataLens. Администратор получает полные права на все [объекты](../../../datalens/concepts/index.md#component-interrelation) и папки в сервисе DataLens, доступ к настройкам DataLens, а также позволяет просматривать информацию о [каталогах](../../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `datalens.instances.user`.

{% note tip %}

Рекомендуем использовать роль `datalens.admin` вместо `datalens.instances.admin`. При аналогичном наборе разрешений она более безопасна, так как предоставляет доступ только к экземпляру DataLens и не дает прав на просмотр всех каталогов в организации.

{% endnote %}

