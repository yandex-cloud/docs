# Установка Kruise


[Kruise](https://openkruise.io/) — это набор ресурсов [CustomResourceDefinition](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/) в {{ k8s }}, с помощью которых можно автоматизировать развертывание и обновление приложений. Инструменты Kruise работают в кластерах Kubernetes без установки других зависимостей.

Преимущества Kruise:

* Расширяет управление вспомогательными (sidecar) контейнерами.
* Обеспечивает высокую доступность приложений.
* Позволяет обновлять приложения без удаления подов.
* Расширяет конфигурацию распределения нагрузки по узлам кластера.

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Kruise](/marketplace/products/yc/kruise) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:

   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Kruise или создайте новое.
   * **Название приложения** — укажите название приложения.

1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Kruise выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_kruise.helmChart.name }} \
      --version {{ mkt-k8s-key.yc_kruise.helmChart.tag }} \
      --untar && \
   helm install \
      --namespace <пространство_имен> \
      --create-namespace \
      kruise ./kruise/
   ```

Актуальную версию Helm-чарта можно посмотреть на [странице приложения](/marketplace/products/yc/kruise#docker-images).

## См. также {#see-also}

* [Документация Kruise](https://openkruise.io/docs/).
