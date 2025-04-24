# Сетевые политики кластера {{ k8s }}

Сетевые политики {{ k8s }} позволяют настроить сетевое взаимодействие между группами [подов](./index.md#pod) и узлами сети. Вы можете создать сетевые политики с помощью [{{ k8s }} Network Policy API](https://kubernetes.io/docs/concepts/services-networking/network-policies/), который задает правила фильтрации трафика на уровне подов. Правила определяют, какие поды и сервисы в кластере {{ k8s }} могут получить доступ друг к другу.

Для управления сетевыми политиками в {{ managed-k8s-name }} используются контроллеры [Calico](https://www.projectcalico.org/) и [Cilium](https://cilium.io/).

Сетевой контроллер Calico использует правила [iptables](https://ru.wikipedia.org/wiki/Iptables), а Cilium — технологию [eBPF](https://ebpf.io/).

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
* Создавать более функциональные сетевые политики, например, фильтровать трафик между подами на [прикладном уровне L7](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI#Уровни_модели_OSI) или на основании DNS-имени внешнего ресурса.
* Применять встроенный инструмент [Hubble](https://docs.cilium.io/en/v1.9/intro/#why-cilium-hubble) для мониторинга сетевых событий.

Cilium в кластере {{ managed-k8s-name }} работает в [туннельном режиме](https://docs.cilium.io/en/v1.14/network/concepts/routing/#encapsulation). Этот режим реализует сетевую связанность объектов кластера на базе [технологии VxLAN](https://ru.wikipedia.org/wiki/Virtual_Extensible_LAN) с помощью Cilium CNI.

Туннельный режим Cilium позволяет:
* Создавать кластеры с пересекающимися IP-адресами в одной сети.
* Использовать расширенный диапазон адресов для подов и сервисов кластера вплоть до `/8`.
* Создавать в два раза больше узлов в кластерах (в сравнении с Calico).

Для использования туннельного режима сервисному аккаунту кластера [требуется роль `k8s.tunnelClusters.agent`](../security/index.md#yc-api).

В разделе [Создание кластера {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) описано, как включить туннельный режим.

## Сетевые политики allow-all и deny-all {#allow-deny-policies}

{% note warning %}

Используйте эти политики только для задач отладки. В остальных случаях гранулярно настраивайте политики для решения конкретных задач.

{% endnote %}

### Политики для входящих подключений {#incoming-connections}

Вы можете создать политику, которая разрешает все входящие подключения ко всем подам в пространстве имен. При наличии такой политики никакие другие политики не могут запретить входящие подключения к этим подам.

Пример:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-all-ingress
spec:
  podSelector: {}
  ingress:
  - {}
  policyTypes:
  - Ingress
```

Вы можете создать политику, которая запрещает все входящие подключения ко всем подам в пространстве имен. Такая политика гарантирует, что для подов, которые не выбраны никакой другой сетевой политикой, также будут запрещены все входящие подключения.

Пример:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
spec:
  podSelector: {}
  policyTypes:
  - Ingress
```

### Политики для исходящих подключений {#outgoing-connections}

Вы можете создать политику, которая разрешает все исходящие подключения из всех подов в пространстве имен. При наличии такой политики никакие другие политики не могут запретить исходящие подключения из этих подов.

Пример:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-all-egress
spec:
  podSelector: {}
  egress:
  - {}
  policyTypes:
  - Egress
```

Вы можете создать политику, которая запрещает все исходящие подключения из всех подов в пространстве имен. Такая политика гарантирует, что для подов, которые не выбраны никакой другой сетевой политикой, также будут запрещены все исходящие подключения.

Пример:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-egress
spec:
  podSelector: {}
  policyTypes:
  - Egress
```

Подробнее о `NetworkPolicy` см. в разделе [{#T}](../../network-load-balancer/k8s-ref/networkpolicy.md).

## Требования к кластеру для включения сетевых политик {#requirements}

Для включения сетевых политик в кластере {{ k8s }} необходимо [достаточное количество ресурсов](node-group/allocatable-resources.md) в группах узлов. Применение сетевых политик требует дополнительных ресурсов памяти и vCPU.

Рекомендуется включать контроллер сетевых политик только в кластере минимум из двух узлов.