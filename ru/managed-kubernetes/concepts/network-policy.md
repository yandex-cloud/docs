# Сетевые политики кластера {{ k8s }}

Сетевые политики {{ k8s }} позволяют настроить сетевое взаимодействие между группами [подов](./index.md#pod) и узлами сети. Вы можете создать сетевые политики с помощью [{{ k8s }} Network Policy API](https://kubernetes.io/docs/concepts/services-networking/network-policies/), который задает правила фильтрации трафика на уровне подов. Правила определяют, какие поды и сервисы в кластере {{ k8s }} могут получить доступ друг к другу.

Для управления сетевыми политиками в {{ managed-k8s-name }} используются контроллеры [Calico](https://www.projectcalico.org/) и [Cilium](https://cilium.io/).

Сетевой контроллер Calico использует правила [iptables]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Iptables){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Iptables){% endif %}, а Cilium — технологию [eBPF](https://ebpf.io/).

{% note warning %}

Вы можете включить использование сетевых политик только при [создании кластера](../operations/kubernetes-cluster/kubernetes-cluster-create.md).

{% endnote %}

## Интеграция с балансировщиками {#balancers}

{% note warning %}

Из-за архитектурных особенностей {{ yandex-cloud }} в {{ managed-k8s-name }} нельзя использовать параметр `loadBalancerSourceRanges` при настройке контроллеров сетевых политик. Для разрешения трафика через [{{ network-load-balancer-full-name }}](../../network-load-balancer/) или [{{ alb-full-name }}](../../application-load-balancer/) используйте [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

{% endnote %}

Пошаговые инструкции по настройке доступа к приложению с помощью NetworkPolicy приведены на странице [{#T}](../operations/create-load-balancer.md).

## Calico {#calico}

Calico позволяет настраивать [базовые политики безопасности](https://docs.projectcalico.org/reference/resources/) кластера {{ k8s }}.

Пошаговые инструкции по его настройке приведены на странице [{#T}](../operations/calico.md).

## Cilium {#cilium}

По сравнению с Calico, контроллер Cilium обладает более широкими возможностями и позволяет:
* Использовать одни и те же диапазоны подсетей для подов и сервисов в разных кластерах.
* Создавать более функциональные сетевые политики, например, фильтровать трафик между подами на [прикладном уровне L7]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Сетевая_модель_OSI#Уровни_модели_OSI){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/OSI_model#Layer_architecture){% endif %} или на основании DNS-имени внешнего ресурса.
* Применять встроенный инструмент [Hubble](https://docs.cilium.io/en/v1.9/intro/#why-cilium-hubble) для мониторинга сетевых событий.

Cilium в кластере {{ managed-k8s-name }} работает в [туннельном режиме](https://docs.cilium.io/en/v1.9/concepts/networking/routing/#encapsulation). Этот режим реализует сетевую связанность объектов кластера на базе [технологии VxLAN]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Virtual_Extensible_LAN){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Virtual_Extensible_LAN){% endif %} с помощью Cilium CNI.

Туннельный режим Cilium позволяет:
* Создавать кластеры с пересекающимися IP-адресами в одной сети.
* Использовать расширенный диапазон адресов для подов и сервисов кластера вплоть до `/8`.
* Создавать в два раза больше узлов в кластерах (в сравнении с Calico).

Для использования туннельного режима сервисному аккаунту кластера [требуется роль `k8s.tunnelClusters.agent`](../security/index.md#yc-api).

## Требования к кластеру для включения сетевых политик {#requirements}

Для включения сетевых политик в кластере {{ k8s }} необходимо [достаточное количество ресурсов](node-group/allocatable-resources.md) в группах узлов. Применение сетевых политик требует дополнительных ресурсов памяти и vCPU.

Рекомендуется включать контроллер сетевых политик только в кластере минимум из двух узлов.