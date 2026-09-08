---
title: Системные и технические требования при установке модуля {{ kspm-name }}
description: В этом разделе собраны системные и технические требования к кластерам {{ k8s }} для установки модуля Контроль {{ k8s }}® ({{ kspm-name }}) в {{ sd-name }}.
---

# Системные и технические требования

Перед началом работы с модулем {{ kspm-name }} убедитесь, что кластеры, которые вы планируете включить в область действия модуля {{ kspm-name }}, соответствуют минимальным требованиям.

## Технические требования {#technical-reqs}

Для установки компонентов {{ kspm-name }} доступные в кластере ресурсы должны удовлетворять следующим техническим требованиям:

* {{ k8s }} версии 1.30 и выше.
* В кластере {{ k8s }} отсутствует [Admission Control](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/) на базе [Kyverno](https://yandex.cloud/ru/marketplace/products/yc/kyverno). Если Kyverno был развернут ранее, его необходимо удалить вместе со всеми созданными им ресурсами [CustomResourceDefinition](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/).
* Между узлами кластера {{ k8s }} и [сервисом {{ container-registry-full-name }}](../../../managed-kubernetes/tutorials/container-registry.md) настроено сетевое взаимодействие.
* Открыт сетевой доступ от пода, в котором запущен сенсор контроля безопасности среды выполнения, до подов кластера через порт `54321`.
* Открыт доступ от кластера к API {{ kspm-name }} (`kspm.api.cloud.yandex.net`) через порт `443` по протоколу TCP.
* С помощью [групп безопасности](../../../managed-kubernetes/operations/connect/security-groups.md#rules-nodes) настроен доступ от мастера кластера к компонентам {{ kspm-name }}, запущенным на узлах кластера.

## Системные требования {#system-reqs}

Для установки компонентов {{ kspm-name }} доступные в кластере ресурсы должны удовлетворять минимальным системным требованиям.

### Требования к группе узлов кластера {#worker-node-requirements}

{% note info %}

Ниже приведена минимальная конфигурация группы узлов кластера, достаточная для запуска компонентов {{ kspm-name }}. В этой конфигурации не учитывается клиентская нагрузка на узлы.

{% endnote %}

#|
||
**Количество узлов**
|
**CPU,&nbsp;requests**</br>(`Admission` + `Runtime sensor`)
|
**Память,&nbsp;requests**</br>(`Admission` + `Runtime sensor`)
||
||
2 | 2 vCPU | 4 ГБ
||
|#

### Потребление ресурсов компонентами {{ kspm-name }} {#component-consumption}

При установке {{ kspm-name }} в кластер {{ managed-k8s-name }} в нем развертываются несколько компонентов. В таблицах ниже приведены эти компоненты, а также минимальный объем ресурсов кластера, который резервируется для каждого из них. При этом в зависимости от нагрузки фактическое потребление ресурсов может быть выше.

**Компоненты Admission (Kyverno и admission-reporter)**

Эти компоненты запускаются в фиксированном количестве реплик и не зависят от количества узлов в кластере.

#|
|| **Компонент** | **Реплики** | **CPU,&nbsp;requests**&nbsp;^1^ | **Память,&nbsp;requests** ||
|| `kyverno-admission-controller` | 3 | — | 512 МБ × 3 ||
|| `kyverno-background-controller` | 1 | 100m | 64 МБ ||
|| `kyverno-cleanup-controller` | 1 | 100m | 64 МБ ||
|| `kyverno-reports-controller` | 1 | 100m | 64 МБ ||
|| `admission-reporter` | 1 | 100m | 64 МБ ||
|| **Итого** | > | **400m** | **1,75 ГБ** ||
|#

^1^ Значения указаны в тысячных долях ядра vCPU (millicores).

**Компоненты Runtime sensor (Tetragon)**

Часть этих компонентов запускается в фиксированном количестве реплик и не зависит от количества узлов в кластере, часть запускается на каждом узле кластера как `DaemonSet`.

#|
|| **Компонент** | **Реплики** | **CPU,&nbsp;requests** | **Память,&nbsp;requests** ||
|| `runtime-sensor-operator` | 1 | 10m | 64 МБ ||
|| `runtime-sensor-agent` | 1 | 50m | 256 МБ ||
|| `tetragon` (DaemonSet, на каждый узел) | ×N | 200m | 256 МБ ||
|| `tetragon-server-proxy` (DaemonSet, на каждый узел) | ×N | — | — ||
|| **Итого (фиксированная часть)** | > | **60m** | **320 МБ** ||
|#

**Компонент Kube-bench**

Компонент `kube-bench-reporter` запускается на каждом узле кластера как `DaemonSet`.

#|
|| **Компонент** | **Реплики** | **CPU,&nbsp;requests** | **Память,&nbsp;requests** ||
|| `kube-bench-reporter` (DaemonSet, на каждый узел) | ×N | 50m | 128 МБ ||
|#

**Компоненты osquery**

Компоненты `osquery-agent` и `osqueryd` запускаются внутри одного `DaemonSet` на каждом узле кластера.

#|
|| **Компонент** | **Реплики** | **CPU,&nbsp;requests** | **Память,&nbsp;requests** ||
|| `osquery-agent` | xN | 20m | 64 МБ ||
|| `osqueryd` | xN | 50m | 128 МБ ||
|#

### Полезные ссылки {#see-also}

[{#T}](../../concepts/kspm.md)
