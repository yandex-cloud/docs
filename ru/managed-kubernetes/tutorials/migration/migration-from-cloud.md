---
title: Миграция из публичного облака в {{ managed-k8s-name }}
description: Руководство по переносу рабочих нагрузок {{ k8s }} из публичного облака в {{ managed-k8s-name }}.
---

# Миграция из публичного облака в {{ managed-k8s-name }}

В этом руководстве описан перенос рабочих нагрузок {{ k8s }} из управляемого сервиса другого облачного провайдера в {{ managed-k8s-name }}.

{% include [principle](../../../_includes/managed-kubernetes/migration/principle.md) %}

Чтобы перенести рабочие нагрузки в {{ managed-k8s-name }}:

1. [Разработайте план миграции](#inventory).
1. [Подготовьте инфраструктуру {{ yandex-cloud }}](#infrastructure).
1. [Перенесите Docker-образы](#images).
1. [Перенесите stateful-нагрузки](#stateful).
1. [Перенесите stateless-нагрузки](#stateless).
1. [Настройте балансировщики и переключите DNS](#dns).
1. [Завершите миграцию](#finalization).


## Необходимые платные ресурсы {#paid-resources}

* {% include notitle [master](../../../_includes/managed-kubernetes/migration/paid-resources.md#master) %}
* {% include notitle [nodes](../../../_includes/managed-kubernetes/migration/paid-resources.md#nodes) %}
* {% include notitle [public-ips](../../../_includes/managed-kubernetes/migration/paid-resources.md#public-ips) %}
* {% include notitle [application-load-balancers](../../../_includes/managed-kubernetes/migration/paid-resources.md#application-load-balancers) %}
* {% include notitle [network-load-balancers](../../../_includes/managed-kubernetes/migration/paid-resources.md#network-load-balancers) %}
* {% include notitle [registry](../../../_includes/managed-kubernetes/migration/paid-resources.md#registry) %}
* {% include notitle [bucket](../../../_includes/managed-kubernetes/migration/paid-resources.md#bucket) %}

* Трансферы {{ data-transfer-name }}, если используется перенос управляемых баз данных ([тарифы {{ data-transfer-full-name }}](../../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

{% include [inventory-intro](../../../_includes/managed-kubernetes/migration/inventory-intro.md) %}

Убедитесь, что все stateful-нагрузки — управляемые базы данных, StatefulSets с PersistentVolume — имеют актуальные резервные копии.

{% include [inventory-resources](../../../_includes/managed-kubernetes/migration/inventory-resources.md) %}

{% include [compatibility](../../../_includes/managed-kubernetes/migration/compatibility.md) %}

{% include [planning](../../../_includes/managed-kubernetes/migration/planning.md) %}

{% include [infrastructure](../../../_includes/managed-kubernetes/migration/infrastructure.md) %}

{% include [images](../../../_includes/managed-kubernetes/migration/images.md) %}

## Перенесите stateful-нагрузки {#stateful}

Перенос stateful-нагрузок — управляемых баз данных, StatefulSets с PersistentVolumes — является самым сложным шагом миграции, так как они хранят данные и их нельзя пересоздать без потерь.

{% note warning %}

Убедитесь, что все stateful-нагрузки — управляемые базы данных, StatefulSets с PersistentVolume — имеют актуальные резервные копии.

{% endnote %}

### Перенесите управляемые базы данных {#managed-databases}

Для переноса управляемых баз данных используйте [{{ data-transfer-full-name }}](../../../data-transfer/index.yaml). Сервис позволяет перенести данные с сохранением рабочего состояния источника и минимизировать время простоя для использующих его приложений.

{% include [databases](../../../_includes/managed-kubernetes/migration/databases.md) %}

{% include [volumes](../../../_includes/managed-kubernetes/migration/volumes.md) %}

{% include [stateless](../../../_includes/managed-kubernetes/migration/stateless.md) %}

{% include [dns](../../../_includes/managed-kubernetes/migration/dns.md) %}

## Завершите миграцию {#finalization}

{% include notitle [finalization-intro](../../../_includes/managed-kubernetes/migration/finalization.md#intro) %}

1. {% include notitle [check-services](../../../_includes/managed-kubernetes/migration/finalization.md#services) %}
1. {% include notitle [check-metrics](../../../_includes/managed-kubernetes/migration/finalization.md#metrics) %}

1. Отключите ресурсы в исходном облаке после подтверждения стабильной работы.

1. {% include notitle [optimize-cluster](../../../_includes/managed-kubernetes/migration/finalization.md#optimization) %}
1. {% include notitle [cleanup-resources](../../../_includes/managed-kubernetes/migration/finalization.md#cleanup) %}
