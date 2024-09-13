# Установка NodeLocal DNS

[NodeLocal DNS](/marketplace/products/yc/node-local-dns) снижает нагрузку по [DNS-запросам](../../../glossary/dns.md) за счет запуска кеша на каждом [узле](../../concepts/index.md#node-group) в [кластере {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster). Это позволяет повысить производительность и отказоустойчивость кластера {{ managed-k8s-name }}.

## Перед началом работы {#before-you-begin}

{% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

{% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на страницу [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку ![Marketplace](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [NodeLocal DNS](/marketplace/products/yc/node-local-dns) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) `kube-system`.
   * **Название приложения** — укажите название, под которым приложение будет развернуто в кластере {{ managed-k8s-name }}.
   * **Внутренний IP-адрес службы kube-dns** — адрес для обращения к NodeLocal DNS Cache. Запросы, отправленные из подов приложений по адресу в поле, маршрутизируются на [local DNS](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#iptables-notrack) с помощью правил iptables.

      Поле содержит адрес `ClusterIP` сервиса `kube-dns` в пространстве имен `kube-system`. Значение поля можно получить с помощью команды:

      ```bash
      kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP}
      ```

      Так как {{ yandex-cloud }} добавляет сервис `kube-dns` при создании кластера, IP-адрес сервиса предопределен. Поэтому его нельзя изменить в поле **Внутренний IP-адрес службы kube-dns**.

   * **Работа с Cilium** — выберите эту опцию, если кластер использует [контроллер сетевых политик Cilium](../../concepts/network-policy.md#cilium).
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

После установки NodeLocal DNS использует следующие значения:
* Зона кластера {{ managed-k8s-name }} — `cluster.local`.
* Адрес кеша NodeLocal DNS — `169.254.20.10`.
* Порт приложения для внешних запросов — `53`.
* Порт для сбора метрик Prometheus — `9253`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Получите адрес для обращения к NodeLocal DNS Cache. Адрес понадобится для установки [Helm-чарта](https://helm.sh/docs/topics/charts/):

   ```bash
   kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP}
   ```

   Команда отображает адрес `ClusterIP` сервиса `kube-dns` в пространстве имен `kube-system`. Сервис `kube-dns` устанавливается автоматически во время создания кластера, поэтому IP-адрес сервиса предопределен.

   Запросы, отправленные из подов приложений по полученному адресу, маршрутизируются на [local DNS](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#iptables-notrack) с помощью правил iptables.

1. Для установки Helm-чарта с NodeLocal DNS выполните команду:

   
   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_node-local-dns.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_node-local-dns.helmChart.tag }} \
     --untar && \
   helm install \
     --set config.cilium=false \
     --set config.clusterIp="<IP-адрес_kube-dns>" \
     node-local-dns ./node-local-dns/
   ```


   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

Подробнее о настройке локального кеширования DNS см. в разделе [{#T}](../../tutorials/node-local-dns.md).
