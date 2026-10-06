

Роль `datalens.instances.user` предоставляет доступ к сервису {{ datalens-name }} в качестве пользователя с правами на создание, чтение и изменение [объектов]({{ link-datalens-docs }}/concepts/) согласно правам доступа к ним, а также позволяет просматривать информацию о [каталогах](../../../resource-manager/concepts/resources-hierarchy.md#folder).

После назначения сервисной роли вы можете [назначить]({{ link-datalens-docs }}/operations/permission/grant) пользователю права доступа к объектам и папкам в сервисе {{ datalens-name }}.


{% note tip %}

Рекомендуем использовать роль `datalens.creator` вместо `datalens.instances.user`. При аналогичном наборе разрешений она более безопасна, так как предоставляет доступ только к экземпляру {{ datalens-name }} и не дает прав на просмотр всех каталогов в организации.

{% endnote %}

