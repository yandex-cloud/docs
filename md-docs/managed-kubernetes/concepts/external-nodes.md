# Внешние узлы кластера

{% note info %}

Подключение внешних узлов находится на стадии [Preview](../../overview/concepts/launch-stages.md). Их использование не тарифицируется.

{% endnote %}

Managed Service for Kubernetes позволяет подключать в качестве узлов [кластера Kubernetes](index.md#kubernetes-cluster) серверы, расположенные вне Yandex Cloud.

## Требования для подключения внешних узлов к кластеру {#requirements}

Чтобы подключить внешние узлы к кластеру Managed Service for Kubernetes, необходимо соответствие следующим требованиям:
* Сетевая связность на уровне L3 между локальной сетевой инфраструктурой ваших серверов и [облачной сетью](../../vpc/concepts/network.md#network) кластера Managed Service for Kubernetes. Внешние узлы подключаются к [мастеру](index.md#master) кластера только через его внутренний IP-адрес в облачной сети Yandex Cloud.

  Установить приватное выделенное соединение между вашей локальной сетевой инфраструктурой и Yandex Cloud можно следующими способами:
  * С помощью сервиса [Yandex Cloud Interconnect](../../interconnect/index.md).
  * Самостоятельно с помощью [VPN](../../glossary/vpn.md) — например, [IPSec](../operations/external-nodes-connect-ipsec.md) или [WireGuard](../operations/external-nodes-connect-wireguard.md).

* Кластер Managed Service for Kubernetes использует [туннельный режим](network-policy.md#cilium) сети.
* Подключаемые серверы должны иметь доступ в интернет.
* Операционная система подключаемых серверов — Ubuntu 24.04.

Как подключить внешние узлы к кластеру Managed Service for Kubernetes, читайте в разделе [Подключение внешних узлов к кластеру](../operations/external-nodes-connect.md).

## Разделение ответственности {#responsibility}

Для предсказуемой работы внешних узлов необходимо обеспечить бесперебойную работу:
* вычислительной инфраструктуры — используемых серверов и установленной на них операционной системы;
  * мы не рекомендуем использовать подключаемые сервера для чего-либо, кроме выполнения функций узлов кластера;
* локальной сетевой инфраструктуры используемых серверов;
* соединения между вашей локальной сетевой инфраструктурой и Yandex Cloud.

Yandex Cloud предоставляет услугу обеспечения надежного приватного соединения между вашей локальной сетевой и облачной инфраструктурой в рамках сервиса [Cloud Interconnect](../../interconnect/index.md). В качестве альтернативы вы можете самостоятельно настраивать и обеспечивать качество такого соединения с помощью VPN.

Yandex Cloud не предоставляет услугу по управлению и обеспечению надежности вычислительной и сетевой инфраструктуры вне датацентров Yandex Cloud. Вы можете воспользоваться преимуществами управляемой инфраструктуры в рамках использования [обычных групп узлов](../operations/node-group/node-group-create.md) сервиса Managed Service for Kubernetes.

## Ограничения при работе с внешними узлами {#restrictions}

При проектировании распределения рабочих нагрузок по узлам в кластере Managed Service for Kubernetes необходимо учитывать следующие особенности:
* К внешним узлам невозможно подключать [объекты](volume.md) `PersistentVolume` на основе облачных дисков Yandex Cloud.
* [Сервисы](index.md#service) на основе L3-балансировщиков Yandex Cloud (например, `LoadBalancer`) не распределяют трафик на такие узлы.

Нагрузки, которым необходима эта функциональность, необходимо размещать только на узлах кластера Managed Service for Kubernetes, которые расположены в Yandex Cloud. Для этого вы можете воспользоваться настройками [node affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity):

```yaml
...
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: yandex.cloud/node-group-id # Kubernetes-метка узлов, расположенных в Yandex Cloud.
            operator: Exists
...
```

В качестве альтернативы управлению трафиком с помощью L3-балансировщиков вы можете воспользоваться управлением трафиком на уровне L7. Для этого установите в кластер Managed Service for Kubernetes Ingress-контроллер и используйте ресурсы типа `Ingress`.

Продукты Marketplace [Ingress-контроллер](../tutorials/alb-ingress-controller.md) и [Gateway API](../tutorials/marketplace/gateway-api.md) на базе [Yandex Application Load Balancer](../../application-load-balancer/index.md) не поддерживают балансировку трафика на внешние узлы.

Для балансировки трафика на внешние узлы воспользуйтесь контроллером [Gwin](../alb-ref/gwin-index.md).

Чтобы использовать контроллер Gwin для балансировки трафика на внешние узлы:
* Адрес внешнего узла должен быть доступен L7-балансировщику Application Load Balancer.
* Адрес внешнего узла должен присутствовать в `status` узла как ресурса, например:

  ```bash
  kubectl get no -o yaml example-cluster-node-1 | yq ".status.addresses"
  ```

  ```yaml
  - address: 10.0.0.7
    type: InternalIP
  - address: 2001:db8::1
    type: InternalIP
  - address: example-cluster-node-1
    type: Hostname
  ```