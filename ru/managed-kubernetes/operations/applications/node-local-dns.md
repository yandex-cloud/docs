# Установка NodeLocal DNS

[NodeLocal DNS](/marketplace/products/yc/node-local-dns) снижает нагрузку по [DNS-запросам](../../../glossary/dns.md) за счет запуска кеша на каждом [узле](../../concepts/index.md#node-group) в [кластере {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster). Это позволяет повысить производительность и отказоустойчивость кластера {{ managed-k8s-name }}.

## Перед началом работы {#before-you-begin}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Получите [внутренний IP-адрес](../../../vpc/concepts/address.md#internal-addresses) службы `kube-dns`:

   ```bash
   kubectl get svc kube-dns -n kube-system -o jsonpath="{.spec.clusterIP}"
   ```

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на страницу [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [NodeLocal DNS](/marketplace/products/yc/node-local-dns) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) `kube-system`.
   * **Название приложения** — укажите название, под которым приложение будет развернуто в кластере {{ managed-k8s-name }}.
   * **Адрес ClusterIp сервиса kube-dns** — укажите IP-адрес, полученный [перед началом работы](#before-you-begin).
   * **Работа с Cilium** — выберите эту опцию, если кластер использует [контроллер сетевых политик Cilium](../../concepts/network-policy.md#cilium).
1. Нажмите кнопку **Установить**.

После установки NodeLocal DNS использует следующие значения:
* Зона кластера {{ managed-k8s-name }} — `cluster.local`.
* Адрес кеша NodeLocal DNS — `169.254.20.10`.
* Порт приложения для внешних запросов — `53`.
* Порт для сбора метрик Prometheus — `9253`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с NodeLocal DNS выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 &&\
   helm pull oci://{{ mkt-k8s-key.yc_node-local-dns.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_node-local-dns.helmChart.tag }} \
     --untar && \
   KUBE_DNS_IP="$(kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP})" && \
   helm install \
     --set config.cilium=false \
     --set config.clusterIp=$KUBE_DNS_IP \
     node-local-dns ./chart/
   ```

Подробнее о настройке локального кеширования DNS см. в [{#T}](../../tutorials/node-local-dns.md).