### Нет доступа к API Kubernetes {#api-security}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | k8s.api-security ||
|#

#### Описание

Не рекомендуется открывать доступ к API Kubernetes из интернета. В случае необходимости используйте средства межсетевого экранирования, например, [группы безопасности](https://yandex.cloud/ru/docs/vpc/concepts/security-groups).

{% note info "**Примечание**" %}

Правило проверяет только наличие внешних IP-адресов, назначенных кластерам Kubernetes.

{% endnote %}

#### Инструкции и решения по выполнению

**Инструкции и решения по выполнению:**

Рекомендуется использовать кластеры Kubernetes без доступа из интернета. О том, как создать такой кластер, читайте в разделе [Создание и настройка кластера Kubernetes без доступа в интернет](https://yandex.cloud/ru/docs/managed-kubernetes/tutorials/k8s-cluster-with-no-internet).

Если доступ к кластеру из интернета необходим, используйте средства межсетевого экранирования:

* [Настройте для кластера группы безопасности](https://yandex.cloud/ru/docs/managed-kubernetes/operations/connect/security-groups).
* Используйте инструменты для настройки network policy с помощью плагинов [Calico](https://yandex.cloud/ru/docs/managed-kubernetes/concepts/network-policy#calico) (базовый) или [Cilium CNI](https://yandex.cloud/ru/docs/managed-kubernetes/concepts/network-policy#cilium) (продвинутый) в Yandex Cloud, применяя правило `default deny` для входящего и исходящего трафика по умолчанию и разрешая явно только необходимый трафик.
* Выделите отдельный кластер Kubernetes для конечных точек, которые взаимодействуют с интернетом, либо отдельные группы узлов (с помощью механизмов: [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/#:~:text=Node%20affinity%20is%20a%20property,onto%20nodes%20with%20matching%20taints) + [Node affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)). Таким образом, выделяется сегмент DMZ, и в случае компрометации узлов из интернета поверхность атаки ограничится.
* Используйте ресурс [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/), чтобы организовать входящий сетевой доступ к рабочим нагрузкам по протоколу HTTP/HTTPS. В Yandex Cloud вы можете использовать как минимум два варианта Ingress-контроллера:

    * [Ingress-контроллер NGINX](https://yandex.cloud/ru/docs/managed-kubernetes/tutorials/ingress-cert-manager).
    * [Ingress-контроллер Yandex Application Load Balancer](https://yandex.cloud/ru/docs/application-load-balancer/tools/k8s-ingress-controller/).
