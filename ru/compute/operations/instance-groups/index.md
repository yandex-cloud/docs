# Пошаговые инструкции для компонента {{ ig-name }}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

## Создание группы виртуальных машин {#ig-create}

* [{#T}](create-fixed-group.md)
* [{#T}](create-with-balancer.md)
* [{#T}](create-with-load-balancer.md)
* [{#T}](create-autoscaled-group.md)

{% if product == "yandex-cloud" %}

* [{#T}](create-with-coi.md)

{% endif %}

* [{#T}](create-from-yaml.md)

## Получение информации о группе виртуальных машин {#ig-info}

* [{#T}](get-list.md)
* [{#T}](get-info.md)
* [{#T}](get-list-instances.md)

## Управление группой виртуальных машин {#ig-control}

* [{#T}](stop.md)
* [{#T}](start.md)
* [{#T}](update.md)
* [{#T}](update-from-yaml.md)
* [{#T}](delete.md)
* [{#T}](enable-autohealing.md)
