---
title: '{{ baremetal-extend-stackland-name }}'
description: Из статьи вы узнаете о продукте {{ baremetal-extend-stackland-name }}.
---

# {{ baremetal-extend-stackland-name }}

*{{ baremetal-extend-stackland-name }}* — продукт BareMetal Extend для автоматического развертывания [{{ stackland-full-name }}](../../../stackland/index.yaml) на выделенных физических [серверах {{ baremetal-name }}](../servers.md).

{{ stackland-full-name }} — платформа контейнеризации с интегрированными PaaS-сервисами {{ yandex-cloud }}. Она объединяет [компоненты](../../../stackland/concepts/components/overview.md) для централизованного управления микросервисными и ИИ-приложениями. Платформа основана на [{{ k8s }}](https://kubernetes.io/ru/), поэтому для управления приложениями можно использовать привычные инструменты и API {{ k8s }}.

{{ baremetal-extend-stackland-name }} автоматизирует подготовку серверов и установку платформы. В результате вы получаете кластер на выделенных ресурсах, в котором можно запускать [контейнерные приложения](../../../glossary/containerization.md#containers-apps) и использовать [платформенные сервисы {{ yandex-cloud }}](../../../stackland/concepts/components/overview.md), в том числе базы данных, объектное хранилище, средства мониторинга, бизнес-аналитики и инструменты для ИИ-приложений.

[Создать кластер {{ baremetal-extend-stackland-name }}](../../operations/extend/stackland.md).

#### См. также {#see-also}

* [{#T}](../extend.md)
* [Подготовка к работе с {{ stackland-name }}](../../../stackland/quickstart.md#prerequisites)
* [Установка {{ stackland-name }} на {{ baremetal-name }}](../../../stackland/tutorials/install-on-yc-bms.md)
