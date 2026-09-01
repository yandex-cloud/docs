---
title: '{{ baremetal-extend-managed-k8s-name }}'
description: Из статьи вы узнаете о продукте {{ baremetal-extend-managed-k8s-name }}.
---

# {{ baremetal-extend-managed-k8s-name }}

*{{ baremetal-extend-managed-k8s-name }}* позволяет создавать [группы рабочих узлов {{ managed-k8s-name }}](../../../managed-kubernetes/concepts/index.md#node-group) на выделенных [серверах {{ baremetal-name }}](../servers.md). На рабочих узлах запускаются [контейнерные приложения](../../../glossary/containerization.md#containers-apps), а [мастер {{ k8s }}](../../../managed-kubernetes/concepts/index.md#master) управляется сервисом {{ managed-k8s-name }}.

Продукт позволяет использовать выделенные процессоры, память и диски серверов для контейнерных нагрузок, сохраняя инструменты управления [кластером {{ k8s }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) в {{ yandex-cloud }}. Такой вариант подойдет, если рабочим нагрузкам нужны физическая изоляция и предсказуемая производительность выделенного оборудования.

При создании группы сервис арендует серверы выбранной [конфигурации](../server-configurations.md), подготавливает их и подключает к кластеру. [Группой узлов можно управлять в {{ managed-k8s-name }}](../../../managed-kubernetes/operations/index.md#node-group), а входящие в нее серверы отображаются в {{ baremetal-name }}.

[Создать группу узлов {{ baremetal-name }} для {{ baremetal-extend-managed-k8s-name }}](../../operations/extend/managed-kubernetes.md).

#### См. также {#see-also}

* [{#T}](../extend.md)
* [{#T}](../private-network.md)
* [{#T}](../dhcp.md)
