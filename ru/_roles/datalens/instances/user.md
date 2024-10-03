Роль `datalens.instances.user` предоставляет доступ к сервису DataLens в качестве пользователя с правами на создание, чтение и изменение [объектов](../../../datalens/concepts/index.md#component-interrelation) согласно правам доступа к ним, а также позволяет просматривать информацию о [каталогах](../../../resource-manager/concepts/resources-hierarchy.md#folder).

После назначения сервисной роли вы можете [назначить](../../../datalens/operations/permission/grant.md) пользователю права доступа к объектам и папкам в сервисе DataLens.

{% note tip %}

Рекомендуем использовать роль `datalens.creator` вместо `datalens.instances.user`. При аналогичном наборе разрешений она более безопасна, так как предоставляет доступ только к экземпляру DataLens и не дает прав на просмотр всех каталогов в организации.

{% endnote %}

