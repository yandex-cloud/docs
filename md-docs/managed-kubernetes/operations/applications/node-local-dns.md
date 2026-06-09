# Установка NodeLocal DNS

[NodeLocal DNS](https://yandex.cloud/ru/marketplace/products/yc/node-local-dns) снижает нагрузку по [DNS-запросам](../../../glossary/dns.md) за счет запуска кеша на каждом [узле](../../concepts/index.md#node-group) в [кластере {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster). Это позволяет повысить производительность и отказоустойчивость кластера {{ managed-k8s-name }}.

## Перед началом работы {#before-you-begin}

[Убедитесь](../connect/security-groups.md), что группы безопасности для кластера {{ managed-k8s-name }} и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

{% note warning %}

От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.

{% endnote %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку ![Marketplace](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [NodeLocal DNS](https://yandex.cloud/ru/marketplace/products/yc/node-local-dns) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) `kube-system`.

      {% note warning %}
      
      Приложение работает корректно только с пространством имен `kube-system`.
      
      {% endnote %}

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

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
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
     --namespace kube-system \
     node-local-dns ./node-local-dns/
   ```

   {% note warning %}
   
   Приложение работает корректно только с пространством имен `kube-system`.
   
   {% endnote %}

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

Подробнее о настройке локального кеширования DNS см. в разделе [{#T}](../../tutorials/node-local-dns.md).