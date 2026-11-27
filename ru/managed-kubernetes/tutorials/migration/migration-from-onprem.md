---
title: Миграция из on-premises в {{ managed-k8s-full-name }}
description: Руководство по переносу рабочих нагрузок {{ k8s }} из собственной инфраструктуры в {{ managed-k8s-name }}.
alternate:
  - href: ru/managed-kubernetes/tutorials/migration/migration-from-onprem.md
    type: text/markdown
    title: Markdown version
---

# Миграция из on-premises в {{ managed-k8s-name }}

В этом руководстве описан перенос рабочих нагрузок {{ k8s }} из кластера в собственной инфраструктуре (on-premises) в {{ managed-k8s-name }}.

{% include [principle](../../../_includes/managed-kubernetes/migration/principle.md) %}

Чтобы перенести рабочие нагрузки в {{ managed-k8s-name }}:

1. [Разработайте план миграции](#inventory).
1. [Подготовьте инфраструктуру {{ yandex-cloud }}](#infrastructure).
1. [Настройте сетевую связность](#connectivity) от собственной инфраструктуры до {{ yandex-cloud }}.
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

* Трансферы {{ data-transfer-name }}, если используется перенос баз данных ([тарифы {{ data-transfer-full-name }}](../../../data-transfer/pricing.md)).
* Виртуальная машина для VPN-шлюза, если используется VPN ([тарифы {{ compute-full-name }}](../../../compute/pricing.md)), или соединение {{ interconnect-name }}, если используется выделенный канал ([тарифы {{ interconnect-full-name }}](../../../interconnect/pricing.md)).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

{% include [inventory-intro](../../../_includes/managed-kubernetes/migration/inventory-intro.md) %}

Убедитесь, что все stateful-нагрузки — базы данных, StatefulSets с PersistentVolume — имеют актуальные резервные копии.

{% include [inventory-resources](../../../_includes/managed-kubernetes/migration/inventory-resources.md) %}

### Проведите инвентаризацию специфичных для on-premises ресурсов {#onprem-resources-inventory}

**Инфраструктурные компоненты.** Составьте список компонентов собственной инфраструктуры и подберите для них замену в {{ yandex-cloud }}. Для хранилищ учитывайте режим доступа к томам и требования приложений.

#|
|| **Компонент on-premises** | **Замена в {{ yandex-cloud }}** ||
|| MetalLB | {{ network-load-balancer-name }} для узлов в облаке ||
|| Local Path Provisioner | Класс хранения `yc-network-ssd` для томов с режимом доступа `ReadWriteOnce` ||
|| Ceph RBD, GlusterFS CSI, vSphere CSI, Longhorn | Класс хранения `yc-network-ssd` для томов с режимом доступа `ReadWriteOnce`, для `ReadWriteMany` [подготовьте подходящее хранилище](#rwx) ||
|| NFS PersistentVolumes | Для томов с режимом доступа `ReadWriteMany` [подготовьте подходящее хранилище](#rwx) ||
|| Ingress-контроллер на физических серверах (NodePort) | [Контроллер Gwin](../../alb-ref/gwin-index.md), проверьте совместимость маршрутов и аннотаций ||
|| Интеграция с LDAP / Active Directory | {{ org-full-name }} с подключением собственного IdP через OIDC, если такой способ аутентификации подходит приложениям ||
|| Локальный реестр контейнеров | {{ cloud-registry-name }} ||
|| Собственный CNI | Поддерживаемые в {{ managed-k8s-name }} [сетевые настройки и политики кластера](../../concepts/network-policy.md) ||
|#

Проверьте зависимости приложений от локальных систем, например DNS, LDAP или Active Directory. Определите, какие системы нужно перенести, а к каким потребуется сохранить доступ из {{ yandex-cloud }}.

{% include [compatibility](../../../_includes/managed-kubernetes/migration/compatibility.md) %}

### Оцените сетевые требования {#network-requirements}

Зафиксируйте DNS-имена и IP-адреса сервисов, правила файрвола и сетевые политики исходного кластера. Найдите обращения к ресурсам по фиксированным IP-адресам и запланируйте их изменение при переносе. Выберите адресные диапазоны облачных подсетей, подов и сервисов так, чтобы они не пересекались между собой и с диапазонами исходной сети.

Определите, нужна ли прямая связность между собственной инфраструктурой и {{ yandex-cloud }}: например, для репликации баз данных по приватным адресам, переноса данных через `rsync` или доступа к системам, которые остаются в исходной сети. Если планируете использовать внешние узлы, заранее проверьте [требования и ограничения](../../concepts/external-nodes.md).

{% include [planning](../../../_includes/managed-kubernetes/migration/planning.md) %}

{% include [infrastructure](../../../_includes/managed-kubernetes/migration/infrastructure.md) %}

### Подготовьте хранилища для RWX-томов {#rwx}


Если тома в исходном кластере используют режим доступа `ReadWriteMany` (RWX), вы можете:


* Развернуть NFS-сервер на [виртуальной машине](../../../compute/operations/vm-create/create-linux-vm.md).
* Использовать [{{ objstorage-name }} через CSI-драйвер](../../operations/volumes/s3-csi-integration.md). Перед выбором {{ objstorage-name }} проверьте, что [ограничения файловой системы](https://github.com/yandex-cloud/k8s-csi-s3#mounter) подходят приложению.

## Настройте сетевую связность {#connectivity}

Перенос данных можно выполнить с прямой связностью между собственной инфраструктурой и {{ yandex-cloud }} или без нее — через {{ objstorage-name }}.

Для организации прямого канала воспользуйтесь одним из способов:

* [IPsec VPN](../../../tutorials/routing/ipsec/index.md) — шифрованный туннель через интернет между IPsec-шлюзами в собственной инфраструктуре и {{ yandex-cloud }}. Рассмотрите этот способ для репликации данных умеренного объема — десятков или сотен гигабайт.
* [{{ interconnect-full-name }}](../../../interconnect/concepts/index.md) — выделенное соединение между собственной инфраструктурой и {{ yandex-cloud }} в обход публичного интернета. Рассмотрите этот способ для переноса больших объемов данных — более 1–2 ТБ.

Убедитесь, что диапазоны IP-адресов (CIDR) собственной инфраструктуры и облачной сети не пересекаются. Настройте маршруты в обе стороны и разрешите нужные подключения в файрволе исходной инфраструктуры и группах безопасности {{ yandex-cloud }}.

Если для переноса используется {{ data-transfer-name }}, на этапе [переноса баз данных](#managed-databases) используйте настроенное соединение через {{ interconnect-name }} или IPsec VPN. В настройках эндпоинта укажите [подсеть, из которой доступен источник](../../../data-transfer/concepts/network.md#source-external).

Если прямая связность недоступна или нежелательна:

1. [Создайте бакет](../../../storage/operations/buckets/create.md) в {{ objstorage-name }}.
1. [Загрузите данные в бакет](../../../storage/operations/objects/upload.md#aws-cli).

{% include [images](../../../_includes/managed-kubernetes/migration/images.md) %}

## Перенесите stateful-нагрузки {#stateful}

Перенос stateful-нагрузок — баз данных, StatefulSets с PersistentVolumes — является самым сложным шагом миграции, так как они хранят данные и их нельзя пересоздать без потерь.

{% note warning %}

Убедитесь, что все stateful-нагрузки — базы данных, StatefulSets с PersistentVolume — имеют актуальные резервные копии.

{% endnote %}

### Перенесите базы данных {#managed-databases}

Для переноса баз данных используйте [{{ data-transfer-full-name }}](../../../data-transfer/index.yaml). Сервис позволяет перенести данные с сохранением рабочего состояния источника и минимизировать время простоя для использующих его приложений.

{% include [databases](../../../_includes/managed-kubernetes/migration/databases.md) %}

{% include [volumes](../../../_includes/managed-kubernetes/migration/volumes.md) %}

{% include [stateless](../../../_includes/managed-kubernetes/migration/stateless.md) %}

{% include [dns](../../../_includes/managed-kubernetes/migration/dns.md) %}

## Завершите миграцию {#finalization}

{% include notitle [finalization-intro](../../../_includes/managed-kubernetes/migration/finalization.md#intro) %}

1. {% include notitle [check-services](../../../_includes/managed-kubernetes/migration/finalization.md#services) %}
1. {% include notitle [check-metrics](../../../_includes/managed-kubernetes/migration/finalization.md#metrics) %}

1. (Опционально) Создайте [финальную резервную копию etcd](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster) исходного кластера. Сохраните ее отдельно от временных ресурсов миграции.
1. Отключите ресурсы исходного кластера после подтверждения стабильной работы.

1. {% include notitle [optimize-cluster](../../../_includes/managed-kubernetes/migration/finalization.md#optimization) %}
1. {% include notitle [cleanup-resources](../../../_includes/managed-kubernetes/migration/finalization.md#cleanup) %}
