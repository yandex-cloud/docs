---
title: Рекомендации по использованию {{ managed-k8s-full-name }}
description: Используйте эти рекомендации, если вашим приложениям требуется высокая доступность и отказоустойчивость, масштабирование нагрузки и изоляция ресурсов.
alternate:
  - href: ru/managed-kubernetes/concepts/usage-recommendations.md
    type: text/markdown
    title: Markdown version
---

# Рекомендации по использованию {{ managed-k8s-name }}


Используйте эти рекомендации для ваших `PRODUCTION`-приложений, которым требуется:
* Высокая доступность и [отказоустойчивость](../../architecture/fault-tolerance.md).
* Масштабирование нагрузки.
* Изоляция ресурсов.

{% note tip %}

Протестируйте предлагаемые стратегии на тестовом окружении перед внедрением в `PRODUCTION`.

{% endnote %}

## Высокая доступность и отказоустойчивость {{ managed-k8s-name }} {#high-availability}

Рекомендации приведены в разделе [Высокая доступность и отказоустойчивость {{ managed-k8s-name }}](high-availability.md).

## Масштабирование нагрузки {#scaling}

Используйте эти рекомендации, если нагрузка на ваш кластер {{ managed-k8s-name }} постоянно растет:
* Для снижения нагрузки на {{ k8s }} DNS используйте [NodeLocal DNS](../tutorials/node-local-dns.md). Если кластер содержит более 50 узлов, используйте [автоматическое масштабирование DNS](../tutorials/dns-autoscaler.md).
* Чтобы снизить горизонтальный трафик внутри кластера, используйте [сетевой балансировщик нагрузки](../operations/create-load-balancer.md) и [правило `externalTrafficPolicy:Local`](../operations/create-load-balancer.md#create-lb), если это возможно.
* Заранее продумайте требования к хранилищам узлов:
  * Изучите [лимиты дисков](../../compute/concepts/limits.md) для {{ compute-full-name }}.
  * Проведите нагрузочное тестирование дисковой подсистемы в тестовом окружении.
* Для снижения задержки при высоких показателях IOPS используйте [нереплицируемые диски](../../compute/concepts/disk.md#disks-types).

### Сетевой балансировщик нагрузки {#nlb}

Сетевой балансировщик нагрузки (Network Load Balancer) распределяет поступающий на него трафик между целевыми ресурсами (ВМ). Обработчик с публичным IP-адресом позволяет балансировщику обрабатывать трафик из интернета, а обработчик с приватным IP-адресом — внутренний трафик. Балансировщик проверяет доступность целевых ресурсов с помощью проверок состояния (Health Checks).

В {{ yandex-cloud }} реализован [механизм](../../architecture/fault-tolerance.md#nlb-zone-shift) `NLB Zone Shift`, который позволяет отметить балансировщик специальным флагом. Если в зоне доступности произошел частичный сбой, который не фиксируется проверками состояния, служба поддержки {{ yandex-cloud }} отключит проблемную зону от этого балансировщика.

Чтобы оценить работоспособность вашего приложения при отказе одной из зон доступности, воспользуйтесь [сценарием](https://github.com/yandex-cloud-examples/yc-deploy-ha-app-with-nlb).

[Подробнее о работе сетевого балансировщика нагрузки](../../architecture/fault-tolerance.md#nlb).

### Балансировщик нагрузки уровня приложения {#alb}

Балансировщик нагрузки уровня приложения (Application Load Balancer) основан на сетевом балансировщике, но позволяет направлять трафик на произвольные приватные IP-адреса, например на IP-адреса ресурсов вне облачной сети. Для маршрутизации трафика используются промежуточные ВМ, выступающие в качестве обратных прокси.

Балансировщик нагрузки уровня приложения поддерживает ручное отключение зоны доступности, в которой произошел частичный сбой.

[Подробнее о работе балансировщика нагрузки уровня приложения](../../architecture/fault-tolerance.md#alb).

## Изоляция ресурсов {#isolation}

Применяйте эти рекомендации для приложений, использующих общие ресурсы кластера {{ k8s }}.

Настройте значения `limits` и `requests` для всех сервисов кластера:

```yaml
---
...
containers:
...
  resources:
    limits:
      cpu: 250m
      memory: 128Mi
    requests:
      cpu: 100m
      memory: 64Mi
...
```

Укажите доступность vCPU в тысячных долях, а RAM — в мегабайтах. Сервис не превысит лимиты vCPU и RAM, указанные в значениях `limits`. Настройка `requests` позволяет масштабировать узлы кластера при помощи автоматического масштабирования.

Чтобы автоматически управлять ресурсами подов, настройте политики {{ k8s }}:
* [Quality of Service for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/) для создания подов различных классов доступности.
* [Limit Ranges](https://kubernetes.io/docs/concepts/policy/limit-range/) для установки лимитов на уровне [пространства имен](../concepts/index.md#namespace).
* [Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/) для ограничения общего потребления ресурсов в пространстве имен.

### Resource Quota {#resource-quota}

Используйте политику `ResourceQuota` для ограничения ресурсов, которые могут быть использованы в рамках одного пространства имен:

```yaml
---
apiVersion: v1
kind: ResourceQuota
metadata:
  name: namespace-quota
  namespace: my-namespace
spec:
  hard:
    # Вычислительные ресурсы
    requests.cpu: "10"
    requests.memory: 20Gi
    limits.cpu: "20"
    limits.memory: 40Gi
    # Количество объектов
    pods: "50"
    services: "10"
    secrets: "20"
    configmaps: "20"
    persistentvolumeclaims: "10"
    # Ресурсы хранилища
    requests.storage: 100Gi
```

С помощью `ResourceQuota` можно ограничить:

| Тип ресурса | Параметры | Описание |
| --- | --- | --- |
| Вычислительные | `requests.cpu`, `requests.memory`, `limits.cpu`, `limits.memory` | Суммарные запросы и лимиты vCPU и RAM для всех подов в пространстве имен |
| Хранилище | `requests.storage`, `persistentvolumeclaims` | Общий объем запрашиваемого хранилища и количество PVC |
| Количество объектов | `pods`, `services`, `secrets`, `configmaps`, `replicationcontrollers`, `deployments.apps`, `statefulsets.apps`, `jobs.batch`, `cronjobs.batch` | Максимальное количество объектов каждого типа |
| Расширенные ресурсы | `requests.nvidia.com/gpu`, `limits.nvidia.com/gpu` | Ресурсы GPU и другие `extended resources` |

{% note tip %}

Комбинируйте `ResourceQuota` с `LimitRange`: `ResourceQuota` ограничивает суммарное потребление ресурсов в пространстве имен, а `LimitRange` задает значения по умолчанию и границы для отдельных контейнеров.

{% endnote %}

## Мониторинг и эскалация {#monitoring-escalation}

[Мониторинг](../../monium/) и [система предупреждений](../../monium/concepts/alerting/alert.md) — важный инструмент обеспечения отказоустойчивости.

* [Настройте мониторинг метрик](../operations/kubernetes-cluster/kubernetes-cluster-get-stats.md) и [создайте алерты](../../monium/operations/alert/create-alert.md), чтобы следить за состоянием мастера, узлов, подов и постоянных томов.
* Настройте для алертов политики [эскалации](../../monium/concepts/alerting/escalations.md).
