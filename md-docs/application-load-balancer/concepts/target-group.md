[Документация Yandex Cloud](../../index.md) > [Yandex Application Load Balancer](../index.md) > [Концепции](index.md) > Целевые группы

# Целевые группы

Целевая группа L7-балансировщика — это набор IP-адресов ВМ, на которых запущены ваши сетевые приложения. Чтобы балансировщик распределял запросы между ВМ целевой группы, ее нужно указать в конфигурации [группы бэкендов](backend-group.md).

Основными целевыми ресурсами в группе являются ВМ, которые подключены к [подсетям](../../vpc/concepts/network.md#subnet) Virtual Private Cloud. Чтобы L7-балансировщик работал корректно, подсети целевых ресурсов должны находиться в одной [облачной сети](../../vpc/concepts/network.md#network).

Также вы можете добавлять в целевую группу ресурсы, которые размещены вне Virtual Private Cloud, например в вашем ЦОД, подключенном к Yandex Cloud через [Cloud Interconnect](../../interconnect/index.md). Адреса ресурсов должны входить в [частные диапазоны из RFC 1918](https://datatracker.ietf.org/doc/html/rfc1918#section-3). Подробнее в разделе [Подсети](../../vpc/concepts/network.md#subnet).

Целевые группы можно создавать:

* [Вручную](../operations/target-group-create.md). В этом случае при изменении внутреннего IP-адреса ВМ, например при ее переносе в другую подсеть, целевую группу нужно обновить самостоятельно — удалить и заново добавить в нее измененную ВМ.
* [Через Instance Groups](../../compute/operations/instance-groups/create-with-load-balancer.md). При изменении конфигурации ВМ Instance Groups будет автоматически поддерживать актуальность IP-адресов машин в целевой группе. Если целевая группа подключена к группе бэкендов, Instance Groups будет следить и за результатами проверок состояния, которые отправляет L7-балансировщик.

Если целевая группа используется хотя бы в одной группе бэкендов, удалить ее нельзя. Сначала [удалите](../operations/backend-group-update.md#update-group) ее из всех групп бэкендов.

## Примеры использования {#examples}

* [Организация виртуального хостинга](../tutorials/virtual-hosting.md)
* [Создание L7-балансировщика с защитой от DDoS с помощью консоли управления или CLI](../tutorials/alb-with-ddos-protection/console.md)
* [Миграция сервисов с внешнего балансировщика NLB на L7-балансировщик ALB с целевым ресурсом — внутренним сетевым балансировщиком NLB](../tutorials/migration-from-nlb-to-alb/nlb-as-target-resource-alb/index.md)
* [Миграция сервисов с балансировщика NLB с целевыми ресурсами из группы виртуальных машин (Instance Groups) на L7-балансировщик ALB](../tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/index.md)
* [Терминирование TLS-соединений с помощью консоли управления](../tutorials/tls-termination/console.md)
* [Запись логов балансировщика в PostgreSQL](../tutorials/logging.md)
* [Отказоустойчивый сайт с балансировкой нагрузки через Yandex Application Load Balancer](../tutorials/application-load-balancer-website/index.md)