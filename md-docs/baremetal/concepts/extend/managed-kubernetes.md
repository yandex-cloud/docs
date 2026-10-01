[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > [Концепции](../index.md) > BareMetal Extend > Extend: Managed Service for Kubernetes®

# Extend: Managed Service for Kubernetes®

*Extend: Managed Service for Kubernetes®* позволяет создавать [группы рабочих узлов Managed Service for Kubernetes](../../../managed-kubernetes/concepts/index.md#node-group) на выделенных [серверах BareMetal](../servers.md). На рабочих узлах запускаются [контейнерные приложения](../../../glossary/containerization.md#containers-apps), а [мастер Kubernetes](../../../managed-kubernetes/concepts/index.md#master) управляется сервисом Managed Service for Kubernetes.

Продукт позволяет использовать выделенные процессоры, память и диски серверов для контейнерных нагрузок, сохраняя инструменты управления [кластером Kubernetes](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) в Yandex Cloud. Такой вариант подойдет, если рабочим нагрузкам нужны физическая изоляция и предсказуемая производительность выделенного оборудования.

При создании группы сервис арендует серверы выбранной [конфигурации](../server-configurations.md), подготавливает их и подключает к кластеру. [Группой узлов можно управлять в Managed Service for Kubernetes](../../../managed-kubernetes/operations/index.md#node-group), а входящие в нее серверы отображаются в BareMetal.

[Создать группу узлов BareMetal для Extend: Managed Service for Kubernetes®](../../operations/extend/managed-kubernetes.md).

#### См. также {#see-also}

* [BareMetal Extend](../extend.md)
* [Приватная сеть](../private-network.md)
* [Сервис DHCP в сети Yandex BareMetal](../dhcp.md)